From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 19 Jun 2019 00:13:06 -0400
Subject: [PATCH v3 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <20190617161222.253849-3-bvanassche@acm.org> (Bart Van Assche's
 message of "Mon, 17 Jun 2019 09:12:21 -0700")
References: <20190617161222.253849-1-bvanassche@acm.org>
 <20190617161222.253849-3-bvanassche@acm.org>
Message-ID: <yq1a7eeusa5.fsf@oracle.com>


Bart,

> +	/*
> +	 * Physical blocks per logical block, 0's based. Is it possible to
> +	 * extract this information from the filesystem properties?
> +	 */
> +	const __le16 ppl0b = cpu_to_le16(0);

Maybe report the filesystem block size here?

Otherwise OK.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
