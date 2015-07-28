From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 28 Jul 2015 10:35:00 -0400
Subject: SGL support of driver
In-Reply-To: <20150727165756.GA8847@infradead.org>
References: <CAB7xdimg82dhfMY5mVAfZZ5=Ub-Dz5N+x1gQ5QWg7qPwb5fsXA@mail.gmail.com>
 <20150727163123.GA5034@infradead.org>
 <alpine.LNX.2.00.1507271636430.15930@localhost.lm.intel.com>
 <20150727165756.GA8847@infradead.org>
Message-ID: <20150728143500.GX13681@linux.intel.com>

On Mon, Jul 27, 2015@09:57:56AM -0700, Christoph Hellwig wrote:
> It also requires pagecache I/O to be split into multiple commands
> where other block devices can handle it a lot more efficiently.

Wait, what?  pagecache I/O is page aligned and page sized.  That can
always be represented by a PRP list.
