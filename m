From: ethan.weidman@kazan-networks.com (Ethan Weidman)
Date: Wed, 21 Nov 2018 00:41:03 +0000
Subject: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
In-Reply-To: <20181120030019.31738-16-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-16-sagi@grimberg.me>
Message-ID: <CY4PR08MB258265FB085A9C26B6F27D93CFDA0@CY4PR08MB2582.namprd08.prod.outlook.com>

>+static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>+               struct nvmf_ctrl_options *opts)
>+{
>+       struct nvme_tcp_ctrl *ctrl;
>+       int ret;
>+
>+       ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
>+       if (!ctrl)
>+               return ERR_PTR(-ENOMEM);
>+
>+       INIT_LIST_HEAD(&ctrl->list);
>+       ctrl->ctrl.opts = opts;
>+       ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
>+       ctrl->ctrl.sqsize = opts->queue_size - 1;
>+       ctrl->ctrl.kato = opts->kato;
>+
>+       INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
>+                       nvme_tcp_reconnect_ctrl_work);
>+       INIT_WORK(&ctrl->ctrl.err_work, nvme_tcp_error_recovery_work);
>+       INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
>+
>+       if (!(opts->mask & NVMF_OPT_TRSVCID)) {
>+               opts->trsvcid =
>+                       kstrdup(__stringify(NVME_TCP_DISC_PORT), GFP_KERNEL);
>+               if (!opts->trsvcid) {
>+                       ret = -ENOMEM;
>+                       goto out_free_ctrl;
>+               }
>+               opts->mask |= NVMF_OPT_TRSVCID;
>+       }

NVME_TCP_DISC_PORT, 8009, should not be the default for nvme fabric connections when trsvcid is not specified.

NVME_RDMA_IP_PORT, 4420, should be used, or renamed to something more generic.
