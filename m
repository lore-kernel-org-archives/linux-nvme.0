From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 12 Apr 2018 09:56:48 -0600
Subject: [PATCH 00/13] nvme 4.17 patch series
In-Reply-To: <20180412151615.5176-1-keith.busch@intel.com>
References: <20180412151615.5176-1-keith.busch@intel.com>
Message-ID: <ec560e80-75de-9e80-891f-262be3a22347@kernel.dk>

On 4/12/18 9:16 AM, Keith Busch wrote:
> This series merges cleanly with linux-block/for-linus.
> 
> Arnd Bergmann (1):
>   nvme: target: fix buffer overflow
> 
> Daniel Verkamp (1):
>   nvmet: fix space padding in serial number
> 
> James Smart (1):
>   nvme: expand nvmf_check_if_ready checks
> 
> Johannes Thumshirn (2):
>   nvme: unexport nvme_start_keep_alive
>   nvme: don't send keep-alives to the discovery controller
> 
> Keith Busch (4):
>   nvme-pci: Skip queue deletion if there are no queues
>   nvme-pci: Remove unused queue parameter
>   nvme-pci: Separate IO and admin queue IRQ vectors
>   nvme: Use admin command effects for admin commands
> 
> Matias Bj?rling (1):
>   nvme: enforce 64bit offset for nvme_get_log_ext fn
> 
> Max Gurtovoy (1):
>   nvme: check return value of init_srcu_struct function
> 
> Ming Lei (1):
>   nvme-loop: fix kernel oops in case of unhandled command
> 
> Rodrigo R. Galvao (1):
>   nvmet: Fix nvmet_execute_write_zeroes sector count
> 
>  drivers/nvme/host/core.c        | 33 ++++++++++------
>  drivers/nvme/host/fabrics.c     | 83 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/fabrics.h     | 33 +---------------
>  drivers/nvme/host/fc.c          | 12 ++----
>  drivers/nvme/host/nvme.h        |  4 +-
>  drivers/nvme/host/pci.c         | 35 ++++++++++-------
>  drivers/nvme/host/rdma.c        | 14 +------
>  drivers/nvme/target/admin-cmd.c |  1 +
>  drivers/nvme/target/discovery.c |  2 +-
>  drivers/nvme/target/io-cmd.c    |  4 +-
>  drivers/nvme/target/loop.c      | 20 ++--------
>  11 files changed, 141 insertions(+), 100 deletions(-)

Thanks, applied.

-- 
Jens Axboe
