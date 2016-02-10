From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 10 Feb 2016 08:52:47 -0700
Subject: [PATCH v1] nvme: Log the ctrl device name instead of the
 undelying pci device name
In-Reply-To: <56BB0D6D.8050802@dev.mellanox.co.il>
References: <1453126453-17976-1-git-send-email-sagig@mellanox.com>
 <56BB0D6D.8050802@dev.mellanox.co.il>
Message-ID: <56BB5CCF.3050503@kernel.dk>

On 02/10/2016 03:14 AM, Sagi Grimberg wrote:
> Jens, care to pick this up for 4.6?
>
> This patch got an ack from Keith and didn't
> raise any objections so far...

Applied for 4.6 - I manually fixed up a reject in 
nvme_cancel_queue_ios(), jfyi.

-- 
Jens Axboe
