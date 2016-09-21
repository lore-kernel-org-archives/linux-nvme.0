From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 21 Sep 2016 13:12:10 -0700
Subject: [PATCH] nvme: Add tertiary number to NVME_VS
In-Reply-To: <1474488352-20601-1-git-send-email-krisman@linux.vnet.ibm.com>
References: <1474488352-20601-1-git-send-email-krisman@linux.vnet.ibm.com>
Message-ID: <20160921201210.GA29507@infradead.org>

On Wed, Sep 21, 2016@05:05:52PM -0300, Gabriel Krisman Bertazi wrote:
> NVMe 1.2.1 specification adds a tertiary element to the version number.
> This updates the macro and its callers to include the final number and
> fixup a single place in nvmet where the version was generated manually.
> 
> For versions prior to 1.2.1, which didn't have the tertiary number, it's
> ok to assume the last number as zero, because that bit would be
> reserved, and the specification defines reserved bits as 0.

Nice cleanups, thanks a lot!

Reviewed-by: Christoph Hellwig <hch at lst.de>
