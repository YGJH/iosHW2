//
//  ContentView.swift
//  piyan
//
//  Created by user20 on 2025/9/26.
//

import SwiftUI
import SwiftData

struct ServerImageView: View {
    let image: Image

    var body: some View {
        image
            .resizable()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .padding(4)
    }
}

struct serverList: View {
    @Environment(\.colorScheme) private var colorScheme;
    
    private var ChatBubbleColor: Color {
        colorScheme == .dark ? Color(red: 10, green: 10, blue: 10, opacity: 0.01) : Color(red: 0, green: 0, blue: 0, opacity: 0.1)
    }

    var body: some View {
        ScrollView{
            VStack {
                // 將 message.fill 放在一個圓形外框中
                Image(systemName: "message.fill")
                    .font(.system(size: 27, weight: .semibold))
                    .foregroundStyle(.gray)
                    .frame(width: 34, height: 34)    // 圖示實際尺寸
                    .padding(12)                      // 內距讓外圈成為直徑約 48 的圓
                    .background(
                        Circle().fill(ChatBubbleColor)
                    )
                    .overlay(
                        Circle().stroke(Color.secondary.opacity(0.25), lineWidth: 1)
                    )
                
                Divider()
                    .frame(width: 50)
                ServerImageView(image: Image(.server1))
                ServerImageView(image: Image(.server2))
            }
            .frame(minWidth: 20 , alignment: .leading)
        }
        .padding(.top, 10)
        .padding(.leading, 6)
    }
}

struct ButtonView: View {
    let image: Image

    @Environment(\.colorScheme) private var colorScheme
    
    private var ButtonColorScheme: Color {
        colorScheme == .dark ? Color(red: 10, green: 10 , blue: 10 , opacity: 0.01): Color(red: 0, green: 0, blue: 0, opacity: 0.1)
    }



    var body: some View {
        Button {
            // 按鈕動作：新增群組/邀請等
        } label: {
            image
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.gray)
                .frame(width: 32, height: 32)
                .background(
                    Circle().fill(ButtonColorScheme)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Add members")
        
    }
//    Image(systemName: "arrowshape.forward.fill")
}


struct ServerChannelListView: View {
    let name: String
    
    @State private var isExpanded: Bool = false
    @Environment(\.colorScheme) private var colorScheme
    
    private var channelTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.4) : Color(red: 0 ,green: 0, blue: 0, opacity: 0.6)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                isExpanded.toggle()
            } label: {
                HStack(spacing: 8) {
                    // 固定箭頭容器寬度，避免圖示切換時推擠文字
                    Image(systemName: isExpanded ? "arrowshape.down.fill" : "arrowshape.forward.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(channelTextColor)
                        .frame(width: 14, alignment: .center) // 固定寬度

                    Text(name)
                        .font(.system(size: 15, weight: Font.Weight.semibold))
                        .foregroundStyle(channelTextColor)
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading) // 標籤寬度固定且靠左
                .contentShape(Rectangle()) // 擴大點擊區域，避免因布局變動影響點擊
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    ServerChannelView(name: "Channel 1")
                    ServerChannelView(name: "Channel 2")
                    ServerChannelView(name: "Channel 3")
                    ServerChannelView(name: "Channel 4")
                    ServerChannelView(name: "Channel 5")
                    ServerChannelView(name: "Channel 6")
                }
                .padding(.leading, 20) // 子項目縮排，不影響上方按鈕
            }
        }
        .padding(.leading, 10)
    }
}


struct ServerChannelView: View {
    let name: String
    @Environment(\.colorScheme) private var colorScheme
    
    private var channelTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.4) : Color(red: 0 ,green: 0, blue: 0, opacity: 0.6)
    }
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "number")
                    .font(.system(size: 15 , weight: .semibold))
                    .foregroundStyle(channelTextColor)
                    .padding(.trailing,-1)
                    .padding(.leading, 10)
                    
                Text(name)
                    .font(.system(size: 15, weight: Font.Weight.semibold))
                    .foregroundStyle(channelTextColor)
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .leading) // 與群組列同寬且靠左
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}



struct serverBadge: View {
    @State private var searchText: String = ""
    
    
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var searchColorScheme: Color {
        colorScheme == .dark ? Color(red: 10, green: 10 , blue: 10 , opacity: 0.01): Color(red: 0, green: 0, blue: 0, opacity: 0.1)
    }

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                
                // 使「放大鏡 + TextField」整組置中
                HStack(spacing: 6) {
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                        
                        TextField("Search", text: $searchText)
                            .textFieldStyle(.plain)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: true, vertical: false)
                        
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
            }
            .overlay(
                Capsule().fill(searchColorScheme)
            )
            
            // 右側圓形按鈕
            ButtonView(image: Image(systemName: "calendar"))
            ButtonView(image: Image(systemName: "person.2.badge.plus.fill"))
            
            
        }

    }

}
struct serverInfo: View {
    @State private var searchText: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Server Name")
                .font(.title)
                .frame(alignment: .topLeading)
            
            serverBadge()
            Divider()
            
            ScrollView {
                // 也可包一層 leading 對齊的 VStack，效果等同
                VStack(alignment: .leading, spacing: 0) {
                    ServerChannelListView(name: "屁眼")
                    ServerChannelListView(name: "屁眼")
                    ServerChannelListView(name: "屁眼")
                    ServerChannelListView(name: "屁眼")
                    ServerChannelListView(name: "屁眼")

                    ServerChannelView(name: "aaaaa")
                }
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            Rectangle().fill(Color(.tertiarySystemBackground))
                .cornerRadius(20)
        )
    }
}

struct ContentView: View {
    var body: some View {
        HStack {
            serverList()
//                .border(Color.blue, width: 2)

            serverInfo()
//                .border(Color.green, width: 2)



        }
//        .border(Color.red)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
