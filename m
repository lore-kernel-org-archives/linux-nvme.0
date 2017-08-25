From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 25 Aug 2017 00:41:26 -0700
Subject: [PATCH v3] nvme: Honor RTD3 Entry Latency for shutdowns
In-Reply-To: <20170825022641.1424-1-martin.petersen@oracle.com>
References: <20170824090222.GA2543@infradead.org>
 <20170825022641.1424-1-martin.petersen@oracle.com>
Message-ID: <20170825074126.GA14685@infradead.org>

On Thu, Aug 24, 2017@10:26:41PM -0400, Martin K. Petersen wrote:
> If an NVMe controller reports RTD3 Entry Latency larger than
> shutdown_timeout, up to a maximum of 60 seconds, use that value to set
> the shutdown timer. Otherwise fall back to the module parameter which
> defaults to 5 seconds.
> 
> Signed-off-by: Martin K. Petersen <martin.petersen at oracle.com>

Do you think this is urgent enough for 4.13?
