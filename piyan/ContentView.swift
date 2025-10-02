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
    private var CircleBorderColor: Color {
        colorScheme == .dark ? Color.black: Color.white
    }


    var body: some View {
        ScrollView{
            VStack {
                Image(systemName: "message.fill")
                    .font(.system(size: 27, weight: .semibold))
                    .foregroundStyle(.gray)
                    .frame(width: 34, height: 34)
                    .padding(12)
                    .background(
                        Circle().fill(ChatBubbleColor).border(CircleBorderColor)
                    )
                    .overlay(
                        Circle().stroke(CircleBorderColor, lineWidth: 1)
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
        Spacer()
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
}

struct ServerChannelListView: View {
    let name: String
    var onSelect: () -> Void = {}
    
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
                    Image(systemName: isExpanded ? "arrowshape.down.fill" : "arrowshape.forward.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(channelTextColor)
                        .frame(width: 14, alignment: .center)

                    Text(name)
                        .font(.system(size: 15, weight: Font.Weight.semibold))
                        .foregroundStyle(channelTextColor)
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    ServerChannelView(name: "Channel 1", onSelect: onSelect)
                    ServerChannelView(name: "Channel 2", onSelect: onSelect)
                    ServerChannelView(name: "Channel 3", onSelect: onSelect)
                    ServerChannelView(name: "Channel 4", onSelect: onSelect)
                    ServerChannelView(name: "Channel 5", onSelect: onSelect)
                    ServerChannelView(name: "Channel 6", onSelect: onSelect)
                }
                .padding(.leading, 3)
            }
        }
        .padding(.leading, 10)
    }
}

struct ServerChannelView: View {
    let name: String
    var onSelect: () -> Void = {}
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var channelTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.4) : Color(red: 0 ,green: 0, blue: 0, opacity: 0.6)
    }
    
    var body: some View {
        Button {
            onSelect()
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
            .frame(maxWidth: .infinity, alignment: .leading)
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
            
            ButtonView(image: Image(systemName: "calendar"))
            ButtonView(image: Image(systemName: "person.2.badge.plus.fill"))
        }
    }
}

struct serverInfo: View {
    var onSelectChannel: () -> Void = {}
    
    @Environment(\.colorScheme) private var colorScheme
    private var BackgroundColor: Color {
        colorScheme == .dark ? Color(red: 28/255, green: 28/255, blue: 30/255, opacity: 1): Color.secondary.opacity(0.1)
    }
    private var borderColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.3)   :
        Color(red: 0, green: 0, blue: 0, opacity: 0.3)
    }
    
    
    @State private var searchText: String = ""
    var body: some View {
        ZStack {
            UnevenRoundedRectangle(
                topLeadingRadius: 20,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 0
            )
            .stroke(borderColor, lineWidth: 1)
            
            VStack(alignment: .leading) {
                Text("Server Name")
                    .font(.title)
                    .frame(alignment: .topLeading)
                    .padding(10)
                
                
                serverBadge()
                    .padding(10)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ServerChannelListView(name: "屁眼", onSelect: onSelectChannel)
                        ServerChannelListView(name: "屁眼", onSelect: onSelectChannel)
                        ServerChannelListView(name: "屁眼", onSelect: onSelectChannel)
                        ServerChannelListView(name: "屁眼", onSelect: onSelectChannel)
                        ServerChannelListView(name: "屁眼", onSelect: onSelectChannel)
                        
                        ServerChannelView(name: "aaaaa", onSelect: onSelectChannel)

                    }
                }
//                .border(Color.red)
//                Spacer()
//                    .frame(width: .infinity, height: .infinity)
//                    .border(Color.blue)
            }
            .frame(maxHeight: .infinity , alignment: .top)
            .background(
                UnevenRoundedRectangle(
                    topLeadingRadius: 20,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 0
                )
                .fill(BackgroundColor)
            )
            Spacer().frame(maxHeight: .infinity)

        }


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
                    Text("凌晨 10:30")
                        .foregroundStyle(TimeColorScheme)
                        .font(.system(size: 14))
                        .padding(.top, 3)
                }

                Text(message)
                    .font(.default)
                    .foregroundStyle(TextColorScheme)
                    .padding(.top, -2)
            }
            .padding(.leading, 4)
            Spacer()
        }
        .padding(.leading, 10)
        .padding(.top, 10)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}

struct ChatingBadge: View {
    let serverName: String
    var onBack: () -> Void = {}
    
    @Environment(\.colorScheme) private var colorScheme
    var BadgeColorScheme: Color {
        colorScheme == .dark ?  Color.white :  Color.black
    }
    var UserCountColorScheme: Color {
        colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3)
    }

    private var returnBackButton : some View {
        Button {
            onBack()
        } label: {
            Image(systemName: "arrowshape.backward.fill")
                .font(.system(size: 20))
                .foregroundStyle(BadgeColorScheme)
                .padding(.leading, 20)
        }
    }
    
    private var topBadge: some View {
        Button {
        } label: {
            Image(systemName: "number")
                .font(.system(size: 24))
                .padding(.leading, 20)
                .foregroundStyle(BadgeColorScheme.opacity(0.5))
            VStack (alignment: .leading) {
                Text(serverName)
                    .foregroundStyle(BadgeColorScheme)
                    .bold()
                    .font(Font.system(size: 18))
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
        }
    }
    var body: some View {
        HStack (alignment: .center) {
            returnBackButton
            topBadge
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 30)
        .padding(.bottom, 10)
    }
}

struct ChatingInputBox: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var buttonBackgroundColor: Color {
        colorScheme == .dark ? Color.white : Color.black;
    }
    
    private var plusButton: some View {
        Button {
        } label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 16, height: 16)
                .padding(9)
                .overlay(
                    Circle()
                        .foregroundColor(buttonBackgroundColor.opacity(0.1))
                )
                .foregroundStyle(buttonBackgroundColor.opacity(1))
        }
    }
    
    private var gameButton: some View {
        Button {
        } label: {
            Image(systemName: "gamecontroller.fill")
                .resizable()
                .frame(width: 18, height: 16)
                .padding(10)
                .overlay(
                    Circle()
                        .foregroundColor(buttonBackgroundColor.opacity(0.1))
                )
                .foregroundStyle(buttonBackgroundColor.opacity(1))
        }
    }
    
    private var giftButton: some View {
        Button {
        } label : {
            Image(systemName: "gift.fill")
                .resizable()
                .frame(width: 16, height: 16)
                .padding(10)
                .overlay(
                    Circle()
                        .foregroundColor(buttonBackgroundColor.opacity(0.1))
                )
                .foregroundStyle(buttonBackgroundColor.opacity(1))
        }
    }

    @State var inputMessage: String = ""
    
    private var sendButton : some View {
        Button(action: {
            inputMessage = ""
        }) {
            Image(systemName: "paperplane.fill")
                .frame(width: 16, height: 16)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.blue)
                .clipShape(Circle())
        }
    }
    
    private var micButton: some View {
        Button {
        } label: {
            Image(systemName: "microphone.fill")
                .resizable()
                .frame(width: 16, height: 20)
                .padding(10)
                .overlay(
                    Circle()
                        .foregroundColor(buttonBackgroundColor.opacity(0.1))
                )
                .foregroundStyle(buttonBackgroundColor)
        }
    }
    
    private var inputField : some View {
        TextField("", text: $inputMessage)
            .textFieldStyle(.plain)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .multilineTextAlignment(.leading)
            .padding(7)
            .overlay(
                HStack{
                    Text("請輸入要說的話：")
                        .font(.system(size: 12))
                        .padding(3)
                        .foregroundStyle(buttonBackgroundColor.opacity(0.3))
                    Spacer()
                }
            )
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(buttonBackgroundColor.opacity(0.1))
            .cornerRadius(10)
    }
    
    var body: some View {
        HStack (alignment:.center){
            plusButton
//                .border(Color.red)
            gameButton
//                .border(Color.red)

            giftButton
//                .border(Color.red)

            inputField
//                .border(Color.red)
            sendButton
//                .border(Color.red)

            micButton
//                .border(Color.red)

        }
        .padding(10)
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

    @State private var messages: [Message] = [
        Message(name: "Guan", text: "第一則"),
        Message(name: "Guan", text: "第二則"),
        Message(name: "Guan", text: "第三則")
    ]
    
    var onBack: () -> Void = {}

    private var messageArea: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .trailing, spacing: 8) {
                        ForEach(messages) { msg in
                            MessageView(name: msg.name, message: msg.text)
                                .id(msg.id)
                        }
                    }
                    .frame(minHeight: geo.size.height, alignment: .bottom)
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                }
                .onAppear {
                    if let lastId = messages.last?.id {
                        proxy.scrollTo(lastId, anchor: .bottom)
                    }
                }
                .onChange(of: messages.count) { oldValue, newValue in
                    if oldValue != newValue, let lastId = messages.last?.id {
                        withAnimation(.easeOut) {
                            proxy.scrollTo(lastId, anchor: .bottom)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 700, maxHeight: .infinity)
    }

    var body: some View {
        VStack(spacing: 0) {
            ChatingBadge(serverName: "公開聊天", onBack: onBack)
            Divider()
            messageArea
            Divider()
            ChatingInputBox()
        }
        .background(chatBoxColorScheme)
    }
}

struct UserBadge: View {
    
    @Environment(\.colorScheme) private var colorScheme;
    
    private var BadgeColor : Color {
        colorScheme == .dark ? Color(red:10, green: 10 , blue: 10, opacity: 0.03) : Color.white
    }
    
    private var HomeButton: some View {
        Button {
            
        } label: {
            Image(systemName: "house.fill")
                .foregroundStyle(Color.gray)
                .frame(width: 20, height: 20)
                .padding(.leading, 40)

        }

    }
    
    private var BellButton: some View {
        Button {
            
        } label: {
            Image(systemName: "bell.fill")
                .foregroundStyle(Color.gray)
                .frame(width: 20 ,height: 20)
                .padding()
        }

    }
    
    private var UserButton: some View {
        Button {
            
        } label: {
            Image(.userIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 40 ,height: 40)
                .clipShape(Circle())
                .padding(.trailing, 30)
                .overlay(
                    Circle()
                        .fill(Color.black)
                        .frame(width: 20, height: 20)
                        .padding(.top, 24)
                        .overlay(
                            Circle()
                                .fill(Color.green)
                                .frame(width: 10 , height: 10)
                                .padding(.top, 24)
                        )
                )

        }
    }
    
    var body : some View {
        HStack {
            HomeButton
            Spacer()
            BellButton
            Spacer()
            UserButton
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(BadgeColor.opacity(0.3))
    }
}

struct ContentView: View {
    @State private var isChatHidden: Bool = true

    var body: some View {
        GeometryReader { geo in
            let isPad = geo.size.width > 700
            
            ZStack(alignment: .topLeading) {
                // 主視圖（server + info + user）
                HStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        HStack(spacing: 0) {
                            serverList()
//                                .border(Color.red)
                            serverInfo {
                                // 只有在 iPhone 才觸發聊天滑入
                                if !isPad {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                                        isChatHidden = false
                                    }
                                }
                            }
                        }
                        
                        UserBadge()
//                            .frame()
//                            .border(Color.blue)
                    }
//                    .ignoresSafeArea()
                    
                    // iPad（大螢幕）直接顯示聊天盒在右邊
                    if isPad {
                        ChatingBox {
                            // iPad 可以不用回收聊天盒，或自訂返回行為
                        }
                        .frame(width: max(geo.size.width * 0.4, 700)) // 自行調整比例
                        .transition(.move(edge: .trailing))
                    }
                }
                
                // iPhone（小螢幕）時，聊天盒用 ZStack 疊上來
                if !isPad {
                    ChatingBox {
                        // 點返回，收回聊天盒
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                            isChatHidden = true
                        }
                    }
                    .frame(width: geo.size.width)
                    .offset(x: isChatHidden ? geo.size.width : 0)
                    .opacity(isChatHidden ? 0 : 1)
                    .animation(.spring(response: 0.35, dampingFraction: 0.9), value: isChatHidden)
//                    .ignoresSafeArea()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//            .border(Color.red)

        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
