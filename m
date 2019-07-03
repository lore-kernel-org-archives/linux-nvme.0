From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 3 Jul 2019 12:13:13 -0600
Subject: [PATCH 0/2] Fix use-after-free bug when ports are removed
In-Reply-To: <e88bed6b-c487-e224-1434-ba9912495a33@grimberg.me>
References: <20190703170136.21515-1-logang@deltatee.com>
 <e88bed6b-c487-e224-1434-ba9912495a33@grimberg.me>
Message-ID: <c072210c-1f44-2803-4781-15ff6f72a07a@deltatee.com>



On 2019-07-03 11:33 a.m., Sagi Grimberg wrote:
>> NVME target ports can be removed while there are still active
>> controllers. Largely this is fine, except some admin commands
>> can access the req->port (for example, id-ctrl uses the port's
>> inline date size as part of it's response). This was found
>> while testing with KASAN.
>>
>> Two patches follow which disconnect active controllers when the
>> ports are removed for loop and rdma. I'm not sure if fc has the
>> same issue and have no way to test this.
>>
>> Alternatively, we could add reference counting to the struct port,
>> but I think this is a more involved change and could be done later
>> after we fix the bug quickly.
> 
> I don't think that when removing a port the expectation is that
> all associated controllers remain intact (although they can, which
> was why we did not remove them), so I think its fine to change that
> if it causes issues.
> 
> Can we handle this in the core instead (also so we'd be consistent
> across transports)?

Yes, that would be much better if we can sort out some other issues below...

> How about this untested patch instead?

I've found a couple of problems with the patch:

1) port->subsystems will always be empty before nvmet_disable_port() is
called. We'd have to restructure things a little perhaps so that when a
subsystem is removed from a port, all the active controllers for that
subsys/port combo would be removed.

2) loop needs to call flush_workqueue(nvme_delete_wq) somewhere,
otherwise there's a small window after the port disappears while
commands can still be submitted. We can actually still hit the bug with
a tight loop.

Maybe there's other cleanup that could be done to solve this: it does
seem like all three transports need to keep their own lists of open
controllers and loops through them to delete them. In theory, that could
be made common so there's common code to manage the list per transport
which would remove some boiler plate code. If we want to go this route
though, I'd suggest using my patches as is for now and doing the cleanup
in the next cycle.

Logan
