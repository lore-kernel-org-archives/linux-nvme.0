From: stephane.gonauer@6wind.com (stephane gonauer)
Date: Thu, 9 Nov 2017 12:48:19 +0100
Subject: building nvmetcli in buildroot
Message-ID: <CANqv2T0CL+hJz0+_yUBnwQ995mupBTOBMpqEcrvi9ZawDBBCtg@mail.gmail.com>

Hello,

I would like to embed nvmetcli into a buildroot project of mine. So I
wrote the first patch (0001-package-add-nvmetcli-package.patch) to
include the nvmetcli as a package .

However this doesn't work well because the setup.cfg from your tree
ends up causing buildroot to try to copy nvmetcli.py to the *HOST*
/usr/sbin.

I looked around other python packages built in my configuration and
no-one seems to use the same "install_scripts" keyword.

So I made the second patch (0001-build-remove-setup.cfg.patch) which
applies against the current nvmetcli tree. With this one, buildroot
does work but the script is placed into /usr/bin.

I wonder if this patch could be applied to your tree or if a better
solution exists.


St?phane
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-package-add-nvmetcli-package.patch
Type: text/x-patch
Size: 2281 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171109/517df33f/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-build-remove-setup.cfg.patch
Type: text/x-patch
Size: 753 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171109/517df33f/attachment-0003.bin>
