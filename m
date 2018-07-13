From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 13 Jul 2018 08:48:24 +0800
Subject: [PATCHv3 0/9] nvme timeout fixes, v3
In-Reply-To: <20180524203500.14081-1-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
Message-ID: <CACVXFVMMC+O65bNweq7KqTgMkGBCdqfe+_QPegFZ5=rPH1Qokg@mail.gmail.com>

On Fri, May 25, 2018@4:34 AM, Keith Busch <keith.busch@intel.com> wrote:
> v2 -> v3:
>
> The main difference is getting rid of the bad idea that we could do
> a CONNECTING -> RESETTING transtion that breaks the state machine, so
> that patch is dropped. The series maintains the concept of retrying a
> reset when an init admin command times out. It just does so in the same
> context instead of requeueing itself.
>
> This series also includes two additional patches to handle other unlikely
> errors on queue initialization and HMB teardown.
>
> Keith Busch (9):
>   nvme: Sync request queues on reset
>   nvme-pci: Fix queue freeze criteria on reset
>   nvme: Move all IO out of controller reset
>   nvme-pci: Rate limit the nvme timeout warnings
>   nvme-pci: End IO requests immediately in CONNECTING state
>   nvme-pci: Unquiesce dead controller queues
>   nvme-pci: Attempt reset retry for IO failures
>   nvme-pci: Queue creation error handling
>   nvme-pci: Don't wait for HMB completion on shutdown
>
>  drivers/nvme/host/core.c |  23 ++++++-
>  drivers/nvme/host/nvme.h |   2 +
>  drivers/nvme/host/pci.c  | 173 ++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 150 insertions(+), 48 deletions(-)

Hello Keith,

I guess there will be V4 for addressing the reported issue?

Thanks,
Ming Lei
