From: hare@suse.de (Hannes Reinecke)
Date: Tue, 8 May 2018 08:06:38 +0200
Subject: [PATCH 7/7] nvme_fc: add 'nvme_discovery' sysfs attribute to fc
 transport device
In-Reply-To: <20180508001214.8951-8-jsmart2021@gmail.com>
References: <20180508001214.8951-1-jsmart2021@gmail.com>
 <20180508001214.8951-8-jsmart2021@gmail.com>
Message-ID: <20180508080638.3ea8d439@pentland.suse.de>

On Mon,  7 May 2018 17:12:14 -0700
"James Smart" <jsmart2021@gmail.com> wrote:

> The fc transport device should allow for a rediscovery, as userspace
> might have lost the events. Example is udev events not handled during
> system startup.
> 
> This patch add a sysfs entry 'nvme_discovery' on the fc class to
> have it replay all udev discovery events for all local port/remote
> port address pairs.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> CC: Hannes Reinecke <hare at suse.com>
> Cc: Ewan Milne <emilne at redhat.com>
> Cc: Johannes Thumshirn <jthumshirn at suse.com>
> 
> ---
> This is actually v4 - based on Hannes' v3 of the same patch:
> [PATCHv3] nvme/fc: add 'discovery' sysfs attribute to fc transport
> device
> http://lists.infradead.org/pipermail/linux-nvme/2017-December/014334.html
> 
> However, refcounting in v3 was still messed up when an rport_get()
> fails. Modified the patch to add the unwind routine to correct it.
> 
> Also renamed the "discovery" attribute to "nvme_discovery" so that
> there will not be collisions if/when we move to a shared fc transport
> and have scsi there as well.
> 
> Note: this patch alone doesn't allow the simple udev script.  The
> patches for the fc transport to move initial connect to use the
> asychronous reconnect path is what allows the simple udev script.
> This patch simply allows to catch up with connectivity if the udev
> events weren't handled. ---
>  drivers/nvme/host/fc.c | 114
> +++++++++++++++++++++++++++++++++++++++++++++---- 1 file changed, 105
> insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
