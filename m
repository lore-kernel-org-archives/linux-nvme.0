From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 31 Jan 2018 21:24:38 +0100
Subject: [LSF/MM TOPIC] few MM topics
In-Reply-To: <20180131192104.GD4841@magnolia>
References: <20180124092649.GC21134@dhcp22.suse.cz>
 <20180131192104.GD4841@magnolia>
Message-ID: <20180131202438.GA21609@dhcp22.suse.cz>

On Wed 31-01-18 11:21:04, Darrick J. Wong wrote:
> On Wed, Jan 24, 2018@10:26:49AM +0100, Michal Hocko wrote:
[...]
> > - I would also love to talk to some FS people and convince them to move
> >   away from GFP_NOFS in favor of the new scope API. I know this just
> >   means to send patches but the existing code is quite complex and it
> >   really requires somebody familiar with the specific FS to do that
> >   work.
> 
> Hm, are you talking about setting PF_MEMALLOC_NOFS instead of passing
> *_NOFS to allocation functions and whatnot?

yes memalloc_nofs_{save,restore}

> Right now XFS will set it
> on any thread which has a transaction open, but that doesn't help for
> fs operations that don't have transactions (e.g. reading metadata,
> opening files).  I suppose we could just set the flag any time someone
> stumbles into the fs code from userspace, though you're right that seems
> daunting.

I would really love to see the code to take the nofs scope
(memalloc_nofs_save) at the point where the FS "critical" section starts
(from the reclaim recursion POV). This would both document the context
and also limit NOFS allocations to bare minumum.

-- 
Michal Hocko
SUSE Labs
