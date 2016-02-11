From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 15:11:47 +0000
Subject: [PATCH for-4.5 10/13] NVMe: Move error handling to failed
 reset handler
In-Reply-To: <56BC83AE.8080702@dev.mellanox.co.il>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-11-git-send-email-keith.busch@intel.com>
 <56BC83AE.8080702@dev.mellanox.co.il>
Message-ID: <20160211151147.GC11908@localhost.localdomain>

On Thu, Feb 11, 2016@02:50:54PM +0200, Sagi Grimberg wrote:
> On 10/02/2016 20:17, Keith Busch wrote:
> >This moves the dead queue handling out of the namespace removal path
> >and into the reset failure path. It fixes a deadlock condition if the
> >controller fails or link down during del_gendisk.
> 
> How does it fix the deadlock?

Previously the queues were setup for failure prior to calling del_gendisk
only if the controller was broken. If the controller happened to be
optimal, this process would have been skipped. If the controller then
failed, the queues wouldn't be killed.
 
> >+	nvme_dev_disable(dev, false);
> >+
> >+	mutex_lock(&ctrl->namespaces_mutex);
> >+	list_for_each_entry(ns, &ctrl->namespaces, list) {
> >+		if (!kref_get_unless_zero(&ns->kref))
> >+			continue;
> >+
> >+		blk_set_queue_dying(ns->queue);
> >+		blk_mq_abort_requeue_list(ns->queue);
> >+		blk_mq_start_stopped_hw_queues(ns->queue, true);
> >+
> >+		nvme_put_ns(ns);
> >+	}
> >+	mutex_unlock(&ctrl->namespaces_mutex);
> >+}
> >+
> 
> Why on earth is this pci specific? This should be in the
> core. Aside from that, I'd really prefer if the core can handle this
> without having the pci (or other) triggering it explicitly, but if
> this must move out of the ns remove then we need documentation on
> what are the rules of when the driver needs to call it.

It's PCI specific only because of the potential need to disable the
controller first (nvme_dev_disable), which is currently PCI specific.
