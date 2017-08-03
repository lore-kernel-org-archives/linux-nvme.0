From: hare@suse.de (Hannes Reinecke)
Date: Thu, 3 Aug 2017 08:38:05 +0200
Subject: [PATCH v2 07/13] mpt3sas: Handle NVMe PCIe device related events
 generated from firmware.
In-Reply-To: <1500038560-11231-8-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1500038560-11231-8-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <62d621e7-2adc-05b1-e914-dcda52b41553@suse.de>

On 07/14/2017 03:22 PM, Suganath Prabu S wrote:
> * The controller firmware sends separate events for NVMe devices and
> PCIe switches similar to existing SAS events.
> 
> * NVMe device detection, addition and removal are reported by the
> firmware through PCIe Topology Change list events.
> 
> * The PCIe device state change events are sent when the firmware
> detects any abnormal conditions with a NVMe device or switch.
> 
> * The enumeration event are sent when the firmware starts PCIe device
> enumeration and stops.
> 
> * This patch has the code change to handle the events and add/remove
> NVMe devices in driver's inventory.
> 
> Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c  |   30 ++-
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c |  471 +++++++++++++++++++++++++++++++++-
>  2 files changed, 495 insertions(+), 6 deletions(-)
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
