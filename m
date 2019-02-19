From: keith.busch@intel.com (Keith Busch)
Date: Tue, 19 Feb 2019 09:12:57 -0700
Subject: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
In-Reply-To: <tencent_6C5D1EC74B826B1E2F22293C@qq.com>
References: <20190213105041.13537-2-ming.lei@redhat.com>
 <20190213150407.GB96272@google.com>
 <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de>
 <20190213213149.GB8027@localhost.localdomain>
 <alpine.DEB.2.21.1902132232560.1659@nanos.tec.linutronix.de>
 <20190213223711.GC8027@localhost.localdomain>
 <alpine.DEB.2.21.1902140949280.1659@nanos.tec.linutronix.de>
 <tencent_6460D33741AF25B57E7BE493@qq.com>
 <alpine.DEB.2.21.1902141430190.1561@nanos.tec.linutronix.de>
 <tencent_6C5D1EC74B826B1E2F22293C@qq.com>
Message-ID: <20190219161256.GA16341@localhost.localdomain>

On Mon, Feb 18, 2019@04:42:27PM -0800, ??? wrote:
> I've tested, this patch can fix the nvme problem, but it can't be applied
> to 4.19 because of different context. And, I still think my original solution
> (genirq/affinity: Assign default affinity to pre/post vectors) is correct.
> There may be similar problems except nvme.

I'll send a proper patch to fix the warning.  It's always a driver bug if
they try to extract affinity from a non-managed irq, but I don't think
this particular nvme instance is very urgent as the end result is the
same, just without the warning.
