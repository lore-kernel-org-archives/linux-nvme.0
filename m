From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 Mar 2016 15:06:57 +0000
Subject: [PATCH v3 RESEND] nvme: avoid cqe corruption when update at
 the same time as read
In-Reply-To: <927773622.9658030.1458658926133.JavaMail.zimbra@kalray.eu>
References: <927773622.9658030.1458658926133.JavaMail.zimbra@kalray.eu>
Message-ID: <20160322150657.GB24460@localhost.localdomain>

On Tue, Mar 22, 2016@04:02:06PM +0100, Marta Rybczynska wrote:
> Make sure the CQE phase (validity) is read before the rest of the
> structure. The phase bit is the highest address and the CQE
> read will happen on most platforms from lower to upper addresses
> and will be done by multiple non-atomic loads. If the structure
> is updated by PCI during the reads from the processor, the
> processor may get a corrupted copy.
> 
> The addition of the new nvme_cqe_valid function that verifies
> the validity bit also allows refactoring of the other CQE read
> sequences.
>
> Signed-off-by: Marta Rybczynska <marta.rybczynska at kalray.eu>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
