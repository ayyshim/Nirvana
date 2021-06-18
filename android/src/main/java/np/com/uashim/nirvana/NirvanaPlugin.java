package np.com.uashim.nirvana;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** NirvanaPlugin */
public class NirvanaPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "nirvana");
    channel.setMethodCallHandler(this);
  }

    private Nirvana nirvana = new Nirvana();


    @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

        switch (call.method) {
          case "setCarrierFrequency":
             nirvana.setCarrierFrequency((double) call.argument("carrierFrequency"), (boolean) call.argument("isPlaying"));
              break;
          case "setBeatFrequency":
              nirvana.setBeatFrequency((double) call.argument("beatFrequency"), (boolean) call.argument("isPlaying"));
              break;
          case "setVolume":
              nirvana.setVolume((double) call.argument("volume"));
              break;
          case "play":
              nirvana.play();
              break;
          case "stop":
              nirvana.stop();
              break;

          default:
              result.notImplemented();
              break;
      }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
