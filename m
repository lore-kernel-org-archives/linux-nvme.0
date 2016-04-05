From: keith.busch@intel.com (Keith Busch)
Date: Tue, 5 Apr 2016 15:54:54 +0000
Subject: [PATCH 0/2] Block: Give option to force io polling
In-Reply-To: <20160405123832.GA27788@infradead.org>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <20160405123832.GA27788@infradead.org>
Message-ID: <20160405155453.GB12625@localhost.localdomain>

On Tue, Apr 05, 2016@05:38:32AM -0700, Christoph Hellwig wrote:
> On Thu, Mar 31, 2016@02:19:12PM -0600, Jon Derrick wrote:
> > In 4.6, enabling io polling in direct-io was switched to a per-io flag.
> > This had an unintended result of giving a significant difference when
> > doing benchmarks between 4.5 and 4.6, using fio's sync engine.
> 
> Only if you manually enabled polling beforehand.  I really don't see
> how this is going to be useful for actual applications vs benchmarks,
> so I'll need more convincing arguments.

I think it's more about providing opt-in control to make the low-latency
benefit reachable to users with existing programs.
