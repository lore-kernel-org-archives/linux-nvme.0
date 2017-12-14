From: marc@merlins.org (Marc MERLIN)
Date: Wed, 13 Dec 2017 19:36:33 -0800
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <20170313153319.fmy6ww72fjtx74xq@merlins.org>
 <20170313143649.GC6994@localhost.localdomain>
 <20170311022612.GB28220@merlins.org>
 <20170215181435.36saagrln25im7ml@merlins.org>
Message-ID: <20171214033633.4oncj3kcsvxv4kic@merlins.org>

On Mon, Mar 13, 2017@08:33:19AM -0700, Marc MERLIN wrote:
> On Mon, Mar 13, 2017@10:36:50AM -0400, Keith Busch wrote:
> > On Fri, Mar 10, 2017@06:26:12PM -0800, Marc MERLIN wrote:
> > > Hi Keith,
> > > 
> > > From what I think I've seen, your patches did get in. Thank you again for
> > > getting them through.
> > > 
> > > I'm assuming that they were too late for 4.10 but would be in 4.11, correct?
> > > 
> > > The 4.10 branch you gave me to test sadly has multiple other bugs that make
> > > it not very desirable on my laptop for every day use, so I'm looking at
> > > switching to a standard released kernel as soon as practical.
> > > I'm also happy to install your patches on top of a release kernel, if they
> > > do apply until they make it to the next mainline release (but don't do extra
> > > rebase for me if that's needed, I'm ok waiting if they don't apply as is)
> > 
> > No problem, thanks for reporting the issue and sticking with it through
> > all the delays.
> > 
> > This was too late for 4.10, but applied with the 4.11 merge. The commit
> > is here:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=302ad8cc09339ea261eef58a8d5f4a116a8ffda5
>  
> Thank yuou.
> 
> > Sorry to hear about the other bugs. I think this should be readily
> > portable to the 4.9 longterm stable brach if we get the OK to apply the
> > new blk-mq API's. I'll do some testing this week and check with the
> > maintainers.
> 
> No worries, I didn't expect a random in between release kernel to be
> fully stable. If I just need to wait for 4.11, I can certainly do that.

So, I was all happy and all with 4.11, and it still works fine.
S3 sleep just works, hibernate just works.
And then 4.12 came, and S3 sleep would not work reliably
4.13 came, same thing
4.14, again, same thing :(

Currently when I put the laptop to sleep, it sometimes, but just
sometimes, keeps the thinkpad light in a slow pulsing light as if it
were still in sleep mode, and just never wakes up.

Sadly, this is crappy to bisect since it's not reliably reproducible.

Before I go through that pain, are there any suggestions or ideas I
should try?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                         | PGP 1024R/763BE901
