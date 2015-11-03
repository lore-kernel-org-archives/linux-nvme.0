From: keith.busch@intel.com (Keith Busch)
Date: Tue, 3 Nov 2015 15:39:58 +0000
Subject: NVMe: Add persistent reservation ops
In-Reply-To: <20151103125815.GA5825@mwanda>
References: <20151103125815.GA5825@mwanda>
Message-ID: <20151103153958.GH13904@localhost.localdomain>

On Tue, Nov 03, 2015@03:58:15PM +0300, Dan Carpenter wrote:
> 
> 	drivers/nvme/host/pci.c:2143 nvme_pr_clear()
> 	warn: suspicious bitop condition
> 
> drivers/nvme/host/pci.c
>   2141  static int nvme_pr_clear(struct block_device *bdev, u64 key)
>   2142  {
>   2143          u32 cdw10 = 1 | key ? 1 << 3 : 0;
> 
> Is this supposed to be?
> 
> 		u32 cdw10 = 1 | (key ? 1 << 3 : 0);
> 
>   2144          return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_register);
>   2145  }

Thanks for the catch. Must have pulled the patch from the wrong machine
when I added it to the persistent reservation series. Do you want to
send the fixing patch?
