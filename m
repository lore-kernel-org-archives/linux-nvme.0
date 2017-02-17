From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Feb 2017 09:24:16 +0100
Subject: [PATCH v2] nvme/core: Check for Security send/recv support
 before issuing commands.
In-Reply-To: <9daa1e48-90c9-9138-4683-4edafffbb613@intel.com>
References: <1487283420-4649-1-git-send-email-scott.bauer@intel.com>
 <9daa1e48-90c9-9138-4683-4edafffbb613@intel.com>
Message-ID: <20170217082416.GA18090@lst.de>

On Thu, Feb 16, 2017@03:38:53PM -0700, Jon Derrick wrote:
> Looks fine,
> Reviewed-by: Jon Derrick <jonathan.derrick at intel.com>

I think we need to do this from nvme_reset before calling into
the OPAL code (or any other security protocol in the future).

I'll prepare a patch.
