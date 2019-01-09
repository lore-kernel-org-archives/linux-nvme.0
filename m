From: hch@lst.de (Christoph Hellwig)
Date: Wed, 9 Jan 2019 19:43:00 +0100
Subject: [PATCH] nvme-multipath: drop optimization for static ANA group IDs
In-Reply-To: <20190109084515.82076-1-hare@suse.de>
References: <20190109084515.82076-1-hare@suse.de>
Message-ID: <20190109184300.GC22070@lst.de>

On Wed, Jan 09, 2019@09:45:15AM +0100, Hannes Reinecke wrote:
> Bit 6 in the ANACAP field is used to indicate that the ANA group ID
> doesn't change while the namespace is attached to the controller.
> There is an optimisation in the code to only allocate space
> for the ANA group header, as the namespace list won't change and
> hence would not need to be refreshed.
> However, this optimisation was never carried over to the actual
> workflow, which always assumes that the buffer is large enough
> to hold the ANA header _and_ the namespace list.
> So drop this optimisation and always allocate enough space.

Isn't the real bug that we always clear groups_only in nvme_ana_work,
and we could simply make the conditional instead?
