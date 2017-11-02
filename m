From: james.smart@broadcom.com (James Smart)
Date: Thu, 2 Nov 2017 15:02:14 -0700
Subject: [PATCH 5/5] lpfc: Add sysfs interface to post NVME RSCN
In-Reply-To: <1509653383.4090.120.camel@localhost.localdomain>
References: <20171028172114.2045-1-jsmart2021@gmail.com>
 <20171028172114.2045-6-jsmart2021@gmail.com>
 <1509653383.4090.120.camel@localhost.localdomain>
Message-ID: <70c97ac7-9726-926b-fdbb-cd51149feff6@broadcom.com>

On 11/2/2017 1:09 PM, Ewan D. Milne wrote:
>
> So, with this sysfs interface, if someone accidentally or intentionally
> issues RSCNs in a loop at high frequency, what is this going to do to
> the FC fabric?
>
> Most people know to use single-initiator zoning, but the affected target
> ports would still get the RSCN, correct?
>
> -Ewan
>
>

It's a moot point right now, but...

It generates some traffic of course. They are small single-frame 
transmissions, so not a lot. If switched, the switch will only send them 
to ports that have registered for the event type, an attribute change, 
and then again only to the initiators within the same zone(s) as the 
target. Target ports would not receive them.? So should be limited to 
the initiators that can view the target.

-- james
