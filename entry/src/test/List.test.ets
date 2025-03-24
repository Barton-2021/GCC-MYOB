import MessageItemTest from './MessageItem.test'
import AIServiceTest from './AIService.test'
import MainPageTest from './MainPage.test'
import localUnitTest from './LocalUnit.test';

export default function testsuite() {
  localUnitTest();
  MainPageTest()
  AIServiceTest()
  MessageItemTest()
}