From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 10 Jun 2014 19:55:40 +0800
Subject: [PATCH v6] NVMe: conversion to blk-mq
In-Reply-To: <20140610113540.GA26195@infradead.org>
References: <1402057225-7312-1-git-send-email-m@bjorling.me>
 <1402057225-7312-2-git-send-email-m@bjorling.me>
 <CACVXFVOieM2cT4FFJhD9MecfCLBtE3AwjCpOeGGRUcmWnN=B=A@mail.gmail.com>
 <5395BFF2.2080402@fb.com> <20140609145944.GA30626@infradead.org>
 <5395D24D.9000306@fb.com>
 <CACVXFVNNm5PJ8g=QD5zm49kaqW_oKCM+utMz+qSd=3WfsE4U2g@mail.gmail.com>
 <20140610113540.GA26195@infradead.org>
Message-ID: <CACVXFVMG0SY57A4kMKE8WC=dNOiDJO+P4GLhzdVXVzMLset6sQ@mail.gmail.com>

On Tue, Jun 10, 2014@7:35 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jun 09, 2014@11:35:00PM +0800, Ming Lei wrote:
>>
>> Use-after-free may cause duplicate completions.
>>
>> BTW, is the scsi-mq patchset public now?
>
> It always has been.  I've posted it fairly frequently to linux-scsi,
> and git://git.infradead.org/users/hch/scsi.git always has the latest
> code, with scsi-mq-wip.11 as the current iteration.

That is great, thanks a lot for sharing it.

Even google can't tell me where the tree is, :-(

Thanks,
-- 
Ming Lei
