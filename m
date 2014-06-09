From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 9 Jun 2014 07:59:44 -0700
Subject: [PATCH v6] NVMe: conversion to blk-mq
In-Reply-To: <5395BFF2.2080402@fb.com>
References: <1402057225-7312-1-git-send-email-m@bjorling.me>
 <1402057225-7312-2-git-send-email-m@bjorling.me>
 <CACVXFVOieM2cT4FFJhD9MecfCLBtE3AwjCpOeGGRUcmWnN=B=A@mail.gmail.com>
 <5395BFF2.2080402@fb.com>
Message-ID: <20140609145944.GA30626@infradead.org>

On Mon, Jun 09, 2014@08:08:50AM -0600, Jens Axboe wrote:
> >[  487.704074] nvme 0000:00:07.0: Cancelling I/O 202 QID 1
> >[  487.717881] nvme 0000:00:07.0: Aborting I/O 202 QID 1
> >[  487.736093] end_request: I/O error, dev nvme0n1, sector 91532352
> >[  487.747378] nvme 0000:00:07.0: completed id 0 twice on queue 0
> >
> >
> >when running fio randread(libaio, iodepth:64) with more than 3 jobs.
> >
> >And looks no such failure when jobs is 1 or 2.
> 
> It's a known issue, make sure you have this patch:
> 
> http://git.kernel.dk/?p=linux-block.git;a=commit;h=f6be4fb4bcb396fc3b1c134b7863351972de081f

So without this patch we can get duplicate completions?  That could
explain the issues that Robert sees with scsi-mq and hpsa..
