From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 24 Aug 2017 22:26:26 -0400
Subject: [PATCH v2] nvme: Honor RTD3 Entry Latency for shutdowns
In-Reply-To: <20170824090222.GA2543@infradead.org> (Christoph Hellwig's
 message of "Thu, 24 Aug 2017 02:02:22 -0700")
References: <20170817174224.tkgrkl4hp2yjgkag@sbauer-Z170X-UD5>
 <20170823223258.6695-1-martin.petersen@oracle.com>
 <20170824090222.GA2543@infradead.org>
Message-ID: <yq1ziao757x.fsf@oracle.com>


Christoph,

> This generally looks fine, but NVMe allows TPs and thus new fields
> to be implemented even against older spec versions, so we should avoid
> version tests wherever possible.

Fine with me. I was just mirroring the other version conditionals.

-- 
Martin K. Petersen	Oracle Linux Engineering
