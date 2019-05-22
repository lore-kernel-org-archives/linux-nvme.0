From: kbusch@kernel.org (Keith Busch)
Date: Wed, 22 May 2019 10:56:23 -0600
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <1558542950751.23268@Dell.com>
References: <CAJZ5v0hZSiQuuq2+P+uLd3uE=ruuTW+5DmAdjqcr39=7poUe-g@mail.gmail.com>
 <CAJZ5v0j0V10BYrME=KU1AJXGDMRUFFHiZEHQnsXhNJGPZKBSUw@mail.gmail.com>
 <20190517090521.GA15509@lst.de>
 <CAJZ5v0iL+ERE4Yy5yO8U2no194sRkvqNZHh5HsZXKvvHbxtk+g@mail.gmail.com>
 <20190517093516.GA17006@lst.de>
 <CAJZ5v0gLqL7GUjwz5F8=9Fc-W2n3FRzbbB2L8udaXgN4Vsd8-Q@mail.gmail.com>
 <D4CDCA72-A3B8-4717-9ED2-A14254C78963@canonical.com>
 <20190522155253.GA29827@lst.de>
 <20190522160221.GB5393@localhost.localdomain>
 <1558542950751.23268@Dell.com>
Message-ID: <20190522165623.GA5486@localhost.localdomain>

On Wed, May 22, 2019@04:35:50PM +0000, Mario.Limonciello@dell.com wrote:
> >I've a branch here that I'll send to the mailing list after some testing
> >this afternoon
> 
>  > https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/log/?h=nvme-power
> 
> Make sure you do your testing with Rafael's patch that keeps the device in D0 across the
> various suspend steps, I didn't see it obviously on your branch in the last 2 weeks of
> commits.

Sure, I'll test with that fix included in the kernel image, though its
upstream destiny will not be through the nvme tree.
