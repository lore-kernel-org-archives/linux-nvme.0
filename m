From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 2 Aug 2019 13:45:14 -0700
Subject: [PATCH 1/2] nvme: skip namespaces which are about to be removed
In-Reply-To: <20190801221031.GH15795@localhost.localdomain>
References: <20190801071644.66690-1-hare@suse.de>
 <20190801071644.66690-2-hare@suse.de>
 <20190801213600.GG15795@localhost.localdomain>
 <8c71f313-4543-f581-af96-84070b8dbe5e@grimberg.me>
 <20190801221031.GH15795@localhost.localdomain>
Message-ID: <34169b0d-af9d-7493-8cfe-dbbadeeeb69d@grimberg.me>

>> This is exactly what I proposed in:
>> [PATCH rfc 2/2] nvme: fix possible use-after-free condition when controller
>> reset is racing namespace scanning
> 
> Hm, I had to look up why the list_del is done at then end. It is after
> del_gendisk() because that syncs dirty buffers, which means we could have
> IO that can timeout. We need the namespaces in the controller list during
> removal so that timeout handlers can iterate them for cleanup. Otherwise
> you could have some buffered write tasks constantly entering the queue,
> preventing namespace removal. The only time should be safe to take the
> namespace off list first is if we've set the queue to dying prior to
> calling del_gendisk.

Would this work?
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6956041224ec..c13cbdc262ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3418,19 +3418,21 @@ static void nvme_ns_remove(struct nvme_ns *ns)
         synchronize_rcu(); /* guarantee not available in head->list */
         nvme_mpath_clear_current_path(ns);
         synchronize_srcu(&ns->head->srcu); /* wait for concurrent 
submissions */
+       nvme_mpath_check_last_path(ns);

-       if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
+       if (ns->disk && ns->disk->flags & GENHD_FL_UP)
                 del_gendisk(ns->disk);
-               blk_cleanup_queue(ns->queue);
-               if (blk_get_integrity(ns->disk))
-                       blk_integrity_unregister(ns->disk);
-       }

         down_write(&ns->ctrl->namespaces_rwsem);
         list_del_init(&ns->list);
         up_write(&ns->ctrl->namespaces_rwsem);

-       nvme_mpath_check_last_path(ns);
+       if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
+               blk_cleanup_queue(ns->queue);
+               if (blk_get_integrity(ns->disk))
+                       blk_integrity_unregister(ns->disk);
+       }
+
         nvme_put_ns(ns);
  }

--
