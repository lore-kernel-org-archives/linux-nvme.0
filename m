From: keith.busch@intel.com (Keith Busch)
Date: Tue, 7 Jun 2016 14:42:48 -0400
Subject: NVMe over Fabrics support for nvme-cli
In-Reply-To: <1465312767-10070-1-git-send-email-hch@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
Message-ID: <20160607184248.GE28414@localhost.localdomain>

On Tue, Jun 07, 2016@05:19:16PM +0200, Christoph Hellwig wrote:
> Hi Keith,
> 
> the series below adds support for the discovery, connect, connect-all and
> disconnect commands to nvme-cli, which are useful to support the NVMe over
> Fabrics host code.  Most of the work is from Ming with various bits and
> pieces from me.  I also did the final rebase to the latest master tree.

Thanks, applied.

Happy to get fabrics in now as I have new features I'd like to add very
soon, and didn't want you to have to rebase again. The new features are
vendor extentions and json output. I'll post them to the linux-nvme list
first in case anyone is interested in reviewing.
