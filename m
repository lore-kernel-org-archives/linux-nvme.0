From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 14:31:55 -0800
Subject: [PATCHv3 0/3] nvme: NUMA locality for fabrics
In-Reply-To: <20181116082359.GB14269@lst.de>
References: <20181102095641.28504-1-hare@suse.de>
 <20181116081241.GA14072@lst.de>
 <c6b0e0f8-f22c-65b6-3657-1f078b0803e2@suse.de>
 <20181116082359.GB14269@lst.de>
Message-ID: <58a66fee-0185-6ab4-3fe1-797d15d9badb@grimberg.me>


>> If we can agree that we'll go for the round-robin scheduler I guess this
>> patchset can be retracted (for now).
>> There still might be some gain to be had, but it can be implemented as an
>> additional I/O policy.
> 
> I don't think we can.  round-robin is fundamentally the wrong thing
> to do as you keep touching different cache lines.  If a customer really
> insists on round robin they are probably better off in a SCSI world..

While we often think that link aggregation is a thing of the past as
adapters keep getting faster, I guess that in some cases it can buy us
some benefits. Personally, as long as the round-robin policy stays ANA
aware I don't see the harm in offering it.

And I agree that its often the wrong thing to do, which is why we
should never let it be the default policy.

What I'm a bit struggling with is the implementation that is a bit
cumbersome IMO with constant clearing of the current_path. In this
policy there is no current_path really...
