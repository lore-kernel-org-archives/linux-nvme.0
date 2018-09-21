From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 21 Sep 2018 15:12:10 -0600
Subject: [PATCH v6 04/13] PCI/P2PDMA: Introduce configfs/sysfs enable
 attribute helpers
In-Reply-To: <20180921161858.GH224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-5-logang@deltatee.com>
 <20180921161858.GH224714@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <736867f3-8b3e-2e8f-1929-60e5e3cba2b5@deltatee.com>



On 2018-09-21 10:18 a.m., Bjorn Helgaas wrote:
> It'd be sort of nice if the contents of the sysfs file were valid
> things you could put *back* into it.  But it looks like the contents
> might be "none", which isn't valid for the store.  And the contents
> are never "on" or "off".

In fact, "none" would be accepted by strtobool() as a false (seeing it
starts with 'n' and strtobool() only looks at the first character).
However, per the rest of your feedback I've changed show() to report
"0", "1" or  pci_name() and dropped "auto". This matches what the other
strtobool configfs attributes are doing in NVMe target.

Logan
