From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 21 Mar 2017 13:05:05 -0400
Subject: [GIT PULL] nvme patches for kernel 4.11 rc4
In-Reply-To: <1490114015-17672-1-git-send-email-sagi@grimberg.me>
References: <1490114015-17672-1-git-send-email-sagi@grimberg.me>
Message-ID: <d50c0245-ac1a-243f-d0dc-95d906a1cd3b@kernel.dk>

On 03/21/2017 12:33 PM, Sagi Grimberg wrote:
> Hey Jens,
> 
> This consists of some fixes for issues reported lately:
> - loop and rdma host driver cpu hotplug fixes
> - fix loop use-after-free
> - nvmet percpu_ref confirmation fix to fail ongoing requests
> - nvmet-rdma fix a non-initialized commands deref
> 
> please pull from:
> 
>   git://git.infradead.org/nvme.git nvme-4.11-rc

Thanks Sagi, pulled.

-- 
Jens Axboe
