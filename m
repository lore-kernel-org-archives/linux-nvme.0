From: sagi@lightbits.io (Sagi Grimberg)
Date: Thu, 22 Dec 2016 14:08:44 +0200
Subject: Q: nvme_rdma and reconnect
In-Reply-To: <20161222064115.GA9581@infradead.org>
References: <20161207183947.128897-1-daniel.verkamp@intel.com>
 <138d5098-5d12-9a06-66c4-14f53770b0ba@intel.com>
 <20161209182827.GA16834@lst.de>
 <7c17a439-5a28-f458-3af7-221d84607611@intel.com>
 <20161221102744.GA30308@lst.de>
 <830460a5-ce31-b882-8f06-4a906763eb50@broadcom.com>
 <20161222064115.GA9581@infradead.org>
Message-ID: <9576f8bf-e2df-d00f-edb6-8f17ae188980@grimberg.me>


>> Sagi, Christoph,
>>
>> Can you explain what the difference is between the "reset" path and the
>> "error/reconnect" path is in the rdma driver.  From my point of view, it
>> would seem both, relative to the fabric-side of the transport, are
>> terminating the controller and reconnecting to a new controller to recover.
>> So why wouldn't they be the same (single) reset flow ?
>
> They should use the same flow.  A couple month ago I had a prototype
> for that but never got it to work fully.

One more distinction is that reconnect failures will retry periodically
while reset failure will remove the device (aligns with the pci driver
behavior).

We can go via the same flow and condition on the state for the
differences, but I'm not sure its easier to understand than two
distinct routines (although that share a lot of code).
