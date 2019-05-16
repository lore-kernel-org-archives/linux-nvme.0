From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 14:39:50 -0600
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <CAJZ5v0gBQVjy70CbA6CzkkjsGQYGeO6fDjJimvadM5_oq=3qeA@mail.gmail.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-6-keith.busch@intel.com>
 <CAJZ5v0iC44O_gLMHnLui+tH+BuHKJzh_WC7PV3JFJwhj041=1A@mail.gmail.com>
 <20190516142657.GD23333@localhost.localdomain>
 <70235CA3-0FBB-4A06-996F-647A0D95C6D0@canonical.com>
 <64e8e0252a4042b99dd3d0def15b1780@AUSX13MPC105.AMER.DELL.COM>
 <20190516193822.GA23853@localhost.localdomain>
 <CAJZ5v0gBQVjy70CbA6CzkkjsGQYGeO6fDjJimvadM5_oq=3qeA@mail.gmail.com>
Message-ID: <20190516203950.GB23853@localhost.localdomain>

On Thu, May 16, 2019@10:25:47PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 16, 2019@9:43 PM Keith Busch <kbusch@kernel.org> wrote:
> > If we're going to replace our SIMPLE_DEV_PM_OPS as Rafael suggests,
> > might as well add a .suspend_noirq callback. We can just save the
> > state again to work around this too.
> 
> Relax, pretty please.  Saving the state again shouldn't be necessary.
> 
> Let's first understand what's going on.

Hah, okay fair enough.

FWIW, I've tried current mainline on two different platforms and I see
only the expected number of calls to pci_pm_suspend_noirq, so everything
works for me.
