From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Tue, 22 Mar 2016 16:04:43 +0100 (CET)
Subject: [PATCH v3 RESEND] nvme: avoid cqe corruption when update at the
 same time as read
In-Reply-To: <927773622.9658030.1458658926133.JavaMail.zimbra@kalray.eu>
References: <927773622.9658030.1458658926133.JavaMail.zimbra@kalray.eu>
Message-ID: <948271214.9659858.1458659083805.JavaMail.zimbra@kalray.eu>

----- Mail original -----
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

This is a resend after a week of testing. Works fine for me.

Regards,
Marta Rybczynska
