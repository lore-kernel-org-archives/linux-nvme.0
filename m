From: hch@lst.de (Christoph Hellwig)
Date: Thu, 25 Jan 2018 16:20:58 +0100
Subject: [PATCH] nvme: don't free uuid pointer before printing it
In-Reply-To: <20180125080925.6019-1-jthumshirn@suse.de>
References: <20180125080925.6019-1-jthumshirn@suse.de>
Message-ID: <20180125152058.GB1778@lst.de>

On Thu, Jan 25, 2018@09:09:25AM +0100, Johannes Thumshirn wrote:
> Commit df351ef73789 ("nvme-fabrics: fix memory leak when parsing host ID
> option") fixed the leak of 'p' but in case uuid_parse() fails the memory
> is freed before the error print that is using it.
> 
> Free it after printing eventual errors.

Thanks,

applied to nvme-4.16.
