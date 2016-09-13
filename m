From: narayan.ayalasomayajula@kazan-networks.com (Narayan Ayalasomayajula)
Date: Tue, 13 Sep 2016 20:04:23 +0000
Subject: Failure with 8K Write operations
In-Reply-To: <a8e92a9f-f3e6-6bc3-b49b-368f3302517d@grimberg.me>
References: <BY2PR08MB181580B3E2779DAF024CAD7DC0FF0@BY2PR08MB1815.namprd08.prod.outlook.com>
 <a8e92a9f-f3e6-6bc3-b49b-368f3302517d@grimberg.me>
Message-ID: <BY2PR08MB1815C4CAC2FC683A05DFD443C0FE0@BY2PR08MB1815.namprd08.prod.outlook.com>

Hi Sagi,

Thanks for the print statement to verify that the sgls in the command capsule match what the Host programmed. I added this print statement and compared the Virtual Address and R_Key information in the /var/log to the NVMe Commands in the trace file and found the two to match. I have the trace and Host log files from this failure (trace is ~6M) - will it be useful for someone who may be looking into this issue? 

Regarding the host side log information you mentioned, I had attached that in my prior email (attached again). Is this what you are requesting? That was collected prior to adding the print statement that you suggested.

Just to summarize, the failure is seen in the following configuration:

1. Host is an 8-core Ubuntu server running the 4.8.0 kernel. It has a ConnectX-4 RNIC (1x100G) and is connected to a Mellanox Switch.
2. Target is an 8-core Ubuntu server running the 4.8.0 kernel. It has a ConnectX-3 RNIC (1x10G) and is connected to a Mellanox Switch.
3. Switch has normal Pause and Jumbo frame support enabled on all ports.
4. Test fails with Host sending a NAK (Remote Access Error) for the following FIO workload:

	[global]
	ioengine=libaio
	direct=1
	runtime=10m
	size=800g
	time_based
	norandommap
	group_reporting
	bs=8k
	numjobs=8
	iodepth=16

	[rand_write]
	filename=/dev/nvme0n1
	rw=randwrite 

I have found that the failure happens with numjobs set to 1 as well.

Thanks again for your response,
Narayan

-----Original Message-----
From: Sagi Grimberg [mailto:sagi@grimberg.me] 
Sent: Tuesday, September 13, 2016 2:16 AM
To: Narayan Ayalasomayajula <narayan.ayalasomayajula at kazan-networks.com>; linux-nvme at lists.infradead.org
Subject: Re: Failure with 8K Write operations


> Hello All,

Hi Narayan,

> I am running into a failure with the 4.8.0 branch and wanted to see this is a known issue or whether there is something I am not doing right in my setup/configuration. The issue that I am running into is that the Host is indicating a NAK (Remote Access Error) condition when executing an FIO script that is performing 100% 8K Write operations. Trace analysis shows that the target has the expected Virtual Address and R_KEY values in the READ REQUEST but for some reason, the Host flags the request as an access violation. I ran a similar test with iWARP Host and Target systems and the did see a Terminate followed by FIN from the Host. The cause for both failures appears to be the same.
>

I cannot reproduce what you are seeing on my setup (Steve, can you?) I'm running 2 VMs connected over SRIOV on the same PC though...

Can you share the log on the host side?

Can you also add this print to verify that the host driver programmed the same sgl as it sent the target:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c index c2c2c28e6eb5..248fa2e5cabf 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -955,6 +955,9 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
         sg->type = (NVME_KEY_SGL_FMT_DATA_DESC << 4) |
                         NVME_SGL_FMT_INVALIDATE;

+       pr_err("%s: rkey=%#x iova=%#llx length=%#x\n",
+               __func__, req->mr->rkey, req->mr->iova, 
+ req->mr->length);
+
         return 0;
  }
--
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Linux_Host_dmesg_log_for_NAK_issue.docx
Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document
Size: 17285 bytes
Desc: Linux_Host_dmesg_log_for_NAK_issue.docx
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160913/90d1fa17/attachment-0001.docx>
