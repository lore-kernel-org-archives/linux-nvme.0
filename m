From: tj@kernel.org (Tejun Heo)
Date: Sat, 18 Jan 2014 09:59:40 -0500
Subject: [PATCH v2 0/9] Phase out pci_enable_msi_block()
In-Reply-To: <CAErSpo4nBdnn3YYaLj6QZ8iyY2pzV8Y7msd5UxJXm1T2AYnqfg@mail.gmail.com>
References: <cover.1389904166.git.agordeev@redhat.com>
 <CAErSpo5ztnyyceeN38XzLasLV6eJqdbqEV0viPp3Af8U=ts23w@mail.gmail.com>
 <20140118071538.GA32535@dhcp-26-207.brq.redhat.com>
 <CAErSpo4nBdnn3YYaLj6QZ8iyY2pzV8Y7msd5UxJXm1T2AYnqfg@mail.gmail.com>
Message-ID: <20140118145940.GE3640@htj.dyndns.org>

On Sat, Jan 18, 2014@07:38:55AM -0700, Bjorn Helgaas wrote:
> On Sat, Jan 18, 2014@12:15 AM, Alexander Gordeev <agordeev@redhat.com> wrote:
> > On Fri, Jan 17, 2014@02:00:32PM -0700, Bjorn Helgaas wrote:
> >> > As the release is supposedly this weekend, do you prefer
> >> > the patches to go to your tree or to individual trees after
> >> > the release?
> >>
> >> I'd be happy to merge them, except for the fact that they probably
> >> wouldn't have any time in -next before I ask Linus to pull them.  So
> >> how about if we wait until after the release, ask the area maintainers
> >> to take them, and if they don't take them, I'll put them in my tree
> >> for v3.15?
> >
> > Patch 11 depends on patches 1-10, so I am not sure how to better handle it.
> > Whatever works for you ;)
> >
> > I am only concerned with a regression fix "ahci: Fix broken fallback to
> > single MSI mode" which would be nice to have in 3.14. But it seems pretty
> > much too late.
> 
> Tejun, if you want to ack that one, I can put it in either the first
> 3.14 pull request or a subsequent one.  Either way, since it's a
> regression fix, we should be able to get it in 3.14.

Acked-by: Tejun Heo <tj at kernel.org>

Please feel free to route it any way you see fit.

Thanks!

-- 
tejun
