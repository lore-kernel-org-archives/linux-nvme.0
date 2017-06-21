From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Wed, 21 Jun 2017 17:14:41 +0200 (CEST)
Subject: [PATCH v2] nvme-rdma: remove race conditions from IB signalling
In-Reply-To: <20170607082559.GA24876@lst.de>
References: <1367439528.79530717.1496748441203.JavaMail.zimbra@kalray.eu>
 <e23c840e-90c2-5929-a8fe-408ef90fa546@grimberg.me>
 <20170607082559.GA24876@lst.de>
Message-ID: <2005801981.129655619.1498058081264.JavaMail.zimbra@kalray.eu>

> On Tue, Jun 06, 2017@02:59:43PM +0300, Sagi Grimberg wrote:
>> Christoph,
>>
>> Can you place a stable tag on this (4.11+)?
> 
> Added.

I do not see this one in nvme-4.13. Can we get it in, please?
We're seeing the races in our setup and this patch fixes it.

Thanks,
Marta
