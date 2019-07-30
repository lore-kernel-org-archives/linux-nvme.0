From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 30 Jul 2019 12:45:31 +0200
Subject: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
In-Reply-To: <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
References: <2332799.izEFUvJP67@kreacher>
 <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
Message-ID: <47415939.KV5G6iaeJG@kreacher>

On Thursday, July 25, 2019 7:03:49 PM CEST Rafael J. Wysocki wrote:
> On Thu, Jul 25, 2019@6:24 PM <Mario.Limonciello@dell.com> wrote:
> >
> > +Rajat
> >
> > > -----Original Message-----
> > > From: Kai-Heng Feng <kai.heng.feng at canonical.com>
> > > Sent: Thursday, July 25, 2019 9:03 AM
> > > To: Rafael J. Wysocki
> > > Cc: Keith Busch; Christoph Hellwig; Sagi Grimberg; linux-
> > > nvme at lists.infradead.org; Limonciello, Mario; Linux PM; LKML
> > > Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
> > > suspend" has problems
> > >
> > >
> > > [EXTERNAL EMAIL]
> > >
> > > Hi Rafael,
> > >
> > >@17:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > > Hi Keith,
> > > >
> > > > Unfortunately,
> > > >
> > > > commit d916b1be94b6dc8d293abed2451f3062f6af7551
> > > > Author: Keith Busch <keith.busch at intel.com>
> > > > Date:   Thu May 23 09:27:35 2019 -0600
> > > >
> > > >     nvme-pci: use host managed power state for suspend
> > > >
> > > > doesn't universally improve things.  In fact, in some cases it makes
> > > > things worse.
> > > >
> > > > For example, on the Dell XPS13 9380 I have here it prevents the processor
> > > > package
> > > > from reaching idle states deeper than PC2 in suspend-to-idle (which, of
> > > > course, also
> > > > prevents the SoC from reaching any kind of S0ix).
> > > >
> > > > That can be readily explained too.  Namely, with the commit above the
> > > > NVMe device
> > > > stays in D0 over suspend/resume, so the root port it is connected to also
> > > > has to stay in
> > > > D0 and that "blocks" package C-states deeper than PC2.
> > > >
> > > > In order for the root port to be able to go to D3, the device connected
> > > > to it also needs
> > > > to go into D3, so it looks like (at least on this particular machine, but
> > > > maybe in
> > > > general), both D3 and the NVMe-specific PM are needed.
> >
> > Well this is really unfortunate to hear.  I recall that with some disks we were
> > seeing problems where NVME specific PM wasn't working when the disk was in D3.
> >
> > On your specific disk, it would be good to know if just removing the pci_save_state(pdev)
> > call helps.
> 
> Yes, it does help.
> 
> > If so, :
> > * that might be a better option to add as a parameter.
> > * maybe we should double check all the disks one more time with that tweak.
> 
> At this point it seems so.

So I can reproduce this problem with plain 5.3-rc1 and the patch below fixes it.

Also Mario reports that the same patch needs to be applied for his 9380 to reach
SLP_S0 after some additional changes under testing/review now, so here it goes.

[The changes mentioned above are in the pm-s2idle-testing branch in the
 linux-pm.git tree at kernel.org.]

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] nvme-pci: Do not prevent PCI bus-level PM from being used

One of the modifications made by commit d916b1be94b6 ("nvme-pci: use
host managed power state for suspend") was adding a pci_save_state()
call to nvme_suspend() in order to prevent the PCI bus-level PM from
being applied to the suspended NVMe devices, but that causes the NVMe
drive (PC401 NVMe SK hynix 256GB) in my Dell XPS13 9380 to prevent
the SoC from reaching package idle states deeper than PC3, which is
way insufficient for system suspend.

Fix this issue by removing the pci_save_state() call in question.

Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki at intel.com>
---
 drivers/nvme/host/pci.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

Index: linux-pm/drivers/nvme/host/pci.c
===================================================================
--- linux-pm.orig/drivers/nvme/host/pci.c
+++ linux-pm/drivers/nvme/host/pci.c
@@ -2897,14 +2897,8 @@ static int nvme_suspend(struct device *d
 		nvme_dev_disable(ndev, true);
 		ctrl->npss = 0;
 		ret = 0;
-		goto unfreeze;
 	}
-	/*
-	 * A saved state prevents pci pm from generically controlling the
-	 * device's power. If we're using protocol specific settings, we don't
-	 * want pci interfering.
-	 */
-	pci_save_state(pdev);
+
 unfreeze:
 	nvme_unfreeze(ctrl);
 	return ret;
