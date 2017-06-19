From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 12:42:45 +0200
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <54010ab6-2b79-dbf6-aaea-40d5933e64dc@grimberg.me>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-7-hch@lst.de>
 <b42db191-1298-c879-a1de-1e39724edc9c@grimberg.me>
 <20170619101953.GA18746@lst.de>
 <54010ab6-2b79-dbf6-aaea-40d5933e64dc@grimberg.me>
Message-ID: <20170619104245.GA19651@lst.de>

On Mon, Jun 19, 2017@01:39:05PM +0300, Sagi Grimberg wrote:
> Not sure what you mean, but I didn't mean to change any locking scheme,
> just have the sibling list exist in struct block_device and call
> nvme_ns_find_siblings as a fops callout when the bdev is created, driver
> stays responsible for locking.

A common list with driver specific locking isn't going to work,
we'll need block locking for using it for multipath decisions.
