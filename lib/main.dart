import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riki_packages_tag/api/gitlab_client.dart';
import 'package:riki_packages_tag/entitys/gitlab_project_entity.dart';
import 'package:dio/dio.dart';
import 'package:riki_packages_tag/entitys/gitlab_tag_entity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RikiPackagesTag',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, List<GitlabProjectEntity>> projects = {
    '用户(C)端': [
      GitlabProjectEntity(projectId: 338, name: 'riki-user_home', subtitle: '首页'),
      GitlabProjectEntity(projectId: 336, name: 'riki-user_mine', subtitle: '我的'),
      GitlabProjectEntity(projectId: 339, name: 'riki-user_shop', subtitle: '商城'),
      GitlabProjectEntity(projectId: 326, name: 'riki-order', subtitle: '订单'),
    ],
    '服务者(B)端': [
      GitlabProjectEntity(projectId: 337, name: 'riki-staff_mine', subtitle: '我的'),
    ],
    '通用(B+C)端': [
      GitlabProjectEntity(projectId: 152, name: 'riki-im', subtitle: 'IM'),
      GitlabProjectEntity(projectId: 322, name: 'riki-process_service', subtitle: '装修流程'),
      GitlabProjectEntity(projectId: 348, name: 'riki-personal_home', subtitle: '个人主页'),
    ],
    '公共组件': [
      GitlabProjectEntity(projectId: 318, name: 'riki-map', subtitle: '地图'),
      GitlabProjectEntity(projectId: 153, name: 'riki-webview', subtitle: 'WebView'),
      GitlabProjectEntity(projectId: 327, name: 'riki-login', subtitle: '登录'),
      GitlabProjectEntity(projectId: 324, name: 'riki-account', subtitle: '账户信息'),
      GitlabProjectEntity(projectId: 314, name: 'riki-ui', subtitle: 'UI包'),
      GitlabProjectEntity(projectId: 310, name: 'riki-router', subtitle: '路由'),
      GitlabProjectEntity(projectId: 146, name: 'riki-base', subtitle: '基础组件'),
      GitlabProjectEntity(projectId: 325, name: 'riki-project_config', subtitle: '项目配置'),
    ]
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [];

    projects.forEach((key, value) {
      slivers.add(SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          child: Text(
            key,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ));
      slivers.add(SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            return GitlabProjectItem(
              project: value[index],
            );
          },
          childCount: value.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 16 / 5,
        ),
      ));
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: slivers,
        ),
      ),
    );
  }
}

class GitlabProjectItem extends StatefulWidget {
  final GitlabProjectEntity project;

  const GitlabProjectItem({Key? key, required this.project}) : super(key: key);

  @override
  _GitlabProjectItemState createState() => _GitlabProjectItemState();
}

class _GitlabProjectItemState extends State<GitlabProjectItem> {
  GitlabClient _gitlabClient = GitlabClient(Dio());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GitlabTagEntity>>(
      builder: (BuildContext context, AsyncSnapshot<List<GitlabTagEntity>> snapshot) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white10),
            color: Colors.white12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.name,
                  ),
                  Text(
                    widget.project.subtitle,
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              Visibility(
                visible: snapshot.connectionState == ConnectionState.done,
                child: Text(
                  snapshot.hasData && snapshot.data!.isNotEmpty ? snapshot.data!.first.name ?? '*' : '*',
                ),
                replacement: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      },
      future: _gitlabClient.getTags(widget.project.projectId),
    );
  }
}
