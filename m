From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Jun 2018 13:41:29 +0300
Subject: [PATCH 1/7] nvme-rdma: fix possible double free condition when
 failing to create a controller
In-Reply-To: <0af01f6d-75f3-3a8c-bcca-abd6a8da3920@mellanox.com>
References: <20180619123415.25077-1-sagi@grimberg.me>
 <20180619123415.25077-2-sagi@grimberg.me>
 <0af01f6d-75f3-3a8c-bcca-abd6a8da3920@mellanox.com>
Message-ID: <be2a572c-6e6e-8a1c-608e-457fbd8cb01b@grimberg.me>


>> @@ -2014,14 +2014,14 @@ static struct nvme_ctrl 
>> *nvme_rdma_create_ctrl(struct device *dev,
>> ? out_remove_admin_queue:
>> ????? nvme_rdma_destroy_admin_queue(ctrl, true);
>> -out_kfree_queues:
>> -??? kfree(ctrl->queues);
>> ? out_uninit_ctrl:
>> ????? nvme_uninit_ctrl(&ctrl->ctrl);
>> ????? nvme_put_ctrl(&ctrl->ctrl);
>> ????? if (ret > 0)
>> ????????? ret = -EIO;
>> ????? return ERR_PTR(ret);
> 
> can you explain this error flow ? we'll never free the queues since the 
> list &ctrl->list is empty. I guess a fix to nvme_rdma_free_ctrl is 
> needed in this case.

Good catch! I lost this in the rebase:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6e45b04ce0f5..4d6953142efd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -905,9 +905,9 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
         list_del(&ctrl->list);
         mutex_unlock(&nvme_rdma_ctrl_mutex);

-       kfree(ctrl->queues);
         nvmf_free_options(nctrl->opts);
  free_ctrl:
+       kfree(ctrl->queues);
         kfree(ctrl);
  }
--

> Also, when ret will be > 0 ?

I guess it can't really happen since nvme_rdma_conn_rejected was added.
I can send a nit for that
