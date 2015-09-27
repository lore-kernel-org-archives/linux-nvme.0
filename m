From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 27 Sep 2015 10:14:36 +0300
Subject: [PATCH 1/4] nvme: move driver into subdirectory
In-Reply-To: <20150927064104.GB18398@infradead.org>
References: <1443317710.4357.25.camel@linux.intel.com>
 <20150927064104.GB18398@infradead.org>
Message-ID: <5607975C.9000409@dev.mellanox.co.il>

On 9/27/2015 9:41 AM, Christoph Hellwig wrote:
> So, why not drivers/nvme/host?  As said I'm not dead set on the host
> name, but having a drivers/nvme sounds useful with all the additional
> nvme-related code we're going to get soon.

I agree. It would be useful when we add a SW controller.
