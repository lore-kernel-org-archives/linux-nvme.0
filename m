From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Jan 2015 16:12:35 +0000 (UTC)
Subject: Potential memory corruption caused by DMA to a killed process
In-Reply-To: <20150107051426.GA7020@u109add4315675089e695.ant.amazon.com>
References: <20150107051426.GA7020@u109add4315675089e695.ant.amazon.com>
Message-ID: <alpine.LNX.2.00.1501081605520.4026@localhost.lm.intel.com>

On Tue, 6 Jan 2015, Matt Wilson wrote:
> Hi,
>
> The current Linux NVMe driver sets the current task state to
> TASK_KILLABLE in nvme_submit_sync_cmd(). This does not seem safe. If a
> userspace process issues a command via ioctl(), the kernel will pin
> the relevant pages through get_user_pages_fast(). But if the process
> is killed before the NVMe device issues the DMA in response, the
> memory will be released and potentially used by something else.
>
> We observed this actually happening in a test environment (set up by
> Anthony) with a test userspace program submitting commands to an
> emulated NVMe device that completed admin commands artificially slowly
> so that we could kill the process reliably.
>
> It would seem that tasks need to be uninterruptable from the time a
> command that references its pages is placed in the submission ring
> until the completion of the command.
>
> Additionally if the driver times out a command, it needs to be
> synchronously (and confidently) aborted before return from ioctl() or
> allow the process to be killed.
>
> Thoughts?

Right, that is a gap in this path. It will be easier to fix when/if the
hot-plug series is applied since it "starts" driver allocated requests
to make them elidgible for timeout handling. Then we can just set the
state to uninterruptable and use schedule() instead of schedule_timeout().
