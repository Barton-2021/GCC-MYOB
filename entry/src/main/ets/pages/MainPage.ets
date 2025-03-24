import router from '@ohos.router';
import { abilityAccessCtrl, bundleManager, common, PermissionRequestResult, Permissions } from '@kit.AbilityKit';
import { map, mapCommon, MapComponent } from '@kit.MapKit'
import { AsyncCallback, BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';
import { geoLocationManager } from '@kit.LocationKit';
import http from '@ohos.net.http';

//AI元素定义
interface Message {
  id:string;
  content: string;
  isAI: boolean;
}

interface DeepSeekConfig {
  ENDPOINT: string;
  API_KEY: string;
  API_URL: string;
}

interface ChatMessage {
  role: "user" | "assistant" | "system"
  content: string
}

const DEEPSEEK_CONFIG: DeepSeekConfig = {
  API_KEY: 'sk-2004207c32944ad693a8eef7733087f6',
  ENDPOINT: 'https://api.deepseek.com/v1/chat/completions',
  API_URL: 'https://api.deepseek.com/v1/chat/completions'
}

@Entry
@Component
struct MainPage {
  @State v: string = ''
  @State refreshing: boolean = false;
  scroller: Scroller = new Scroller()
  //页面刷新
  @State isRefreshing: boolean = false
  @State arr: String[] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
  //选择器
  private fruits: TextCascadePickerRangeContent[] = [
    {
      text: '一教',
      children: [{
        text: '1楼',
        children: [{ text: '101' }, { text: '102' }, { text: '103' },
          { text: '104' }, { text: '105' }, { text: '106' },
          { text: '107' }, { text: '108' }]
      },
        {
          text: '2楼',
          children: [{ text: '201' }, { text: '202' }, { text: '203' }, { text: '204' }, { text: '205' },
            { text: '206' }, { text: '207' }, { text: '208' }]
        },
        {
          text: '3楼',
          children: [{ text: '301' }, { text: '302' }, { text: '303' }, { text: '304' }, { text: '305' },
            { text: '306' }, { text: '307' }, { text: '308' }]
        },
        {
          text: '4楼',
          children: [{ text: '401' }, { text: '402' }, { text: '403' }, { text: '404' }, { text: '405' },
            { text: '406' }, { text: '407' }, { text: '408' }]
        },
        {
          text: '5楼',
          children: [{ text: '501' }, { text: '502' }, { text: '503' }, { text: '504' }, { text: '505' },
            { text: '506' }, { text: '507' }, { text: '508' }]
        },
        {
          text: '6楼',
          children: [{ text: '601' }, { text: '602' }, { text: '603' }, { text: '604' }, { text: '605' },
            { text: '606' }, { text: '607' }, { text: '608' }]
        }]
    },
    {
      text: '二教',
      children: [{
        text: '1楼',
        children: [{ text: '101' }, { text: '102' }, { text: '103' }, { text: '104' }, { text: '105' }, { text: '106' },
          { text: '107' }, { text: '108' }]
      },
        {
          text: '2楼',
          children: [{ text: '201' }, { text: '202' }, { text: '203' }, { text: '204' }, { text: '205' },
            { text: '206' }, { text: '207' }, { text: '208' }]
        },
        {
          text: '3楼',
          children: [{ text: '301' }, { text: '302' }, { text: '303' }, { text: '304' }, { text: '305' },
            { text: '306' }, { text: '307' }, { text: '308' }]
        },
        {
          text: '4楼',
          children: [{ text: '401' }, { text: '402' }, { text: '403' }, { text: '404' }, { text: '405' },
            { text: '406' }, { text: '407' }, { text: '408' }]
        },
        {
          text: '5楼',
          children: [{ text: '501' }, { text: '502' }, { text: '503' }, { text: '504' }, { text: '505' },
            { text: '506' }, { text: '507' }, { text: '508' }]
        },
        {
          text: '6楼',
          children: [{ text: '601' }, { text: '602' }, { text: '603' }, { text: '604' }, { text: '605' },
            { text: '606' }, { text: '607' }, { text: '608' }]
        }]
    },
    {
      text: '三教',
      children: [{
        text: '1楼',
        children: [{ text: '101' }, { text: '102' }, { text: '103' }, { text: '104' }, { text: '105' }, { text: '106' },
          { text: '107' }, { text: '108' }]
      },
        {
          text: '2楼',
          children: [{ text: '201' }, { text: '202' }, { text: '203' }, { text: '204' }, { text: '205' },
            { text: '206' }, { text: '207' }, { text: '208' }]
        },
        {
          text: '3楼',
          children: [{ text: '301' }, { text: '302' }, { text: '303' }, { text: '304' }, { text: '305' },
            { text: '306' }, { text: '307' }, { text: '308' }]
        },
        {
          text: '4楼',
          children: [{ text: '401' }, { text: '402' }, { text: '403' }, { text: '404' }, { text: '405' },
            { text: '406' }, { text: '407' }, { text: '408' }]
        },
        {
          text: '5楼',
          children: [{ text: '501' }, { text: '502' }, { text: '503' }, { text: '504' }, { text: '505' },
            { text: '506' }, { text: '507' }, { text: '508' }]
        },
        {
          text: '6楼',
          children: [{ text: '601' }, { text: '602' }, { text: '603' }, { text: '604' }, { text: '605' },
            { text: '606' }, { text: '607' }, { text: '608' }]
        }]
    },
    {
      text: '四教',
      children: [{
        text: '1楼',
        children: [{ text: '101' }, { text: '102' }, { text: '103' }, { text: '104' }, { text: '105' }, { text: '106' },
          { text: '107' }, { text: '108' }]
      },
        {
          text: '2楼',
          children: [{ text: '201' }, { text: '202' }, { text: '203' }, { text: '204' }, { text: '205' },
            { text: '206' }, { text: '207' }, { text: '208' }]
        },
        {
          text: '3楼',
          children: [{ text: '301' }, { text: '302' }, { text: '303' }, { text: '304' }, { text: '305' },
            { text: '306' }, { text: '307' }, { text: '308' }]
        },
        {
          text: '4楼',
          children: [{ text: '401' }, { text: '402' }, { text: '403' }, { text: '404' }, { text: '405' },
            { text: '406' }, { text: '407' }, { text: '408' }]
        },
        {
          text: '5楼',
          children: [{ text: '501' }, { text: '502' }, { text: '503' }, { text: '504' }, { text: '505' },
            { text: '506' }, { text: '507' }, { text: '508' }]
        },
        {
          text: '6楼',
          children: [{ text: '601' }, { text: '602' }, { text: '603' }, { text: '604' }, { text: '605' },
            { text: '606' }, { text: '607' }, { text: '608' }]
        }]
    },
    {
      text: '五教',
      children: [{
        text: '1楼',
        children: [{ text: '101' }, { text: '102' }, { text: '103' }, { text: '104' }, { text: '105' }, { text: '106' },
          { text: '107' }, { text: '108' }]
      },
        {
          text: '2楼',
          children: [{ text: '201' }, { text: '202' }, { text: '203' }, { text: '204' }, { text: '205' },
            { text: '206' }, { text: '207' }, { text: '208' }]
        },
        {
          text: '3楼',
          children: [{ text: '301' }, { text: '302' }, { text: '303' }, { text: '304' }, { text: '305' },
            { text: '306' }, { text: '307' }, { text: '308' }]
        },
        {
          text: '4楼',
          children: [{ text: '401' }, { text: '402' }, { text: '403' }, { text: '404' }, { text: '405' },
            { text: '406' }, { text: '407' }, { text: '408' }]
        },
        {
          text: '5楼',
          children: [{ text: '501' }, { text: '502' }, { text: '503' }, { text: '504' }, { text: '505' },
            { text: '506' }, { text: '507' }, { text: '508' }]
        },
        {
          text: '6楼',
          children: [{ text: '601' }, { text: '602' }, { text: '603' }, { text: '604' }, { text: '605' },
            { text: '606' }, { text: '607' }, { text: '608' }]
        }]
    },
    {
      text: '六教',
      children: [{
        text: '1楼',
        children: [{ text: '101' }, { text: '102' }, { text: '103' }, { text: '104' }, { text: '105' }, { text: '106' },
          { text: '107' }, { text: '108' }]
      },
        {
          text: '2楼',
          children: [{ text: '201' }, { text: '202' }, { text: '203' }, { text: '204' }, { text: '205' },
            { text: '206' }, { text: '207' }, { text: '208' }]
        },
        {
          text: '3楼',
          children: [{ text: '301' }, { text: '302' }, { text: '303' }, { text: '304' }, { text: '305' },
            { text: '306' }, { text: '307' }, { text: '308' }]
        },
        {
          text: '4楼',
          children: [{ text: '401' }, { text: '402' }, { text: '403' }, { text: '404' }, { text: '405' },
            { text: '406' }, { text: '407' }, { text: '408' }]
        },
        {
          text: '5楼',
          children: [{ text: '501' }, { text: '502' }, { text: '503' }, { text: '504' }, { text: '505' },
            { text: '506' }, { text: '507' }, { text: '508' }]
        },
        {
          text: '6楼',
          children: [{ text: '601' }, { text: '602' }, { text: '603' }, { text: '604' }, { text: '605' },
            { text: '606' }, { text: '607' }, { text: '608' }]
        }]
    },
    {
      text: '七教',
      children: [{
        text: '1楼',
        children: [{ text: '101' }, { text: '102' }, { text: '103' }, { text: '104' }, { text: '105' }, { text: '106' },
          { text: '107' }, { text: '108' }]
      },
        {
          text: '2楼',
          children: [{ text: '201' }, { text: '202' }, { text: '203' }, { text: '204' }, { text: '205' },
            { text: '206' }, { text: '207' }, { text: '208' }]
        },
        {
          text: '3楼',
          children: [{ text: '301' }, { text: '302' }, { text: '303' }, { text: '304' }, { text: '305' },
            { text: '306' }, { text: '307' }, { text: '308' }]
        },
        {
          text: '4楼',
          children: [{ text: '401' }, { text: '402' }, { text: '403' }, { text: '404' }, { text: '405' },
            { text: '406' }, { text: '407' }, { text: '408' }]
        },
        {
          text: '5楼',
          children: [{ text: '501' }, { text: '502' }, { text: '503' }, { text: '504' }, { text: '505' },
            { text: '506' }, { text: '507' }, { text: '508' }]
        },
        {
          text: '6楼',
          children: [{ text: '601' }, { text: '602' }, { text: '603' }, { text: '604' }, { text: '605' },
            { text: '606' }, { text: '607' }, { text: '608' }]
        }]
    },
    {
      text: '八教',
      children: [{
        text: '1楼',
        children: [{ text: '101' }, { text: '102' }, { text: '103' }, { text: '104' }, { text: '105' }, { text: '106' },
          { text: '107' }, { text: '108' }]
      },
        {
          text: '2楼',
          children: [{ text: '201' }, { text: '202' }, { text: '203' }, { text: '204' }, { text: '205' },
            { text: '206' }, { text: '207' }, { text: '208' }]
        },
        {
          text: '3楼',
          children: [{ text: '301' }, { text: '302' }, { text: '303' }, { text: '304' }, { text: '305' },
            { text: '306' }, { text: '307' }, { text: '308' }]
        },
        {
          text: '4楼',
          children: [{ text: '401' }, { text: '402' }, { text: '403' }, { text: '404' }, { text: '405' },
            { text: '406' }, { text: '407' }, { text: '408' }]
        },
        {
          text: '5楼',
          children: [{ text: '501' }, { text: '502' }, { text: '503' }, { text: '504' }, { text: '505' },
            { text: '506' }, { text: '507' }, { text: '508' }]
        },
        {
          text: '6楼',
          children: [{ text: '601' }, { text: '602' }, { text: '603' }, { text: '604' }, { text: '605' },
            { text: '606' }, { text: '607' }, { text: '608' }]
        }]
    },
    {
      text: '九教',
      children: [{
        text: '1楼',
        children: [{ text: '101' }, { text: '102' }, { text: '103' }, { text: '104' }, { text: '105' }, { text: '106' },
          { text: '107' }, { text: '108' }]
      },
        {
          text: '2楼',
          children: [{ text: '201' }, { text: '202' }, { text: '203' }, { text: '204' }, { text: '205' },
            { text: '206' }, { text: '207' }, { text: '208' }]
        },
        {
          text: '3楼',
          children: [{ text: '301' }, { text: '302' }, { text: '303' }, { text: '304' }, { text: '305' },
            { text: '306' }, { text: '307' }, { text: '308' }]
        },
        {
          text: '4楼',
          children: [{ text: '401' }, { text: '402' }, { text: '403' }, { text: '404' }, { text: '405' },
            { text: '406' }, { text: '407' }, { text: '408' }]
        },
        {
          text: '5楼',
          children: [{ text: '501' }, { text: '502' }, { text: '503' }, { text: '504' }, { text: '505' },
            { text: '506' }, { text: '507' }, { text: '508' }]
        },
        {
          text: '6楼',
          children: [{ text: '601' }, { text: '602' }, { text: '603' }, { text: '604' }, { text: '605' },
            { text: '606' }, { text: '607' }, { text: '608' }]
        }]
    }
  ]
  private select: number | number[] = 0
  //状态数据
  @State currentIndex: number = 0;
  @State fanSwitch: boolean = false;
  @State airConditionerSwitch: boolean = false;
  @State lightSwitch: boolean = false;
  @State waterSwitch: boolean = false;
  @State powerSwitch: boolean = false;
  //地图元素
  private mapOptions?: mapCommon.MapOptions;
  private callback?: AsyncCallback<map.MapComponentController>;
  private mapController?: map.MapComponentController;
  private mapEventManager?: map.MapEventManager;
  //AI助手
  @State messages: Message[] = [{
    id: 'init',
    content: '您好！这里是GCC智慧安全管家AI助手，有什么可以帮您？',
    isAI: true
  }];
  @State inputText: string = ''
  private isSending: boolean = false;

  //AI思考
  private addMessage(content: string, isAI: boolean) {
    this.messages = [...this.messages, {
      id: `${Date.now()}_${Math.floor(Math.random() * 1000)}`,
      content: content,
      isAI: isAI
    }];
  }

  //API请求
  private async fetchDeepSeek(prompt: string): Promise<string> {
    const httpRequest = http.createHttp();
    const requestMessages: ChatMessage[] = [{
          role: "user",
          content: prompt
        }]
    try {
      const response = await httpRequest.request(
        DEEPSEEK_CONFIG.ENDPOINT,
        {
          method: http.RequestMethod.POST,
          header: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${DEEPSEEK_CONFIG.API_KEY}`
          },
          extraData: JSON.stringify({
            model: "deepseek-chat",
            messages: requestMessages
          })
        })
      if (response.responseCode === 200) {
        return JSON.parse(response.result.toString()).choices[0].message.content;
      }
      throw new Error(`API Error: ${response.responseCode}`);
    } finally {
      httpRequest.destroy();
    }
  }

  // 消息处理流程
  private async handleSend() {
    if (this.isSending || !this.inputText.trim()) return;
    this.isSending = true;
    const userInput = this.inputText;
    // 清空输入
    this.inputText = '';
    // 添加用户消息
    this.addMessage(userInput, false);
    // 添加加载提示
    this.addMessage('思考中...', true);
    try {
      const aiResponse = await this.fetchDeepSeek(userInput);
      // 移除加载提示
      this.messages = this.messages.filter(msg => msg.content !== '思考中...');
      // 添加AI回复
      this.addMessage(aiResponse, true);
    } catch (e) {
      this.messages = this.messages.filter(msg => msg.content !== '思考中...');
      this.addMessage('请求失败，请重试', true);
    } finally {
      this.isSending = false;
    }
  }

  // 校验应用是否被授予定位权限，可以通过调用checkAccessToken()方法来校验当前是否已经授权。
  async checkPermissions(): Promise<boolean> {
    const permissions: Array<Permissions> = ['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION'];
    for (let permission of permissions) {
      let grantStatus: abilityAccessCtrl.GrantStatus = await this.checkAccessToken(permission);
      if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        // 启用我的位置图层，mapController为地图操作类对象，获取方式详见显示地图章节
        this.mapController?.setMyLocationEnabled(true);
        // 启用我的位置按钮
        this.mapController?.setMyLocationControlsEnabled(true);
        return true;
      }
    }
    return false;
  }

  // 如果没有被授予定位权限，动态向用户申请授权
  requestPermissions(): void {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    atManager.requestPermissionsFromUser(getContext() as common.UIAbilityContext,
      ['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION'])
      .then((data: PermissionRequestResult) => {
        // 启用我的位置图层
        this.mapController?.setMyLocationEnabled(true);
      })
      .catch((err: BusinessError) => {
        console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
      })
  }

  async checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;
    // 获取应用程序的accessTokenID
    let tokenId: number = 0;
    let bundleInfo: bundleManager.BundleInfo =
      await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
    console.info('Succeeded in getting Bundle.');
    let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
    tokenId = appInfo.accessTokenId;
    // 校验应用是否被授予权限
    grantStatus = await atManager.checkAccessToken(tokenId, permission);
    console.info('Succeeded in checking access token.');
    return grantStatus;
  }

  aboutToAppear(): void {
    // 地图初始化参数，设置地图中心点坐标及层级，以广州市为例
    this.mapOptions = {
      position: ({
        target: ({
          latitude: 23.1836,
          longitude: 113.3341
        }),
        zoom: 10
      }),
      mapType: mapCommon.MapType.STANDARD,
      myLocationControlsEnabled: true,
      scaleControlsEnabled: true
    };

    // 地图初始化的回调
    this.callback = async (err, mapController) => {
      if (!err) {
        // 获取地图的控制器类，用来操作地图
        this.mapController = mapController;
        this.mapController.setBuildingEnabled(true);
        // this.mapController.setMapType(mapCommon.MapType.TERRAIN);
        // 设置地图为自动模式
        this.mapController.setDayNightMode(mapCommon.DayNightMode.AUTO);
        this.mapEventManager = this.mapController.getEventManager();
        // 获取用户位置坐标
        let location = await geoLocationManager.getCurrentLocation();
        // 设置用户的位置
        this.mapController.setMyLocation(location);
        this.mapController.on('mapLoad', () => {
          promptAction.showToast({
            message: '地图加载中',
            duration: 5000
          })
        })
      }
    };
  }

  // 页面每次显示时触发一次，包括路由过程、应用进入前台等场景，仅@Entry装饰的自定义组件生效
  onPageShow(): void {
    // 将地图切换到前台
    if (this.mapController) {
      this.mapController.show();
    }
  }

  // 页面每次隐藏时触发一次，包括路由过程、应用进入后台等场景，仅@Entry装饰的自定义组件生效
  onPageHide(): void {
    // 将地图切换到后台
    if (this.mapController) {
      this.mapController.hide();
    }
  }

  //自定义构造器
  @Builder
  buildTabBar(index: number, title: string) {
    Column() {
      if (0 == index) {
        Image($r("app.media.shield")).width(30).fillColor(this.currentIndex == index ? "#ff0016ca" : "#ff000000")
        Text(title).fontColor(this.currentIndex == index ? "#ff0016ca" : "#ff000000").fontWeight(FontWeight.Bold)
      } else if (1 == index) {
        Image($r("app.media.bicyclesafety")).width(30).fillColor(this.currentIndex == index ? "#ff0016ca" : "#ff000000")
        Text(title).fontColor(this.currentIndex == index ? "#ff0016ca" : "#ff000000").fontWeight(FontWeight.Bold)
      } else if (2 == index) {
        Image($r("app.media.AI")).width(32).fillColor(this.currentIndex == index ? "#ff0016ca" : "#ff000000")
        Text(title).fontColor(this.currentIndex == index ? "#ff0016ca" : "#ff000000").fontWeight(FontWeight.Bold)
      } else if (3 == index) {
        Image($r("app.media.my")).width(32).fillColor(this.currentIndex == index ? "#ff0016ca" : "#ff000000")
        Text(title).fontColor(this.currentIndex == index ? "#ff0016ca" : "#ff000000").fontWeight(FontWeight.Bold)
      }
    }
    .border({ width: { top: 1 }, color: '#ddd' })
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {

      //环境安全模块
      TabContent() {
        Refresh({ refreshing: $$this.isRefreshing }) {
          Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Start, justifyContent: FlexAlign.Start }) {
            Column() {
              Row({ space: 100 }) {
                Image($r('app.media.shield'))
                  .width(25)
                  .height(25)
                Text('环境安全')
                  .fontSize(20)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Bold)
                Image($r('app.media.refresh'))
                  .width(22)
                  .height(22)
              }

              //宿舍模块
              Tabs({ barPosition: BarPosition.Start }) {
                TabContent() {
                  Column({ space: 20 }) {
                    Text("  宿舍号")
                      .width("90%")
                      .margin({ top: -100 })
                      .textAlign(TextAlign.Start)
                    Text("38栋xxxx宿舍")
                      .width(300)
                      .margin(10)
                      .textAlign(TextAlign.Start)
                      .borderWidth(1)
                      .padding(10)
                    Text("  开关设置")
                      .width("90%")
                      .textAlign(TextAlign.Start)
                    Column({ space: 15 }) {
                      this.buildSwitchRow('风扇', this.fanSwitch)
                      this.buildSwitchRow('空调', this.airConditionerSwitch)
                      this.buildSwitchRow('灯光', this.lightSwitch)
                      this.buildSwitchRow('水闸', this.waterSwitch)
                      this.buildSwitchRow('电闸', this.powerSwitch)
                    }
                    .width('100%')
                    .padding({ left: 20, right: 20 })
                  }.width("90%").alignItems(HorizontalAlign.Start).justifyContent(FlexAlign.Start)
                }.tabBar("宿舍").border({ width: { top: 1 }, color: '#ddd' }).width("100%").height("100%")

                //教室模块
                TabContent() {
                  Column({ space: 20 }) {
                    Text("  教室号")
                      .margin({ top: -50 })
                      .width("90%")
                      .textAlign(TextAlign.Start)
                    Button("教室：" + this.v, { type: ButtonType.Normal, stateEffect: true })
                      .width("85%")
                      .margin(10)
                      .onClick(() => {
                        this.getUIContext().showTextPickerDialog({
                          range: this.fruits,
                          selected: this.select,
                          disappearTextStyle: { color: Color.Gray, font: { size: 15, weight: FontWeight.Normal } },
                          textStyle: { color: Color.Black, font: { size: 20, weight: FontWeight.Normal } },
                          selectedTextStyle: { color: Color.Blue, font: { size: 30, weight: FontWeight.Normal } },
                          onAccept: (value: TextPickerResult) => {
                            this.select = value.index
                            this.v = value.value as string
                          }
                        })
                      })
                    Text("  开关设置")
                      .width("90%")
                      .textAlign(TextAlign.Start)
                    Column({ space: 15 }) {
                      this.buildSwitchRow('风扇', this.fanSwitch)
                      this.buildSwitchRow('空调', this.airConditionerSwitch)
                      this.buildSwitchRow('灯光', this.lightSwitch)
                      this.buildSwitchRow('电闸', this.powerSwitch)
                    }
                    .width('100%')
                    .padding({ left: 20, right: 20 })

                    Row({ space: 10 }) {
                      Column() {
                        Text('温度')
                          .fontSize(16)
                          .textAlign(TextAlign.Center)
                        Text('25°C')
                          .fontSize(20)
                          .fontWeight(FontWeight.Bold)
                          .textAlign(TextAlign.Center)
                      }
                      .width('30%')
                      .backgroundColor('#FFFF00')
                      .padding({ top: 10, bottom: 10 })

                      Column() {
                        Text('湿度')
                          .fontSize(16)
                          .textAlign(TextAlign.Center)
                        Text('60%')
                          .fontSize(20)
                          .fontWeight(FontWeight.Bold)
                          .textAlign(TextAlign.Center)
                      }
                      .width('30%')
                      .backgroundColor('#FFFF00')
                      .padding({ top: 10, bottom: 10 })

                      Column() {
                        Text('二氧化碳')
                          .fontSize(16)
                          .textAlign(TextAlign.Center)
                        Text('400ppm')
                          .fontSize(20)
                          .fontWeight(FontWeight.Bold)
                          .textAlign(TextAlign.Center)
                      }
                      .width('30%')
                      .backgroundColor('#FFFF00')
                      .padding({ top: 10, bottom: 10 })
                    }
                    .width('100%')
                    .margin({ bottom: 20 })
                    .justifyContent(FlexAlign.Center)
                  }.width('100%').margin({ top: 5 })
                }.tabBar("教室").border({ width: { top: 1 }, color: '#ddd' }).width("100%").height("100%")
              }.scrollable(false)
            }.justifyContent(FlexAlign.SpaceAround).margin({ top: 5 })
          }
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
      }.tabBar(this.buildTabBar(0, "环境安全"))

      //自行车安全模块
      TabContent() {
        Refresh({ refreshing: $$this.isRefreshing }) {
          Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Start, justifyContent: FlexAlign.Start }) {
            Column() {
              Row({ space: 90 }) {
                Image($r('app.media.bicyclesafety'))
                  .width(25)
                  .height(25)
                Text('自行车安全')
                  .fontSize(20)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Bold)
                Image($r('app.media.refresh'))
                  .width(22)
                  .height(22)
              }

              Row({ space: 20 }) {
                Column() {
                  Text('上锁情况')
                    .fontSize(20)
                    .fontColor(Color.Black)
                  Row({ space: 5 }) {
                    Text('否')
                      .fontSize(20)
                      .fontColor(Color.Black)
                    Toggle({ type: ToggleType.Switch, isOn: false })
                    Text('是')
                      .fontSize(20)
                      .fontColor(Color.Black)
                  }
                  .margin({ top: 10 })
                }

                Column() {
                  Text('上次停放位置')
                    .fontSize(20)
                    .fontColor(Color.Black)
                  Row({ space: 10 }) {
                    Image($r('app.media.location'))
                      .width(20)
                      .height(20)
                    Text('广东省广州市黄埔区')
                      .fontSize(20)
                      .fontColor(Color.Black)
                  }
                  .margin({ top: 10 })
                }
              }
              .margin({ top: 50 })

              //地图
              MapComponent({
                mapOptions: this.mapOptions,
                mapCallback: this.callback
              })
                .width('100%')
                .height('77%')
                .margin({ top: 25 })
            }
            .margin({ top: 5 })
          }
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
      }.tabBar(this.buildTabBar(1, "自行车安全"))
      .onClick(() => {
        this.requestPermissions()
      })

      //AI助手模块
      TabContent() {
        Refresh({ refreshing: $$this.isRefreshing }) {
          Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Start, justifyContent: FlexAlign.Start }) {
            Column() {
              Row({ space: 115 }) {
                Image($r('app.media.AI'))
                  .width(25)
                  .height(25)
                Text('AI助手')
                  .fontSize(20)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Bold)
                Image($r('app.media.refresh'))
                  .width(22)
                  .height(22)
              }

              Column() {
                List({ space: 10 }) {
                  ForEach(this.messages, (msg: Message) => {
                    ListItem() {
                      Column() {
                        Text(msg.content)
                          .padding(12)
                          .backgroundColor(msg.isAI ? '#f0f0f0' : '#007DFF')
                          .borderRadius(8)
                          .margin({ top: 20 })
                          .fontColor(msg.isAI ? '#333' : 'white')
                      }
                      .width('100%')
                      .alignItems(msg.isAI ? HorizontalAlign.Start : HorizontalAlign.End)
                    }
                  })
                }
                .layoutWeight(1)
                .width('100%')

                // 输入区域
                Row({ space: 10 }) {
                  TextInput({ text: this.inputText, placeholder: '输入消息...' })
                    .onChange((value) => {
                      this.inputText = value
                    })
                    .layoutWeight(1)

                  Button('发送')
                    .onClick(() => this.handleSend())
                    .enabled(!this.isSending)
                }
                .padding(10)
                .width('100%')
                .backgroundColor('#ffffff')
              }
            }
            .height('98%')
            .margin({ top: 0 })
            .padding(10)
          }
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
      }.tabBar(this.buildTabBar(2, "AI助手"))

      //“我的”模块
      TabContent() {
        Refresh({ refreshing: $$this.isRefreshing }) {
          Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Start, justifyContent: FlexAlign.Start }) {
            Column() {
              Row({ space: 115 }) {
                Image($r('app.media.my'))
                  .width(25)
                  .height(25)
                Text('我的')
                  .fontSize(20)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Bold)
                Image($r('app.media.refresh'))
                  .width(22)
                  .height(22)
              }

              Scroll(this.scroller) {
                Swiper() {
                  Image($r("app.media.myphoto1"))
                    .width("100%")
                    .height("25%")
                    .objectFit(ImageFit.Fill)
                    .margin({ top: 10 })

                  Image($r("app.media.myphoto2"))
                    .width("100%")
                    .height("25%")
                    .objectFit(ImageFit.Fill)
                    .margin({ top: 10 })

                  Image($r("app.media.myphoto3"))
                    .width("100%")
                    .height("25%")
                    .objectFit(ImageFit.Fill)
                    .margin({ top: 10 })

                }
                .loop(true)
                .autoPlay(true)
                .interval(3000)
                .margin({ top: 5 })
              }

              Image($r("app.media.my"))
                .width(80)
              Text("李广商")
                .margin(5)
                .textAlign(TextAlign.Center)

              Row() {
                Image($r("app.media.id"))
                  .width(25)
                Text("  个人资料                                           ")
                Image($r("app.media.right"))
                  .width(25)
              }
              .margin({ top: 15 })
              .width("90%")
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/MyidPage'
                })
              })

              Divider()
                .width("90%")
                .strokeWidth(1)
                .margin({ top: 10 })

              Row() {
                Image($r("app.media.guanlian"))
                  .width(25)
                Text("  关联管理                                           ")
                Image($r("app.media.right"))
                  .width(25)
              }
              .margin({ top: 15 })
              .width("90%")
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/AssociationPage'
                })
              })

              Divider()
                .width("90%")
                .strokeWidth(1)
                .margin({ top: 10 })

              Row() {
                Image($r("app.media.anquan"))
                  .width(25)
                Text("  账户安全                                           ")
                Image($r("app.media.right"))
                  .width(25)
              }
              .margin({ top: 15 })
              .width("90%")
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/AccountPage'
                })
              })

              Divider()
                .width("90%")
                .strokeWidth(1)
                .margin({ top: 10 })

              Row() {
                Image($r("app.media.guanyu"))
                  .width(25)
                Text("  关于我们                                           ")
                Image($r("app.media.right"))
                  .width(25)
              }
              .margin({ top: 15 })
              .width("90%")
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/AboutPage'
                })
              })

              Divider()
                .width("90%")
                .strokeWidth(1)
                .margin({ top: 10 })

              Button('退出登录', { type: ButtonType.Normal, stateEffect: true })
                .width('70%')
                .fontSize(20)
                .margin({ top: 25 })
                .borderRadius(5)
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/Index'
                  })
                })

              Button('注销账号', { type: ButtonType.Normal, stateEffect: true })
                .width('70%')
                .fontSize(20)
                .margin({ top: 10 })
                .borderRadius(5)
                .backgroundColor(Color.Red)
                .onClick(() => {
                  this.getUIContext().showAlertDialog(
                    {
                      title: '将注销账号',
                      message: '是否确认注销账号',
                      autoCancel: true,
                      alignment: DialogAlignment.Center,
                      offset: { dx: 0, dy: -20 },
                      gridCount: 5,
                      transition: TransitionEffect.asymmetric(TransitionEffect.OPACITY
                        .combine(TransitionEffect.scale({ x: 1.5, y: 1.5 })),
                        TransitionEffect.OPACITY
                          .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 })
                          )),
                      buttons: [{
                        value: '取消',
                        action: () => {
                        }
                      },
                        {
                          enabled: true,
                          defaultFocus: true,
                          style: DialogButtonStyle.HIGHLIGHT,
                          value: '确认',
                          backgroundColor: Color.Red,
                          action: () => {
                            router.pushUrl({
                              url: 'pages/Index'
                            })
                          }
                        }],
                    }
                  )
                })

              Text("版本号：1.0.0")
                .fontColor(Color.Gray)
                .fontStyle(FontStyle.Normal)
                .fontWeight(FontWeight.Lighter)
                .fontSize(15)
                .margin({ top: 30 })
            }
            .margin({ top: 5 })
          }
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
      }.tabBar(this.buildTabBar(3, "我的"))
     }
     .margin({top:10})
     .barHeight(75)
     .scrollable(false)
     .width("100%")
     .height("100%")
     //标签页选择事件，index表示当前标签页索引
     .onChange(index => {
       this.currentIndex = index;
     })
  }

  //元素定义
  @Builder
  buildSwitchRow(label: string, isOn: boolean) {
    Row({ space: 10 }) {
      if (label === '风扇') {
        Image($r("app.media.fan"))
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
          .margin({ right: 5 });
      } else if (label === '空调') {
        Image($r("app.media.airconditioner"))
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
          .margin({ right: 5 });
      } else if (label === '灯光') {
        Image($r("app.media.lamplight"))
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
          .margin({ right: 5 });
      } else if (label === '水闸') {
        Image($r("app.media.sluice"))
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
          .margin({ right: 5 });
      } else if (label === '电闸') {
        Image($r("app.media.electricbrake"))
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
          .margin({ right: 5 });
      }

      Text(label)
        .fontSize(16)
        .width('30%');

      Text(' ')
        .width('auto')
        .layoutWeight(1);

      Row() {
        Text('关')
          .fontSize(14)
          .opacity(1);

        Toggle({
          type: ToggleType.Switch,
          isOn: isOn
        })
          .width(60)
          .height(30)
          .onChange((checked: boolean) => {
            switch (label) {
              case '风扇':
                this.fanSwitch = checked;
                break;
              case '空调':
                this.airConditionerSwitch = checked;
                break;
              case '灯光':
                this.lightSwitch = checked;
                break;
              case '水闸':
                this.waterSwitch = checked;
                break;
              case '电闸':
                this.powerSwitch = checked;
                break;
            }
          });

        Text('开')
          .fontSize(14)
          .opacity(1);
      }
      .width('auto')
      .justifyContent(FlexAlign.End);
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 10, right: 10 });
  }
}