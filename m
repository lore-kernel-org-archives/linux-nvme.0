From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 Jan 2016 22:08:05 +0000
Subject: [GIT PULL] NVMe changes for 4.5-rc1
In-Reply-To: <56A258F1.1060207@fb.com>
References: <20160121212738.GA15727@kernel.dk>
 <CA+55aFzaxsVDXC0SCQpBym9PR6cyKkACS5N9AsxhEWC+GaX1YQ@mail.gmail.com>
 <56A251C2.101@fb.com>
 <CA+55aFwy5YJdV5Xk_Mj1niWUQeUbXUS6igNZBw710cibQfY48A@mail.gmail.com>
 <56A258F1.1060207@fb.com>
Message-ID: <20160122220805.GA30907@localhost.localdomain>

On Fri, Jan 22, 2016@09:29:37AM -0700, Jens Axboe wrote:
> On 01/22/2016 09:26 AM, Linus Torvalds wrote:
> >
> >On Jan 22, 2016 7:59 AM, "Jens Axboe" <axboe at fb.com
> ><mailto:axboe@fb.com>> wrote:
> > >>
> > >>   - nvme_dev_remove() got renamed to nvme_remove_namespaces(), but also
> > >> lost the "dev" argument (it takes "struct nvme_ctrl *ctrl" now).
> > >
> > > &dev->ctrl
> >
> >That's not the problem - the code does that already.
> >
> >But we want the dev argument *back*, since the function now wants to do
> >that nvme_io_incapable() check and then cancel the IO on it.
> >
> >And I didn't know if you guys would want to use container_of() or just
> >change the calling convention back to using "dev", or perhaps just
> >decide to do the IO cleanup in the caller instead. That last option
> >seems the cleanest, since now nvme_dev_remove_namespaces() is just about
> >the namespace, and maybe it would be better to re-introduce a whole new
> >nvme_dev_remove() that does the old thing.
> 
> The latter is the cleanest approach, we'll get it fixed up.

Looks like IO ending is the only conflict. The cleanup below will
get the functionality back.

You might notice nvme_dev_disable is called twice for a surprise removal,
case, but that's okay.
---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72ef832..5d31cfc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2118,6 +2118,15 @@ static void nvme_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
+
+	/*
+	 * If the controller can't do IO (surprise removal, for example), we
+	 * need to disable prior to deleting namespaces. This ends outstanding
+	 * requests and prevents attempts to sync dirty data.
+	 */
+	if (nvme_io_incapable(&dev->ctrl))
+		nvme_dev_disable(dev, true);
+
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, true);
--
