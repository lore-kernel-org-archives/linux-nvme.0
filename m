From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 29 Jan 2014 14:48:01 -0700
Subject: [PATCH v2 0/9] Phase out pci_enable_msi_block()
In-Reply-To: <20140118145940.GE3640@htj.dyndns.org>
References: <cover.1389904166.git.agordeev@redhat.com>
 <CAErSpo5ztnyyceeN38XzLasLV6eJqdbqEV0viPp3Af8U=ts23w@mail.gmail.com>
 <20140118071538.GA32535@dhcp-26-207.brq.redhat.com>
 <CAErSpo4nBdnn3YYaLj6QZ8iyY2pzV8Y7msd5UxJXm1T2AYnqfg@mail.gmail.com>
 <20140118145940.GE3640@htj.dyndns.org>
Message-ID: <20140129214801.GE16825@google.com>

On Sat, Jan 18, 2014@09:59:40AM -0500, Tejun Heo wrote:
> On Sat, Jan 18, 2014@07:38:55AM -0700, Bjorn Helgaas wrote:
> > On Sat, Jan 18, 2014@12:15 AM, Alexander Gordeev <agordeev@redhat.com> wrote:
> > > On Fri, Jan 17, 2014@02:00:32PM -0700, Bjorn Helgaas wrote:
> > >> > As the release is supposedly this weekend, do you prefer
> > >> > the patches to go to your tree or to individual trees after
> > >> > the release?
> > >>
> > >> I'd be happy to merge them, except for the fact that they probably
> > >> wouldn't have any time in -next before I ask Linus to pull them.  So
> > >> how about if we wait until after the release, ask the area maintainers
> > >> to take them, and if they don't take them, I'll put them in my tree
> > >> for v3.15?
> > >
> > > Patch 11 depends on patches 1-10, so I am not sure how to better handle it.
> > > Whatever works for you ;)
> > >
> > > I am only concerned with a regression fix "ahci: Fix broken fallback to
> > > single MSI mode" which would be nice to have in 3.14. But it seems pretty
> > > much too late.
> > 
> > Tejun, if you want to ack that one, I can put it in either the first
> > 3.14 pull request or a subsequent one.  Either way, since it's a
> > regression fix, we should be able to get it in 3.14.
> 
> Acked-by: Tejun Heo <tj at kernel.org>
> 
> Please feel free to route it any way you see fit.

I applied the following to my pci/msi branch, since they had acks from
maintainers (Tejun, I assumed your ack applies to both ahci patches):

    ahci: Fix broken fallback to single MSI mode
    ahci: Use pci_enable_msi_range()
    vfio: Use pci_enable_msi_range() and pci_enable_msix_range()
    wil6210: Use pci_enable_msi_range()

I didn't do anything with these:

    ipr: Get rid of superfluous call to pci_disable_msi/msix()
    ipr: Use pci_enable_msi_range() and pci_enable_msix_range()

	The conflict with "ipr: Handle early EEH" needs to get resolved
	first.  Either Alexander's patches need to go via the same tree as
	the EEH change, or the EEH change needs to be in some published
	tree so I can cherry-pick it.

    nvme: Fix invalid call to irq_set_affinity_hint()
    nvme: Use pci_enable_msi_range() and pci_enable_msix_range()

	These don't seem fully baked yet.  If/when Keith acks them, I (or
	he) can merge them.

    ath10k: Use pci_enable_msi_range()

	This has been acked, but no longer applies to mainline (I'm
	currently at 0e47c969c65e).

Bjorn
