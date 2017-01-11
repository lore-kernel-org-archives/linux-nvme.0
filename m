From: hare@suse.de (Hannes Reinecke)
Date: Wed, 11 Jan 2017 14:46:04 +0100
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
In-Reply-To: <20170111134312.GH6286@linux-x5ow.site>
References: <20170111134312.GH6286@linux-x5ow.site>
Message-ID: <79efbc41-26fb-77e5-751a-05d7c811870d@suse.de>

On 01/11/2017 02:43 PM, Johannes Thumshirn wrote:
> Hi all,
> 
> I'd like to attend LSF/MM and would like to discuss polling for block drivers.
> 
> Currently there is blk-iopoll but it is neither as widely used as NAPI in the
> networking field and accoring to Sagi's findings in [1] performance with
> polling is not on par with IRQ usage.
> 
> On LSF/MM I'd like to whether it is desirable to have NAPI like polling in
> more block drivers and how to overcome the currently seen performance issues.
> 
> [1] http://lists.infradead.org/pipermail/linux-nvme/2016-October/006975.html
> 
Yup.

I'm all for it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
