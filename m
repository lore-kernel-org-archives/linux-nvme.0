From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 6 Apr 2017 12:23:59 +0300
Subject: [PATCH rfc 5/6] block: Add rdma affinity based queue mapping
 helper
In-Reply-To: <becb84ac-7819-a207-56b1-70f16cb80e42@mellanox.com>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <1491140492-25703-6-git-send-email-sagi@grimberg.me>
 <becb84ac-7819-a207-56b1-70f16cb80e42@mellanox.com>
Message-ID: <e1ea43dd-c44b-4b2f-f381-1195fd082609@grimberg.me>

> shouldn't you include  <linux/kobject.h> and <linux/blkdev.h> like in
> commit 8ec2ef2b66ea2f that fixes blk-mq-pci.c ?

Not really. We can lose these from blk-mq-pci.c as well.

>> +#include <linux/blk-mq.h>
>> +#include <linux/blk-mq-rdma.h>
>> +#include <rdma/ib_verbs.h>
>> +#include <linux/module.h>
>> +#include "blk-mq.h"
>
> Is this include needed ?

You're right, I can just keep:

+#include <linux/blk-mq.h>
+#include <linux/blk-mq-rdma.h>
+#include <rdma/ib_verbs.h>
