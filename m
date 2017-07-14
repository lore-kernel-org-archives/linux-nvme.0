From: Steve.Schremmer@netapp.com (Schremmer, Steven)
Date: Fri, 14 Jul 2017 22:18:03 +0000
Subject: [dm-devel] [PATCH 2/4] libmultipath: drop
 uevent_can_discard_by_devpath
In-Reply-To: <20170714113209.17177-3-mwilck@suse.com>
References: <20170714113209.17177-1-mwilck@suse.com>
 <20170714113209.17177-3-mwilck@suse.com>
Message-ID: <BN6PR06MB248104C3DEBCBFDDE02C8A108CAD0@BN6PR06MB2481.namprd06.prod.outlook.com>

> From: dm-devel-bounces at redhat.com [mailto:dm-devel-bounces at redhat.com] On Behalf Of Martin Wilck
> Sent: Friday, July 14, 2017 6:32 AM
> To: Christophe Varoqui <christophe.varoqui at opensvc.com>; tang.junhui at zte.com.cn; Benjamin Marzinski <bmarzins at redhat.com>;
> Hannes Reinecke <hare at suse.de>; Guan Junxiong <guanjunxiong at huawei.com>
> Cc: Martin Wilck <mwilck at suse.de>; dm-devel at redhat.com; Xose Vazquez Perez <xose.vazquez at gmail.com>; linux-
> nvme at lists.infradead.org
> Subject: [dm-devel] [PATCH 2/4] libmultipath: drop uevent_can_discard_by_devpath
> 
> This function is broken. Not all devices that matter for multipathd
> follow the block/$DEVICE/$PARTITION convention (example: NVME)
> 
> Signed-off-by: Martin Wilck <mwilck at suse.com>
> Reviewed-by: Hannes Reinecke <hare at suse.de>
> ---

Reviewed-by: Steve Schremmer <steve.schremmer at netapp.com>
