From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 9 Jun 2014 18:40:53 +0800
Subject: [PATCH v6] NVMe: conversion to blk-mq
In-Reply-To: <CACVXFVM-OUFv+gUnNcGt86FhS1BABV4sQxhCqPf20KKZTwNbyQ@mail.gmail.com>
References: <1402057225-7312-1-git-send-email-m@bjorling.me>
 <1402057225-7312-2-git-send-email-m@bjorling.me>
 <CACVXFVOieM2cT4FFJhD9MecfCLBtE3AwjCpOeGGRUcmWnN=B=A@mail.gmail.com>
 <CAOu_J6kXB0rFJ+Z1-FcUwEVQ7dhKZseQBzVONhT1wG=41zFNGA@mail.gmail.com>
 <CACVXFVNGB0JzRVE8rQru3s12s0U9gtxd0t_ZhnUHQao4ppH8DQ@mail.gmail.com>
 <CACVXFVM-OUFv+gUnNcGt86FhS1BABV4sQxhCqPf20KKZTwNbyQ@mail.gmail.com>
Message-ID: <CACVXFVNzyu7k0wf-Gw9VgtHCtrYDdOs3OEDdpzivujpQOVyQfA@mail.gmail.com>

On Mon, Jun 9, 2014 at 3:53 PM, Ming Lei <tom.leiming at gmail.com>
>
> After pulling from your tree, the problem still persists.
>
> I test nvme over qemu, and both linus/next tree can
> work well with qemu nvme.

One problem I found is that rq->start_time isn't set
after you cleared IO_STAT intentionally, then the
request can't be requeued any more. Once the request
can be requeued, the problem becomes req hanging.

The root cause is that device returns
NVME_INTERNAL_DEV_ERROR(0x6) with your conversion
patch.

Thanks,
-- 
Ming Lei
