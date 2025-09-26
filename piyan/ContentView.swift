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
                .padding(.leading, 3) // 子項目縮排，不影響上方按鈕
            }
        }
        .padding(.leading, 10)
        .border(Color.red, width: 2)
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
        .border(Color.red , width: 2)
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
                .padding(.top, 10)

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

struct MessageView: View {
    
    
    let name: String
    let message: String
    
    @Environment(\.colorScheme) private var colorScheme
    
    var TextColorScheme: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    var TimeColorScheme: Color {
        colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(.user)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            

            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(name)
                        .font(.default)
                        .bold()
                        .foregroundStyle(TextColorScheme)
                        .padding(.top, 4)
//                        .border(Color.yellow, width: 2)
                    Text("凌晨 10:30")
                        .foregroundStyle(TimeColorScheme)
                        .font(.system(size: 14))
                        .padding(.top, 3)
//                        .border(Color.gray, width: 1)
                }

                Text(message)
                    .font(.default)
                    .foregroundStyle(TextColorScheme)
                    .padding(.top, -2)
//                    .border(Color.yellow, width: 2)

                
            }

            .padding(.leading, 4)
            Spacer()
        }
        .padding(.leading, 10)
        .padding(.top, 10)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
//        .border(Color.white, width: 2)

    }
}

struct ChatingBadge: View {
    
    let serverName: String
    @Environment(\.colorScheme) private var colorScheme
    var BadgeColorScheme: Color {
        colorScheme == .dark ?  Color.white :  Color.black
    }
    var UserCountColorScheme: Color {
        colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3)
    }

    var body: some View {
        HStack (alignment: .center) {
            Image(systemName: "arrowshape.backward.fill")
                .font(.system(size: 20))
                .foregroundStyle(BadgeColorScheme)
                .padding(.leading, 20)
            
            Image(systemName: "number")
                .font(.system(size: 24))
                .padding(.leading, 20)
//                .border(Color.white, width: 1)

            VStack (alignment: .leading) {
                
                Text(serverName)
                    .foregroundStyle(BadgeColorScheme)
                    .bold()
                    .font(Font.system(size: 18))
//                    .border(Color.white, width: 1)
                HStack {
                    Circle()
                        .foregroundStyle(Color.green)
                        .frame(width: 5, height: 5)
                        .padding(.trailing, -4)
                    Text("有 64 人在線上")
                        .foregroundStyle(UserCountColorScheme)
                        .font(Font.system(size: 10))
                }.padding(.top, -9)
                    
                
            }
//                .padding(.leading, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 30)
//        .border(Color.white, width: 2)

        
    }
    
}

//struct ChatingBox: View{
////    @Environment(\.colorScheme) private var colorScheme
//
//    @Environment(\.colorScheme) private var colorScheme
//    var ChatBoxColorSheme: Color {
//        colorScheme == .dark ? Color(red: 0 , green: 0, blue: 0, opacity: 1):
//        Color(red: 10, green: 10, blue: 10, opacity: 1)
//    }
//    
//    var body: some View {
//        VStack {
//            ChatingBadge(serverName: "公開聊天")
//            Divider()
//                .background(ChatBoxColorSheme)
//            
//            // 內容不足時貼齊底部；內容超過時向上捲動，超出才會被上方標題遮住
//            ScrollView {
//                    VStack(alignment: .trailing, spacing: 0) {
//
//                        MessageView(name: "Guan" ,message: "aaaaaa")
//                        MessageView(name: "Guan" ,message: "aaaaaa")
//                        MessageView(name: "Guan" ,message: "aaaaaa")
//                        MessageView(name: "Guan" ,message: "aaaaaa")
//                        MessageView(name: "Guan" ,message: "aaaaaa")
//                    }
//                    .frame(maxWidth: .infinity)
//            }
//            .frame(maxWidth: .infinity)
//        }
//        .background(ChatBoxColorSheme)
//    }
//}

struct ChatingInputBox: View {
   
    var body: some View {
        
    }
}
struct Message: Identifiable {
    let id = UUID()
    let name: String
    let text: String
}

struct ChatingBox: View {
    @Environment(\.colorScheme) private var colorScheme

    var chatBoxColorScheme: Color {
        colorScheme == .dark ? Color.black : Color(white: 0.95)
    }

    // 範例用資料，實務上你會用你的 messages state / view model
    @State private var messages: [Message] = [
        Message(name: "Guan", text: "第一則"),
        Message(name: "Guan", text: "第二則"),
        Message(name: "Guan", text: "第三則")
    ]

    var body: some View {
        VStack(spacing: 0) {
            ChatingBadge(serverName: "公開聊天")
            Divider()
                .background(chatBoxColorScheme)

            // 重要：GeometryReader 只包裹 ScrollView 區域，geo.size.height = 可用內容高度
            GeometryReader { geo in
                ScrollViewReader { proxy in
                    ScrollView {
                        // LazyVStack 比 VStack 在大量訊息時效能更好
                        LazyVStack(alignment: .trailing, spacing: 8) {
                            ForEach(messages) { msg in
                                MessageView(name: msg.name, message: msg.text)
                                    .id(msg.id) // 設 id 以便 ScrollViewReader scrollTo()
                            }
                        }
                        // 這一行是關鍵：內容最小高度等於可視高度，並以 bottom 對齊
                        .frame(minHeight: geo.size.height, alignment: .bottom)
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                    }
                    // 畫面出現時捲到最後一則
                    .onAppear {
                        if let lastId = messages.last?.id {
                            proxy.scrollTo(lastId, anchor: .bottom)
                        }
                    }
                    // 當 messages 改變（例如新訊息加入）時，自動捲到底
                    .onChange(of: messages.count) { oldValue, newValue in
                        if oldValue != newValue, let lastId = messages.last?.id {
                            withAnimation(.easeOut) {
                                proxy.scrollTo(lastId, anchor: .bottom)
                            }
                        }
                    }
                }
            } // GeometryReader
            .frame(maxWidth: .infinity)
            
            
            ChatingInputBox()
            
        }
        .background(chatBoxColorScheme)
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            HStack {
                serverList()
                    .border(Color.blue, width: 2)
                serverInfo()
                    .border(Color.green, width: 2)
                //                .frame(maxWidth: 0)
                    .frame(maxWidth: 500)
            
            }
            ChatingBox()

        }
//        .border(Color.red)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
