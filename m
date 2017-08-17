From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 17 Aug 2017 13:06:32 -0400
Subject: [PATCH] nvme: Honor RTD3 Entry Latency for shutdowns
In-Reply-To: <20170817150113.GL7233@localhost.localdomain> (Keith Busch's
 message of "Thu, 17 Aug 2017 11:01:13 -0400")
References: <20170816195552.22492-1-martin.petersen@oracle.com>
 <20170816202543.ilkhynyffe2tjrl7@sbauer-Z170X-UD5>
 <yq1wp63qlug.fsf@oracle.com>
 <20170817150113.GL7233@localhost.localdomain>
Message-ID: <yq1o9rektt3.fsf@oracle.com>


Keith,

>> > My only concern is if this value extends past the DPM_WATCHDOG
>> > timeout value. If it does we're going to end up panic()ing the
>> > kernel during suspends. If others agree I think we should set it to
>> > the minimum value of DPM_WATCHDOG_TIMEOUT and shutdown_timeout.
>> 
>> I don't have a problem with that. Keith?
>
> Sounds good to me as well.

Hrm, this gets pretty messy.

DPM_WATCHDOG_TIMEOUT is buried deep in the config options (hidden behind
PM_DEBUG and EXPERT). And as a result doesn't appear to be enabled in
most common kernel configs. It also isn't exported from the PM subsystem
in a generic way.

In addition, I'm not sure what we'd do in case a device demands a 10
second shutdown time but the user has the kernel configured with a 2
second DPM watchdog. Then what? The device is still going to take 10
seconds to complete the shutdown request.

-- 
Martin K. Petersen	Oracle Linux Engineering
