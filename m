From: keith.busch@intel.com (Keith Busch)
Date: Thu, 17 Aug 2017 11:01:13 -0400
Subject: [PATCH] nvme: Honor RTD3 Entry Latency for shutdowns
In-Reply-To: <yq1wp63qlug.fsf@oracle.com>
References: <20170816195552.22492-1-martin.petersen@oracle.com>
 <20170816202543.ilkhynyffe2tjrl7@sbauer-Z170X-UD5>
 <yq1wp63qlug.fsf@oracle.com>
Message-ID: <20170817150113.GL7233@localhost.localdomain>

On Wed, Aug 16, 2017@04:49:43PM -0400, Martin K. Petersen wrote:
> 
> Scott,
> 
> > My only concern is if this value extends past the DPM_WATCHDOG timeout
> > value. If it does we're going to end up panic()ing the kernel during
> > suspends. If others agree I think we should set it to the minimum value
> > of DPM_WATCHDOG_TIMEOUT and shutdown_timeout.
> 
> I don't have a problem with that. Keith?

Sounds good to me as well.
