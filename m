From: keith.busch@intel.com (Keith Busch)
Date: Wed, 3 Jan 2018 13:01:41 -0700
Subject: Bug report - drivers/nvme/host/pci.c?
In-Reply-To: <BY2PR04MB2101903E77826A0479550572861E0@BY2PR04MB2101.namprd04.prod.outlook.com>
References: <4dcd8c76-872e-69e3-3cbd-d051bdf0bf62@huawei.com>
 <BY2PR04MB2101903E77826A0479550572861E0@BY2PR04MB2101.namprd04.prod.outlook.com>
Message-ID: <20180103200140.GA11172@localhost.localdomain>

On Wed, Jan 03, 2018@07:46:05PM +0000, Chaitanya Kulkarni wrote:
>    HI Fangjian,
> 
>    I ran your test on the latest kernel and I did not see the problem.
<> 
>    Is there a particular reason why you are using Linux version 4.15.0-rc1?
> 
>    Can you please check if you are having the same problem on the latest
>    kernel as mentioned in my log?
> 
>    Regards,
> 
>    Chaitanya

I would guess the reporter has an IOMMU enabled that DMA maps into fewer
entries than the virtual table has. Since that's possible, I think the
WARN_ON is invalid unless you overwrite iod->nents to be the return of
dma_map_sg, I think.
