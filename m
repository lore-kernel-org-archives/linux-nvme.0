From: hare@suse.de (Hannes Reinecke)
Date: Thu, 15 Feb 2018 08:46:17 +0100
Subject: [V1] mpt3sas: Do not use 32-bit atomic request descriptor for
 Ventura controllers.
In-Reply-To: <1518603397-3941-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1518603397-3941-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <20180215084617.58825f96@pentland.suse.de>

On Wed, 14 Feb 2018 02:16:37 -0800
Suganath Prabu S <suganath-prabu.subramani@broadcom.com> wrote:

> Problem Statement: Sending I/O through 32 bit descriptors to
>  Ventura series of controller results in IO timeout on certain
> conditions.
> 
> This error only occurs on systems with high I/O activity on
> Ventura series controllers.
> 
> Changes in this patch will prevent driver from using 32 bit descriptor
> and use 64 bit Descriptors
> 
> V1 Change set:
> 1) In this patch removed callbacks as suggested by Hannes.
> 
> Note:
>  This patch Should be applied on top of
> https://www.spinics.net/lists/linux-scsi/msg117405.html
> "Adding MPI Endpoint device support" patches.
> 
> Signed-off-by: Suganath Prabu S
> <suganath-prabu.subramani at broadcom.com> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c      | 169
> ++++---------------------------
> drivers/scsi/mpt3sas/mpt3sas_base.h      |  11 +-
> drivers/scsi/mpt3sas/mpt3sas_config.c    |   2 +-
> drivers/scsi/mpt3sas/mpt3sas_ctl.c       |  22 ++--
> drivers/scsi/mpt3sas/mpt3sas_scsih.c     |  20 ++--
> drivers/scsi/mpt3sas/mpt3sas_transport.c |   8 +- 6 files changed, 54
> insertions(+), 178 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
