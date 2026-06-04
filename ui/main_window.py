from PySide6.QtCore import Qt
from PySide6.QtGui import QFont
from PySide6.QtWidgets import (
    QFrame,
    QGridLayout,
    QGroupBox,
    QLabel,
    QListWidget,
    QListWidgetItem,
    QMainWindow,
    QScrollArea,
    QSizePolicy,
    QVBoxLayout,
    QWidget,
)

from data.changelog import CHANGELOG
from data.features import FEATURES
from data.members import MEMBERS
from data.progress import PROGRESS_ITEMS
from data.project_info import PROJECT_NAME, PROJECT_SLOGAN, REPOSITORY_STATUS


class TeamProjectWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("班级项目协作看板")
        self.resize(1120, 720)
        self.setStyleSheet(STYLE)

        root = QWidget()
        layout = QVBoxLayout(root)
        layout.setContentsMargins(22, 22, 22, 22)
        layout.setSpacing(16)
        layout.addWidget(self.build_header())
        layout.addLayout(self.build_content_grid())
        layout.addWidget(self.build_changelog())
        self.setCentralWidget(root)

    def build_header(self):
        box = QFrame()
        box.setObjectName("Header")
        layout = QVBoxLayout(box)
        title = QLabel(PROJECT_NAME)
        title.setObjectName("Title")
        slogan = QLabel(PROJECT_SLOGAN)
        slogan.setObjectName("Slogan")
        status = QLabel(REPOSITORY_STATUS)
        status.setObjectName("RepoStatus")
        status.setWordWrap(True)
        layout.addWidget(title)
        layout.addWidget(slogan)
        layout.addWidget(status)
        return box

    def build_content_grid(self):
        grid = QGridLayout()
        grid.setSpacing(16)
        grid.addWidget(self.build_members(), 0, 0)
        grid.addWidget(self.build_features(), 0, 1)
        grid.addWidget(self.build_progress(), 0, 2)
        grid.setColumnStretch(0, 2)
        grid.setColumnStretch(1, 2)
        grid.setColumnStretch(2, 2)
        return grid

    def build_members(self):
        box = QGroupBox("组员 B 负责：成员与分工")
        layout = QVBoxLayout(box)
        for member in MEMBERS:
            card = QFrame()
            card.setObjectName("MemberCard")
            card_layout = QVBoxLayout(card)
            name = QLabel(f"{member['role']}：{member['name']}")
            name.setObjectName("CardTitle")
            task = QLabel(member["task"])
            task.setWordWrap(True)
            card_layout.addWidget(name)
            card_layout.addWidget(task)
            layout.addWidget(card)
        layout.addStretch()
        return self.wrap_scroll(box)

    def build_features(self):
        box = QGroupBox("组员 C 负责：项目功能清单")
        layout = QVBoxLayout(box)
        feature_list = QListWidget()
        for item in FEATURES:
            feature_list.addItem(QListWidgetItem(f"✓ {item}"))
        layout.addWidget(feature_list)
        return box

    def build_progress(self):
        box = QGroupBox("组员 D 负责：Issue / PR 进度")
        layout = QVBoxLayout(box)
        for item in PROGRESS_ITEMS:
            card = QFrame()
            card.setObjectName("ProgressCard")
            card_layout = QVBoxLayout(card)
            title = QLabel(f"{item['issue']} {item['title']}")
            title.setObjectName("CardTitle")
            owner = QLabel(f"负责人：{item['owner']}")
            status = QLabel(f"状态：{item['status']}")
            status.setObjectName("StatusText")
            card_layout.addWidget(title)
            card_layout.addWidget(owner)
            card_layout.addWidget(status)
            layout.addWidget(card)
        layout.addStretch()
        return self.wrap_scroll(box)

    def build_changelog(self):
        box = QGroupBox("组员 D 负责：版本日志")
        layout = QVBoxLayout(box)
        for item in CHANGELOG:
            label = QLabel(f"• {item}")
            label.setWordWrap(True)
            layout.addWidget(label)
        return box

    def wrap_scroll(self, widget):
        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setWidget(widget)
        scroll.setFrameShape(QFrame.NoFrame)
        scroll.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        return scroll


STYLE = """
QWidget {
    font-family: "Noto Sans CJK SC", "Microsoft YaHei", Arial;
    font-size: 15px;
    color: #1f2937;
    background: #f4f7fb;
}
#Header {
    background: qlineargradient(x1:0, y1:0, x2:1, y2:0, stop:0 #2563eb, stop:1 #38bdf8);
    border-radius: 18px;
    padding: 18px;
}
#Title {
    color: white;
    font-size: 30px;
    font-weight: 800;
    background: transparent;
}
#Slogan {
    color: rgba(255, 255, 255, 0.92);
    font-size: 18px;
    background: transparent;
}
#RepoStatus {
    color: white;
    background: rgba(255, 255, 255, 0.18);
    border-radius: 10px;
    padding: 10px;
    margin-top: 8px;
}
QGroupBox {
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 16px;
    margin-top: 14px;
    padding: 16px;
    font-weight: 700;
}
QGroupBox::title {
    subcontrol-origin: margin;
    left: 14px;
    padding: 0 8px;
}
#MemberCard, #ProgressCard {
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 10px;
    margin-bottom: 8px;
}
#CardTitle {
    color: #0f172a;
    font-size: 16px;
    font-weight: 700;
    background: transparent;
}
#StatusText {
    color: #2563eb;
    font-weight: 700;
    background: transparent;
}
QListWidget {
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 8px;
}
QListWidget::item {
    padding: 10px;
}
QScrollArea, QScrollArea QWidget, QScrollArea QViewport {
    background: transparent;
}
"""
