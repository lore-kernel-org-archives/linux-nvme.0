From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 5 Apr 2016 05:38:32 -0700
Subject: [PATCH 0/2] Block: Give option to force io polling
In-Reply-To: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20160405123832.GA27788@infradead.org>

On Thu, Mar 31, 2016@02:19:12PM -0600, Jon Derrick wrote:
> In 4.6, enabling io polling in direct-io was switched to a per-io flag.
> This had an unintended result of giving a significant difference when
> doing benchmarks between 4.5 and 4.6, using fio's sync engine.

Only if you manually enabled polling beforehand.  I really don't see
how this is going to be useful for actual applications vs benchmarks,
so I'll need more convincing arguments.
