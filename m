From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Jun 2017 10:37:14 +0200
Subject: [PATCH v4 8/8] nvmet: use NVME_IDENTIFY_DATA_SIZE
In-Reply-To: <20170604103649.22130-9-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-9-jthumshirn@suse.de>
Message-ID: <20170605083714.GA22677@lst.de>

On Sun, Jun 04, 2017@12:36:49PM +0200, Johannes Thumshirn wrote:
> Use NVME_IDENTIFY_DATA_SIZE define instead of hard coding the magic
> 4096 value.

Can you bump this to the front of the series?
