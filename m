From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Thu, 6 Jul 2017 12:44:25 +0200 (CEST)
Subject: [PATCH v2] nvme-rdma: remove race conditions from IB signalling
In-Reply-To: <20170705170429.GA4697@lst.de>
References: <1367439528.79530717.1496748441203.JavaMail.zimbra@kalray.eu>
 <e23c840e-90c2-5929-a8fe-408ef90fa546@grimberg.me>
 <20170607082559.GA24876@lst.de>
 <2005801981.129655619.1498058081264.JavaMail.zimbra@kalray.eu>
 <20170705170429.GA4697@lst.de>
Message-ID: <1951365057.174454158.1499337865396.JavaMail.zimbra@kalray.eu>

> On Wed, Jun 21, 2017@05:14:41PM +0200, Marta Rybczynska wrote:
>> I do not see this one in nvme-4.13. Can we get it in, please?
>> We're seeing the races in our setup and this patch fixes it.
> 
> I've added it.  Note that your mail was whitespace damaged, so I had
> to apply it manually.  I used that opportunity to also move the comments
> around a bit.

Thank you! And sorry for the issue.

Best regards,
Marta
