From: kbusch@kernel.org (Keith Busch)
Date: Thu, 1 Aug 2019 16:10:31 -0600
Subject: [PATCH 1/2] nvme: skip namespaces which are about to be removed
In-Reply-To: <8c71f313-4543-f581-af96-84070b8dbe5e@grimberg.me>
References: <20190801071644.66690-1-hare@suse.de>
 <20190801071644.66690-2-hare@suse.de>
 <20190801213600.GG15795@localhost.localdomain>
 <8c71f313-4543-f581-af96-84070b8dbe5e@grimberg.me>
Message-ID: <20190801221031.GH15795@localhost.localdomain>

On Thu, Aug 01, 2019@02:52:37PM -0700, Sagi Grimberg wrote:
> 
> > > nvme_ns_remove() will only remove the namespaces from the list at
> > > the very last step, so we might run into situations where we iterate
> > > over namespaces which are about to be deleted.
> > > To avoid crashes we should be skipping all namespaces with the
> > > NVME_NS_REMOVING flag set.
> > 
> > This all looks to be racing with whatever task is going to call
> > nvme_ns_remove().
> > 
> > Could we instead move these invalid namespaces off the ctrl->namespaces
> > list prior to calling nvme_ns_remove(), and while holding the write
> > lock? That way nothing can iterate the namespaces that we're deleting.
> > We already do that in some places, so that looks like it may be the safe
> > way to do this.
> 
> This is exactly what I proposed in:
> [PATCH rfc 2/2] nvme: fix possible use-after-free condition when controller
> reset is racing namespace scanning

Hm, I had to look up why the list_del is done at then end. It is after
del_gendisk() because that syncs dirty buffers, which means we could have
IO that can timeout. We need the namespaces in the controller list during
removal so that timeout handlers can iterate them for cleanup. Otherwise
you could have some buffered write tasks constantly entering the queue,
preventing namespace removal. The only time should be safe to take the
namespace off list first is if we've set the queue to dying prior to
calling del_gendisk.
