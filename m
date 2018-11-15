From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 15 Nov 2018 11:30:15 -0600
Subject: [PATCH v2 1/2] pci: prevent sk hynix nvme from entering D3
In-Reply-To: <20181115145809.GA207836@google.com>
References: <20181106071214.12745-1-acelan.kao@canonical.com>
 <20181109002157.GK41183@google.com>
 <B21C5A96-AB21-4405-BBF1-9AD343425CA9@canonical.com>
 <20181115145809.GA207836@google.com>
Message-ID: <20181115173015.GB229449@google.com>

On Thu, Nov 15, 2018@08:58:09AM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 15, 2018@03:16:29PM +0800, Kai Heng Feng wrote:
> > On Nov 9, 2018,@08:21, Bjorn Helgaas <helgaas@kernel.org> wrote:

> > > I'm not sure we want a quirk for this at all, since as Christoph
> > > points out, it doesn't fix a functional issue as the other uses of
> > > quirk_no_ata_d3() do.
> > > 
> > > From your emails with Christoph, it sounds like this quirk is a
> > > workaround for a firmware defect.  If we *do* end up wanting a quirk,
> > > the changelog should at least mention the firmware defect and maybe
> > > check whether it has been fixed.
> > 
> > According to SK Hynix folks and new evidence on the new Intel NVMe
> > we have, this is something we are going to see more often.
> 
> Hmmm, are you suggesting that if we went this quirk route, we'd be
> updating the quirk frequently to add new devices?
> 
> I'm opposed to that as a strategy because it makes needless work.  You
> have to update the quirk, backport it to older kernels, re-release
> distro kernels, etc.

But I guess you have to do this anyway just to add the vendor/device
ID to the driver, so maybe this isn't a big deal to you.  If you can
do a quirk like this in the driver, it would be invisible to me and I
wouldn't care.  I just don't want to deal with ongoing tweaks like
this in the PCI core :)

Bjorn
