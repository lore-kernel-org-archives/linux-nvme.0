From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 15 Mar 2016 06:30:02 -0700
Subject: [PATCH v2] nvme: avoid cqe corruption when update at the same
 time as  read
In-Reply-To: <2110767714.5479030.1458045053603.JavaMail.zimbra@kalray.eu>
References: <2110767714.5479030.1458045053603.JavaMail.zimbra@kalray.eu>
Message-ID: <20160315133002.GA15981@infradead.org>

> +/* We read the CQE phase first to check if the rest of the entry is valid */
> +static inline bool nvme_cqe_valid(struct nvme_queue *nvmeq, u16 head,
> +	u16 phase)

the second line here would normally get a two tab indent.


Except for this minor nitpick this looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
