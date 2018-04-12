From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 12 Apr 2018 08:57:59 -0600
Subject: [GIT PULL] nvme-4.17 round 2
In-Reply-To: <20180412145526.GC4810@localhost.localdomain>
References: <20180412145526.GC4810@localhost.localdomain>
Message-ID: <7dfd5bdd-3a0b-b131-e44c-b99f54afa3a8@kernel.dk>

On 4/12/18 8:55 AM, Keith Busch wrote:
> The following changes since commit f23f5bece686a76598335141a091934f7eb0998c:
> 
>   blk-mq: Allow PCI vector offset for mapping queues (2018-03-27 21:25:36 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.17-2
> 
> for you to fetch changes up to 1d3528abf41ae3a0ee22f23f294033e000d3ecd1:
> 
>   nvme: expand nvmf_check_if_ready checks (2018-04-12 07:12:09 -0600)
> 
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       nvme: target: fix buffer overflow
> 
> Daniel Verkamp (1):
>       nvmet: fix space padding in serial number
> 
> James Smart (1):
>       nvme: expand nvmf_check_if_ready checks
> 
> Johannes Thumshirn (2):
>       nvme: unexport nvme_start_keep_alive
>       nvme: don't send keep-alives to the discovery controller
> 
> Keith Busch (4):
>       nvme-pci: Skip queue deletion if there are no queues
>       nvme-pci: Remove unused queue parameter
>       nvme-pci: Separate IO and admin queue IRQ vectors
>       nvme: Use admin command effects for admin commands
> 
> Matias Bj?rling (1):
>       nvme: enforce 64bit offset for nvme_get_log_ext fn
> 
> Max Gurtovoy (1):
>       nvme: check return value of init_srcu_struct function
> 
> Ming Lei (1):
>       nvme-loop: fix kernel oops in case of unhandled command
> 
> Rodrigo R. Galvao (1):
>       nvmet: Fix nvmet_execute_write_zeroes sector count
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

This doesn't merge cleanly with my for-linus, or master. Can you
respin this? Just send me the patch series, that's also fine.

-- 
Jens Axboe
