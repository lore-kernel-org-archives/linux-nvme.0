From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 26 Sep 2015 23:41:04 -0700
Subject: [PATCH 1/4] nvme: move driver into subdirectory
In-Reply-To: <1443317710.4357.25.camel@linux.intel.com>
References: <1443317710.4357.25.camel@linux.intel.com>
Message-ID: <20150927064104.GB18398@infradead.org>

So, why not drivers/nvme/host?  As said I'm not dead set on the host
name, but having a drivers/nvme sounds useful with all the additional
nvme-related code we're going to get soon.
