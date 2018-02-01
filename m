From: david@fromorbit.com (Dave Chinner)
Date: Fri, 2 Feb 2018 09:47:38 +1100
Subject: [Lsf-pc] [LSF/MM TOPIC] few MM topics
In-Reply-To: <20180201154655.GN21609@dhcp22.suse.cz>
References: <20180124092649.GC21134@dhcp22.suse.cz>
 <20180131192104.GD4841@magnolia>
 <20180131202438.GA21609@dhcp22.suse.cz>
 <20180131234126.oobqdp6ibcayduu3@destitution>
 <20180201154655.GN21609@dhcp22.suse.cz>
Message-ID: <20180201224738.y3vsrh7ekdugm5ae@destitution>

On Thu, Feb 01, 2018@04:46:55PM +0100, Michal Hocko wrote:
> On Thu 01-02-18 10:41:26, Dave Chinner wrote:
> > On Wed, Jan 31, 2018@09:24:38PM +0100, Michal Hocko wrote:
> [...]
> > > This would both document the context
> > > and also limit NOFS allocations to bare minumum.
> > 
> > Yup, most of XFS already uses implicit GFP_NOFS allocation calls via
> > the transaction context process flag manipulation.
> 
> Yeah, xfs is in quite a good shape. There are still around 40+ KM_NOFS
> users. Are there any major obstacles to remove those? Or is this just
> "send patches" thing.

They need to be looked at on a case by case basis - many of
them are the "shut up lockdep false positives" workarounds because
the code is called from multiple memory reclaim contexts. In other
cases they might actually be needed. If you send patches, it'll
kinda force us to look at them and say yay/nay :P

> Compare that to
> $ git grep GFP_NOFS -- fs/btrfs/ | wc -l
> 272

Fair point. :P

Cheers,

Dave.
-- 
Dave Chinner
david at fromorbit.com
