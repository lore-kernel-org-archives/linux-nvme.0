From: hch@lst.de (Christoph Hellwig)
Date: Thu, 26 Jul 2018 11:24:31 +0200
Subject: [PATCH 1/2] nvme-cli: add minimal ana-log page support
In-Reply-To: <20180725144848.GC14596@localhost.localdomain>
References: <20180725001316.2714-1-chaitanya.kulkarni@wdc.com>
 <20180725045352.GA10905@lst.de>
 <20180725144848.GC14596@localhost.localdomain>
Message-ID: <20180726092431.GD24335@lst.de>

On Wed, Jul 25, 2018@08:48:48AM -0600, Keith Busch wrote:
> Adding the RAE option for user space tooling is a good idea. Defaulting to
> on should be safe too (will confirm on older drives),

Is it?  Strictly speaking the bit is reserved for drivers < 1.3, so they
could reject it, even if I doubt anyone does.

> but does re-arming
> the AEN really create a problem for ANA? I thought the log page problem
> was when reading a page changes the result of the next read, but that
> only applies to very few logs.

Yes, for ANA we should be fine.  The only real problem was the changed
namespace log, and we stopped relying on that.
