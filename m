From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Wed, 3 May 2017 15:58:17 +0000
Subject: [PATCH v4, under testing] nvme-rdma: support devices with queue
 size < 32
In-Reply-To: <20170503155316.GA14334@obsidianresearch.com>
References: <79901165.5342369.1493805915415.JavaMail.zimbra@kalray.eu>
 <823aa3f0-685f-4569-11d6-238cc4f0b126@grimberg.me>
 <780938034.8003164.1493824767084.JavaMail.zimbra@kalray.eu>
 <20170503155316.GA14334@obsidianresearch.com>
Message-ID: <1493827096.3901.4.camel@sandisk.com>

On Wed, 2017-05-03@09:53 -0600, Jason Gunthorpe wrote:
> On Wed, May 03, 2017@05:19:27PM +0200, Marta Rybczynska wrote:
> 
> > > where
> > > 	queue->sig_limit = max(queue->queue_size / 2, 1);
> > 
> > I tried to avoid that because this adds a division in the fast path Bart
> > was unhappy about in v2.
> 
> The compiler switches divide/multiply by powers of two into fast bit shifts.

Hello Jason,

As far as I know the compiler only does that for compile-time constants. In
this case the divisor (max(queue_size / 2, 1)) is not a compile-time constant.

Bart.
