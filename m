From: hare@suse.de (Hannes Reinecke)
Date: Mon, 7 Nov 2016 08:00:54 +0100
Subject: [PATCH v5 7/7] nvme-fabrics: Add FC LLDD loopback driver to test
 FC-NVME
In-Reply-To: <58201df6.7F/3WOWKvafCLB1k%jsmart2021@gmail.com>
References: <58201df6.7F/3WOWKvafCLB1k%jsmart2021@gmail.com>
Message-ID: <bf66ddaa-16ba-b2e4-b0a1-e86ad3494816@suse.de>

On 11/07/2016 07:23 AM, James Smart wrote:
> 
> Add FC LLDD loopback driver to test FC host and target transport within
> nvme-fabrics
> 
> To aid in the development and testing of the lower-level api of the FC
> transport, this loopback driver has been created to act as if it were a
> FC hba driver supporting both the host interfaces as well as the target
> interfaces with the nvme FC transport.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> 
> ---
> v4 mods:
> - corrected newnport memory leak
> - Checkpatch updates - S_IWUSR to 0200
> 
> v5 mods:
> - remove spurious parens on some name checks
> 
>  MAINTAINERS                  |    1 +
>  drivers/nvme/target/Kconfig  |   13 +
>  drivers/nvme/target/Makefile |    2 +
>  drivers/nvme/target/fcloop.c | 1147 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1163 insertions(+)
>  create mode 100644 drivers/nvme/target/fcloop.c
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
