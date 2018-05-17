From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 May 2018 00:16:51 -0700
Subject: [PATCH] nvme: handle completions outside of the queue lock
In-Reply-To: <20180517034750.GA22063@localhost.localdomain>
References: <da619fe4-a9ea-57e9-a731-e59a9043970e@kernel.dk>
 <20180517034750.GA22063@localhost.localdomain>
Message-ID: <20180517071651.GC30079@infradead.org>

On Wed, May 16, 2018@09:47:50PM -0600, Keith Busch wrote:
> Looks good to me. Queued up for 4.18 with just a minor changelog
> update.

Folks, can we please at least wait a night to give other ins a
different time zone to review?  In fact for things not entirely critical
and non-trivial a few days would be good.
