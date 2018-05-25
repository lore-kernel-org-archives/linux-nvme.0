From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 16:30:58 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180525142217.zedv7hz6ov6s45qk@linux-x5ow.site>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
 <20180525142217.zedv7hz6ov6s45qk@linux-x5ow.site>
Message-ID: <20180525143058.GA26391@lst.de>

On Fri, May 25, 2018@04:22:17PM +0200, Johannes Thumshirn wrote:
> But Mike's and Hannes' arguments where reasonable as well, we do not
> know if there are any existing setups we might break leading to
> support calls, which we have to deal with. Personally I don't believe
> there are lot's of existing nvme multipath setups out there, but who
> am I to judge.

I don't think existing setups are very likely, but they absolutely
are a valid reason to support the legacy mode.  That is why we support
the legacy mode using the multipath module option.  Once you move
to a per-subsystem switch you don't support legacy setups, you
create a maze of new setups that we need to keep compatibility
support for forever.

> So can we find a middle ground to this? Or we'll have the
> all-or-nothing situation we have in scsi-mq now again. How about
> tieing the switch to a config option which is off per default?

The middle ground is the module option.  It provides 100% backwards
compatibility if used, but more importantly doesn't create hairy
runtime ABIs that we will have to support forever.
