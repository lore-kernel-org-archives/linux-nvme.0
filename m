From: hch@lst.de (Christoph Hellwig)
Date: Tue, 16 Jul 2019 11:38:25 +0200
Subject: [PATCH] nvme-multipath: sanitize nvme_update_ana_state()
In-Reply-To: <20190716071830.22672-1-hare@suse.de>
References: <20190716071830.22672-1-hare@suse.de>
Message-ID: <20190716093825.GC32562@lst.de>

On Tue, Jul 16, 2019@09:18:30AM +0200, Hannes Reinecke wrote:
> Commit 04e70bd4a026 ("nvme-multipath: do not select namespaces
> which are about to be removed") introduced checks when traversing
> the list of namespaces to avoid tripping over invalid namespaces.
> A similar check is needed in nvme_update_ana_state() to skip updates
> for any namespaces which will be removed.
> With that we should also remove the WARN_ON() at the end of the
> iteration; this will also be errorneously triggered if ANA Change AENS
> are received during scanning.

What is the problem we are trying to fix here?  Just that we should
not call nvme_mpath_set_live?  In that case it might make more sense
to move the removed check to just guard that call and at least keep
the values in struct nvme_ns uptodate.
