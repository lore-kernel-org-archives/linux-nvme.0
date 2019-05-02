From: keith.busch@intel.com (Keith Busch)
Date: Thu, 2 May 2019 07:08:51 -0600
Subject: [PATCH 1/2] nvme/pci: init shadow doorbell after each reset
In-Reply-To: <20190502113134.20835-2-mlevitsk@redhat.com>
References: <20190502113134.20835-1-mlevitsk@redhat.com>
 <20190502113134.20835-2-mlevitsk@redhat.com>
Message-ID: <20190502130851.GA28496@localhost.localdomain>

On Thu, May 02, 2019@02:31:33PM +0300, Maxim Levitsky wrote:
> @@ -2303,8 +2303,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
>  			return ret;
>  		}
>  		dev->ctrl.tagset = &dev->tagset;
> -
> -		nvme_dbbuf_set(dev);
>  	} else {
>  		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
>  
> @@ -2312,6 +2310,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
>  		nvme_free_queues(dev, dev->online_queues);
>  	}
>  
> +	nvme_dbbuf_set(dev);
>  	return 0;
>  }

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
