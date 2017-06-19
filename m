From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 14:27:26 +0300
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <20170619105907.GB21924@lst.de>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-7-hch@lst.de>
 <b42db191-1298-c879-a1de-1e39724edc9c@grimberg.me>
 <20170619101953.GA18746@lst.de>
 <54010ab6-2b79-dbf6-aaea-40d5933e64dc@grimberg.me>
 <20170619104245.GA19651@lst.de>
 <72e49383-1fa4-bd4d-2351-0ed71aaaad19@grimberg.me>
 <20170619105907.GB21924@lst.de>
Message-ID: <8667b820-b25a-c5ea-759b-68fb95a1b02f@grimberg.me>


>> Didn't mean driver specific locking on the sibling list itself,
>> just on the sibling search. The sibling list should obviously have its
>> own locking. You have yet to reveal how the block layer should handle
>> the siblings, but I imagine you have some family representation, which
>> will have its own locking scheme to manage siblings/paths.
> 
> Oh.  No, I don't want to do the search in the block layer at all.
> 
> The are two (or more) request_queues siblings thing makes total sense
> for the block layer.  But how we decide that fact is totally driver
> specif?c.  E.g. for SCSI the search would look completely different
> as we don't have the equivalent of the controllers per subsystem
> list.

OK, I'm totally not getting my point across obviously...

I completely agree that the multipath map (sibling list) is
driver specific, I'm just arguing that the search itself can
be invoked from the block layer through a block_device_operation
when the bdev is created (in there, the driver sibling search has
its own driver specific locking).

When a match is found, driver calls something like
blk_link_sibling(a, b) which grows a sibling relationship map, this
call has block layer locking protection.

[somehow I still have a feeling this won't get across either...]





btw, I didn't see handling of the case where a sibling match found where
the sibling is already linked (a sibling too).

say we have namespaces a, b and c, where b,c are siblings of a (all with
the same nsid=3).

If I read the code correctly, c will link to both a and b wouldn't it?

Do we need to check: list_empty(&cur->siblings)?

Or am I not understanding the data structure?
