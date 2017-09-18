From: hch@lst.de (Christoph Hellwig)
Date: Mon, 18 Sep 2017 17:49:39 +0200
Subject: [PATCH v2] fs: pass the write life time hint to the mapped
 filesystem
In-Reply-To: <2f7829a5-d47b-e6a0-cc10-8b534e9772ab@moysys.com>
References: <2f7829a5-d47b-e6a0-cc10-8b534e9772ab@moysys.com>
Message-ID: <20170918154939.GA13431@lst.de>

On Mon, Sep 18, 2017@09:45:57AM -0600, Michael Moy wrote:
> The write hint needs to be copied to the mapped filesystem
> so it can be passed down to the nvme device driver.
>
> v2: fix tabs in the email

If you want the write hint for buffered I/O you need to set it on the
inode using F_SET_RW_HINT.

With your patch we'd magically move the file hint to the inode hint
on each write.
