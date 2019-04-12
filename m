From: emilne@redhat.com (Ewan D. Milne)
Date: Fri, 12 Apr 2019 10:30:35 -0400
Subject: [PATCH] nvme,scsi: display FC-NVMe port roles
In-Reply-To: <20190410141619.146391-1-hare@suse.de>
References: <20190410141619.146391-1-hare@suse.de>
Message-ID: <04d92ced07c6a8e95432bafa1be73529aff00efb.camel@redhat.com>

On Wed, 2019-04-10@16:16 +0200, Hannes Reinecke wrote:
> Currently the FC-NVMe driver is leverating the SCSI FC transport
> class to access the remote ports. Which means that all FC-NVMe
> remote ports will be visible to the fc transport layer, but due
> to missing definitions the port roles will always be 'unknown'.
> This patch adds the missing definitions to the fc transport class
> to that the port roles are correctly displayed.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/fc.c           |  2 +-
>  drivers/scsi/lpfc/lpfc_hbadisc.c | 10 ++++++++--
>  drivers/scsi/qla2xxx/qla_def.h   |  5 ++++-
>  drivers/scsi/qla2xxx/qla_init.c  | 15 +++++++++++----
>  drivers/scsi/qla2xxx/qla_mbx.c   |  8 +++++++-
>  drivers/scsi/scsi_transport_fc.c |  3 +++
>  include/linux/nvme-fc-driver.h   |  6 ------
>  include/scsi/scsi_transport_fc.h |  3 +++
>  8 files changed, 37 insertions(+), 15 deletions(-)
> 

Reviewed-by: Ewan D. Milne <emilne at redhat.com>
