import router from '@ohos.router'

@Entry
@Component
struct Index {
  @State account: String = ''
  @State password: string = ''
  scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceAround }) {
        Text('GCC智慧安全管家')
          .fontSize(35)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)

        Column({ space: 0 }) {
          Row({ space: 5 }) {
            Image($r('app.media.phone'))
              .width(20)
              .height(20)
            TextInput({ placeholder: '请输入您的手机号码' }).type(InputType.PhoneNumber)
              .onChange((value) => {
                this.account = value;
              })
              .width('85%')
          }

          Row({ space: 5 }) {
            Image($r('app.media.key'))
              .width(20)
              .height(20)
            TextInput({ placeholder: '请输入您的密码' }).type(InputType.Password)
              .onChange((value) => {
                this.password = value;
              })
              .width('85%')
          }
          .margin({ top: 20 })

          Button('登录', { type: ButtonType.Normal, stateEffect: true })
            .width('95%')
            .fontSize(20)
            .margin({ top: 50 })
            .borderRadius(5)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/MainPage'
              })
            })

          Row({ space: 0 }) {
            Button('忘记密码', { type: ButtonType.Normal, stateEffect: true })
              .fontSize(20)
              .fontColor(Color.Grey)
              .width('50%')
              .backgroundColor(Color.White)
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/ForgetPassWordPage'
                })
              })

            Button('注册账号', { type: ButtonType.Normal, stateEffect: true })
              .fontSize(20)
              .fontColor(Color.Blue)
              .width('50%')
              .backgroundColor(Color.White)
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/SignUpPage'
                })
              })
          }
          .margin({ top: 30 })
        }
        .width('90%')
      }
      .height('100%')
      .width('100%')
    }
  }
}