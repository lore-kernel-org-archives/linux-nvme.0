From: kbusch@kernel.org (Keith Busch)
Date: Thu, 23 May 2019 09:27:11 -0600
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <20190522230810.GA14049@localhost.localdomain>
References: <CAJZ5v0j0V10BYrME=KU1AJXGDMRUFFHiZEHQnsXhNJGPZKBSUw@mail.gmail.com>
 <20190517090521.GA15509@lst.de>
 <CAJZ5v0iL+ERE4Yy5yO8U2no194sRkvqNZHh5HsZXKvvHbxtk+g@mail.gmail.com>
 <20190517093516.GA17006@lst.de>
 <CAJZ5v0gLqL7GUjwz5F8=9Fc-W2n3FRzbbB2L8udaXgN4Vsd8-Q@mail.gmail.com>
 <D4CDCA72-A3B8-4717-9ED2-A14254C78963@canonical.com>
 <20190522155253.GA29827@lst.de>
 <20190522160221.GB5393@localhost.localdomain>
 <1558542950751.23268@Dell.com>
 <20190522230810.GA14049@localhost.localdomain>
Message-ID: <20190523152710.GB14943@localhost.localdomain>

On Wed, May 22, 2019@04:08:10PM -0700, Keith Busch wrote:
> On Wed, May 22, 2019@04:35:50PM +0000, Mario.Limonciello@dell.com wrote:
> > >I've a branch here that I'll send to the mailing list after some testing
> > >this afternoon
> > 
> >  > https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/log/?h=nvme-power
> > 
> > Make sure you do your testing with Rafael's patch that keeps the device in D0 across the
> > various suspend steps, I didn't see it obviously on your branch in the last 2 weeks of
> > commits.
> 
> Well, I may have picked an unlucky rebase point. I can't run the tests,
> but it doesn't look like it has anything to do with the nvme changes. I'll
> go back to my original stable point and try again tomorrow.

Kernel repo was fine, I just had the wrong kconfig that was intended for my
minimal vm's.

Tests are successful now (though still only faking deeper NPSS), posting
new series shortly.
