From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 27 Oct 2016 13:31:47 +0300
Subject: [PATCH rfc 0/6] convert nvme pci to use irq-poll service
In-Reply-To: <20161027100918.j62izkq6hmos6sc4@linux-x5ow.site>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <20161027100918.j62izkq6hmos6sc4@linux-x5ow.site>
Message-ID: <a99705df-4f4c-3b2e-e9cc-9f3ca00e17c4@grimberg.me>


> Hi Sagi,

Hey Johannes,

> I'm wondering if I've somehow missed the v2 of this series?

You didn't miss it.

I currently have it in:
git://git.infradead.org/nvme-fabrics.git   nvme-irq-poll

 From my tests with Qemu nvme I still see ~10% performance
degradation for 4K IOs and cannot explain where its
coming from. But I think we need some real setup tests as
well.

Hence, I don't feel comfortable getting this in at this point.
I would appreciate if people can also try it out and provide
some insight (Jens, Christoph, Keith).

The networking folks are using napi everywhere and can reach
much lower latencies than NVMe so IMO we just need to identify
some gaps. I have some micro-optimization patches for irq-poll
but they don't seem to make a real difference.
