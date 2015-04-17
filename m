From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 16 Apr 2015 23:33:51 -0700
Subject: uapi/linux/nvme.h
In-Reply-To: <1429223704.2691.17.camel@jpfreyen-mobl5.amr.corp.intel.com>
References: <20150415061142.GA14354@infradead.org>
 <alpine.LNX.2.00.1504151412380.32385@localhost.lm.intel.com>
 <20150415142535.GA29983@infradead.org>
 <1429223704.2691.17.camel@jpfreyen-mobl5.amr.corp.intel.com>
Message-ID: <20150417063351.GA389@infradead.org>

On Thu, Apr 16, 2015@03:35:04PM -0700, J Freyensee wrote:
> There is an NVMe test compliance suite developed at www.iol.unh.edu (U
> of New Hampshire that has hosted NVMe plugfests), that will probably be
> one of the first things to check to see if changes in here break.  I
> have no experience with this test suite; I just know it exists.

Do you mena this one: https://github.com/nvmecompliance/tnvme/

It doesn't seem to use our nvme.h heaer for anything.  In fact it seems
to use totally non-standard ioctls not provided by the in-kernel nvme
driver.
