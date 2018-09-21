From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 21 Sep 2018 13:44:38 -0600
Subject: [PATCH v6 04/13] PCI/P2PDMA: Introduce configfs/sysfs enable
 attribute helpers
In-Reply-To: <20180921161858.GH224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-5-logang@deltatee.com>
 <20180921161858.GH224714@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <db325d7a-f3c7-a287-b2b7-3530ef75cd9f@deltatee.com>

On 2018-09-21 10:18 AM, Bjorn Helgaas wrote:
> Where do these store/show functions get connected to sysfs?  I know
> there's a lot of magic there, so apologies if I'm missing it.

Well in this patch set they are used in configfs not sysfs. It's not
magic, they are just helpers for other drivers. They are called in Patch
13 by NVMe target's configfs functions.

Logan
