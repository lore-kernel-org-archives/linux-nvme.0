From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=C3=B8rling?=)
Date: Mon, 9 Jun 2014 08:00:45 +0200
Subject: [PATCH v6] NVMe: conversion to blk-mq
In-Reply-To: <CACVXFVOieM2cT4FFJhD9MecfCLBtE3AwjCpOeGGRUcmWnN=B=A@mail.gmail.com>
References: <1402057225-7312-1-git-send-email-m@bjorling.me>
 <1402057225-7312-2-git-send-email-m@bjorling.me>
 <CACVXFVOieM2cT4FFJhD9MecfCLBtE3AwjCpOeGGRUcmWnN=B=A@mail.gmail.com>
Message-ID: <CAOu_J6kXB0rFJ+Z1-FcUwEVQ7dhKZseQBzVONhT1wG=41zFNGA@mail.gmail.com>

On Mon, Jun 9, 2014@6:35 AM, Ming Lei <tom.leiming@gmail.com> wrote:
> On Fri, Jun 6, 2014@8:20 PM, Matias Bj?rling <m@bjorling.me> wrote:
>> This converts the current NVMe driver to utilize the blk-mq layer.
>
> Looks it can't be applied cleanly against 3.15-rc8 + Jens's for-linux
> branch, when I fix the conflict manually, below failure is triggered:
>
> [  487.696057] nvme 0000:00:07.0: Cancelling I/O 202 QID 1
> [  487.699005] nvme 0000:00:07.0: Aborting I/O 202 QID 1
> [  487.704074] nvme 0000:00:07.0: Cancelling I/O 202 QID 1
> [  487.717881] nvme 0000:00:07.0: Aborting I/O 202 QID 1
> [  487.736093] end_request: I/O error, dev nvme0n1, sector 91532352
> [  487.747378] nvme 0000:00:07.0: completed id 0 twice on queue 0
>
>
> when running fio randread(libaio, iodepth:64) with more than 3 jobs.
>
> And looks no such failure when jobs is 1 or 2.

Can you try with the nvmemq_review branch at

https://github.com/MatiasBjorling/linux-collab.git

I'll take a look tomorrow and see if I can reproduce it. Thanks!

>
> Thanks,
> --
> Ming Lei
