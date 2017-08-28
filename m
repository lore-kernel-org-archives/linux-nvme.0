From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Aug 2017 10:22:29 -0400
Subject: [PATCH v4] nvme: Honor RTD3 Entry Latency for shutdowns
In-Reply-To: <20170825231450.32637-1-martin.petersen@oracle.com>
References: <20170825195605.GC1207@localhost.localdomain>
 <20170825231450.32637-1-martin.petersen@oracle.com>
Message-ID: <20170828142229.GF1207@localhost.localdomain>

On Fri, Aug 25, 2017@07:14:50PM -0400, Martin K. Petersen wrote:
> If an NVMe controller reports RTD3 Entry Latency larger than
> shutdown_timeout, up to a maximum of 60 seconds, use that value to set
> the shutdown timer. Otherwise fall back to the module parameter which
> defaults to 5 seconds.
> 
> Signed-off-by: Martin K. Petersen <martin.petersen at oracle.com>

Looks good,

Reviewed-by: Keith Busch <keith.busch at intel.com>
