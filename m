From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 1 Mar 2017 17:39:45 -0700
Subject: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
In-Reply-To: <20170302003216.GC13171@bhelgaas-glaptop.roam.corp.google.com>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
 <20170228150920.GB12481@bhelgaas-glaptop.roam.corp.google.com>
 <d3d5567a-2147-43c5-d094-fb5345f02143@deltatee.com>
 <20170302003216.GC13171@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <1c1c683c-df1a-bda5-fbea-0f7aaa30b632@deltatee.com>



On 01/03/17 05:32 PM, Bjorn Helgaas wrote:
> It's not a perfect fit in drivers/pci because it's not bus
> infrastructure and I don't want to be the default maintainer of it,
> but I agree there's not really an alternative that's clearly better,
> so let's leave it where it is for now.

Sounds good, thanks.

It would be nice if it could stay where it is for organization but go
through other maintainers trees (though I'm not sure who). I understand
why you wouldn't want to take on the maintenance of it. Hopefully,
myself and the other Microsemi developers will be able to do the bulk of
the maintenance work for the driver.

Thanks,

Logan
