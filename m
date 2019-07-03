From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 3 Jul 2019 10:33:31 -0700
Subject: [PATCH 0/2] Fix use-after-free bug when ports are removed
In-Reply-To: <20190703170136.21515-1-logang@deltatee.com>
References: <20190703170136.21515-1-logang@deltatee.com>
Message-ID: <e88bed6b-c487-e224-1434-ba9912495a33@grimberg.me>

> Hey,

Hey Logan,

> NVME target ports can be removed while there are still active
> controllers. Largely this is fine, except some admin commands
> can access the req->port (for example, id-ctrl uses the port's
> inline date size as part of it's response). This was found
> while testing with KASAN.
> 
> Two patches follow which disconnect active controllers when the
> ports are removed for loop and rdma. I'm not sure if fc has the
> same issue and have no way to test this.
> 
> Alternatively, we could add reference counting to the struct port,
> but I think this is a more involved change and could be done later
> after we fix the bug quickly.

I don't think that when removing a port the expectation is that
all associated controllers remain intact (although they can, which
was why we did not remove them), so I think its fine to change that
if it causes issues.

Can we handle this in the core instead (also so we'd be consistent
across transports)?

How about this untested patch instead?
--
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0587707b1a25..12b58e568810 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -277,6 +277,21 @@ void nvmet_unregister_transport(const struct 
nvmet_fabrics_ops *ops)
  }
  EXPORT_SYMBOL_GPL(nvmet_unregister_transport);

+void nvmet_port_del_ctrls(struct nvmet_port *port)
+{
+       struct nvmet_subsys_link *l;
+       struct nvmet_ctrl *ctrl;
+
+       list_for_each_entry(l, &port->subsystems, entry) {
+               mutex_lock(&l->subsys->lock);
+               list_for_each_entry(ctrl, &l->subsys->ctrls, subsys_entry) {
+                       if (ctrl->port == port)
+                               ctrl->ops->delete_ctrl(ctrl);
+               }
+               mutex_unlock(&l->subsys->lock);
+       }
+}
+
  int nvmet_enable_port(struct nvmet_port *port)
  {
         const struct nvmet_fabrics_ops *ops;
@@ -321,6 +336,8 @@ void nvmet_disable_port(struct nvmet_port *port)

         lockdep_assert_held(&nvmet_config_sem);

+       nvmet_port_del_ctrls(port);
+
         port->enabled = false;
         port->tr_ops = NULL;
--
