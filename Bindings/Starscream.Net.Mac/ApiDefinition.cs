using Foundation;

namespace Starscream.Net.Mac {

    [Static]
    partial interface Constants
    {
        // extern double StarscreamVersionNumber;
        [Field("StarscreamVersionNumber", "__Internal")]
        double StarscreamVersionNumber { get; }

        // extern const unsigned char[] StarscreamVersionString;
        [Field("StarscreamVersionString", "__Internal")]
        NSString StarscreamVersionString { get; }
    }

    // @interface FoundationTransport : NSObject <NSStreamDelegate>
    [BaseType(typeof(NSObject), Name = "_TtC10Starscream19FoundationTransport")]
    [DisableDefaultCtor]
    interface FoundationTransport : INSStreamDelegate
    {
        // -(void)stream:(NSStream * _Nonnull)aStream handleEvent:(NSStreamEvent)eventCode;
        [Export("stream:handleEvent:")]
        void Stream(NSStream aStream, NSStreamEvent eventCode);
    }

    // @interface NativeEngine : NSObject <NSURLSessionDataDelegate, NSURLSessionWebSocketDelegate>
    [BaseType(typeof(NSObject), Name = "_TtC10Starscream12NativeEngine")]
    interface NativeEngine : INSUrlSessionDataDelegate, INSUrlSessionWebSocketDelegate
    {
        // -(void)URLSession:(NSURLSession * _Nonnull)session webSocketTask:(NSURLSessionWebSocketTask * _Nonnull)webSocketTask didOpenWithProtocol:(NSString * _Nullable)protocol;
        [Export("URLSession:webSocketTask:didOpenWithProtocol:")]
        void URLSession(NSUrlSession session, NSUrlSessionWebSocketTask webSocketTask, [NullAllowed] string protocol);

        // -(void)URLSession:(NSURLSession * _Nonnull)session webSocketTask:(NSURLSessionWebSocketTask * _Nonnull)webSocketTask didCloseWithCode:(NSURLSessionWebSocketCloseCode)closeCode reason:(NSData * _Nullable)reason;
        [Export("URLSession:webSocketTask:didCloseWithCode:reason:")]
        void URLSession(NSUrlSession session, NSUrlSessionWebSocketTask webSocketTask, NSUrlSessionWebSocketCloseCode closeCode, [NullAllowed] NSData reason);

        // -(void)URLSession:(NSURLSession * _Nonnull)session task:(NSURLSessionTask * _Nonnull)task didCompleteWithError:(NSError * _Nullable)error;
        [Export("URLSession:task:didCompleteWithError:")]
        void URLSession(NSUrlSession session, NSUrlSessionTask task, [NullAllowed] NSError error);
    }

}


