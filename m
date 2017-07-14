From: Steve.Schremmer@netapp.com (Schremmer, Steven)
Date: Fri, 14 Jul 2017 22:16:46 +0000
Subject: [dm-devel] [PATCH 3/4] libmultipath: only listen for uevents with
 DEVTYPE=disk
In-Reply-To: <20170714113209.17177-4-mwilck@suse.com>
References: <20170714113209.17177-1-mwilck@suse.com>
 <20170714113209.17177-4-mwilck@suse.com>
Message-ID: <BN6PR06MB248104CDFB472F08E5BC634F8CAD0@BN6PR06MB2481.namprd06.prod.outlook.com>

> -----Original Message-----
> From: dm-devel-bounces at redhat.com [mailto:dm-devel-bounces at redhat.com] On Behalf Of Martin Wilck
> Sent: Friday, July 14, 2017 6:32 AM
> To: Christophe Varoqui <christophe.varoqui at opensvc.com>; tang.junhui at zte.com.cn; Benjamin Marzinski <bmarzins at redhat.com>;
> Hannes Reinecke <hare at suse.de>; Guan Junxiong <guanjunxiong at huawei.com>
> Cc: Martin Wilck <mwilck at suse.de>; dm-devel at redhat.com; Xose Vazquez Perez <xose.vazquez at gmail.com>; linux-
> nvme at lists.infradead.org
> Subject: [dm-devel] [PATCH 3/4] libmultipath: only listen for uevents with DEVTYPE=disk
> 
> We are only interested in disks anyway. This saves us checking
> for devtype in the uevent processing queue, and is more powerful
> than the previous test in the dropped function
> uevent_can_discard_by_devpath().
> 
> Signed-off-by: Martin Wilck <mwilck at suse.com>
> Reviewed-by: Hannes Reinecke <hare at suse.de>
> ---

Reviewed-by: Steve Schremmer <steve.schremmer at netapp.com>
