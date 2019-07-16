From: hare@suse.de (Hannes Reinecke)
Date: Tue, 16 Jul 2019 12:02:15 +0200
Subject: [PATCH] nvme-multipath: sanitize nvme_update_ana_state()
In-Reply-To: <20190716093825.GC32562@lst.de>
References: <20190716071830.22672-1-hare@suse.de>
 <20190716093825.GC32562@lst.de>
Message-ID: <aa83c6b8-5d72-2e11-2681-5bb2e67ba890@suse.de>

On 7/16/19 11:38 AM, Christoph Hellwig wrote:
> On Tue, Jul 16, 2019@09:18:30AM +0200, Hannes Reinecke wrote:
>> Commit 04e70bd4a026 ("nvme-multipath: do not select namespaces
>> which are about to be removed") introduced checks when traversing
>> the list of namespaces to avoid tripping over invalid namespaces.
>> A similar check is needed in nvme_update_ana_state() to skip updates
>> for any namespaces which will be removed.
>> With that we should also remove the WARN_ON() at the end of the
>> iteration; this will also be errorneously triggered if ANA Change AENS
>> are received during scanning.
> 
> What is the problem we are trying to fix here?  Just that we should
> not call nvme_mpath_set_live?  In that case it might make more sense
> to move the removed check to just guard that call and at least keep
> the values in struct nvme_ns uptodate.
> 
The underlying problem is the 'WARN_ON()', which actually can (and is)
triggered when ANA change AENs are received during controller (re-) connect.
At the same time it's quite pointless to update the ANA state for
namespaces which are on their way out; we _still_ seeing odd behaviour
during simultaneous rescan/reset, and this is just another safeguard.

But for now I'd be happy to drop the check for NS_REMOVING and just
delete the WARN_ON().

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
