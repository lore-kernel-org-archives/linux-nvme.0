From: hch@lst.de (hch@lst.de)
Date: Mon, 8 Jan 2018 10:47:16 +0100
Subject: Bug report - drivers/nvme/host/pci.c?
In-Reply-To: <BY2PR04MB21010125E9B1334D2FA505E786130@BY2PR04MB2101.namprd04.prod.outlook.com>
References: <4dcd8c76-872e-69e3-3cbd-d051bdf0bf62@huawei.com>
 <BY2PR04MB21010125E9B1334D2FA505E786130@BY2PR04MB2101.namprd04.prod.outlook.com>
Message-ID: <20180108094716.GA4673@lst.de>

On Mon, Jan 08, 2018@04:25:52AM +0000, Chaitanya Kulkarni wrote:
> Hi Fangjian,
> 
> 
> In my config I don't have COMFIG_ARM_SMMU* enabled, the test system I have is x86_64.

Try intel_iommu=force if it's an Intel system, or look up the AMD option
for AMD systems.
