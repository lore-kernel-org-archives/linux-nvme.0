From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 15 Nov 2016 07:53:23 -0700
Subject: [GIT PULL] nvme fabrics patches for 4.9-rc6
In-Reply-To: <1479204030-20590-1-git-send-email-sagi@grimberg.me>
References: <1479204030-20590-1-git-send-email-sagi@grimberg.me>
Message-ID: <19898ee4-e15a-48af-768c-76b0c36c6e27@kernel.dk>

On 11/15/2016 03:00 AM, Sagi Grimberg wrote:
> Hey Jens,
>
> These are the relevant fixes for rc6
> - fix possible crash in nvmet-rdma cm_handler from Bart
> - fix possible memory leak in nvmet-rdma for connection failures
> - fix possible use-after-free conditions in nvmet-rdma
> - fix possible IO errors during reconnect stage from Christoph
> - fix possible memory leak in nvme-rdma during IO queues connect
>   failures from Steve

Pulled, thanks Sagi.

-- 
Jens Axboe
