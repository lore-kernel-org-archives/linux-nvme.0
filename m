From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 19 Feb 2019 07:19:43 +0100 (CET)
Subject: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
In-Reply-To: <tencent_6C5D1EC74B826B1E2F22293C@qq.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-2-ming.lei@redhat.com>
 <20190213150407.GB96272@google.com>
 <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de>
 <20190213213149.GB8027@localhost.localdomain>
 <alpine.DEB.2.21.1902132232560.1659@nanos.tec.linutronix.de>
 <20190213223711.GC8027@localhost.localdomain>
 <alpine.DEB.2.21.1902140949280.1659@nanos.tec.linutronix.de>
 <tencent_6460D33741AF25B57E7BE493@qq.com>
 <alpine.DEB.2.21.1902141430190.1561@nanos.tec.linutronix.de>
 <tencent_6C5D1EC74B826B1E2F22293C@qq.com>
Message-ID: <alpine.DEB.2.21.1902190718160.1644@nanos.tec.linutronix.de>

On Tue, 19 Feb 2019, ??? wrote:
> 
> I've tested, this patch can fix the nvme problem, but it can't be applied
> to 4.19 because of different context. And, I still think my original solution
> (genirq/affinity: Assign default affinity to pre/post vectors) is correct.
> There may be similar problems except nvme.

As I explained you in great length, it is not correct because it's just
papering over the underlying problem.

Please stop advertising semantically broken duct tape solutions.

Thanks,

	tglx
