### A simple backup solution.

Strongly inspired by https://www.sanitarium.net/golug/rsync_backups_2010.html

Because everytime I look for one, everything is too complicated to setup, or to use.

`rsync` is all you need, this script is really a simple wrapper around it.

Drop it in the folder you want to save things to.
Adapt `sources` to contain local or distant (ssh) paths to folders to save.
The user that runs the script must be able to connect to these hosts and read the paths.
Adapt the `excludes` file if you have specific things to exclude.

You can run it through crontab, airflow, or anyway you see fit, even manually
it's a simple bash script, that takes no parameters.

It uses hard links to avoid duplicating files, so even saving every day won't
create gigantic archives, you can safely delete old backups, it won't affect
files duplicated in more recent ones (deleting old backup will only free space
for files that don't exist in any other backup anymore).
