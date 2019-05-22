From: kbusch@kernel.org (Keith Busch)
Date: Wed, 22 May 2019 10:02:21 -0600
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <20190522155253.GA29827@lst.de>
References: <CAJZ5v0gBQVjy70CbA6CzkkjsGQYGeO6fDjJimvadM5_oq=3qeA@mail.gmail.com>
 <20190516203950.GB23853@localhost.localdomain>
 <CAJZ5v0hZSiQuuq2+P+uLd3uE=ruuTW+5DmAdjqcr39=7poUe-g@mail.gmail.com>
 <CAJZ5v0j0V10BYrME=KU1AJXGDMRUFFHiZEHQnsXhNJGPZKBSUw@mail.gmail.com>
 <20190517090521.GA15509@lst.de>
 <CAJZ5v0iL+ERE4Yy5yO8U2no194sRkvqNZHh5HsZXKvvHbxtk+g@mail.gmail.com>
 <20190517093516.GA17006@lst.de>
 <CAJZ5v0gLqL7GUjwz5F8=9Fc-W2n3FRzbbB2L8udaXgN4Vsd8-Q@mail.gmail.com>
 <D4CDCA72-A3B8-4717-9ED2-A14254C78963@canonical.com>
 <20190522155253.GA29827@lst.de>
Message-ID: <20190522160221.GB5393@localhost.localdomain>

On Wed, May 22, 2019@05:52:53PM +0200, Christoph Hellwig wrote:
> On Wed, May 22, 2019@02:47:57PM +0800, Kai Heng Feng wrote:
> > I've got confirmation from Vendor, disabling HMB isn?t necessary when the 
> > host stays at D0, which is what we use in S2I.
> > I?ve done some testing and I can confirm S2I suspend/resume can work 
> > without disabling HMB.
> 
> Great.  Who is going to cook up a new patch taking all the recent
> findings into account?

I've a branch here that I'll send to the mailing list after some testing
this afternoon

  https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/log/?h=nvme-power
