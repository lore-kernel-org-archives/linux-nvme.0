From: bdeyal@gmail.com (Eyal BenDavid)
Date: Thu, 10 Jan 2019 17:46:34 +0200
Subject: nvme-cli logging in /var/log
Message-ID: <CAPrnrPBsJY7xDDn5q7_T+AB+HbqY2V-qmdFB8bovOhv0EOpGag@mail.gmail.com>

Hi all,

How about logging results, error, debugging to /var/log?

nvme-cli is a system tool that runs by admins in scripts and
configuration programs.
I think logging is essential for debugging and administration.

I have a side branch with a (preliminary) logging framework to enable that.

so instead of printing to stderr one would write:

   nvmecli_error("error : %s", message);
or
   nvmecli_perror("error : %s", message);

In this case the message is printed as is to stderr and sent to system
logger too.
Logging function accepts printf format string and arguments.

log lines in /var/log/nvme-cli  look like:
===============================
Jan 10 17:40:16 hostname nvme-cli[11183]: I: === Starting NVMe CLI Logger ===
Jan 10 17:40:16 hostname nvme-cli[11183]: D: Debug Message
Jan 10 17:40:16 hostname nvme-cli[11183]: I: Info Message
Jan 10 17:40:16 hostname nvme-cli[11183]: N: Notice Message
Jan 10 17:40:16 hostname nvme-cli[11183]: W: Warn Message in
logger.c:main():L245
Jan 10 17:40:16 hostname nvme-cli[11183]: E: Error Message in
logger.c:main():L246
Jan 10 17:40:16 hostname nvme-cli[11183]: E: perror Message: Operation
already in progress in logger.c:main():L248
Jan 10 17:40:16 hostname nvme-cli[11183]: F: Fatal Message
Jan 10 17:40:16 hostname nvme-cli[11183]:    === nvme-cli stack trace ===
Jan 10 17:40:16 hostname nvme-cli[11183]:    (2) ./lgr() [0x401518]
Jan 10 17:40:16 hostname nvme-cli[11183]:    (3)
/lib64/libc.so.6(__libc_start_main+0xeb) [0x7f791bbf511b]
Jan 10 17:40:16 hostname nvme-cli[11183]:    (4) ./lgr() [0x400a2a]
Jan 10 17:40:16 hostname nvme-cli[11183]:     in logger.c:main():L249
Jan 10 17:40:16 hostname nvme-cli[11183]: I: === Closing NVMe CLI Logger ===

The code that sent it is:
==================

int main()
{
    nvmecli_open_logger("debug");

    nvmecli_trace("Trace Message");
    nvmecli_debug("Debug Message");
    nvmecli_info("Info Message");
    nvmecli_notice("Notice Message");
    nvmecli_warn("Warn Message");
    nvmecli_error("Error Message");
    errno = 114;
    nvmecli_perror("perror Message");
    nvmecli_fatal("Fatal Message");

    nvmecli_close_logger();
    return 0;
}

The logging code calls syslog() and relies on the system logger to
redirect the message to its destination.

My branch has configuration file for rsyslog with rules to redirect
messages to /var/log/nvme-cli

Now if this feature is desired in mainline, I can create a pull request.

Please share your thoughts.

Thanks!
Eyal
