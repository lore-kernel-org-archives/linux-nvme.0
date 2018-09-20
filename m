From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 20 Sep 2018 00:10:40 -0700
Subject: Kernel v4.19-rc4 KASAN complaint
In-Reply-To: <6892a170-0dcf-9498-19c2-50e1ae89f4ef@acm.org>
References: <6892a170-0dcf-9498-19c2-50e1ae89f4ef@acm.org>
Message-ID: <20180920071040.GA8685@infradead.org>

On Tue, Sep 18, 2018@02:16:48PM -0700, Bart Van Assche wrote:
> Hello,
> 
> If I run the nvmeof-mp tests from https://github.com/bvanassche/blktests
> against kernel v4.19-rc4 then a KASAN complaint appears. This complaint does
> not appear when I run these tests against kernel v4.18. Could this be a
> regression?

Sounds like it is.  4.19 has the new ANA code, so the multipath code
has some churn.

> BUG: KASAN: use-after-free in srcu_invoke_callbacks+0x207/0x290

Can you resolve the address using gdb on vmlinux to a specific
line of code?
