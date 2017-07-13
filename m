From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Jul 2017 10:59:51 +0300
Subject: [RFC] nvme: Fabrics should use the fctype field for data direction
In-Reply-To: <20170713072755.GA12984@lst.de>
References: <20170712165819.5326-1-jonathan.derrick@intel.com>
 <20170713072755.GA12984@lst.de>
Message-ID: <06c2b112-cca5-9a15-4c5a-3d013a23be23@grimberg.me>

> Interesting.  I wonder how things ever worked without this..
> 
> But the Fabrics multiplexer is a bidi command, so nvme_is_write
> will always return true currently.
> 
> On the host side it only matters for the passthrough ioctls,
> which no one uses for the fabrics commands.
> 
> On the target side this means we always try to copy data in and
> never out, strange.

There is no data-out in any of the fabrics commands.
