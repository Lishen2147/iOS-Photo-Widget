//
//  ContentView.swift
//  PhotoWidget
//
//  Created by Lishen Liu on 7/7/24.
//

import PhotosUI
import Foundation
import SwiftUI
import WidgetKit

class ImagePickerViewModel: ObservableObject {
    @Published private(set) var selectedUIImage: UIImage?
    @Published var pickedPhotoItem: PhotosPickerItem? {
        didSet {
            loadImageFrom(item: pickedPhotoItem)
        }
    }
    private var hasImageBeenSelected: Bool = false
    func loadImageFrom(item: PhotosPickerItem?) {
        guard let item = item else { return }
        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.selectedUIImage = uiImage
                }
            }
        }
    }
}

struct ContentView: View {
    @StateObject var vm = ImagePickerViewModel()
    @AppStorage(
        "ImageShowCaseWidget",
        store: UserDefaults(suiteName: "YOUR APP GROUP NAME")
    )
    var imageData: Data = Data()
    
    var body: some View {
        ZStack {
            Color.white // Background color for the entire view
            
            VStack(spacing: 0) {
                // Title at the top with black background
                Text("\n\nLishen's PhotoWidget")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        Color.black,
                        in:UnevenRoundedRectangle(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 20,
                            bottomTrailingRadius: 20,
                            topTrailingRadius: 0,
                            style: .continuous
                        )
                    )
                    .padding(.horizontal, -20)
                    .padding(.top, -20)
                    .zIndex(1)
                
                Spacer()
                
                // Main content including photo picker and update button
                PhotosPicker(selection: $vm.pickedPhotoItem) {
                    if vm.selectedUIImage == nil {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 3)
                            Image(systemName: "plus")
                                .font(.system(size: 50))
                        }
                        .foregroundStyle(.black)
                        .frame(width: 300, height: 130)
                    } else {
                        GeometryReader { geo in
                            Image(uiImage: vm.selectedUIImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fit) // Preserve aspect ratio
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.black, lineWidth: 3.0))
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                    }
                }
                
                Spacer()
                
                // Button section (conditionally rendered)
                if vm.selectedUIImage != nil {
                    Button {
                        if let uiImage = vm.selectedUIImage {
                            let resizedImage = uiImage.resized(to: CGSize(width: 300, height: 130))
                            if let data = resizedImage.jpegData(compressionQuality: 1.0) {
                                imageData = data
                            }
                        }
                        WidgetCenter.shared.reloadAllTimelines()
                    } label: {
                        Text("Show in Widget\n\n")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(
                                Color.black,
                                in:UnevenRoundedRectangle(
                                    topLeadingRadius: 20,
                                    bottomLeadingRadius: 0,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 20,
                                    style: .continuous
                                )
                            )
                    }
                    .padding(.bottom, -20)
                    .padding(.horizontal, -20)
                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all) // Ignores safe area to position content at the very top
    }
    /// Calculates image size based on its orientation to fit within the given geometry.
    private func imageSize(for image: UIImage, in geometry: GeometryProxy) -> CGSize {
        let maxWidth = geometry.size.width
        let maxHeight = geometry.size.height
        
        let imageSize = image.size
        let aspectWidth = maxWidth / imageSize.width
        let aspectHeight = maxHeight / imageSize.height
        
        let aspectRatio = min(aspectWidth, aspectHeight)
        
        return CGSize(width: imageSize.width * aspectRatio, height: imageSize.height * aspectRatio)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
