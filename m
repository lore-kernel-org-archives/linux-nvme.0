From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 17 May 2019 11:17:52 +0200
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <20190517090521.GA15509@lst.de>
References: <20190515163625.21776-6-keith.busch@intel.com>
 <CAJZ5v0iC44O_gLMHnLui+tH+BuHKJzh_WC7PV3JFJwhj041=1A@mail.gmail.com>
 <20190516142657.GD23333@localhost.localdomain>
 <70235CA3-0FBB-4A06-996F-647A0D95C6D0@canonical.com>
 <64e8e0252a4042b99dd3d0def15b1780@AUSX13MPC105.AMER.DELL.COM>
 <20190516193822.GA23853@localhost.localdomain>
 <CAJZ5v0gBQVjy70CbA6CzkkjsGQYGeO6fDjJimvadM5_oq=3qeA@mail.gmail.com>
 <20190516203950.GB23853@localhost.localdomain>
 <CAJZ5v0hZSiQuuq2+P+uLd3uE=ruuTW+5DmAdjqcr39=7poUe-g@mail.gmail.com>
 <CAJZ5v0j0V10BYrME=KU1AJXGDMRUFFHiZEHQnsXhNJGPZKBSUw@mail.gmail.com>
 <20190517090521.GA15509@lst.de>
Message-ID: <CAJZ5v0iL+ERE4Yy5yO8U2no194sRkvqNZHh5HsZXKvvHbxtk+g@mail.gmail.com>

On Fri, May 17, 2019@11:05 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, May 17, 2019@10:39:19AM +0200, Rafael J. Wysocki wrote:
> > I forgot about one thing which is relevant here, sorry about that.
>
> While we got your attention, let me repeat two questions / requests
> that seem to have got lost:
>
>  (1) in what system power states are the devices not allowed to
>      every use DMA to access host memory?  Disabling the host memory
>      buffer for NVMe devices can be somewhat expensive, so we'd prefer
>      to only do that if we really have to

AFAICS, using DMA while creating a hibernation snapshot image of
memory would not be a good idea, so the host memory buffer should be
disabled during the "freeze" stage or hibernation (and it can be
re-enabled when that stage is complete).

Other than this I don't see hard reasons for disabling DMA transfers
unless that it a prerequisite for putting the device into D3.

>  (2) can we get some good kerneldoc comments for
>      pm_suspend_via_firmware and pm_suspend_via_s2idle explaining
>      when exactly they will return true, and how a driver can make
>      use of these facts?

I suppose so. :-)

That's in my list of things to do in fact.

>  Right now these appear a little too much black magic to be useful

Fair enough.
