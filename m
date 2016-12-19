From: jonathan.derrick@intel.com (Jon Derrick)
Date: Mon, 19 Dec 2016 08:20:14 -0700
Subject: [PATCH 1/2] nvme : Use correct scnprintf in cmb show
In-Reply-To: <1481914491-21456-2-git-send-email-sbates@raithlin.com>
References: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
 <1481914491-21456-2-git-send-email-sbates@raithlin.com>
Message-ID: <20161219152013.GA3512@localhost.localdomain>

Looks good. Thanks Stephen.

Reviewed-by Jon Derrick: <jonathan.derrick at intel.com>

On Fri, Dec 16, 2016@11:54:50AM -0700, Stephen Bates wrote:
> Make sure we are using the correct scnprintf in the sysfs show
> function for the CMB.
> 
> Signed-off-by: Stephen Bates <sbates at raithlin.com>
> ---
>  drivers/nvme/host/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5e52034..be10860 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -50,7 +50,7 @@
>  #define NVME_AQ_DEPTH		256
>  #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
>  #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
> -		
> +
>  /*
>   * We handle AEN commands ourselves and don't even let the
>   * block layer know about them.
> @@ -1332,7 +1332,7 @@ static ssize_t nvme_cmb_show(struct device *dev,
>  {
>  	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
>  
> -	return snprintf(buf, PAGE_SIZE, "cmbloc : x%08x\ncmbsz  : x%08x\n",
> +	return scnprintf(buf, PAGE_SIZE, "cmbloc : x%08x\ncmbsz  : x%08x\n",
>  		       ndev->cmbloc, ndev->cmbsz);
>  }
>  static DEVICE_ATTR(cmb, S_IRUGO, nvme_cmb_show, NULL);
> -- 
> 2.1.4
> 
