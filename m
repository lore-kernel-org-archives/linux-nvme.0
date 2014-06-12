From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 12 Jun 2014 08:58:38 +0800
Subject: [PATCH v6] NVMe: conversion to blk-mq
In-Reply-To: <CACVXFVNzyu7k0wf-Gw9VgtHCtrYDdOs3OEDdpzivujpQOVyQfA@mail.gmail.com>
References: <1402057225-7312-1-git-send-email-m@bjorling.me>
 <1402057225-7312-2-git-send-email-m@bjorling.me>
 <CACVXFVOieM2cT4FFJhD9MecfCLBtE3AwjCpOeGGRUcmWnN=B=A@mail.gmail.com>
 <CAOu_J6kXB0rFJ+Z1-FcUwEVQ7dhKZseQBzVONhT1wG=41zFNGA@mail.gmail.com>
 <CACVXFVNGB0JzRVE8rQru3s12s0U9gtxd0t_ZhnUHQao4ppH8DQ@mail.gmail.com>
 <CACVXFVM-OUFv+gUnNcGt86FhS1BABV4sQxhCqPf20KKZTwNbyQ@mail.gmail.com>
 <CACVXFVNzyu7k0wf-Gw9VgtHCtrYDdOs3OEDdpzivujpQOVyQfA@mail.gmail.com>
Message-ID: <CACVXFVPu6yZZXV_ET1M1zpnY-oa6QP6NqPdO9RzCT97nReGLvQ@mail.gmail.com>

On Mon, Jun 9, 2014@6:40 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> The root cause is that device returns
> NVME_INTERNAL_DEV_ERROR(0x6) with your conversion
> patch.

The above problem is caused by qemu not handling -EAGAIN from
io_submit(), so please ignore the report.


Thanks,
-- 
Ming Lei
