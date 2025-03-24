import router from '@ohos.router';

@Entry
@Component
struct MyidPage {
  //页面刷新
  @State isRefreshing: boolean = false
  @State arr: String[] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10']

  build() {
    Refresh({ refreshing: $$this.isRefreshing }) {
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Start }) {
        Column() {
          Row({ space: 100 }) {
            Image($r('app.media.back'))
              .width(25)
              .height(25)
              .onClick(() => {
                router.back() // 标准返回函数
              })
            Text('个人资料')
              .fontSize(20)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
            Image($r('app.media.refresh'))
              .width(22)
              .height(22)
          }
          .margin(15)

          Text("  用户名")
            .width("90%")
            .margin({ top: 10 })
            .textAlign(TextAlign.Start)
          Text("李广商")
            .width(300)
            .margin(10)
            .textAlign(TextAlign.Start)
            .borderWidth(1)
            .padding(10)
          Text("  电话号码")
            .width("90%")
            .textAlign(TextAlign.Start)
          Text("12345678911")
            .width(300)
            .margin(10)
            .textAlign(TextAlign.Start)
            .borderWidth(1)
            .padding(10)
          Text("  邮箱")
            .width("90%")
            .textAlign(TextAlign.Start)
          Text("liguangshang@qq.com")
            .width(300)
            .margin(10)
            .textAlign(TextAlign.Start)
            .borderWidth(1)
            .padding(10)
          Text("  地址")
            .width("90%")
            .textAlign(TextAlign.Start)
          Text("广东省广州市")
            .width(300)
            .margin(10)
            .textAlign(TextAlign.Start)
            .borderWidth(1)
            .padding(10)

          Button('编辑资料', { type: ButtonType.Normal, stateEffect: true })
            .width('50%')
            .fontSize(20)
            .margin({ top: 50 })
            .borderRadius(5)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/EditIdPage'
              })
            })
        }
      }
      .width("100%")
      .height("100%")
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