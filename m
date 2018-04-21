From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Apr 2018 09:06:03 +0200
Subject: [pci PATCH v8 2/4] ena: Migrate over to unmanaged SR-IOV support
In-Reply-To: <20180420162841.46077.17967.stgit@ahduyck-green-test.jf.intel.com>
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
 <20180420162841.46077.17967.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180421070603.GC24431@lst.de>

On Fri, Apr 20, 2018@12:30:21PM -0400, Alexander Duyck wrote:
> Instead of implementing our own version of a SR-IOV configuration stub in
> the ena driver we can just reuse the existing
> pci_sriov_configure_simple function.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck at intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
