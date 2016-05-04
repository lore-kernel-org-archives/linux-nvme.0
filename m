From: hare@suse.de (Hannes Reinecke)
Date: Wed, 4 May 2016 12:19:53 +0200
Subject: RFC: what to do about abort?
In-Reply-To: <20160504100313.GA22726@infradead.org>
References: <20160504100313.GA22726@infradead.org>
Message-ID: <5729CCC9.9060307@suse.de>

On 05/04/2016 12:03 PM, Christoph Hellwig wrote:
> I've recently spent some time on the Abort implementation for
> the Fabrics host and target drivers, and given how vaguele Abort
> is defined in the spec, I fail to see how sending an abort actually
> buys us anything.  The controller doesn't even have to respond, and
> in fact many don't, so we simply end up escalation to a reset after
> the abort command times out.  Similarly the amount of abort commands
> is severly limited, and I've not seen a controller exceeding the
> recommended 4 allowed abort commands, leading to sever pressure on
> the error handling code for the typical case of a somehow stuck
> controller that has multiple outstanding commands beyoned the allowed
> timeout.
> 
Failure to respond to an abort command?
IE you send the abort and never ever get a completion for the abort?
Uh-oh.
How would be able to figure out if the card has been able to process
the abort?

> Based on that I came to the conclusion that we'd be much better off
> to just use the 60 second timeout for I/O command as well, and simply
> avoid ever sending the abort command.  RFC patch below:
> 
Doesn't really help if the command has been dropped into a black
hole somewhere on the way, right?
In general you _do_ want to handle aborts; there might be
long-running commands or the array might be genuinely stuck.
In which case you do want to send an abort to inform the array that
it should stop processing the command.

If and how the aborts are handled from the initiator side is another
story, but for the transport you do need them.
And increasing the timeout is just deferring the issue to another
time; why should any command return within the increased timeout, if
it already failed to return within the original timeout?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
