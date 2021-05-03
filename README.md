# Demo project: SwiftUI Preview cannot be used while selecting the `SharedUI` target

![error message](assets/images/error_message.png)

## Repro steps

> Environment: macOS Big Sur 11.3 (or 11.2.x), Xcode 12.5 or 12.4.

1. Open the workspace
2. Select the `SharedUI` target (framework)
3. Open the `WebImage.swift` source file
4. Run the SwiftUI preview

## Actual behavior

Preview shows "Updating took more than 5 seconds".

### Logs

```log
== PREVIEW UPDATE ERROR:

    PreviewUpdateTimedOutError: Updating took more than 5 seconds
    
    Updating a preview from WebImage_Previews in XCPreviewAgent.app (38361) took more than 5 seconds.
```

## Expected behavior

Can preview this file.

Please note that, if you use the main app target (executable rather than the frame)

## License

WTFPL
