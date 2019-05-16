From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 16 May 2019 22:25:47 +0200
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <20190516193822.GA23853@localhost.localdomain>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-6-keith.busch@intel.com>
 <CAJZ5v0iC44O_gLMHnLui+tH+BuHKJzh_WC7PV3JFJwhj041=1A@mail.gmail.com>
 <20190516142657.GD23333@localhost.localdomain>
 <70235CA3-0FBB-4A06-996F-647A0D95C6D0@canonical.com>
 <64e8e0252a4042b99dd3d0def15b1780@AUSX13MPC105.AMER.DELL.COM>
 <20190516193822.GA23853@localhost.localdomain>
Message-ID: <CAJZ5v0gBQVjy70CbA6CzkkjsGQYGeO6fDjJimvadM5_oq=3qeA@mail.gmail.com>

On Thu, May 16, 2019@9:43 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, May 16, 2019@06:33:56PM +0000, Mario.Limonciello@dell.com wrote:
> > > >> Then, you can populate nvme_dev_pm_ops as follows:
> > > >>
> > > >> static const struct dev_pm_ops = {
> > > >>     .suspend = nvme_suspend,
> > > >>     .resume = nvme_resume,
> > > >>     .freeze = nvme_simple_suspend,
> > > >>     .thaw = nvme_simple_resume,
> > > >>     .poweroff = nvme_simple_suspend,
> > > >>     .restore = nvme_simple_resume,
> > > >> };
> > > >>
> > > >> and it should all work.
> > > >
> > > > Thanks for the pointers, I'll give that idea a shot.
> > >
> > > Thanks for your work, I?ve tested your patch series on top of nvme-5.2 branch. It
> > > works well once I apply flag PCI_DEV_FLAGS_NO_D3.
> > > After some digging I think it?s another bug though:
>
> ....
>
> > > pci_pm_suspend_noirq() gets called twice:
> > > [   70.358779] nvme 0000:03:00.0: PCI PM: Suspend power state: D0
> > > [   70.496908] nvme 0000:03:00.0: PCI PM: Suspend power state: D3hot
> > > So it?s still being put to D3.
> > >
> > > I?ll check why this bug happens.
> > >
> > > Kai-Heng
> >
> > Can you please try this patch:
> > https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1612437
> >
> > It hasn't been submitted upstream yet, but should soon and I think it will fix this behavior.

I wonder how.

>
> If we're going to replace our SIMPLE_DEV_PM_OPS as Rafael suggests,
> might as well add a .suspend_noirq callback. We can just save the
> state again to work around this too.

Relax, pretty please.  Saving the state again shouldn't be necessary.

Let's first understand what's going on.
