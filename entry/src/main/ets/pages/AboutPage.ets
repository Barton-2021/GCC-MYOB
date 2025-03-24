import router from '@ohos.router';

@Entry
@Component
struct AboutPage {
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
            Text('关于我们')
              .fontSize(20)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
            Image($r('app.media.refresh'))
              .width(22)
              .height(22)
          }
          .margin(15)

          Image($r("app.media.logo"))
            .width(100)
            .height(100)
            .margin({ top: 20 })

          Row({ space: 10 }) {
            Image($r("app.media.team"))
              .width(25)
            Text("开发团队：  广州智尘梦科技工作室")
              .fontWeight(FontWeight.Medium)
          }
          .margin({ top: 15 })
          .width("90%")

          Divider()
            .width("90%")
            .strokeWidth(1)

          Row({ space: 10 }) {
            Image($r("app.media.location"))
              .width(25)
            Text("办公地址：  广东省广州市黄埔区")
              .fontWeight(FontWeight.Medium)
          }
          .width("90%")

          Divider()
            .width("90%")
            .strokeWidth(1)

          Row({ space: 10 }) {
            Image($r("app.media.callphone"))
              .width(25)
            Text("联系我们：  133333333333")
              .fontWeight(FontWeight.Medium)
          }
          .width("90%")

          Divider()
            .width("90%")
            .strokeWidth(1)
        }

        Row({ space: 10 }) {
          Image($r("app.media.email"))
            .width(25)
          Text("电子邮箱：  1122@changeyear.cn")
            .fontWeight(FontWeight.Medium)
        }
        .margin({ top: 20 })
        .width("90%")

        Divider()
          .width("90%")
          .strokeWidth(1)
          .margin({ top: 20 })

        Row({ space: 10 }) {
          Image($r("app.media.web"))
            .width(25)
          Text("企业官网：  www.changeyear.cn")
            .fontWeight(FontWeight.Medium)
        }
        .margin({ top: 20 })
        .width("90%")

        Divider()
          .width("90%")
          .strokeWidth(1)
          .margin({ top: 20 })
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