From: keith.busch@intel.com (Busch, Keith)
Date: Tue, 27 Nov 2012 20:13:38 +0000
Subject: NVMe: Timed-out commands and expected behavior?
In-Reply-To: <CACiFetTk=A5iWwxw1mgnUdzU9GvVevASpvh5cgGdQvWTKSSvPQ@mail.gmail.com>
References: <CACiFetTk=A5iWwxw1mgnUdzU9GvVevASpvh5cgGdQvWTKSSvPQ@mail.gmail.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B9162CE011@FMSMSX105.amr.corp.intel.com>

On Tue Nov 27 12:12:54 EST 2012, Geoffrey Blake wrote:
> Hi all,
> 
> I'm developing a device model for a simulator based off the NVMe 1.0c
> specification and have been using the linux driver from the git-tree
> hosted here.  I've run into what I believe is unintentional behavior
> for read/write commands submitted from nvme_submit_bio_queue().  The
> commands are allocated with a specified timeout (NVME_IO_TIMEOUT) and I
> wanted to know what is the intended behavior when that timeout is
> reached? 

I believe the idea was to prevent an application from hanging in a D+ state on an IO that will never return. But I think you're right; the situation you've described reveals unintended consequences that probably need to be addressed.

> Below I'll describe what I've seen and believe is happening by
> looking at the driver code.
> 
> With my model, I've set its performance intentionally low to debug that
> it is functionally correct, but this leads to high latency I/O
> operations at times if the submission queues start to get backed up.
> After a while my model will complain that a PRP list structure contains
> bad data and the simulation will exit.  Getting an instruction trace
> indicates that the nvme driver is deallocating memory and setting the
> contents to invalid values that the controller model is concurrently
> trying to access.  No ABORT commands were sent by the kernel to
> indicate a command should be thrown out.
> 

I took a stab at sending aborts a while back, but ran into other problems with real hardware misbehaving: the controller would sometimes never return status for the abort and the driver ran out of abort requests that could be sent, or the controller returned successful status but never sent a completion for the command being aborted. The handling for all these situations started to require more code than I originally thought should have been necessary, at which point I set it aside. :)

> Looking at the driver I see that nvme_kthread() runs periodically to
> cleanup any timed-out cmds by calling nvme_cancel_ios().  The cmd is
> then canceled by cancel_cmdid() and its completion handler is called
> (bio_completion() in my case) and it deallocates the dma buffers for
> the kernel to reclaim.  Some cancelled commands that the controller
> still processed are posted to the completion queue and then
> special_completion() is called which simply returns if the command is
> canceled.  This means the controller has potentially been writing to
> reclaimed kernel buffers that could contain data for something else,
> leading to corruption.
> 
> Should the driver actually inform the controller that a command is
> being cancelled with an ABORT command?  Or should the driver just not
> reclaim the buffers until the command has actually completed?  Or have
> I missed modeling intended behavior by the controller in this case?
> Thanks,
> Geoff Blake
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
