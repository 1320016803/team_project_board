from PySide6.QtWidgets import QApplication

from ui.main_window import TeamProjectWindow


if __name__ == "__main__":
    app = QApplication([])
    window = TeamProjectWindow()
    window.show()
    app.exec()
