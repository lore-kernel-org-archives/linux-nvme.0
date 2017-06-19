From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 13:39:05 +0300
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <20170619101953.GA18746@lst.de>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-7-hch@lst.de>
 <b42db191-1298-c879-a1de-1e39724edc9c@grimberg.me>
 <20170619101953.GA18746@lst.de>
Message-ID: <54010ab6-2b79-dbf6-aaea-40d5933e64dc@grimberg.me>


>> General question, Would it make sense to invoke this search from the
>> block layer as part of adding a new disk (a new block_device operation)?
>> And should the sibling association maybe move up to struct block_device?
>> (we could cache nvme_id_ns in nvme_ns for that to happen)?
> 
> For the block/nvme multipath code I need to expose the relationship
> to the block layer.  But the locking is already complicated enough as
> is, so I want to keep the NVMe list as well with that.

Not sure what you mean, but I didn't mean to change any locking scheme,
just have the sibling list exist in struct block_device and call
nvme_ns_find_siblings as a fops callout when the bdev is created, driver
stays responsible for locking.
