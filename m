From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 8 Aug 2016 07:43:46 -0600
Subject: [GIT PULL] fabrics fixes for the next 4.8-rc
In-Reply-To: <1470658479-7861-1-git-send-email-sagi@grimberg.me>
References: <1470658479-7861-1-git-send-email-sagi@grimberg.me>
Message-ID: <d85d3089-9def-0859-e1fe-f026f7191c83@kernel.dk>

On 08/08/2016 06:14 AM, Sagi Grimberg wrote:
> Hey Jens,
>
> Mostly stability fixes for nvmet, rdma:
> - fix uninitialized rdma_cm private data from Roland.
> - rdma device removal handling (host and target).
> - fix controller disconnect during active mounts.
> - fix namespaces lost after fabric reconnects.
> - remove redundant calls to namespace removal (rdma, loop).
> - actually send controller shutdown when disconnecting.
> - reconnect fixes (ns rescan and aen requeue)
> - nvmet controller serial number inconsistency fix.
>
>
> please pull from:
>
>   git://git.infradead.org/nvme-fabrics.git nvmf-4.8-rc

Pulled in for 4.8, thanks.

-- 
Jens Axboe
