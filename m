From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Nov 2018 10:38:07 -0700
Subject: [PATCH 3/7] nvme: implement mq_ops->commit_rqs() hook
In-Reply-To: <64106f7d-73d9-70f3-7b28-9b836994d5aa@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-4-axboe@kernel.dk>
 <20181129154713.GC7234@infradead.org>
 <2188627d-6d45-fe8a-8d31-fa46fdb82618@kernel.dk>
 <20181129170430.GA27364@infradead.org>
 <64106f7d-73d9-70f3-7b28-9b836994d5aa@kernel.dk>
Message-ID: <20181129173806.GA9377@localhost.localdomain>

On Thu, Nov 29, 2018@10:06:20AM -0700, Jens Axboe wrote:
> On 11/29/18 10:04 AM, Christoph Hellwig wrote:
> > gcc never warns about unused static inline functions.  Which makes a lot
> > of sense at least for headers..
> 
> Not so much for non-headers :-)

You can #include .c files too! :)
