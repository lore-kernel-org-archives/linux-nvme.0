From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 27 Jun 2019 00:02:48 +0000
Subject: [PATCH -next] nvme-pci: Make nvme_dev_pm_ops static
In-Reply-To: <20190626202311.GB4934@minwooim-desktop>
References: <20190626020902.38240-1-yuehaibing@huawei.com>
 <20190626202311.GB4934@minwooim-desktop>
Message-ID: <16F98F71-9186-443A-A787-1F966A3BCC87@wdc.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

?On 6/26/19, 1:23 PM, "Linux-nvme on behalf of Minwoo Im" <linux-nvme-bounces@lists.infradead.org on behalf of minwoo.im.dev@gmail.com> wrote:

    On 19-06-26 10:09:02, YueHaibing wrote:
    > Fix sparse warning:
    > 
    > drivers/nvme/host/pci.c:2926:25: warning:
    >  symbol 'nvme_dev_pm_ops' was not declared. Should it be static?
    > 
    > Reported-by: Hulk Robot <hulkci at huawei.com>
    > Signed-off-by: YueHaibing <yuehaibing at huawei.com>
    > ---
    >  drivers/nvme/host/pci.c | 2 +-
    >  1 file changed, 1 insertion(+), 1 deletion(-)
    > 
    > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
    > index 1893520..f500133 100644
    > --- a/drivers/nvme/host/pci.c
    > +++ b/drivers/nvme/host/pci.c
    > @@ -2923,7 +2923,7 @@ static int nvme_simple_resume(struct device *dev)
    >  	return 0;
    >  }
    >  
    > -const struct dev_pm_ops nvme_dev_pm_ops = {
    > +static const struct dev_pm_ops nvme_dev_pm_ops = {
    >  	.suspend	= nvme_suspend,
    >  	.resume		= nvme_resume,
    >  	.freeze		= nvme_simple_suspend,
    
    IMHO, it should be in static.
    
    Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
