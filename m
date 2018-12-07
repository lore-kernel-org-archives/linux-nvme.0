From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 7 Dec 2018 12:44:34 -0700
Subject: [GIT PULL] first batch of nvme updates for 4.21
In-Reply-To: <20181207192046.GA19243@infradead.org>
References: <20181207192046.GA19243@infradead.org>
Message-ID: <eed3dc6e-d01e-64b6-6d3b-43d81b54660e@kernel.dk>

On 12/7/18 12:20 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> please pull this first batch of nvme updates for Linux 4.21.
> 
> Highlights:
>  - target support for persistent discovery controllers (Jay Sternberg)
>  - target optimizations to use non-blocking reads (Chaitanya Kulkarni)
>  - host side support for the Enhanced Command Retry TP (Keith Busch)
>  - host and target support for traffic based keep alive (Sagi Grimberg)
>  - host and target support for disabling SQ based flow control (Sagi Grimberg)
> 
> Plus all kinds of optimizations and cleanups from the usual suspects.
> 
> The following changes since commit 43e497feb3987c868f87c7ca1470c5937689fe01:
> 
>   blk-mq: re-build queue map in case of kdump kernel (2018-12-06 22:52:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.21
> 
> for you to fetch changes up to 48fd68b3c5c66af6e0004787a54765a8d040989b:
> 
>   nvme: remove unused function nvme_ctrl_ready (2018-12-07 11:16:38 -0800)
> 
> ----------------------------------------------------------------
> Chaitanya Kulkarni (4):
>       nvme: consolidate memset calls in the nvme_setup_cmd path
>       nvmet: use IOCB_NOWAIT for file-ns buffered I/O
>       nvmet: use unlikely for req status check
>       nvmet: fix the structure member indentation
> 
> Christoph Hellwig (1):
>       nvmet: mark nvmet_genctr static
> 
> Hannes Reinecke (1):
>       nvme: add a numa_node field to struct nvme_ctrl
> 
> Israel Rukshin (3):
>       nvme: Remove unused forward declaration
>       nvmet-rdma: Add unlikely for response allocated check
>       nvme: remove unused function nvme_ctrl_ready
> 
> James Smart (1):
>       nvmet-fc: remove the IN_ISR deferred scheduling options
> 
> Jay Sternberg (7):
>       nvmet: provide aen bit functions for multiple controller types
>       nvmet: change aen mask functions to use bit numbers
>       nvmet: allow Keep Alive for Discovery controller
>       nvmet: make kato and AEN processing for use by other controllers
>       nvmet: add defines for discovery change async events
>       nvmet: add support to Discovery controllers for commands
>       nvmet: enable Discovery Controller AENs
> 
> Keith Busch (1):
>       nvme: implement Enhanced Command Retry
> 
> Sagi Grimberg (9):
>       nvme: introduce ctrl attributes enumeration
>       nvme: cache controller attributes
>       nvme: support traffic based keep-alive
>       nvmet: support for traffic based keep-alive
>       nvmet: allow host connect even if no allowed subsystems are exported
>       nvmet: support fabrics sq flow control
>       nvmet: don't override treq upon modification.
>       nvmet: expose support for fabrics SQ flow control disable in treq
>       nvme: disable fabrics SQ flow control when asked by the user
> 
>  drivers/nvme/host/core.c          |  70 ++++++++++++++++++--
>  drivers/nvme/host/fabrics.c       |  13 +++-
>  drivers/nvme/host/fabrics.h       |   2 +
>  drivers/nvme/host/fc.c            |   5 +-
>  drivers/nvme/host/multipath.c     |   4 +-
>  drivers/nvme/host/nvme.h          |  13 ++--
>  drivers/nvme/host/rdma.c          |   5 +-
>  drivers/nvme/target/admin-cmd.c   |  76 ++++++++++++----------
>  drivers/nvme/target/configfs.c    |  42 ++++++++----
>  drivers/nvme/target/core.c        | 118 +++++++++++++---------------------
>  drivers/nvme/target/discovery.c   | 129 +++++++++++++++++++++++++++++++++++--
>  drivers/nvme/target/fabrics-cmd.c |   6 ++
>  drivers/nvme/target/fc.c          |  66 +------------------
>  drivers/nvme/target/io-cmd-file.c | 130 ++++++++++++++++++++++++--------------
>  drivers/nvme/target/nvmet.h       |  53 +++++++++++++---
>  drivers/nvme/target/rdma.c        |   2 +-
>  include/linux/nvme-fc-driver.h    |  16 -----
>  include/linux/nvme.h              |  51 +++++++++++++--
>  18 files changed, 514 insertions(+), 287 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
