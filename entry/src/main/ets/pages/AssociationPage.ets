import router from '@ohos.router';
import { scanBarcode, scanCore } from '@kit.ScanKit';
import { JSON } from '@kit.ArkTS';
import { promptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';


@Entry
@Component
struct AssociationPage {
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
            Text('关联管理')
              .fontSize(20)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
            Image($r('app.media.refresh'))
              .width(22)
              .height(22)
          }
          .margin(15)

          Text("  宿舍号")
            .width("90%")
            .margin({ top: 10 })
            .textAlign(TextAlign.Start)
          Text("38栋xxxx宿舍")
            .width(300)
            .margin(10)
            .textAlign(TextAlign.Start)
            .borderWidth(1)
            .padding(10)
          TextInput({ placeholder: '请输入您的宿舍号' }).type(InputType.Number)
            .width('85%')
            .margin(10)
          Text("  自行车")
            .width("90%")
            .textAlign(TextAlign.Start)
          Text("0001号")
            .width(300)
            .margin(10)
            .textAlign(TextAlign.Start)
            .borderWidth(1)
            .padding(10)
          Button('扫码绑定自行车设备')
            .margin({ top: 20 })
            .type(ButtonType.Normal)
            .borderRadius(8)
            .onClick(async () => {
              console.info("[ScanKitDemo] 默认界面扫码开始。");
              const options: scanBarcode.ScanOptions = {
                scanTypes: [scanCore.ScanType.ALL],
                enableMultiMode: true,
                enableAlbum: true
              };
              try {
                const result: scanBarcode.ScanResult = await scanBarcode.startScanForResult(getContext(this), options);
                console.info("[ScanKitDemo] Succeed. Data:" + JSON.stringify(result));
                promptAction.showToast({
                  message: JSON.stringify(result),
                  duration: 5000
                })
              } catch (error) {
                const e: BusinessError = error as BusinessError;
                console.error("[ScanKitDemo] Failed. Cause:" + JSON.stringify(e));
              }
            })

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
          .margin(50)
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