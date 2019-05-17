From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 17 May 2019 11:32:31 +0200
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <E72968DB-907D-41F9-BD51-5D7672659802@canonical.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-6-keith.busch@intel.com>
 <CAJZ5v0iC44O_gLMHnLui+tH+BuHKJzh_WC7PV3JFJwhj041=1A@mail.gmail.com>
 <20190516142657.GD23333@localhost.localdomain>
 <70235CA3-0FBB-4A06-996F-647A0D95C6D0@canonical.com>
 <64e8e0252a4042b99dd3d0def15b1780@AUSX13MPC105.AMER.DELL.COM>
 <20190516193822.GA23853@localhost.localdomain>
 <CAJZ5v0gBQVjy70CbA6CzkkjsGQYGeO6fDjJimvadM5_oq=3qeA@mail.gmail.com>
 <20190516203950.GB23853@localhost.localdomain>
 <CAJZ5v0hZSiQuuq2+P+uLd3uE=ruuTW+5DmAdjqcr39=7poUe-g@mail.gmail.com>
 <CAJZ5v0j0V10BYrME=KU1AJXGDMRUFFHiZEHQnsXhNJGPZKBSUw@mail.gmail.com>
 <E72968DB-907D-41F9-BD51-5D7672659802@canonical.com>
Message-ID: <CAJZ5v0gRKEiR2_1egcZwr9sAATG=nUh8igf-TasvWqe4syTu_A@mail.gmail.com>

On Fri, May 17, 2019 at 11:23 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>@16:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> > On Thu, May 16, 2019 at 10:56 PM Rafael J. Wysocki <rafael at kernel.org>
> > wrote:
> >> On Thu, May 16, 2019@10:45 PM Keith Busch <kbusch@kernel.org> wrote:
> >>> On Thu, May 16, 2019@10:25:47PM +0200, Rafael J. Wysocki wrote:
> >>>> On Thu, May 16, 2019@9:43 PM Keith Busch <kbusch@kernel.org> wrote:
> >>>>> If we're going to replace our SIMPLE_DEV_PM_OPS as Rafael suggests,
> >>>>> might as well add a .suspend_noirq callback. We can just save the
> >>>>> state again to work around this too.
> >>>>
> >>>> Relax, pretty please.  Saving the state again shouldn't be necessary.
> >>>>
> >>>> Let's first understand what's going on.
> >>>
> >>> Hah, okay fair enough.
> >>>
> >>> FWIW, I've tried current mainline on two different platforms and I see
> >>> only the expected number of calls to pci_pm_suspend_noirq, so everything
> >>> works for me.
> >>
> >> And I don't see why it might not work anywhere else other than a
> >> kernel source hacked into pieces or a platform with fundamental
> >> problems. :-)
> >
> > I forgot about one thing which is relevant here, sorry about that.
> >
> > If there is a spurious EC wakeup during s2idle, pci_pm_suspend_noirq()
> > *will* be run again after pci_pm_resume_noirq() without going through
> > the entire system resume and next suspend.  In that case the second
> > iteration of pci_pm_suspend_noirq() will put the device into D3, if
> > that's the target power state of the device as determined by
> > pci_prepare_to_sleep(), because pci_pm_resume_noirq() calls
> > pci_restore_state() which clears state_saved.
> >
> > That's not what appears to happen on the test platform as per the
> > posted log, but nevertheless it can happen.
>
> The patch Mario pointed solves the issue for the test platform I used.
>
> I?ve tested a dozen NVMes, all of them work properly with Keith?s patch
> series, once the LPIT fix is applied.
>
> >
> > Arguably, the driver should not need to worry about that, so that
> > needs to be addressed in the PCI core IMO.
> >
> > The attached patch should help (not inline to avoid gmail-induced
> > white space damage).
> >
> > I will post it properly with a changelog shortly.
> > <pci-pm-skip-noirq.patch>
>
> Since the patch Mario suggested solves the issue, do you still want me to
> test this patch?

I don't think it will matter in that case.
