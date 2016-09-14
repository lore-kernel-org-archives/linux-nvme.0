From: narayan.ayalasomayajula@kazan-networks.com (Narayan Ayalasomayajula)
Date: Wed, 14 Sep 2016 00:03:55 +0000
Subject: Failure with 8K Write operations
In-Reply-To: <1473810683.2781.72.camel@linux.intel.com>
References: <BY2PR08MB181580B3E2779DAF024CAD7DC0FF0@BY2PR08MB1815.namprd08.prod.outlook.com>
 <a8e92a9f-f3e6-6bc3-b49b-368f3302517d@grimberg.me>
 <BY2PR08MB1815C4CAC2FC683A05DFD443C0FE0@BY2PR08MB1815.namprd08.prod.outlook.com>
 <1473810683.2781.72.camel@linux.intel.com>
Message-ID: <SN1PR08MB1822F0F69AE0A389A74CD6F1C0F10@SN1PR08MB1822.namprd08.prod.outlook.com>

Hi Jay,

Thanks for taking the effort to emulate the behavior.

I did not mention this in my last email but had indicated it in the earlier posting. I am using null_blk as the target (so the IOs are not being serviced by a real nvme target). I am not sure if that could somehow be the catalyst for the failure. Is it possible for you to re-run your test with null_blk as the target? 

Thanks,
Narayan

-----Original Message-----
From: J Freyensee [mailto:james_p_freyensee@linux.intel.com] 
Sent: Tuesday, September 13, 2016 4:51 PM
To: Narayan Ayalasomayajula <narayan.ayalasomayajula at kazan-networks.com>; Sagi Grimberg <sagi at grimberg.me>; linux-nvme at lists.infradead.org
Subject: Re: Failure with 8K Write operations

On Tue, 2016-09-13@20:04 +0000, Narayan Ayalasomayajula wrote:
> Hi Sagi,
> 
> Thanks for the print statement to verify that the sgls in the command 
> capsule match what the Host programmed. I added this print statement 
> and compared the Virtual Address and R_Key information in the /var/log 
> to the NVMe Commands in the trace file and found the two to match. I 
> have the trace and Host log files from this failure (trace is ~6M) - 
> will it be useful for someone who may be looking into this issue?
> 
> Regarding the host side log information you mentioned, I had attached 
> that in my prior email (attached again). Is this what you are 
> requesting? That was collected prior to adding the print statement 
> that you suggested.
> 
> Just to summarize, the failure is seen in the following
> configuration:
> 
> 1. Host is an 8-core Ubuntu server running the 4.8.0 kernel. It has a
> ConnectX-4 RNIC (1x100G) and is connected to a Mellanox Switch.
> 2. Target is an 8-core Ubuntu server running the 4.8.0 kernel. It has 
> a ConnectX-3 RNIC (1x10G) and is connected to a Mellanox Switch.
> 3. Switch has normal Pause and Jumbo frame support enabled on all 
> ports.
> 4. Test fails with Host sending a NAK (Remote Access Error) for the 
> following FIO workload:
> 
> 	[global]
> 	ioengine=libaio
> 	direct=1
> 	runtime=10m
> 	size=800g
> 	time_based
> 	norandommap
> 	group_reporting
> 	bs=8k
> 	numjobs=8
> 	iodepth=16
> 
> 	[rand_write]
> 	filename=/dev/nvme0n1
> 	rw=randwrite
> 

Hi Narayan:

I have a 2 host, 2 target 1RU server data network using a 32x Arista
switch and using your FIO setup above, I am not seeing any errors. ?I
tried running your script on each Host at the same time targeting the
same NVMe Target (but different SSDs targeted by each Host) as well as
only running the script on 1 Host only and didn't see any errors. Also
tried 'numjobs=1' and didn't reproduce what you see.

Both Host and Targets for me are using the 4.8-rc4 kernel. ?Both the
Host and Target are using dual port Mellanox?ConnectX-3 Pro EN 40Gb (so
I'm using a RoCE setup). My Hosts are 32 processor machines and Targets
are 28 Processor machine. ?All filled w/various Intel SSDs.

Something unique about your setup.

Jay


> I have found that the failure happens with numjobs set to 1 as well.
> 
> Thanks again for your response,
> Narayan
> 
> -----Original Message-----
> From: Sagi Grimberg [mailto:sagi at grimberg.me]?
> Sent: Tuesday, September 13, 2016 2:16 AM
> To: Narayan Ayalasomayajula <narayan.ayalasomayajula at kazan-networks.c
> om>; linux-nvme at lists.infradead.org
> Subject: Re: Failure with 8K Write operations
> 
> 
> > 
> > Hello All,
> 
> Hi Narayan,
> 
> > 
> > I am running into a failure with the 4.8.0 branch and wanted to see
> > this is a known issue or whether there is something I am not doing
> > right in my setup/configuration. The issue that I am running into
> > is that the Host is indicating a NAK (Remote Access Error)
> > condition when executing an FIO script that is performing 100% 8K
> > Write operations. Trace analysis shows that the target has the
> > expected Virtual Address and R_KEY values in the READ REQUEST but
> > for some reason, the Host flags the request as an access violation.
> > I ran a similar test with iWARP Host and Target systems and the did
> > see a Terminate followed by FIN from the Host. The cause for both
> > failures appears to be the same.
> > 
> 
> I cannot reproduce what you are seeing on my setup (Steve, can you?)
> I'm running 2 VMs connected over SRIOV on the same PC though...
> 
> Can you share the log on the host side?
> 
> Can you also add this print to verify that the host driver programmed
> the same sgl as it sent the target:
> --
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index c2c2c28e6eb5..248fa2e5cabf 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -955,6 +955,9 @@ static int nvme_rdma_map_sg_fr(struct
> nvme_rdma_queue *queue,
> ?????????sg->type = (NVME_KEY_SGL_FMT_DATA_DESC << 4) |
> ?????????????????????????NVME_SGL_FMT_INVALIDATE;
> 
> +???????pr_err("%s: rkey=%#x iova=%#llx length=%#x\n",
> +???????????????__func__, req->mr->rkey, req->mr->iova,?
> + req->mr->length);
> +
> ?????????return 0;
> ? }
> --
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
