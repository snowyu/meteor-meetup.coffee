# Meetup Activity

* Front
  * QRCode to fetch an activity randomly.
  * Chat Room
  * Chat Display on Screen
* Backstage Management
  * CRUD


## Model

* Activity
  * id: autoInc
  * name
  * title
  * description
  * image
  * createdAt: datetime
  * createdBy: String
* User
  * username:
  * phone:
  * password: treat phone as password
  * isAdmin:
  * createdAt

## Front

1. QRCode to fetch an activity randomly
  * a static QRCode page to visit the fetch_activity(Home) page
  * a fetch_activity page:

    ```coffee
    input user name first if no login
    if meetup.enabled
      vActivity = fecthOneRandomly
    gotoChatRoomPage(vActivity)
    # goto the chat room page and show the vActivity name and title on the top
    ```
2. Chat Room Page
  * type message
  * show the others' chat.
  * show the activity if have activity
3. Chat Display(Screen) Page for PC only
  * the left main panel is the chat to interactive.
    * the latest chat message display first
  * the right panel show the qrCode and Co. Intro.

* Back
  * Activities Editor
  * enable the Meetup


## Config

/private/config/server.yml:

```yaml
reset: false # whether clear database after startup.
```

## Third-party Libraries

* meteor
  * yo angular-meteor
* Angular
  * ui-router
  * angular-material
* Jade
* Stylus


* meteor add angular-meteor-auth
* meteor add momentjs:moment
* meteor add dotansimha:accounts-ui-angular
+ meteor add cfs:standard-packages
+ meteor add cfs:filesystem
+ meteor add monbro:yaml-config-loader
+ meteor add angularjs:angular-sanitize
  for use: https://github.com/mistic100/angular-smilies (emojion)

- meteor add utilities:avatar https://github.com/meteor-utilities/avatar/
- meteor add meteorhacks:npm # 这个东西不错，然后你在root目录的package.json中的npm包会自动下载。
  Busboy = Meteor.npmRequire('busboy')

* [accounts-password]: https://www.meteor.com/accounts
  当在客户端调用注册的时候，会自动登入如果成功。

  ```coffee
    Accounts.createUser username: '', password: '', (err)->
  ```
  不过他的UI不能用了。[accounts-ui]
  第三方[ian:accounts-ui-bootstrap-3](https://github.com/ianmartorell/meteor-accounts-ui-bootstrap-3/)
  meteor remove accounts-ui
  meteor add twbs:bootstrap
  meteor add ian:accounts-ui-bootstrap-3
  account-ui-unstyle 没有暴露设置用户最小长度的参数(validateUsername):
    https://github.com/meteor/meteor/blob/master/packages/accounts-ui-unstyled/login_buttons.js
  发现另一个可以取代accounts-ui的： http://useraccounts.meteor.com/
  https://github.com/meteor-useraccounts/core/blob/master/Guide.md 比accounts-ui完善

* meteor add yasseraudio:angular-qrcode-generator
  * https://github.com/monospaced/angular-qrcode
* [upload file](https://github.com/CollectionFS/Meteor-CollectionFS)
  * https://medium.com/@victorleungtw/how-to-upload-files-with-meteor-js-7b8e811510fa#.wbk9pz5o9
* [AutoForm](https://github.com/aldeed/meteor-autoform)
  * 与Angular配合有难度，如果非要用angular 可以用这个[angular-formly](http://angular-formly.com):
    * https://scotch.io/tutorials/easy-angularjs-forms-with-angular-formly
    * wieldo:autoformly: 内部使用angular-formly来自动更新meteor collection，但文档太差劲
* [Animation GIF](http://giphy.com/)
* [disqus like for meteor](https://atmospherejs.com/arkham/comments-ui)
  * another one: https://github.com/Differential/meteor-comments
* [disqus like service writen python](http://posativ.org/isso/)

* nullchat: 显示 giphy 的窗体找到了，它用的是模板。然后通过 Client.ShowModal 渲染到一个modal对话框中
  * 模式窗体模板:client\views\modals\gif\
  * Client.showModal: client\lib\client-utilies.es6.js
  目前为了节约时间不用。

* ui-router 可以用 ui-sref 属性作为代替<a herf=>跳转路由，值为路由名称。
  `<span ui-sref='Main'/>`
  `<a ui-sref="blog.edit-post({id: item.id})"></a>`
* pageTitle:
  * https://github.com/riggerthegeek/ng-page-title
  * https://github.com/nonplus/angular-ui-router-title

* https://github.com/Ranks/emojione

meteor run --port 0.0.0.0:3000

中文翻译的教程:
http://angular.meteorhub.org/tutorials/angular1/routing-and-multiple-views
https://www.codetutorial.io/meteor-server-file-upload/ 这编教程不错

http://ngmodules.org/ : 各种angular 指令模块。
http://www.angular-meteor.com/tutorials/socially/angular1/bootstrapping

```javascript
angular.element(e).injector().get('serviceName')
```

