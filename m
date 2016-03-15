From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 15 Mar 2016 13:52:46 +0100
Subject: [PATCH v2] nvme: avoid cqe corruption when update at the same
 time as  read
In-Reply-To: <2110767714.5479030.1458045053603.JavaMail.zimbra@kalray.eu>
References: <2110767714.5479030.1458045053603.JavaMail.zimbra@kalray.eu>
Message-ID: <20160315125246.GN14621@c203.arch.suse.de>

On Tue, Mar 15, 2016@01:30:53PM +0100, Marta Rybczynska wrote:
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

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
