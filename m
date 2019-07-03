From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 3 Jul 2019 13:24:33 -0600
Subject: [PATCH 0/2] Fix use-after-free bug when ports are removed
In-Reply-To: <e7f0ae6e-9a72-0640-12d3-1683f9950a13@grimberg.me>
References: <20190703170136.21515-1-logang@deltatee.com>
 <e88bed6b-c487-e224-1434-ba9912495a33@grimberg.me>
 <c072210c-1f44-2803-4781-15ff6f72a07a@deltatee.com>
 <e7f0ae6e-9a72-0640-12d3-1683f9950a13@grimberg.me>
Message-ID: <6344ac00-0102-5cc8-a565-58a715657345@deltatee.com>



On 2019-07-03 1:20 p.m., Sagi Grimberg wrote:
> 
>>> Can we handle this in the core instead (also so we'd be consistent
>>> across transports)?
>>
>> Yes, that would be much better if we can sort out some other issues
>> below...
>>
>>> How about this untested patch instead?
>>
>> I've found a couple of problems with the patch:
>>
>> 1) port->subsystems will always be empty before nvmet_disable_port() is
>> called. We'd have to restructure things a little perhaps so that when a
>> subsystem is removed from a port, all the active controllers for that
>> subsys/port combo would be removed.
> 
> Yes, that is better.

Ok, if you like this solution I'll try and come up with a patch like
that. It *may* not be too intrusive compared to the cleanup I suggested
below.

>> 2) loop needs to call flush_workqueue(nvme_delete_wq) somewhere,
>> otherwise there's a small window after the port disappears while
>> commands can still be submitted. We can actually still hit the bug with
>> a tight loop.
> 
> We could simply flush the workqueue in nvme_loop_delete_ctrl for
> each controller?
> 
> Might be an overkill though, and its risking circular locking in case
> we are going via the fatal error path (work context flushing a different
> workqueue always annoys lockdep even when its perfectly safe)
> 
>> Maybe there's other cleanup that could be done to solve this: it does
>> seem like all three transports need to keep their own lists of open
>> controllers and loops through them to delete them. In theory, that could
>> be made common so there's common code to manage the list per transport
>> which would remove some boiler plate code. If we want to go this route
>> though, I'd suggest using my patches as is for now and doing the cleanup
>> in the next cycle.
> 
> Then please fix tcp as well.

Ok, I'll try to send either a destroy controller on subsystem-removal
patch or I'll resend these with TCP included sometime today or tomorrow.

Thanks,

Logan
