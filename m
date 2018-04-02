From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 2 Apr 2018 23:25:57 +0000
Subject: [RFC PATCH 1/8] nvme-core: add new interfaces
In-Reply-To: <d3235b3f-9253-64d2-d488-144c384be6f9@deltatee.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-2-chaitanya.kulkarni@wdc.com>
 <d3235b3f-9253-64d2-d488-144c384be6f9@deltatee.com>
Message-ID: <A0D6856B-E5A2-465C-B40B-D7E9E4D3D4FE@wdc.com>

[CK] Okay, I'll fix it in next version.

On 3/30/18, 10:48 AM, "Logan Gunthorpe" <logang@deltatee.com> wrote:

    
    
    On 30/03/18 12:57 AM, Chaitanya Kulkarni wrote:
    > +int nvme_get_ctrl_by_name(char *ctrl_name, struct nvme_ctrl **ctrl)
    > +{
    > +	int ret = -ENODEV;
    > +	char str[256] = "/dev/";
    
    Kernel code should not make assumptions about the layout of the
    filesystem. Prepending "/dev/" to a controller name is icky. I'd suggest
    looking at blkdev_get_by_path() and doing something similar. Also this
    function should probably be called nvme_get_ctrl_by_path() seeing it
    seems to be trying to take a path and not a name.
    
    Logan
    
