From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 10 Jun 2014 04:35:40 -0700
Subject: [PATCH v6] NVMe: conversion to blk-mq
In-Reply-To: <CACVXFVNNm5PJ8g=QD5zm49kaqW_oKCM+utMz+qSd=3WfsE4U2g@mail.gmail.com>
References: <1402057225-7312-1-git-send-email-m@bjorling.me>
 <1402057225-7312-2-git-send-email-m@bjorling.me>
 <CACVXFVOieM2cT4FFJhD9MecfCLBtE3AwjCpOeGGRUcmWnN=B=A@mail.gmail.com>
 <5395BFF2.2080402@fb.com> <20140609145944.GA30626@infradead.org>
 <5395D24D.9000306@fb.com>
 <CACVXFVNNm5PJ8g=QD5zm49kaqW_oKCM+utMz+qSd=3WfsE4U2g@mail.gmail.com>
Message-ID: <20140610113540.GA26195@infradead.org>

On Mon, Jun 09, 2014@11:35:00PM +0800, Ming Lei wrote:
> 
> Use-after-free may cause duplicate completions.
> 
> BTW, is the scsi-mq patchset public now?

It always has been.  I've posted it fairly frequently to linux-scsi,
and git://git.infradead.org/users/hch/scsi.git always has the latest
code, with scsi-mq-wip.11 as the current iteration.
