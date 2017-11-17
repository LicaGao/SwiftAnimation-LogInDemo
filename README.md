# SwiftAnimation-LogInDemo
### 11月16日、17日练习
* 昨天本来是想做个模仿Twitter启动动画的练习，看了一些成品的Demo后发现，关键帧动画真的，无敌好玩！！！所以花了点时间看了看有关关键帧动画的东西。简单写了个动画但是时间太晚了没有上传。</br>所以今天连同昨天的练习一起，写了一个动画效果勉强还算好看（大概吧）的模拟登录界面😂
* duration 设置动画时间，在 values 中设置关键帧，keytimes 中设置对应的时间百分比。timingFunctions中设置对应的速度控制。因为设置了layer.cornerRadius切割成圆角，所以为了保持按钮等组件的圆角不变在使用关键帧动画的同时也混用了基础动画
* 在ListViewController中，模仿[大佬的demo](https://weibo.com/ttarticle/p/show?id=2309403942494873235448&ssl_rnd=1509782817.9439)做了一个tableViewCell背景颜色梯度变化的效果，并且设置visibleCells将cell藏在屏幕底部，使用Spring动画实现弹性效果
