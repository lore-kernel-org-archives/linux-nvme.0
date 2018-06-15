From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Jun 2018 11:38:06 +0200
Subject: please revert a nvme-cli commit
In-Reply-To: <a4ece148-00b6-01de-ab6b-3fc8a89818f8@broadcom.com>
References: <20180613075557.GA22940@lst.de>
 <64647508-fd1f-9ec2-171d-88ba2a5653b7@broadcom.com>
 <20180614124237.GA28896@lst.de>
 <a4ece148-00b6-01de-ab6b-3fc8a89818f8@broadcom.com>
Message-ID: <20180615093806.GA21345@lst.de>

On Thu, Jun 14, 2018@09:29:24AM -0700, James Smart wrote:
>> I don't agree.  For one so far we've guaranteed the device node
>> appears before we return from the write to the /dev/nvme-fabrics
>> device.  If that changes it is a significant ABI break, and we need
>> to fix that in the kernel.
>
> what provides the guarantee that it appears first ?
>
> Based on what I've seen there is nothing but time that guarantees it, and 
> if that's true, the udev user side always has a potential of getting hung 
> up and exceeding the time.

Then we need to use the proper apis to wait for it to appear instead
of just trying a few times.  I suspect those are going to be either
libudev or libsysfs APIs, but I'll need to look into the details.

>> And for retrying the actual I/O we need to decide on the exact semantics
>> we want to support first.  Blind n time retry is always a bad idea,
>> we need to build some sort of reliable infrastructure.  Be that
>> optionally marking requests as not failfast, and/or some sort of poll
>> notification for a device that is ready.
>
> Ok. Given I've already had complaints that the cli shouldn't hang out for a 
> minute or more - the time it takes for a controller to lose connectivity 
> and fail the loss timeout, and that's not considering the cmds that probe 
> several controllers each of which could do this sequentially resulting in a 
> delay of many minutes - and as the user may want to kill the waiting cli, 
> I'm of the opinion that the kernel request should be terminated not 
> suspended. Thus the ios should continue to be failfast and let the policy 
> be in the cli based on what the command is.? Making the cli use the poll 
> notification to find when the controller is ready again is fine.

The passthrough ioctls can set a per-command timeout, so we should set
that to the time we want to wait for.  And yes, we should do a killable
wait.  Right now the block layer doesn't offer an API for that, but
we really should switch all of NVMe over to that.  I can take it as
an action item to add that support.

> what should be the general policy for any command? if receive an EAGAIN 
> (not ready) then poll until ready or device failure ????? or return 
> failure immediately unless command is connect-all (discovery log read) then 
> it waits for ready/failure ?

We should only ever return EAGAIN if opened with O_NONBLOCK for a start.
And then preferable we should allow to poll for the controller to be
ready.

> what should be the policy for the commands that probe multiple controllers 
> ? ?? do commands fail immediately causing command to skip controllers not 
> ready (message when does so) ??? note: the skip is already there on 
> command failure, but if we suspend as a general policy, it would affect it.

I think we should have the ioctl blocking until the sent timeout (or
killed) and just skip the controllers that time out.  But I'd be happy
to listen to other idea if they sound more sensible.
