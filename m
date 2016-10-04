From: hare@suse.de (Hannes Reinecke)
Date: Tue, 4 Oct 2016 09:46:32 +0200
Subject: [PATCH 7/7] nvme-fabrics: Add FC LLDD loopback driver to test
 FC-NVME
In-Reply-To: <57f34bb7.DaNIUHq69nou/DuF%james.smart@broadcom.com>
References: <57f34bb7.DaNIUHq69nou/DuF%james.smart@broadcom.com>
Message-ID: <2fe7ca7c-a647-df2f-0e2e-ff57d411ebba@suse.de>

On 10/04/2016 08:27 AM, James Smart wrote:
> 
> Add FC LLDD loopback driver to test FC host and target transport within
> nvme-fabrics
> 
> To aid in the development and testing of the lower-level api of the FC
> transport, this loopback driver has been created to act as if it were a
> FC hba driver supporting both the host interfaces as well as the target
> interfaces with the nvme FC transport.
> 
> The changes made since the prior patch:
> - Created defines for template constants per review
> - Removal of fabric name for nport qualifier. Not necessary in T11
> - Reworked teardown paths with ref counting and proper locking
> - Teardown now invokes callbackes on completion of unregister functions
> - Added callbacks for unregister complete interfaces
> - Split sysfs add of remoteport and targetport for better testing.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/target/Kconfig  |   13 +
>  drivers/nvme/target/Makefile |    2 +
>  drivers/nvme/target/fcloop.c | 1131 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1146 insertions(+)
>  create mode 100644 drivers/nvme/target/fcloop.c
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
