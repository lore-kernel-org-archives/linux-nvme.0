From: shiraz.saleem@intel.com (Shiraz Saleem)
Date: Fri, 18 Jan 2019 19:12:31 -0600
Subject: NVMEoF regression on i40iw for 5.0-rc
In-Reply-To: <d2c6ca08-8c47-401d-3768-b5c0c51bc4a2@grimberg.me>
References: <9DD61F30A802C4429A01CA4200E302A7A5A0B747@fmsmsx124.amr.corp.intel.com>
 <d2c6ca08-8c47-401d-3768-b5c0c51bc4a2@grimberg.me>
Message-ID: <20190119011231.GA13408@ssaleem-MOBL4.amr.corp.intel.com>

On Fri, Jan 18, 2019@11:55:43AM -0800, Sagi Grimberg wrote:
> 
> > Hi Sagi,
> > 
> > There is a regression introduced in 5.0.0-rcx with this commit b65bb777ef22 (" nvme-rdma: support separate queue maps for read and write")
> > on the initiator side while running NVMEoF on i40iw device.
> > 
> > The crash is at https://elixir.bootlin.com/linux/v5.0-rc2/source/drivers/nvme/host/rdma.c#L303
> > 
> > It appears it's because the nvme rdma queue data struct being referenced in
> > nvme_rdma_init_request() has not been setup yet via nvme_rdma_alloc_queue().
> > Any idea why this might be the case?
> 
> Hi Shiraz,
> 
> What is the exact nvme-cli command you are running?
> 
> It appears that you are trying to create 16 I/O queues but end up
> creating only a single I/O queue? I guess that is due to the fact
> that your device supports only a single queue. However it seems
> that we initialize requests for a second hctx that wasn't allocated
> (as we have a single I/O queue).
>

Thats true. We end up with only 1 completion vector and I/O queue. It just so happened
that on this DUT that our allocation scheme assigned only one MSIX-vector for RDMA
on this dev. But we tried creating 16 I/O queues via

echo "transport=rdma,traddr=100.0.0.90,trsvcid=1055,nqn=nvme-subsystem-TEST,nr_io_queues=16" > /dev/nvme-fabrics
 
I ll try the patch you posted on the mailing list.

Shiraz
