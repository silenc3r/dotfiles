import os
from ranger.api.commands import Command


# Now, simply bind this function to a key, by adding this
# to your ~/.config/ranger/rc.conf: map <C-f> fzf_select
class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """

    def execute(self):
        import subprocess

        if self.quantifier:
            # match only directories
            command = r"""\
                find -L . \( -path '*/\.*' -o -fstype 'dev' \
                -o -fstype 'proc' \) -prune -o -type d -print 2> /dev/null \
                | sed 1d | cut -b3- | fzf +m
             """
        else:
            # match files and directories
            command = r"""\
                find -L . \( -path '*/\.*' -o -fstype 'dev' \
                -o -fstype 'proc' \) -prune -o -print 2> /dev/null  \
                | sed 1d | cut -b3- | fzf +m
            """
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode("utf-8").rstrip("\n"))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class yank(Command):
    """:yank [name|dir|path]

    Copies the file's name (default), directory or path into both the primary X
    selection and the clipboard.
    """

    modes = {
        "": "basename",
        "name_without_extension": "basename_without_extension",
        "name": "basename",
        "dir": "dirname",
        "path": "path",
    }

    def execute(self):
        import subprocess

        def clipboards():
            from ranger.ext.get_executables import get_executables

            clipboard_managers = {
                "xclip": [["xclip"], ["xclip", "-selection", "clipboard"]],
                "xsel": [["xsel"], ["xsel", "-b"]],
                "pbcopy": [["pbcopy"]],
            }
            ordered_managers = ["pbcopy", "xclip", "xsel"]
            executables = get_executables()
            for manager in ordered_managers:
                if manager in executables:
                    return clipboard_managers[manager]
            return []

        clipboard_commands = clipboards()

        mode = self.modes[self.arg(1)]
        selection = self.get_selection_attr(mode)
        if not selection:
            selection = [str(self.fm.thisdir)]

        new_clipboard_contents = "\n".join(selection)
        for command in clipboard_commands:
            process = subprocess.Popen(
                command, universal_newlines=True, stdin=subprocess.PIPE
            )
            process.communicate(input=new_clipboard_contents)

    def get_selection_attr(self, attr):
        return [getattr(item, attr) for item in self.fm.thistab.get_selection()]

    def tab(self, tabnum):
        return (self.start(1) + mode for mode in sorted(self.modes.keys()) if mode)
