From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Feb 2017 09:24:26 +0100
Subject: [PATCH] nvmet: Do not check for sg_cnt being zero for
 read/write commands.
In-Reply-To: <1486510557-26831-1-git-send-email-parav@mellanox.com>
References: <1486510557-26831-1-git-send-email-parav@mellanox.com>
Message-ID: <20170208082426.GA7629@lst.de>

On Tue, Feb 07, 2017@05:35:57PM -0600, Parav Pandit wrote:
> sg_cnt cannot be zero for inline or sge mode from the fabric drivers
> because nvme read/write commands have minimum of one block to be
> read or written. (nlb dw12 is 0 based value).
> So sg_cnt check for 0 is not useful.

Except that we currently don't verify the data transfer in the SGL
matches that in the command.  It's been on my todo list for a while,
so maybe you can take it off my plate first before we'll aply this
patch.
