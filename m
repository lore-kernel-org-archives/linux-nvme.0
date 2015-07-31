From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 31 Jul 2015 00:19:35 -0700
Subject: SGL support of driver
In-Reply-To: <20150730183828.GY13681@linux.intel.com>
References: <CAB7xdimg82dhfMY5mVAfZZ5=Ub-Dz5N+x1gQ5QWg7qPwb5fsXA@mail.gmail.com>
 <20150727163123.GA5034@infradead.org>
 <alpine.LNX.2.00.1507271636430.15930@localhost.lm.intel.com>
 <20150727165756.GA8847@infradead.org>
 <20150728143500.GX13681@linux.intel.com>
 <20150729075557.GA11755@infradead.org>
 <20150730183828.GY13681@linux.intel.com>
Message-ID: <20150731071935.GA20609@infradead.org>

On Thu, Jul 30, 2015@02:38:28PM -0400, Matthew Wilcox wrote:
> I'm not really interested in optimising for badly configured RAID setups :-)
> 
> But point taken, RAID (and other things) can mess with I/Os between the
> page cache and the driver.

With blocksize < pagesize you can also get other non-aligned I/O,
although rately in a way where you could fit multiple of these into a
SGL.
