From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 27 Sep 2018 11:09:26 -0600
Subject: [PATCH v8 11/13] nvme-pci: Add a quirk for a pseudo CMB
In-Reply-To: <20180927165420.5290-12-logang@deltatee.com>
References: <20180927165420.5290-1-logang@deltatee.com>
 <20180927165420.5290-12-logang@deltatee.com>
Message-ID: <20180927170925.GB19589@localhost.localdomain>

On Thu, Sep 27, 2018@10:54:18AM -0600, Logan Gunthorpe wrote:
> Introduce a quirk to use CMB-like memory on older devices that have
> an exposed BAR but do not advertise support for using CMBLOC and
> CMBSIZE.
> 
> We'd like to use some of these older cards to test P2P memory.
> 
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

The implementation looks fine, and this is why we have quirks ... but
CMB has existed since 2014! :)

Reviewed-by: Keith Busch <keith.busch at intel.com>
