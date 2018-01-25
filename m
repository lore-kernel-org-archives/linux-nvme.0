From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 25 Jan 2018 13:31:26 +0200
Subject: [PATCH v1 0/4] Fix host side state machine
In-Reply-To: <f20a4413-dbb7-c092-f69c-b9edfa3df424@grimberg.me>
References: <1516813067-1717-1-git-send-email-maxg@mellanox.com>
 <f20a4413-dbb7-c092-f69c-b9edfa3df424@grimberg.me>
Message-ID: <8151106d-aafe-a5e3-13a0-cc6e7ee13087@mellanox.com>



On 1/24/2018 9:33 PM, Sagi Grimberg wrote:
> The series looks reasonable to me, but we'll need James to
> see if it works out for fc and keith to ack on Jianchao's patch first.

James,
what do you think of the following untested changes to fc host:



diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 01df6d5..2922c20 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2704,7 +2704,7 @@ static inline blk_status_t nvme_fc_is_ready(struct 
nvme_fc_queue *queue,
   * on the link side, recreates the controller association.
   */
  static int
-nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
+nvme_fc_create_association(struct nvme_fc_ctrl *ctrl, bool new)
  {
         struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
         int ret;
@@ -2735,7 +2735,7 @@ static inline blk_status_t nvme_fc_is_ready(struct 
nvme_fc_queue *queue,
         if (ret)
                 goto out_delete_hw_queue;

-       if (ctrl->ctrl.state != NVME_CTRL_NEW)
+       if (!new)
                 blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);

         ret = nvmf_connect_admin_queue(&ctrl->ctrl);
@@ -2801,7 +2801,7 @@ static inline blk_status_t nvme_fc_is_ready(struct 
nvme_fc_queue *queue,
          */

         if (ctrl->ctrl.queue_count > 1) {
-               if (ctrl->ctrl.state == NVME_CTRL_NEW)
+               if (new)
                         ret = nvme_fc_create_io_queues(ctrl);
                 else
                         ret = nvme_fc_reinit_io_queues(ctrl);
@@ -3001,7 +3001,7 @@ static inline blk_status_t nvme_fc_is_ready(struct 
nvme_fc_queue *queue,
         }

         if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE)
-               ret = nvme_fc_create_association(ctrl);
+               ret = nvme_fc_create_association(ctrl, false);
         else
                 ret = -ENOTCONN;

@@ -3036,7 +3036,7 @@ static inline blk_status_t nvme_fc_is_ready(struct 
nvme_fc_queue *queue,
                         container_of(to_delayed_work(work),
                                 struct nvme_fc_ctrl, connect_work);

-       ret = nvme_fc_create_association(ctrl);
+       ret = nvme_fc_create_association(ctrl, false);
         if (ret)
                 nvme_fc_reconnect_or_delete(ctrl, ret);
         else
@@ -3090,6 +3090,7 @@ static inline blk_status_t nvme_fc_is_ready(struct 
nvme_fc_queue *queue,
         struct nvme_fc_ctrl *ctrl;
         unsigned long flags;
         int ret, idx, retry;
+       bool changed;

         if (!(rport->remoteport.port_role &
             (FC_PORT_ROLE_NVME_DISCOVERY | FC_PORT_ROLE_NVME_TARGET))) {
@@ -3206,8 +3207,11 @@ static inline blk_status_t 
nvme_fc_is_ready(struct nvme_fc_queue *queue,
          * request fails, retry the initial connection creation up to
          * three times before giving up and declaring failure.
          */
+       changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
+       WARN_ON_ONCE(!changed);
+
         for (retry = 0; retry < 3; retry++) {
-               ret = nvme_fc_create_association(ctrl);
+               ret = nvme_fc_create_association(ctrl, true);
                 if (!ret)
                         break;
         }


-Max.
