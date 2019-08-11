From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 10 Aug 2019 20:42:26 -0700
Subject: [GIT PULL] nvme fixes for the next round of 5.3-rc
In-Reply-To: <20190809180412.26392-1-sagi@grimberg.me>
References: <20190809180412.26392-1-sagi@grimberg.me>
Message-ID: <e49babd9-ed35-20e5-7826-a3d0a8ea9107@kernel.dk>

On 8/9/19 11:04 AM, Sagi Grimberg wrote:
> Hey Jens,
> 
> Few nvme fixes for the next rc round.
> - detect capacity changes on the mpath disk from Anthony
> - probe/remove fix from Keith
> - various fixes to pass blktests from Logan
> - deadlock in reset/scan race fix
> - nvme-rdma use-after-free fix
> - deadlock fix when passthru commands race mpath disk info update

Pulled, thanks Sagi.

-- 
Jens Axboe
