import router from '@ohos.router';

@Entry
@Component
struct ForgetPassWordPage {

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceAround }) {
      Text('忘记密码')
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
            })
            .width('85%')
        }

        Row({ space: 2 }) {
          Image($r('app.media.message'))
            .width(30)
            .height(30)
          TextInput({ placeholder: '请输入短信验证码' }).type(InputType.Normal)
            .onChange((value) => {
            })
            .width('65%')
          Button('发送', { type: ButtonType.Normal, stateEffect: true })
            .width('20%')
            .fontSize(15)
            .borderRadius(5)
        }
        .margin({ top: 20 })

        Row({ space: 5 }) {
          Image($r('app.media.key'))
            .width(20)
            .height(20)
          TextInput({ placeholder: '请输入您的密码' }).type(InputType.Password)
            .onChange((value) => {
            })
            .width('85%')
        }
        .margin({ top: 20 })

        Button('重置密码', { type: ButtonType.Normal, stateEffect: true })
          .width('95%')
          .fontSize(20)
          .margin({ top: 50 })
          .borderRadius(5)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Index'
            })
          })
      }
      .width('90%')
    }
    .height('100%')
    .width('100%')
  }
}