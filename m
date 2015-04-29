From: keith.busch@intel.com (Keith Busch)
Date: Wed, 29 Apr 2015 14:44:19 +0000 (UTC)
Subject: Hot-remove of a device with a mounted partition
In-Reply-To: <006f01d08274$d31e7430$795b5c90$@samsung.com>
References: <006f01d08274$d31e7430$795b5c90$@samsung.com>
Message-ID: <alpine.LNX.2.00.1504291435050.15930@localhost.lm.intel.com>

On Wed, 29 Apr 2015, Sunad Bhandary wrote:
> 1) When the device is removed , sometimes(around 4-5 out of 10 times) the
> removal process hangs. The device nodes are still present under /dev. It
> seems like call to del_gendisk  function is hung and not returning.

Looks like it's stuck entrying a frozen queue. I'm not sure why it ever
succeeds in your test. :)

Thanks for the catch. We'll have to figure out some way to coordinate
this with blk-mq so its safe in all scenarios.
