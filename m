From: axboe@fb.com (Jens Axboe)
Date: Mon, 9 Jun 2014 09:27:09 -0600
Subject: [PATCH v6] NVMe: conversion to blk-mq
In-Reply-To: <20140609145944.GA30626@infradead.org>
References: <1402057225-7312-1-git-send-email-m@bjorling.me>
 <1402057225-7312-2-git-send-email-m@bjorling.me>
 <CACVXFVOieM2cT4FFJhD9MecfCLBtE3AwjCpOeGGRUcmWnN=B=A@mail.gmail.com>
 <5395BFF2.2080402@fb.com> <20140609145944.GA30626@infradead.org>
Message-ID: <5395D24D.9000306@fb.com>

On 2014-06-09 08:59, Christoph Hellwig wrote:
> On Mon, Jun 09, 2014@08:08:50AM -0600, Jens Axboe wrote:
>>> [  487.704074] nvme 0000:00:07.0: Cancelling I/O 202 QID 1
>>> [  487.717881] nvme 0000:00:07.0: Aborting I/O 202 QID 1
>>> [  487.736093] end_request: I/O error, dev nvme0n1, sector 91532352
>>> [  487.747378] nvme 0000:00:07.0: completed id 0 twice on queue 0
>>>
>>>
>>> when running fio randread(libaio, iodepth:64) with more than 3 jobs.
>>>
>>> And looks no such failure when jobs is 1 or 2.
>>
>> It's a known issue, make sure you have this patch:
>>
>> https://urldefense.proofpoint.com/v1/url?u=http://git.kernel.dk/?p%3Dlinux-block.git%3Ba%3Dcommit%3Bh%3Df6be4fb4bcb396fc3b1c134b7863351972de081f&k=ZVNjlDMF0FElm4dQtryO4A%3D%3D%0A&r=3JMVyziIyZtZ5cv9eWNLwQ%3D%3D%0A&m=MKK7A%2B9AnXXwtMV9YPSFEprXId0z0WLtd2JQPxnaNVc%3D%0A&s=45425e5d17390ae912457035ff081b95a7084725706ffe91166a1bdb25d8bf3d
>
> So without this patch we can get duplicate completions?  That could
> explain the issues that Robert sees with scsi-mq and hpsa..

I don't see how that would happen in general, except if the timeout
part was buggy.

-- 
Jens Axboe
