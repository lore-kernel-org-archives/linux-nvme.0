From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 12:59:07 +0200
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <72e49383-1fa4-bd4d-2351-0ed71aaaad19@grimberg.me>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-7-hch@lst.de>
 <b42db191-1298-c879-a1de-1e39724edc9c@grimberg.me>
 <20170619101953.GA18746@lst.de>
 <54010ab6-2b79-dbf6-aaea-40d5933e64dc@grimberg.me>
 <20170619104245.GA19651@lst.de>
 <72e49383-1fa4-bd4d-2351-0ed71aaaad19@grimberg.me>
Message-ID: <20170619105907.GB21924@lst.de>

On Mon, Jun 19, 2017@01:57:19PM +0300, Sagi Grimberg wrote:
> Didn't mean driver specific locking on the sibling list itself,
> just on the sibling search. The sibling list should obviously have its
> own locking. You have yet to reveal how the block layer should handle
> the siblings, but I imagine you have some family representation, which
> will have its own locking scheme to manage siblings/paths.

Oh.  No, I don't want to do the search in the block layer at all.

The are two (or more) request_queues siblings thing makes total sense
for the block layer.  But how we decide that fact is totally driver
specif?c.  E.g. for SCSI the search would look completely different
as we don't have the equivalent of the controllers per subsystem
list.
