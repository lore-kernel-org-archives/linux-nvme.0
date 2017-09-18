From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 18 Sep 2017 16:08:35 -0700
Subject: [PATCH] nvme-fabrics: Allow 0 as KATO value
In-Reply-To: <20170914165928.30862-1-gpiccoli@linux.vnet.ibm.com>
References: <20170914165928.30862-1-gpiccoli@linux.vnet.ibm.com>
Message-ID: <20170918230835.GA31242@infradead.org>

On Thu, Sep 14, 2017@01:59:28PM -0300, Guilherme G. Piccoli wrote:
> Currently, driver code allows user to set 0 as KATO
> (Keep Alive TimeOut), but this is not being respected.
> This patch enforces the expected behavior.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>

Thanks, applied to nvme-4.14 after an offline ACK from Sagi.
