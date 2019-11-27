## speech_to_text_plugins

## Works only with Android now!


 activate()  method create android speechRecognizer and ask permission for 
 android 6+ version. Do not forget to add
   uses-permission android:name="android.permission.RECORD_AUDIO"
  permission to manifest 
  
```
    activate();
```

Listen method start listening your voice, and send result as List of Strings
```
    listen();
```

When you call cancel, recognition canceled
```
    cancel();
```

Call when you need to stop speechRecognition and destroy it
```
    destroy();
```

When you call stop, recognition stopped and send result as List of String
```
    stop();
```
