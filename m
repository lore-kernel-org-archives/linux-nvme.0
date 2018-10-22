From: hch@lst.de (Christoph Hellwig)
Date: Mon, 22 Oct 2018 10:59:12 +0200
Subject: [PATCH RFC] nvmet: emulate noiob boundary
In-Reply-To: <20181019222437.25289-1-sagi@grimberg.me>
References: <20181019222437.25289-1-sagi@grimberg.me>
Message-ID: <20181022085912.GE18755@lst.de>

On Fri, Oct 19, 2018@03:24:37PM -0700, Sagi Grimberg wrote:
> Useful to exercise the host driver to noiob support without having device
> that actually require it.

This code looks ok to me, but I'm rather worried about adding these
just for fun features - we'll eventually have a configfs mess just
like the scsi target code if we just keep adding random options.
