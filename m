From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 19:43:29 +0300
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <20170619130045.GA32190@lst.de>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-7-hch@lst.de>
 <b42db191-1298-c879-a1de-1e39724edc9c@grimberg.me>
 <20170619101953.GA18746@lst.de>
 <54010ab6-2b79-dbf6-aaea-40d5933e64dc@grimberg.me>
 <20170619104245.GA19651@lst.de>
 <72e49383-1fa4-bd4d-2351-0ed71aaaad19@grimberg.me>
 <20170619105907.GB21924@lst.de>
 <8667b820-b25a-c5ea-759b-68fb95a1b02f@grimberg.me>
 <20170619130045.GA32190@lst.de>
Message-ID: <3df15cd3-4604-99c5-5f66-46c383293ae3@grimberg.me>


>> I completely agree that the multipath map (sibling list) is
>> driver specific, I'm just arguing that the search itself can
>> be invoked from the block layer through a block_device_operation
>> when the bdev is created (in there, the driver sibling search has
>> its own driver specific locking).
> 
> Let's wait for that until we have some block layer code posted.

I was actually going to ask you to share the block code :)
It will clear a lot for me...
