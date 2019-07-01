From: hare@suse.de (Hannes Reinecke)
Date: Mon, 1 Jul 2019 07:48:50 +0200
Subject: [PATCH v5 3/3] nvme: Set physical block size and optimal I/O size
 according to NVMe 1.4
In-Reply-To: <20190628165331.163919-4-bvanassche@acm.org>
References: <20190628165331.163919-1-bvanassche@acm.org>
 <20190628165331.163919-4-bvanassche@acm.org>
Message-ID: <cc9e95c5-e2c5-5a93-f680-a0aecb3bf070@suse.de>

On 6/28/19 6:53 PM, Bart Van Assche wrote:
> From the NVMe 1.4 spec:
> 
> NSFEAT bit 4 if set to 1: indicates that the fields NPWG, NPWA, NPDG, NPDA,
> and NOWS are defined for this namespace and should be used by the host for
> I/O optimization;
> [ ... ]
> Namespace Preferred Write Granularity (NPWG): This field indicates the
> smallest recommended write granularity in logical blocks for this namespace.
> This is a 0's based value. The size indicated should be less than or equal
> to Maximum Data Transfer Size (MDTS) that is specified in units of minimum
> memory page size. The value of this field may change if the namespace is
> reformatted. The size should be a multiple of Namespace Preferred Write
> Alignment (NPWA). Refer to section 8.25 for how this field is utilized to
> improve performance and endurance.
> [ ... ]
> Each Write, Write Uncorrectable, or Write Zeroes commands should address a
> multiple of Namespace Preferred Write Granularity (NPWG) (refer to Figure
> 245) and Stream Write Size (SWS) (refer to Figure 515) logical blocks (as
> expressed in the NLB field), and the SLBA field of the command should be
> aligned to Namespace Preferred Write Alignment (NPWA) (refer to Figure 245)
> for best performance.
> 
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>
> ---
>  drivers/nvme/host/core.c | 34 ++++++++++++++++++++++++++++++++--
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
