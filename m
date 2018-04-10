From: mr.nuke.me@gmail.com (Alex G.)
Date: Tue, 10 Apr 2018 10:37:08 -0500
Subject: [PATCH] blk-mq: Fix recently introduced races in the timeout
 handling code
Message-ID: <696b572b-c1b9-e192-ee2c-78b522019266@gmail.com>

I've observed a very nasty NULL pointer dereference with NVME drives on
hot-unplug [1]. While I haven't gone in the details of this change, it
does fix the NULL dereference I've been seeing.

Alex

[1] http://lists.infradead.org/pipermail/linux-nvme/2018-April/016623.html
