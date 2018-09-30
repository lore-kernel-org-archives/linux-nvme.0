From: james.smart@broadcom.com (James Smart)
Date: Sun, 30 Sep 2018 09:33:56 -0700
Subject: [PATCH v2] nvme: call nvme_complete_rq on NVME_MPATH failures
In-Reply-To: <a422e9b3-1fdd-b910-ae3b-0f9194e589c0@suse.de>
References: <20180927235854.12386-1-jsmart2021@gmail.com>
 <a422e9b3-1fdd-b910-ae3b-0f9194e589c0@suse.de>
Message-ID: <db987865-951f-06d1-1152-475300a11275@broadcom.com>



On 9/29/2018 5:13 AM, Hannes Reinecke wrote:
> Don't we need a mapping in nvme_error_status() to map the new code into
> a BLK_STS_XXX code other that BLK_STS_IOERR?

Under what condition and for what reason ?

IOERR is appropriate, and what it was reporting before (for 
NVME_SC_ABORT_REQ).
If it's for a NVME_MPATH io, it doesn't matter as the status is ignored 
due to the retry.

-- james
