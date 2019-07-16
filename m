From: leon@kernel.org (Leon Romanovsky)
Date: Tue, 16 Jul 2019 13:20:50 +0300
Subject: [PATCH for-rc] RDMA/bnxt_re: Honor vlan_id in GID entry comparison
In-Reply-To: <20190716095852.GA25228@kroah.com>
References: <20190715091913.15726-1-selvin.xavier@broadcom.com>
 <20190716071030.GH10130@mtr-leonro.mtl.com>
 <20190716071644.GA21780@kroah.com>
 <20190716084126.GJ10130@mtr-leonro.mtl.com>
 <20190716090917.GA11964@kroah.com>
 <20190716095007.GK10130@mtr-leonro.mtl.com>
 <20190716095852.GA25228@kroah.com>
Message-ID: <20190716102050.GL10130@mtr-leonro.mtl.com>

On Tue, Jul 16, 2019@06:58:52PM +0900, Greg KH wrote:
> On Tue, Jul 16, 2019@12:50:07PM +0300, Leon Romanovsky wrote:
> > On Tue, Jul 16, 2019@06:09:17PM +0900, Greg KH wrote:
> > > On Tue, Jul 16, 2019@11:41:26AM +0300, Leon Romanovsky wrote:
> > > > On Tue, Jul 16, 2019@04:16:44PM +0900, Greg KH wrote:
> > > > > On Tue, Jul 16, 2019@10:10:30AM +0300, Leon Romanovsky wrote:
> > > > > > On Mon, Jul 15, 2019@05:19:13AM -0400, Selvin Xavier wrote:
> > > > > > > GID entry consist of GID, vlan, netdev and smac.
> > > > > > > Extend GID duplicate check companions to consider vlan_id as well
> > > > > > > to support IPv6 VLAN based link local addresses. Introduce
> > > > > > > a new structure (bnxt_qplib_gid_info) to hold gid and vlan_id information.
> > > > > > >
> > > > > > > The issue is discussed in the following thread
> > > > > > > https://www.spinics.net/lists/linux-rdma/msg81594.html
> > > > > > >
> > > > > > > Fixes: 823b23da7113 ("IB/core: Allow vlan link local address based RoCE GIDs")
> > > > > > > Cc: <stable at vger.kernel.org> # v5.2+
> > > > > > > Reported-by: Yi Zhang <yi.zhang at redhat.com>
> > > > > >
> > > > > > > Co-developed-by: Parav Pandit <parav at mellanox.com>
> > > > > > > Signed-off-by: Parav Pandit <parav at mellanox.com>
> > > > > >
> > > > > > I never understood why bad habits are so stinky.
> > > > > >
> > > > > > Can you please explain us what does it mean Co-developed-by and
> > > > > > Signed-off-by of the same person in the same patch?
> > > > >
> > > > > See Documentation/process/submitting-patches.rst for what that tag
> > > > > means.
> > > >
> > > > Read it, it doesn't help me to understand if I should now add
> > > > Co-developed-by tag to most of RDMA Mellanox upstreamed patches,
> > > > which already care my Signed-off-by, because I'm changing and fixing
> > > > them many times.
> > >
> > > It depends, it's your call, if you think you deserve the credit, sure,
> > > add it.  If you are just doing basic "review" where you tell people what
> > > needs to be done better, that's probably not what you need to do here.
> >
> > I'll probably not use this and not because I don't deserve credit, but
> > because it looks ridiculously to me to see my name repeated N times for
> > my work.
>
> That's up to you, and your fellow co-authors to decide.
>
> > > One example, where I just added myself to a patch happened last week
> > > where the developer submitted one solution, I took it and rewrote the
> > > whole implementation (from raw kobjects to using the driver model).  The
> > > original author got the "From:" and I got a Co-developed-by line.
> >
> > In old days, we simply changed Author field if changes were above some
> > arbitrary threshold (usually half of the original patch) and added SOB.
> >
> > Why wasn't this approach enough?
>
> Because we have had some patches where it really was a work of multiple
> people and it is good to show the correct authorship wherever possible.
>
> If you look, this tag was added based on a document in the kernel tree
> that Thomas and I worked on together and we both wanted the "blame" for
> it :)
>
> > > Does that help?
> >
> > Yes, and it makes me wonder when we will need to hire compliance officer
> > who will review all our upstreamed patches to comply with more and more
> > bureaucracy.
>
> Oh come on, this is about the ability to give people credit where they
> did not have it before.  It's not about being "compliant", it's about
> being "nice" and "fair".  Something that no one should complain about.
>
> There is no one forcing you to add this tag to patches with your name on
> it if you do not want to.  But for those who work on changes together,
> it is important to give them that type of credit.

It is partly true, I agree that for my own patches I can do more or less
whatever I want, but my responsibilities are broader and I need to guide
internal development teams on how to develop for upstream and how
to upstream their work later on.

Exactly like Theodore (if I'm not mistaken here) mentioned in last
reply to ksummit thread about meaningful Reviewed-by and Acked-by tags,
I got complains when I changed/fixed inappropriate tags. Now, I'll get
extra complains for not allowing to use Co-... tag too.

So it is not true for my second responsibility, where I must to do it
right and with minimal number of my personal preferences.

This extra documented tag puts me in position where I don't want to
be - in the middle between documentation and personal opinion on not
important thing.

Thanks

>
> thanks,
>
> greg k-h
