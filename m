From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 15 May 2018 09:23:15 -0600
Subject: Question about stream number
In-Reply-To: <4feb7a21-14b1-be61-a88e-8c7841fae96c@huawei.com>
References: <672a97be-7fbf-b21e-9f75-2c18e64ccf8f@kernel.dk>
 <20180508163539.GB31027@localhost.localdomain>
 <20180511170252.GA7344@localhost.localdomain>
 <5617cb00-dff4-8316-af05-e72d6c7f6304@kernel.dk>
 <4feb7a21-14b1-be61-a88e-8c7841fae96c@huawei.com>
Message-ID: <4932a012-1150-f97b-920a-c3618e08aee3@kernel.dk>

On 5/15/18 6:46 AM, dingxiang wrote:
> Hi?Jens
>      In current NVMe driver, the stream number is set to 4:
> 
>         /ctrl->nr_streams = min_t(unsigned, ctrl->nssa, BLK_MAX_WRITE_HINTS - 1);/
> 
>    Why the number is 4 rather than /ctrl->nssa? /

Because we only expose 4 different streams through the fcntl() get/set
rw hint API.

>    There is no limit in nvme spec 1.3, can I change it  if I need ?

There is a limit, but it's much higher :-)

There's nothing preventing you from changing it. But it would have to be
from an in-kernel user right now, since we don't have a way of passing
in more than 4 separate streams from userspace as it stands.

-- 
Jens Axboe
