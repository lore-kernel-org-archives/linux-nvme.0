From: james.smart@broadcom.com (James Smart)
Date: Tue, 5 Dec 2017 11:41:31 -0800
Subject: [PATCH] nvme-fc: Implement async-connect option
In-Reply-To: <1512461082-41520-1-git-send-email-hare@suse.de>
References: <1512461082-41520-1-git-send-email-hare@suse.de>
Message-ID: <363cfdca-be70-ab28-e241-c835d18c588f@broadcom.com>

On 12/5/2017 12:04 AM, Hannes Reinecke wrote:
> By opening the control fd with O_NONBLOCK the fabrics module will
> attempt an async connect if implemented.
> This is especially useful when calling 'nvme connect' from an udev
> rule, as there each program should return as fast as possible to
> avoid an udev event processing stall.
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
>

This seems odd.?? I would have thought any async connect option would 
have been isolated in the fabrics.c file and applicable to any transport.

I can understand why this works as fc is well suited for this division 
(allocates ctrl 1st, then makes 1st connection in same style as 
reconnects). But the other transports aren't structure the same way so 
they're going to be a bit more trouble.

-- james
