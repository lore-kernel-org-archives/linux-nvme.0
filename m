From: james.smart@broadcom.com (James Smart)
Date: Tue, 20 Mar 2018 10:07:34 -0700
Subject: Nvme over fabrics controller reset issue
In-Reply-To: <CADLzrv8jrv4SMYa9BOFOi4rkyBkfYQD5QJ64QVqyXrCnDddVKg@mail.gmail.com>
References: <CADLzrv8jrv4SMYa9BOFOi4rkyBkfYQD5QJ64QVqyXrCnDddVKg@mail.gmail.com>
Message-ID: <0486ff2e-8cd1-a80e-bba1-fa618837cc27@broadcom.com>

If you sent a SetProperty as a pass-thru, the initiator side will have 
no clue about controller reset happening as it won't be snooping the 
commands.? What should happen is for the controller side to reset the 
controller, contacting the transport to delete the connections.? I would 
have expected that to happen on the CC.EN=0. Thus, the CC.EN=1 should 
not have succeeded - it should have timed out, at that point, or upon 
the first detection of an issue talking to a controller-terminated 
associaton.

It is a bug that nvmet fabrics-cmd.c doesn't terminate the controller if 
CC.EN=0.

-- james


On 3/19/2018 9:21 PM, muthu crazy wrote:
> Hi All,
>
> I found a strange behaviour when I used NVMe Fabrics target.  From
> Host I sent a Set property command to make CC.EN=0. And then again I
> made CC.EN=1. I was expecting all the transport and nvme queus will be
> deleted. But didn't happen, rather queus are retained connection is
> still active.
>
>   Isn't violation of NVMe spec. Is there any reason for implementing this way?
>
> Thanks and regards,
> Muthu
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
