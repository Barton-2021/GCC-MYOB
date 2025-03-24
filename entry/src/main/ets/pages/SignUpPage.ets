import router from '@ohos.router';

@Entry
@Component
struct SignUpPage {

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceAround }) {
      Text('用户注册')
        .fontSize(35)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)

      Column({ space: 0 }) {
        Row({ space: 5 }) {
          Image($r('app.media.my'))
            .width(20)
            .height(20)
          TextInput({ placeholder: '请输入您的用户名' }).type(InputType.Normal)
            .onChange((value) => {
            })
            .width('85%')
        }

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

        Row({ space: 5 }) {
          Image($r('app.media.phone'))
            .width(20)
            .height(20)
          TextInput({ placeholder: '请输入您的手机号码' }).type(InputType.PhoneNumber)
            .onChange((value) => {
            })
            .width('85%')
        }
        .margin({ top: 20 })

        Button('注册', { type: ButtonType.Normal, stateEffect: true })
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