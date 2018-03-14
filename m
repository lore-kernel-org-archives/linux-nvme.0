From: hare@suse.de (Hannes Reinecke)
Date: Wed, 14 Mar 2018 12:43:09 +0100
Subject: [PATCH 12/13] qla2xxx: Fix Async GPN_FT for FCP and FC-NVMe scan
In-Reply-To: <20180312181650.20704-13-himanshu.madhani@cavium.com>
References: <20180312181650.20704-1-himanshu.madhani@cavium.com>
 <20180312181650.20704-13-himanshu.madhani@cavium.com>
Message-ID: <2f2cde2c-60bd-66c6-0437-fb097be8a60b@suse.de>

On 03/12/2018 07:16 PM, Himanshu Madhani wrote:
> From: Quinn Tran <quinn.tran at cavium.com>
> 
> This patch combines FCP and FC-NVMe scan into single scan when
> driver detects FC-NVMe capability on same port.
> 
> Signed-off-by: Quinn Tran <quinn.tran at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>  drivers/scsi/qla2xxx/qla_def.h  |   7 ++
>  drivers/scsi/qla2xxx/qla_gbl.h  |   2 +-
>  drivers/scsi/qla2xxx/qla_gs.c   | 231 ++++++++++++++++++++++++++++++++--------
>  drivers/scsi/qla2xxx/qla_init.c |   8 +-
>  drivers/scsi/qla2xxx/qla_os.c   |   8 +-
>  5 files changed, 204 insertions(+), 52 deletions(-)
> 
Please fixup the kbuild robot warning.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
