From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 9 Jun 2014 12:35:48 +0800
Subject: [PATCH v6] NVMe: conversion to blk-mq
In-Reply-To: <1402057225-7312-2-git-send-email-m@bjorling.me>
References: <1402057225-7312-1-git-send-email-m@bjorling.me>
 <1402057225-7312-2-git-send-email-m@bjorling.me>
Message-ID: <CACVXFVOieM2cT4FFJhD9MecfCLBtE3AwjCpOeGGRUcmWnN=B=A@mail.gmail.com>

On Fri, Jun 6, 2014@8:20 PM, Matias Bj?rling <m@bjorling.me> wrote:
> This converts the current NVMe driver to utilize the blk-mq layer.

Looks it can't be applied cleanly against 3.15-rc8 + Jens's for-linux
branch, when I fix the conflict manually, below failure is triggered:

[  487.696057] nvme 0000:00:07.0: Cancelling I/O 202 QID 1
[  487.699005] nvme 0000:00:07.0: Aborting I/O 202 QID 1
[  487.704074] nvme 0000:00:07.0: Cancelling I/O 202 QID 1
[  487.717881] nvme 0000:00:07.0: Aborting I/O 202 QID 1
[  487.736093] end_request: I/O error, dev nvme0n1, sector 91532352
[  487.747378] nvme 0000:00:07.0: completed id 0 twice on queue 0


when running fio randread(libaio, iodepth:64) with more than 3 jobs.

And looks no such failure when jobs is 1 or 2.

Thanks,
--
Ming Lei
