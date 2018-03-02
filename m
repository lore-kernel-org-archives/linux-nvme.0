From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 1 Mar 2018 17:15:51 -0700
Subject: [PATCH v2 02/10] PCI/P2PDMA: Add sysfs group to display p2pmem
 stats
In-Reply-To: <20180301174450.GF13722@bhelgaas-glaptop.roam.corp.google.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-3-logang@deltatee.com>
 <20180301174450.GF13722@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <d69d59c0-6182-cce7-7ba4-8552ba95bef5@deltatee.com>



On 01/03/18 10:44 AM, Bjorn Helgaas wrote:
> I think these two statements are out of order, since the attributes
> dereference pdev->p2pdma.  And it looks like you set "error"
> unnecessarily, since you return immediately looking at it.

Per the previous series, sysfs_create_group is must_check for some 
reason. I had a printk there but you didn't think it was necessary. So 
assigning it to error is the only way to squash the warning.

Logan
