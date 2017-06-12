From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 12 Jun 2017 09:07:53 -0700
Subject: [PATCH] nvmet-fc: Remove a set-but-not-used variable
In-Reply-To: <20170608164329.20304-1-bart.vanassche@wdc.com>
References: <20170608164329.20304-1-bart.vanassche@wdc.com>
Message-ID: <20170612160753.GA16226@infradead.org>

On Thu, Jun 08, 2017@09:43:29AM -0700, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche at sandisk.com>
> 
> This was detected by building the nvmet-fc driver with W=1.

Thanks Bart, applied to the nvme-4.13 branch.
