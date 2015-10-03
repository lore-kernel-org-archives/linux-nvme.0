From: hch@lst.de (Christoph Hellwig)
Date: Sat, 3 Oct 2015 12:01:59 +0200
Subject: [PATCH 1/7] nvme: delete dev from dev_list in nvme_reset
In-Reply-To: <alpine.LNX.2.00.1510022041060.23840@localhost.lm.intel.com>
References: <1443808699-4738-1-git-send-email-hch@lst.de>
 <1443808699-4738-2-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1510022041060.23840@localhost.lm.intel.com>
Message-ID: <20151003100159.GA851@lst.de>

On Fri, Oct 02, 2015@09:13:22PM +0000, Keith Busch wrote:
> A moment of panic when I saw this, but we're 'ok'. The reset handler calls
> nvme_dev_shutdown() first, and that removes the device from the list,
> so we won't really see a controller twice added in the list.

Oh.  So we get a double list del there.  I though list debuging would
complain about this.  Anyway, let's make the deletion uniform and so that
any fixes can be applied to all callers in the same way.
