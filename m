From: hch@lst.de (Christoph Hellwig)
Date: Fri, 10 Nov 2017 12:13:57 +0100
Subject: [PATCH 1/2] nvme: add Kconfig option 'NVME_MULTIPATH_DEFAULT'
In-Reply-To: <1510307903-3346-2-git-send-email-hare@suse.de>
References: <1510307903-3346-1-git-send-email-hare@suse.de>
 <1510307903-3346-2-git-send-email-hare@suse.de>
Message-ID: <20171110111357.GA7837@lst.de>

On Fri, Nov 10, 2017@10:58:22AM +0100, Hannes Reinecke wrote:
> Add a configuration option to enable or disable NVMe multipath
> per default.

NAK.  If you really want a local override please keep this as a local
patch.
