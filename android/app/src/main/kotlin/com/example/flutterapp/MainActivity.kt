package com.example.flutterapp

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.view.FlutterNativeView

class MainActivity: FlutterActivity() {
    private val BASIC_MESSAGE_CHANNEL = "basicMessageChannel";
    private val METHOD_CHANNEL="methodChannel";
    private val EVENT_CHANNEL="eventChannel";

    private val METHOD_CHANNEL_ROBOT = "com.example.flutterapp/robot";
    private val executorService = Executors.newSingleThreadExecutor();

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    private fun basicMessageChannelDemo(){
        BasicMessageChannel(this.flutterView, BASIC_MESSAGE_CHANNEL,StandardMessageCodec.INSTANCE)
                .setMessageHandler{any, reply ->
                    println("android listen:$any")
                    reply.reply("android reponse to flutter");

                    BasicMessageChannel(this.flutterView,BASIC_MESSAGE_CHANNEL,StandardMessageCodec.INSTANCE)
                            .send("android send to flutter"){
                                println("android receive reponse:$it")
                            }
                }
    }

    private fun methodChannelDemo(){
        MethodChannel(this.flutterView,METHOD_CHANNEL)
                .sendMethodCallHandler{
                    methodCall,result ->{
                    println("android listen:${methodCall.method} \t ${methodCall.arguments}")
                    when(methodCall.method){
                        "getAge" ->{
                            result.success(getAge(methodCall.argument<String>("name")))
                        }
                    }
                    }

                    MethodChannel(this.flutterView,METHOD_CHANNEL)
                            .invokeMethod("getSex",mapOf(mapOf("name","tom")),object :MethodChannel.Result{
                                override fun notImplemented() {
                                    println("android receive notImplemented")
                                }

                                override fun error(p0:String?,p1:String?,p2:Any?){
                                    println("android receive error")
                                }

                                override fun success(p0: java.lang.Object?) {
                                    println("android receive reponse:$p0")
                                }
                            })
                }
    }

    private getAge(name:String?):Int{
        return when(name){
            "lili" -> 18
            "tom" -> 19
            "allen" -> 20
            else-<0
        }
    }

    private fun eventChannelDemo(){
        EventChannel(this.flutterView,EVENT_CHANNEL)
                .setStreamHandler(object: EventChannel.StreamHandler{
                    override fun onListen(p0: java.lang.Object?, p1: EventChannel.EventSink?) {
                        println("android onListen:$p0")

                        events?.success(1)
                        events?.success(2)
                        events?.success(3)
                        events?.success(4)
                        events?.endOfStream()
                        events?.success(5)
                    }

                    override fun onCancel(p0: java.lang.Object?) {
                        println("android onCancel:$p0")
                    }
                })
    }

    private fun startGame():Int{
        println("android startGame")

        JavaToC.playGTP("boardsize")
    }
}
