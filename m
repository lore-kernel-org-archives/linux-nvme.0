From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 24 Sep 2016 10:50:54 -0600
Subject: [GIT PULL] nvme fabrics patches for 4.9
In-Reply-To: <1474674451-23213-1-git-send-email-sagi@grimberg.me>
References: <1474674451-23213-1-git-send-email-sagi@grimberg.me>
Message-ID: <e46f950d-c3c1-90bc-5a5f-9d4394001999@kernel.dk>

On 09/23/2016 05:47 PM, Sagi Grimberg wrote:
> Hey Jens,
>
> On the nvme target end we have:
> - direct IO writes in nvmet to avoid an extra context switch
> - dsm fix from Sasha
> - smart log stats support from Chaitanya
>
> On the fabrics end we have a few cleanups and preps for
> fc transport from James
>
> please pull from:
>
>   git://git.infradead.org/nvme-fabrics.git nvmf-4.9

Pulled into for-4.9/block, thanks.

-- 
Jens Axboe
