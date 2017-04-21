From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Fri, 21 Apr 2017 10:01:29 +0200 (CEST)
Subject: [PATCH v3] nvme-rdma: support devices with queue size < 32
In-Reply-To: <dc34a67f-a650-311d-f9ae-7e854c9d7067@grimberg.me>
References: <1519881025.363156294.1491837154312.JavaMail.zimbra@kalray.eu>
 <1491838338.4199.5.camel@sandisk.com>
 <1807354347.364485979.1491900728245.JavaMail.zimbra@kalray.eu>
 <1491923426.2654.1.camel@sandisk.com>
 <1677617891.385461828.1492681414720.JavaMail.zimbra@kalray.eu>
 <391faec7-924d-7af2-eb1b-b3106bd4193c@grimberg.me>
 <dc34a67f-a650-311d-f9ae-7e854c9d7067@grimberg.me>
Message-ID: <1470265850.389792108.1492761689842.JavaMail.zimbra@kalray.eu>



----- Le 20 Avr 17, ? 13:43, Sagi Grimberg sagi at grimberg.me a ?crit :

>> Looks good,
>>
>> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
>>
>> BTW, did you test with deeper queue depths (say 512)?

It's in progress. Small depth (16) is running for several
days already.

> 
> Wait, taking it back...
> 
> Can you make nvme_rdma_queue_sig_limit() return a bool instead?

Sure.

> 
> Also, Looking at this closer, I'm pretty convinced that this
> should convert to atomic. For iSER its fine as is because
> we are under the iscsi connection lock, but here we need to
> handle mutual exclusion.
> 
> This would be an incremental change though.

I can see that. I was wondering about atomics when rewriting
this, and I agree that it will be cleaner.

Marta
