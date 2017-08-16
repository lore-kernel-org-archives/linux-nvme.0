From: scott.bauer@intel.com (Scott Bauer)
Date: Wed, 16 Aug 2017 14:25:44 -0600
Subject: [PATCH] nvme: Honor RTD3 Entry Latency for shutdowns
In-Reply-To: <20170816195552.22492-1-martin.petersen@oracle.com>
References: <20170816195552.22492-1-martin.petersen@oracle.com>
Message-ID: <20170816202543.ilkhynyffe2tjrl7@sbauer-Z170X-UD5>

On Wed, Aug 16, 2017@03:55:52PM -0400, Martin K. Petersen wrote:
> If an NVMe controller reports RTD3 Entry Latency bigger than
> shutdown_timeout, use that value to set the shutdown timer. Otherwise
> fall back to the module parameter which defaults to 5 seconds.

My only concern is if this value extends past the DPM_WATCHDOG timeout
value. If it does we're going to end up panic()ing the kernel during
suspends. If others agree I think we should set it to the minimum value
of DPM_WATCHDOG_TIMEOUT and shutdown_timeout.
