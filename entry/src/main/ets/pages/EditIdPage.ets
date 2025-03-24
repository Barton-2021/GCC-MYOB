import router from '@ohos.router';

@Entry
@Component
struct EditIdPage {
  //页面刷新
  @State isRefreshing: boolean = false
  @State arr: String[] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10']

  build() {
    Refresh({ refreshing: $$this.isRefreshing }) {
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Start }) {
        Column({ space: 20 }) {
          Row({ space: 100 }) {
            Image($r('app.media.back'))
              .width(25)
              .height(25)
              .onClick(() => {
                router.back() // 标准返回函数
              })
            Text('编辑资料')
              .fontSize(20)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
            Image($r('app.media.refresh'))
              .width(22)
              .height(22)
          }
          .margin(15)

          Image($r("app.media.id"))
            .width(100)
            .height(100)
            .margin({ top: 20 })

          Row({ space: 5 }) {
            Text("  用户名")
              .width("20%")
              .textAlign(TextAlign.Start)
            TextInput({ placeholder: '请输入您的用户名' })
              .type(InputType.Normal)
              .width("60%")
              .height(30)
              .textAlign(TextAlign.Start)
              .padding(0)
          }
          .margin({ top: 20 })

          Row({ space: 5 }) {
            Text("  手机号码")
              .width("30%")
              .textAlign(TextAlign.Start)
            TextInput({ placeholder: '请输入您的手机号码' })
              .type(InputType.Number)
              .width("50%")
              .height(30)
              .textAlign(TextAlign.Start)
              .padding(0)
          }
          .margin({ top: 20 })

          Row({ space: 5 }) {
            Text("  邮箱")
              .width("20%")
              .textAlign(TextAlign.Start)
            TextInput({ placeholder: '请输入您的邮箱' })
              .width("60%")
              .height(30)
              .textAlign(TextAlign.Start)
              .padding(0)
          }
          .margin({ top: 20 })

          Row({ space: 5 }) {
            Text("  地址")
              .width("20%")
              .textAlign(TextAlign.Start)
            TextInput({ placeholder: '请输入您的地址' })
              .type(InputType.Normal)
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

            Button('保存', { type: ButtonType.Normal, stateEffect: true })
              .fontSize(20)
              .fontColor(Color.White)
              .width('50%')
              .borderWidth(1)
              .backgroundColor(Color.Blue)
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/MainPage'
                })
              })
          }
          .margin(20)
        }
      }
      .height('100%')
      .width('100%')
    }
    .onStateChange((refreshStatus: RefreshStatus) => {
      console.info('Refresh onStatueChange state is ' + refreshStatus)
    })
    .onOffsetChange((value: number) => {
      console.info('Refresh onOffsetChange offset:' + value)
    })
    .onRefreshing(() => {
      setTimeout(() => {
        this.isRefreshing = false
      }, 2000)
      console.log('onRefreshing test')
    })
    .refreshOffset(64)
    .pullToRefresh(true)
  }
}