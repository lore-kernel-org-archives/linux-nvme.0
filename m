From: keith.busch@intel.com (Keith Busch)
Date: Wed, 11 Apr 2018 11:58:24 -0600
Subject: 'modprobe nvme_core multipath=N' crashes in face of multipath
 fabric
In-Reply-To: <20180411141720.GB22124@redhat.com>
References: <20180410204953.GA17979@redhat.com>
 <20180411134530.GC9238@localhost.localdomain>
 <20180411141720.GB22124@redhat.com>
Message-ID: <20180411175824.GE9238@localhost.localdomain>

On Wed, Apr 11, 2018@10:17:21AM -0400, Mike Snitzer wrote:
> On Wed, Apr 11 2018 at  9:45am -0400,
> Keith Busch <keith.busch@intel.com> wrote:
> 
> > On Tue, Apr 10, 2018@04:49:53PM -0400, Mike Snitzer wrote:
> > > This isn't new since the 4.17 merge or anything, I first noticed this
> > > issue existed while using a 4.16-rc4 kernel.
> > > 
> > > modprobe nvme_core multipath=N
> > 
> > Thanks for the notice.
> > 
> > There is definitely a bug here when CONFIG_NVME_MULTIPATH=y but nvme_core
> > multipath is disabled in the presence of shared namespaces. I think we'd
> > need each namespace to get a different "head" out of the subsystem in
> > this case, but it may take a moment for me to detangle this.
> 
> No problem, it certainly isn't something I could tackle any quicker ;)
> 
> Thanks for looking to resolve this though.

It doesn't look like we'll be able to allocate new namespace 'heads'
here without complicating this even more.

The below should fix the naming collision by getting new instances for
each namespace that attaches to a head. I'm not sure this is much better,
but maybe Christoph will have a better suggestion.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 38b450ec00eb..683ccaa70cdc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -350,6 +350,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	list_del_init(&head->entry);
 	cleanup_srcu_struct(&head->srcu);
+	ida_destroy(&head->ns_ida);
 	kfree(head);
 }
 
@@ -366,6 +367,7 @@ static void nvme_free_ns(struct kref *kref)
 		nvme_nvm_unregister(ns);
 
 	put_disk(ns->disk);
+	ida_simple_remove(&ns->head->ns_ida, ns->instance);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
 	kfree(ns);
@@ -2836,6 +2838,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->subsys = ctrl->subsys;
 	head->ns_id = nsid;
 	kref_init(&head->ref);
+	ida_init(&head->ns_ida);
 
 	nvme_report_ns_ids(ctrl, nsid, id, &head->ids);
 
@@ -2856,6 +2859,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	cleanup_srcu_struct(&head->srcu);
 out_ida_remove:
 	ida_simple_remove(&ctrl->subsys->ns_ida, head->instance);
+	ida_destroy(&head->ns_ida);
 out_free_head:
 	kfree(head);
 out:
@@ -2895,6 +2899,12 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 	list_add_tail(&ns->siblings, &head->list);
 	ns->head = head;
 
+	ret = ida_simple_get(&head->ns_ida, 1, 0, GFP_KERNEL);
+	if (ret >= 0) {
+		ns->instance = ret;
+		ret = 0;
+	}
+
 out_unlock:
 	mutex_unlock(&ctrl->subsys->lock);
 	return ret;
@@ -3003,7 +3013,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		flags = GENHD_FL_HIDDEN;
 	} else {
 		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance,
-				ns->head->instance);
+				ns->instance);
 	}
 #else
 	/*
@@ -3059,6 +3069,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
 	mutex_unlock(&ctrl->subsys->lock);
+	ida_simple_remove(&ns->head->ns_ida, ns->instance);
  out_free_id:
 	kfree(id);
  out_free_queue:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ced5b3d3269d..3f95b2f7ecf3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -252,6 +252,7 @@ struct nvme_ns_head {
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
 #endif
+	struct ida		ns_ida;
 	struct list_head	list;
 	struct srcu_struct      srcu;
 	struct nvme_subsystem	*subsys;
@@ -282,6 +283,7 @@ struct nvme_ns {
 	struct kref kref;
 	struct nvme_ns_head *head;
 
+	int instance;
 	int lba_shift;
 	u16 ms;
 	u16 sgs;
--
