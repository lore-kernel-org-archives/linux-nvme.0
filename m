From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 13 Sep 2016 12:16:24 +0300
Subject: Failure with 8K Write operations
In-Reply-To: <BY2PR08MB181580B3E2779DAF024CAD7DC0FF0@BY2PR08MB1815.namprd08.prod.outlook.com>
References: <BY2PR08MB181580B3E2779DAF024CAD7DC0FF0@BY2PR08MB1815.namprd08.prod.outlook.com>
Message-ID: <a8e92a9f-f3e6-6bc3-b49b-368f3302517d@grimberg.me>


> Hello All,

Hi Narayan,

> I am running into a failure with the 4.8.0 branch and wanted to see this is a known issue or whether there is something I am not doing right in my setup/configuration. The issue that I am running into is that the Host is indicating a NAK (Remote Access Error) condition when executing an FIO script that is performing 100% 8K Write operations. Trace analysis shows that the target has the expected Virtual Address and R_KEY values in the READ REQUEST but for some reason, the Host flags the request as an access violation. I ran a similar test with iWARP Host and Target systems and the did see a Terminate followed by FIN from the Host. The cause for both failures appears to be the same.
>

I cannot reproduce what you are seeing on my setup (Steve, can you?)
I'm running 2 VMs connected over SRIOV on the same PC though...

Can you share the log on the host side?

Can you also add this print to verify that the
host driver programmed the same sgl as it sent
the target:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c2c2c28e6eb5..248fa2e5cabf 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -955,6 +955,9 @@ static int nvme_rdma_map_sg_fr(struct 
nvme_rdma_queue *queue,
         sg->type = (NVME_KEY_SGL_FMT_DATA_DESC << 4) |
                         NVME_SGL_FMT_INVALIDATE;

+       pr_err("%s: rkey=%#x iova=%#llx length=%#x\n",
+               __func__, req->mr->rkey, req->mr->iova, req->mr->length);
+
         return 0;
  }
--
