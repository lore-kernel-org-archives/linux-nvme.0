From: chenhc@lemote.com (=?utf-8?B?6ZmI5Y2O5omN?=)
Date: Tue, 19 Feb 2019 08:42:27 +0800
Subject: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
In-Reply-To: <alpine.DEB.2.21.1902141430190.1561@nanos.tec.linutronix.de>
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
Message-ID: <tencent_6C5D1EC74B826B1E2F22293C@qq.com>

My lemote.com email is too weak, I'll stop top post because this time I've
cc-ed my gmail.

I've tested, this patch can fix the nvme problem, but it can't be applied
to 4.19 because of different context. And, I still think my original solution
(genirq/affinity: Assign default affinity to pre/post vectors) is correct.
There may be similar problems except nvme.
 
Huacai

------------------ Original ------------------
From:  "Thomas Gleixner"<tglx@linutronix.de>;
Date:  Thu, Feb 14, 2019 09:31 PM
To:  "???"<chenhc at lemote.com>;
Cc:  "Keith Busch"<keith.busch at intel.com>; "Bjorn Helgaas"<helgaas at kernel.org>; "Jens Axboe"<axboe at kernel.dk>; "Sagi Grimberg"<sagi at grimberg.me>; "linux-pci"<linux-pci at vger.kernel.org>; "LKML"<linux-kernel at vger.kernel.org>; "linux-nvme"<linux-nvme at lists.infradead.org>; "Ming Lei"<ming.lei at redhat.com>; "linux-block"<linux-block at vger.kernel.org>; "Christoph Hellwig"<hch at lst.de>;
Subject:  Re: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
 
On Thu, 14 Feb 2019, ??? wrote:

Please do not top post....

> I'll test next week, but 4.19 has the same problem, how to fix that for 4.19?

By applying the very same patch perhaps?

Thanks,

tglx
