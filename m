From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sun, 11 Dec 2016 00:07:37 +0300
Subject: [patch] nvme-fabrics: correct some printk information
In-Reply-To: <1481403290.1764.1.camel@perches.com>
References: <20161210090618.GA11680@elgon.mountain>
 <1481369270.5946.51.camel@perches.com>
 <20161210184029.GY8176@mwanda>
 <alpine.DEB.2.20.1612102104050.1986@hadrien>
 <1481403290.1764.1.camel@perches.com>
Message-ID: <20161210210737.GR8244@mwanda>

On Sat, Dec 10, 2016@12:54:50PM -0800, Joe Perches wrote:
> diff -u -p drivers//dma/pxa_dma.c /tmp/nothing//dma/pxa_dma.c
> --- drivers//dma/pxa_dma.c
> +++ /tmp/nothing//dma/pxa_dma.c
> @@ -640,9 +640,6 @@ static unsigned int clear_chan_irq(struc
>  	dcsr = phy_readl_relaxed(phy, DCSR);
>  	phy_writel(phy, dcsr, DCSR);
>  	if ((dcsr & PXA_DCSR_BUSERR) && (phy->vchan))
> -		dev_warn(&phy->vchan->vc.chan.dev->device,
> -			 "%s(chan=%p): PXA_DCSR_BUSERR\n",
> -			 __func__, &phy->vchan);

That's not a defect.  We're getting the address of vchan.  I don't get
it?

regards,
dan carpenter
