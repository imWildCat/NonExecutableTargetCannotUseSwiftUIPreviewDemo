
import FetchImage
import SwiftUI

public struct WebImage: View {
  let url: URL

  @ObservedObject private var image = FetchImage()

  private let imageFrame: CGRect?

  public init(url: URL, imageFrame: CGRect? = nil) {
    self.url = url
    self.imageFrame = imageFrame
  }

  public var body: some View {
    ZStack {
      Rectangle().fill(Color.gray)
      image.view?
        .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
        .frame(width: imageFrame?.width, height: imageFrame?.height, alignment: .center)
//        .resizable()
//        .aspectRatio(contentMode: .fill)
//        .clipped()
    }
    .onAppear { image.load(url) }
    .onDisappear(perform: image.reset)
  }
}
struct WebImage_Previews: PreviewProvider {
  static var previews: some View {
    WebImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/en/a/a9/Example.jpg")!, imageFrame: CGRect(x: 0, y: 0, width: 100, height: 100))
      .frame(width: 100.0, height: 100.0, alignment: .center)
    
    Text("This cannot be previewed in the SharedUI target")
  }
}
