//
//  AppPageCell.swift
//  SwiftUIJustPlay
//
//  Created by wangrenzhu2021 on 2022/5/9.
//

import SwiftUI
import SwiftUIFlux
import SDWebImageSwiftUI

struct AppPageCell: ConnectedView {

    struct Props {
        let model: AppItemVM
    }
    
    let appId: Int
    
    func map(state: AppState,
             dispatch: @escaping DispatchFunction) -> Props {
        Props(model: state.homeState.appItems[appId]!)
    }
    
    @State var isBusy = false
    @State var isFav = false

    let item: AppItemVM

    func body(props: Props) -> some View {
        HStack {
            if isBusy {
                ZStack {
                    ProgressView()
                }
                .frame(
                    width: 40,
                    height: 40,
                    alignment: .leading
                )
                .padding(.leading, 10.0)
            } else {
                AnimatedImage(url: URL(string: props.model.icon))
                    .frame(
                        width: 40,
                        height: 40,
                        alignment: .leading
                        
                    )
                    .padding(.leading, 10.0)
                    .cornerRadius(25)
            }
            VStack(alignment: .leading) {
                Text(props.model.title)
                    .font(.system(size: 15))
                    .bold()
                    .lineLimit(1)
                Text(props.model.content)
                    .font(.system(size: 12))
                    .lineLimit(2)
            }
            Spacer()
            Button {
                self.isFav.toggle()
            } label: {
                Image(systemName: isFav ? "heart.fill": "heart")
                    .foregroundColor(isFav ? .red : .gray)
            }
            .padding(.trailing, 10.0)
            
        }
        .frame(height: 60)
        .background(Color.yellow)
        .cornerRadius(12)
    }
}

struct AppPageCell_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AppPageCell(appId: sampleAppVM.id,
                        item: sampleAppVM).environmentObject(sampleStore)
        }
        
    }
}
