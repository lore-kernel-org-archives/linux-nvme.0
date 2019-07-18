From: john.p.donnelly@oracle.com (John Donnelly)
Date: Thu, 18 Jul 2019 13:08:48 -0500
Subject: [PATCH] nvme-multipath: sanitize nvme_update_ana_state()
In-Reply-To: <20190717143859.GA13872@lst.de>
References: <20190716071830.22672-1-hare@suse.de>
 <20190716093825.GC32562@lst.de>
 <aa83c6b8-5d72-2e11-2681-5bb2e67ba890@suse.de>
 <20190717143859.GA13872@lst.de>
Message-ID: <D78D352F-0E90-46E1-ABBC-1093CBD858C3@oracle.com>



> On Jul 17, 2019,@9:38 AM, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Tue, Jul 16, 2019@12:02:15PM +0200, Hannes Reinecke wrote:
>> The underlying problem is the 'WARN_ON()', which actually can (and is)
>> triggered when ANA change AENs are received during controller (re-) connect.
>> At the same time it's quite pointless to update the ANA state for
>> namespaces which are on their way out; we _still_ seeing odd behaviour
>> during simultaneous rescan/reset, and this is just another safeguard.
>> 
>> But for now I'd be happy to drop the check for NS_REMOVING and just
>> delete the WARN_ON().
> 
> Well, we should certainly skip the nvme_mpath_set_live as well for
> a removing namespace.  But yes, I'd prefer to move the check there
> and then remove the WARN_ON over the big hammer.
> 

Hi 
  I happen to be seeing this WARNING in a port we are using while doing failover testing . If the WARNING is removed , should there be another logging message of a similar nature that alerts of a configuration issue has been detected ? Or is this a transient condition ? 
