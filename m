From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 13:57:19 +0300
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <20170619104245.GA19651@lst.de>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-7-hch@lst.de>
 <b42db191-1298-c879-a1de-1e39724edc9c@grimberg.me>
 <20170619101953.GA18746@lst.de>
 <54010ab6-2b79-dbf6-aaea-40d5933e64dc@grimberg.me>
 <20170619104245.GA19651@lst.de>
Message-ID: <72e49383-1fa4-bd4d-2351-0ed71aaaad19@grimberg.me>


>> Not sure what you mean, but I didn't mean to change any locking scheme,
>> just have the sibling list exist in struct block_device and call
>> nvme_ns_find_siblings as a fops callout when the bdev is created, driver
>> stays responsible for locking.
> 
> A common list with driver specific locking isn't going to work,
> we'll need block locking for using it for multipath decisions.

Didn't mean driver specific locking on the sibling list itself,
just on the sibling search. The sibling list should obviously have its
own locking. You have yet to reveal how the block layer should handle
the siblings, but I imagine you have some family representation, which
will have its own locking scheme to manage siblings/paths.
