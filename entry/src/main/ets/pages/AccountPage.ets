import router from '@ohos.router';
import { CustomContentDialog } from '@kit.ArkUI'

@Entry
@Component
struct AccountPage {
  @State message: string = 'Hello World';
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomContentDialog({
      primaryTitle: '修改密码',
      // secondaryTitle: '辅助文本',
      contentBuilder: () => {
        this.buildContent();
      },
      buttons: [
        {
          value: '取消',
          buttonStyle: ButtonStyleMode.TEXTUAL,
          action: () => {
            // console.info('Callback when the button is clicked')
          }
        },
        {
          value: '保存',
          buttonStyle: ButtonStyleMode.TEXTUAL,
          // role: ButtonRole.ERROR
        }
      ],
    }),
  });

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Start }) {
      Column({ space: 20 }) {
        Row({ space: 100 }) {
          Image($r('app.media.back'))
            .width(25)
            .height(25)
            .onClick(() => {
              router.back() // 标准返回函数
            })
          Text('账户安全')
            .fontSize(20)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
          Image($r('app.media.refresh'))
            .width(22)
            .height(22)
        }
        .margin(15)

        Row({ space: 5 }) {
          Text("  密码")
            .width("20%")
            .textAlign(TextAlign.Start)
          Text("***************")
            .width("60%")
            .height(30)
            .textAlign(TextAlign.Start)
            .padding(0)
        }
        .margin({ top: 20 })

        Row({ space: 10 }) {
          Button('取消', { type: ButtonType.Normal, stateEffect: true })
            .fontSize(20)
            .fontColor(Color.Black)
            .width('50%')
            .borderWidth(1)
            .backgroundColor(Color.White)
            .onClick(() => {
              router.back() // 标准返回函数
            })

          Button('修改密码', { type: ButtonType.Normal, stateEffect: true })
            .fontSize(20)
            .fontColor(Color.White)
            .width('50%')
            .borderWidth(1)
            .backgroundColor(Color.Blue)// .onClick(() => {
              //   router.pushUrl({
              //     url: 'pages/MainPage'
              //   })
              // })
            .onClick(() => {
              this.dialogController.open()
            })
        }
        .margin(20)

      }
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  buildContent(): void {
    Column() {
      Row({ space: 5 }) {
        Text("新密码")
          .width("20%")
          .textAlign(TextAlign.Start)
        TextInput({ placeholder: '请输入密码' })
          .type(InputType.Password)
          .width("60%")
          .height(30)
          .textAlign(TextAlign.Start)
          .padding(0)
      }

      Row({ space: 5 }) {
        Text("确认密码")
          .width("30%")
          .textAlign(TextAlign.Start)
        TextInput({ placeholder: '请再次输入密码' })
          .type(InputType.Password)
          .width("50%")
          .height(30)
          .textAlign(TextAlign.Start)
          .padding(0)
      }
      .margin({ top: 10 })
    }
    .width('100%')
  }
}