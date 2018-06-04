From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Mon, 4 Jun 2018 15:49:16 -0600
Subject: [PATCH v2 2/8] nvmet-rdma: wrap raw kref_get/put() with
 corresponding helpers
In-Reply-To: <20180604123003.24748-3-roman.penyaev@profitbricks.com>
References: <20180604123003.24748-1-roman.penyaev@profitbricks.com>
 <20180604123003.24748-3-roman.penyaev@profitbricks.com>
Message-ID: <20180604214916.GC24926@ziepe.ca>

On Mon, Jun 04, 2018@02:29:57PM +0200, Roman Pen wrote:
> This is just a preparation patch: put kref_put() and kref_get_unless_zero()
> inside helpers with more suitable names.
> 
> Signed-off-by: Roman Pen <roman.penyaev at profitbricks.de>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Steve Wise <swise at opengridcomputing.com>
> Cc: Bart Van Assche <bart.vanassche at sandisk.com>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Doug Ledford <dledford at redhat.com>
> Cc: linux-nvme at lists.infradead.org
>  drivers/nvme/target/rdma.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 52e0c5d579a7..4304b8d8d027 100644
> +++ b/drivers/nvme/target/rdma.c
> @@ -775,7 +775,7 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
>  	return ret;
>  }
>  
> -static void nvmet_rdma_free_dev(struct kref *ref)
> +static void nvmet_rdma_free_device(struct kref *ref)
>  {
>  	struct nvmet_rdma_device *ndev =
>  		container_of(ref, struct nvmet_rdma_device, ref);
> @@ -790,6 +790,16 @@ static void nvmet_rdma_free_dev(struct kref *ref)
>  	kfree(ndev);
>  }
>  
> +static int nvmet_rdma_dev_put(struct nvmet_rdma_device *dev)
> +{
> +	return kref_put(&dev->ref, nvmet_rdma_free_device);
> +}
> +
> +static int nvmet_rdma_dev_get(struct nvmet_rdma_device *dev)
> +{
> +	return kref_get_unless_zero(&dev->ref);
> +}

Don't wrap get_unless_zero with something called get..

unless_zero should only be used in special situations where something tricky
is going on.. In this case it looks like it is because a
nvmet_rdma_device can continue to reside in the device_list() even after
being fully 'put'..

Which does pose a question to this whole series, what have you done to
ensure the client data access isn't racing with the removal of the
device/client?

We might want to adjust the core code to make this a little saner, eg
maybe the client_data should have an option that manages a kref'd
memory blob internally with proper locking or something..

Jason
