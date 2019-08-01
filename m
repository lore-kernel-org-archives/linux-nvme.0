From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Aug 2019 14:52:37 -0700
Subject: [PATCH 1/2] nvme: skip namespaces which are about to be removed
In-Reply-To: <20190801213600.GG15795@localhost.localdomain>
References: <20190801071644.66690-1-hare@suse.de>
 <20190801071644.66690-2-hare@suse.de>
 <20190801213600.GG15795@localhost.localdomain>
Message-ID: <8c71f313-4543-f581-af96-84070b8dbe5e@grimberg.me>


>> nvme_ns_remove() will only remove the namespaces from the list at
>> the very last step, so we might run into situations where we iterate
>> over namespaces which are about to be deleted.
>> To avoid crashes we should be skipping all namespaces with the
>> NVME_NS_REMOVING flag set.
> 
> This all looks to be racing with whatever task is going to call
> nvme_ns_remove().
> 
> Could we instead move these invalid namespaces off the ctrl->namespaces
> list prior to calling nvme_ns_remove(), and while holding the write
> lock? That way nothing can iterate the namespaces that we're deleting.
> We already do that in some places, so that looks like it may be the safe
> way to do this.

This is exactly what I proposed in:
[PATCH rfc 2/2] nvme: fix possible use-after-free condition when 
controller reset is racing namespace scanning
