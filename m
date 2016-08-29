From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 29 Aug 2016 08:39:51 -0600
Subject: [GIT PULL] another round of fabrics fixes for the next 4.8-rc
In-Reply-To: <1472389796-1868-1-git-send-email-sagi@grimberg.me>
References: <1472389796-1868-1-git-send-email-sagi@grimberg.me>
Message-ID: <161e3ff2-745e-78ec-d479-4f73763be128@kernel.dk>

On 08/28/2016 07:09 AM, Sagi Grimberg wrote:
> Hey Jens,
>
> Mostly stability fixes and cleanups:
> - NQN endianess fix from Daniel
> - possible use-after-free fix from Vincent
> - nvme-rdma connect semantics fixes from Jay
> - Remove redundant variables in rdma driver
> - Kbuild fix from Christoph
> - nvmf_host referencing fix from Christoph
> - uninit variable fix from Colin

Thanks, pulled.


-- 
Jens Axboe
