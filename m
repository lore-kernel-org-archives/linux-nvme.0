From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 Jan 2019 16:58:34 +0100
Subject: [PATCH] nvme: Block ns inventory changes during admin
In-Reply-To: <20190128153344.GA15271@localhost.localdomain>
References: <20190125194819.11476-1-keith.busch@intel.com>
 <20190128073924.GB3287@lst.de> <20190128153344.GA15271@localhost.localdomain>
Message-ID: <20190128155834.GA11346@lst.de>

On Mon, Jan 28, 2019@08:33:45AM -0700, Keith Busch wrote:
> This was reported internally from Wen. If you prefer, we can open a
> public bz sighting and append the kernel logs for a changelog Link:.

I don't really need a bugzilla, but I'd like to understand the reported
problem a little better.
