From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 21 Feb 2019 10:16:31 +0800
Subject: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
In-Reply-To: <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190220031122.GA17298@ming.t460p> <20190220141701.GA26537@lst.de>
 <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <CACVXFVMkxPJsAKkJ0uopFPCpFiZDxA2qH11Yt8AsuKHEmVqGxA@mail.gmail.com>

On Thu, Feb 21, 2019 at 2:16 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 02/20/2019 06:17 AM, Christoph Hellwig wrote:
> > We shouldn't be allocating a scatterlist for a command that doesn't
> > have a payload.
> >
> > The blk_rq_payload_bytes check in nvme_rdma_map_data is supposed to
> > prevent that.
> >
> > Chaitanya, can you try to debug why this is not working?  I'm on
> > vacation and don't have much time right now unfortunately.
> >
>
>
> Hi Ming,
>
> Can you please test following patch on your system ?

With this patch, the test can pass.

[root at ktest-04 blktests]# ./check nvmeof-mp/002
nvmeof-mp/002 (File I/O on top of multipath concurrently with logout
and login (mq)) [passed]
    runtime  75.478s  ...  54.317s

>
>
>
>  From 79e178a53a9f101d1f5f6a4923298bb1ffe936ef Mon Sep 17 00:00:00 2001
> From: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Date: Wed, 20 Feb 2019 09:16:58 -0800
> Subject: [PATCH] nvme-rdma: use nr_phys_segments when map rq to sgl
>
> Use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes() to check
> if a command contains data to be mapped.  This fixes the case where
> a struct request contains LBAs, but it has no payload, such as
> Write Zeroes support.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>   drivers/nvme/host/rdma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index ac365366c2ec..c6a489049fd5 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1150,7 +1150,7 @@ static void nvme_rdma_unmap_data(struct
> nvme_rdma_queue *queue,
>         struct nvme_rdma_device *dev = queue->device;
>         struct ib_device *ibdev = dev->dev;
>
> -       if (!blk_rq_payload_bytes(rq))
> +       if (!blk_rq_nr_phys_segments(rq))
>                 return;
>
>         if (req->mr) {
> @@ -1273,7 +1273,7 @@ static int nvme_rdma_map_data(struct
> nvme_rdma_queue *queue,
>
>         c->common.flags |= NVME_CMD_SGL_METABUF;
>
> -       if (!blk_rq_payload_bytes(rq))
> +       if (!blk_rq_nr_phys_segments(rq))
>                 return nvme_rdma_set_sg_null(c);
>
>         req->sg_table.sgl = req->first_sgl;
> --
> 2.17.0
>
>
> Also can you please share all the QEMU config/setup information that
> you have used to run the tests ? I want to add this test to the blktests
> with QEMU platform.

Just enable the required kernel config options and install
device-mapper-multipath,
then run './check nvmeof-mp/002', it will be started.

Thanks,
Ming Lei
