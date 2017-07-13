From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Jul 2017 09:27:55 +0200
Subject: [RFC] nvme: Fabrics should use the fctype field for data direction
In-Reply-To: <20170712165819.5326-1-jonathan.derrick@intel.com>
References: <20170712165819.5326-1-jonathan.derrick@intel.com>
Message-ID: <20170713072755.GA12984@lst.de>

Interesting.  I wonder how things ever worked without this..

But the Fabrics multiplexer is a bidi command, so nvme_is_write
will always return true currently.

On the host side it only matters for the passthrough ioctls,
which no one uses for the fabrics commands.

On the target side this means we always try to copy data in and
never out, strange.

So this looks good to me, but it'll need a little test run.  As Sagi
said the loop driver is trivial to test, but one of us should also
run it though rdma testing.
