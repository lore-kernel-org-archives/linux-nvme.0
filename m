From: axboe@fb.com (Jens Axboe)
Date: Tue, 22 Mar 2016 10:28:07 -0600
Subject: [PATCH v3 RESEND] nvme: avoid cqe corruption when update at the
 same time as read
In-Reply-To: <927773622.9658030.1458658926133.JavaMail.zimbra@kalray.eu>
References: <927773622.9658030.1458658926133.JavaMail.zimbra@kalray.eu>
Message-ID: <56F17297.50900@fb.com>

On 03/22/2016 09:02 AM, Marta Rybczynska wrote:
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

Added for this merge window, thanks.

-- 
Jens Axboe
