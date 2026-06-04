# 班级项目协作看板

这是第14周 GitHub 五人协作示例项目。

本项目使用 PySide6 制作一个 GUI 看板，用来展示小组成员通过 Issue、Fork、分支、Pull Request、Review、Merge 共同完成项目的过程。

## 运行方式

```bash
pip install -r requirements.txt
python main.py
```

## 5人分工

| 角色 | 修改文件 | 任务 |
|---|---|---|
| 组长 | README.md | 创建仓库、创建 Issue、审核 PR、合并代码 |
| 组员 A | data/project_info.py | 修改项目名称、口号、仓库状态 |
| 组员 B | data/members.py | 补全 5 人成员卡片 |
| 组员 C | data/features.py | 补充项目功能清单 |
| 组员 D | data/progress.py、data/changelog.py | 补充 Issue/PR 进度和版本日志 |

## 协作要求

1. 组员先 Fork 组长仓库。
2. 每位组员创建自己的任务分支。
3. 每位组员只修改自己负责的文件。
4. 修改后运行 `python main.py` 检查 GUI 是否正常。
5. push 到自己的 Fork 后，向组长仓库发 Pull Request。
6. 组长 review 后再 merge。
