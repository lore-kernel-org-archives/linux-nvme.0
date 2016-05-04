From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 4 May 2016 03:58:15 -0700
Subject: RFC: what to do about abort?
In-Reply-To: <5729CCC9.9060307@suse.de>
References: <20160504100313.GA22726@infradead.org> <5729CCC9.9060307@suse.de>
Message-ID: <20160504105815.GA20848@infradead.org>

On Wed, May 04, 2016@12:19:53PM +0200, Hannes Reinecke wrote:
> Failure to respond to an abort command?
> IE you send the abort and never ever get a completion for the abort?
> Uh-oh.

The NVMe spec is extremely vague about Abort doing anything:

"An Abort command is a best effort command; the command to abort may
 have already completed, currently be in execution, or may be deeply
 queued. It is implementation specific if/when a controller chooses
 to complete the command when the command to abort is not found."

And various controllers make full use of the ambiguity offered.

> How would be able to figure out if the card has been able to process
> the abort?

We don't.  Once the abort command itself times out we finally reset
the controller.  And I've not seen a Abort command doing anything but
timing out in the wild.
> 
> > Based on that I came to the conclusion that we'd be much better off
> > to just use the 60 second timeout for I/O command as well, and simply
> > avoid ever sending the abort command.  RFC patch below:
> > 
> Doesn't really help if the command has been dropped into a black
> hole somewhere on the way, right?

It does.  We still end up resetting the controller about 60 seconds
after the black hole appeared, but we put a whole lot less stress
on the host and controller in the meantime.

> In general you _do_ want to handle aborts; there might be
> long-running commands or the array might be genuinely stuck.
> In which case you do want to send an abort to inform the array that
> it should stop processing the command.

There might be special cases where we want to abort a long running
command without touching the rest of the controller state.  However
for the current NVMe driver there are no such long running commands
except for the asynchronous event requests (which never respond to
aborts anyway in practice), and there is no infrastructure to abort
commands except for from the timeout handler.  This mail and patch
should not be interpreted as blocking that use case of abort in the
long run.

> 
> If and how the aborts are handled from the initiator side is another
> story, but for the transport you do need them.

Which transport?  NVMe aborts are protocol level aborts that are just
another command as far as the transport is concerned.

> And increasing the timeout is just deferring the issue to another
> time; why should any command return within the increased timeout, if
> it already failed to return within the original timeout?

No good reason.  I'm just trying to keep existing behavior as much
as possible, and the existing behavior is:

 60 second timeouts for admin command, then reset the controller
 30 second timeouts for I/O commands, then:

    a) send a abort command if under the abort limit
    b) reset the timer for another 30 seconds

The I/O command behavior essentially is a 60 to 90 second timeout due to
the way aborts are actually implemented.  Setting a consistent 60 second
timeout and do the deterministic reset will provide us with a much more
consistent behavior, and put a lot less stress on the host and
controller in the even of the timeout.
