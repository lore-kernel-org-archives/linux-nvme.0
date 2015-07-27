From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 27 Jul 2015 09:57:56 -0700
Subject: SGL support of driver
In-Reply-To: <alpine.LNX.2.00.1507271636430.15930@localhost.lm.intel.com>
References: <CAB7xdimg82dhfMY5mVAfZZ5=Ub-Dz5N+x1gQ5QWg7qPwb5fsXA@mail.gmail.com>
 <20150727163123.GA5034@infradead.org>
 <alpine.LNX.2.00.1507271636430.15930@localhost.lm.intel.com>
Message-ID: <20150727165756.GA8847@infradead.org>

On Mon, Jul 27, 2015@04:50:25PM +0000, Keith Busch wrote:
> The Linux driver never recieves an IO vector that requires double
> buffering though, and usually not physically contiguous. I'm not sure
> there is a case to support SGL in the linux-nvme driver. Maybe if it's
> tied to block integrity extensions with interleaved metadata formats,
> but it'd be odd to find a device that implements SGL but not separate
> metadata.

That's because it asks never to get one..

vectored direct I/O is a case where NVMe currently has to split
while most other block devices can handle it in a single I/O.  For
some database workloads this does make a significant difference, and
it's even more interesting for providing atomicy to userspace using
a future O_ATOMIC.

It also requires pagecache I/O to be split into multiple commands
where other block devices can handle it a lot more efficiently.
