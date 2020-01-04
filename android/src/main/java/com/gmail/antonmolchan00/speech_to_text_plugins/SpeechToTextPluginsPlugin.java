package com.gmail.antonmolchan00.speech_to_text_plugins;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.speech.RecognitionListener;
import android.speech.RecognizerIntent;
import android.speech.SpeechRecognizer;

import androidx.core.app.ActivityCompat;

import java.util.ArrayList;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** SpeechToTextPluginsPlugin */
public class SpeechToTextPluginsPlugin implements MethodCallHandler, PluginRegistry.RequestPermissionsResultListener {

  private static final int MY_PERMISSIONS_RECORD_AUDIO = 16669;

  private SpeechRecognizer recognizer;
  private MethodChannel speechChannel;
  private Intent recognizeIntent;
  private Activity activity;
  private Result permissionResult;
  private Result speechResult;

  private SpeechToTextPluginsPlugin(Activity activity, MethodChannel channel) {
    this.speechChannel = channel;
    this.speechChannel.setMethodCallHandler(this);
    this.activity = activity;

    recognizer = SpeechRecognizer.createSpeechRecognizer(activity.getApplicationContext());
    recognizer.setRecognitionListener(listener);

    recognizeIntent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
    recognizeIntent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, "en-US");
    recognizeIntent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, "en-US");
    recognizeIntent.putExtra(RecognizerIntent.EXTRA_CALLING_PACKAGE, getClass().getPackage().getName());
    recognizeIntent.putExtra(RecognizerIntent.EXTRA_PARTIAL_RESULTS, true);
    recognizeIntent.putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 10);
  }

  private RecognitionListener listener = new RecognitionListener() {

    @Override
    public void onReadyForSpeech(Bundle params) {
    }

    @Override
    public void onBeginningOfSpeech() {
    }

    @Override
    public void onRmsChanged(float rmsdB) { }

    @Override
    public void onBufferReceived(byte[] buffer) { }

    @Override
    public void onEndOfSpeech() {
    }

    @Override
    public void onError(int errorCode) {
      returnResult(new ArrayList<String>());
    }

    @Override
    public void onResults(Bundle results) {
      ArrayList<String> matches = results.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION);
      if (matches != null) {
        returnResult(matches);
      }
    }

    @Override
    public void onPartialResults(Bundle partialResults) { }

    @Override
    public void onEvent(int eventType, Bundle params) {    }
  };

  private void returnResult (ArrayList<String> matches) {
    try {
      speechResult.success(matches);
    }catch (Exception ignored){}
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch (call.method) {
      case "speech.activate":

        if (activity.checkCallingOrSelfPermission(Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED) {
          result.success(true);
        } else {
          permissionResult = result;
          ActivityCompat.requestPermissions(activity, new String[]{Manifest.permission.RECORD_AUDIO}, MY_PERMISSIONS_RECORD_AUDIO);
        }

        break;
      case "speech.listen":
        speechResult = result;
        recognizer.startListening(recognizeIntent);
//        result.success(true);
        break;
      case "speech.cancel":
        recognizer.cancel();
        result.success(true);
        break;
      case "speech.stop":
        speechResult = result;
        recognizer.stopListening();
//        result.success(true);
        break;
      case "speech.destroy":
        recognizer.cancel();
        recognizer.destroy();
        result.success(true);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public boolean onRequestPermissionsResult(int code, String[] permissions, int[] results) {
    if (code == MY_PERMISSIONS_RECORD_AUDIO) {
      if(results[0] == PackageManager.PERMISSION_GRANTED) {
        permissionResult.success(true);
      } else {
        permissionResult.success(false);
      }
      permissionResult = null;
      return true;
    }
    return false;
  }

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "speech_to_text_plugins");
    final SpeechToTextPluginsPlugin plugin = new SpeechToTextPluginsPlugin(registrar.activity(), channel);
    channel.setMethodCallHandler(plugin);
    registrar.addRequestPermissionsResultListener(plugin);
  }

}
