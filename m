From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 25 May 2018 08:50:09 -0600
Subject: [PATCH] Fix controller reset return
In-Reply-To: <20180525091056.GD11309@infradead.org>
References: <20180511162501.7258-1-keith.busch@intel.com>
 <20180525091056.GD11309@infradead.org>
Message-ID: <20180525145009.GR11037@localhost.localdomain>

On Fri, May 25, 2018@02:10:56AM -0700, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-4.18-2

I'd included this one in an earlier 4.17 pull request. The regression
caused some major problems in test automation, and the fix was trivial.
