From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 16 Aug 2017 16:49:43 -0400
Subject: [PATCH] nvme: Honor RTD3 Entry Latency for shutdowns
In-Reply-To: <20170816202543.ilkhynyffe2tjrl7@sbauer-Z170X-UD5> (Scott Bauer's
 message of "Wed, 16 Aug 2017 14:25:44 -0600")
References: <20170816195552.22492-1-martin.petersen@oracle.com>
 <20170816202543.ilkhynyffe2tjrl7@sbauer-Z170X-UD5>
Message-ID: <yq1wp63qlug.fsf@oracle.com>


Scott,

> My only concern is if this value extends past the DPM_WATCHDOG timeout
> value. If it does we're going to end up panic()ing the kernel during
> suspends. If others agree I think we should set it to the minimum value
> of DPM_WATCHDOG_TIMEOUT and shutdown_timeout.

I don't have a problem with that. Keith?

-- 
Martin K. Petersen	Oracle Linux Engineering
