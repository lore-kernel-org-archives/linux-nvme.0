From: axboe@fb.com (Jens Axboe)
Date: Mon, 9 Jun 2014 09:40:28 -0600
Subject: [PATCH v6] NVMe: conversion to blk-mq
In-Reply-To: <CACVXFVMQ_ehnsj=7+6-WmKLSQAhDRDvOEnE6Ekbwj8sfYuuRAA@mail.gmail.com>
References: <1402057225-7312-1-git-send-email-m@bjorling.me>	<1402057225-7312-2-git-send-email-m@bjorling.me>	<CACVXFVOieM2cT4FFJhD9MecfCLBtE3AwjCpOeGGRUcmWnN=B=A@mail.gmail.com>	<5395BFF2.2080402@fb.com>	<CACVXFVPGO9vsOv_uVa0+5AdBduu1RJ0Fmg8XPx1QgJAvnjKj_g@mail.gmail.com>	<5395CE64.6040402@fb.com>
 <CACVXFVMQ_ehnsj=7+6-WmKLSQAhDRDvOEnE6Ekbwj8sfYuuRAA@mail.gmail.com>
Message-ID: <5395D56C.4000304@fb.com>

On 2014-06-09 09:15, Ming Lei wrote:
> On Mon, Jun 9, 2014@11:10 PM, Jens Axboe <axboe@fb.com> wrote:
>> On 2014-06-09 09:07, Ming Lei wrote:
>>
>> You are right, I didn't get to the bottom of the thread first.
>> Might be better to just have ->start_time set always, regardless of io stats
>> being enabled or not.
>
> Yes, just like what non-mq code did.

I queued up a fix for it.

-- 
Jens Axboe
