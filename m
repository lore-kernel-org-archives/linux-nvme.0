From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Oct 2015 10:25:44 -0700
Subject: [PATCH 2/2] drivers/nvme: default to the IOMMU page size on Power
In-Reply-To: <20151002172313.GC41011@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002171800.GB41011@linux.vnet.ibm.com>
 <20151002172313.GC41011@linux.vnet.ibm.com>
Message-ID: <20151002172544.GA16139@infradead.org>

Hi Nishanth,

please expose this value through the generic DMA API instead of adding
architecture specific hacks to drivers.
