From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Jul 2017 19:30:31 +0300
Subject: [PATCH rfc 2/3] RDMA/core: expose cpu affinity based completion
 vector lookup
In-Reply-To: <20170713155000.GA2577@lst.de>
References: <1499007694-7231-1-git-send-email-sagi@grimberg.me>
 <1499007694-7231-3-git-send-email-sagi@grimberg.me>
 <20170713155000.GA2577@lst.de>
Message-ID: <0126c38f-c6e1-3496-9c08-dcf043986923@grimberg.me>


>> A ULP might want to lookup an optimal completion vector based on
>> a given cpu core affinity. Expose a lookup routine for it iterating
>> on the device completion vectors searching a vector with affinity
>> matching the given cpu.
> 
> Shouldn't this return the mask of cpus with the matching affinity
> instead of always the first one?

Its the opposite, I'm looking for the vector matching a given cpu.

In case there are multiple vectors with the same cpu assignment,
it doesn't really matter which one is it.
