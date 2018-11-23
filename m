From: igor.j.konopko@intel.com (Igor Konopko)
Date: Fri, 23 Nov 2018 17:08:59 +0100
Subject: Should I submit bugs against RC kernels?
In-Reply-To: <20181121191913.GJ26707@localhost.localdomain>
References: <af0de79e5ac94be7ad4594fdace103d7@ausx13mps321.AMER.DELL.COM>
 <20181121191913.GJ26707@localhost.localdomain>
Message-ID: <7739c84c-1bc4-b4e8-eba3-48c5c5118e5d@intel.com>



On 21.11.2018 20:19, Keith Busch wrote:
> On Wed, Nov 21, 2018@06:21:49PM +0000, Alex_Gagniuc@Dellteam.com wrote:
>> Hi,
>>
>> I'm not sure if submitting bugs against RC is a good idea. I am seeing
>> more issues with SURPRISE!!! removal of drives under v4.20-rc3.
>>
>> Alex
> 
> Hi Alex,
> 
> Yes, you can (and should!) report sightings for issues on rc kernels to
> the appropriate subsystems.
> 
> The following should resolve the issue you're seeing. I won't be able to
> test it till next Monday, though.
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4f504e8f0669..b1ce747411de 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1495,6 +1495,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
>   		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
>   		blk_cleanup_queue(dev->ctrl.admin_q);
>   		blk_mq_free_tag_set(&dev->admin_tagset);
> +		dev->ctrl.admin_q = NULL;
>   	}
>   }
>   
> --

Hi
I also hit the same issue as Alex. I also tried the proposed fix and it 
helps for surprise removal scenario, but causes another issue - when 
during hot removal scenarios we have some ongoing calls to 
blk_execute_rq() - which uses admin queue, then we hit null pointer 
dereference on that path.
I just submit other fix, which on my side helps for both hot removal 
scenario and also does not brake blk_execute_rq() path.

Igor
