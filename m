From: hch@lst.de (Christoph Hellwig)
Date: Wed,  8 Jun 2016 14:30:55 +0200
Subject: NVMe over Fabrics: updates for req_op changes and misc fixes
Message-ID: <1465389066-19119-1-git-send-email-hch@lst.de>

Thanks Jens for pulling in the req_op changes from Mike!

This will require a few minor changes for the NVMe over Fabrics code, so
I've rebase the git tree on top of it, and merged all changes from review
and testing.  Below are the incremental changes vs the previous version,
which I plan to fold in before resending.  Nothing of this touches the
patches in the "general preparation for NVMe over Fabrics support" series,
which would be good to get in ASAP.

Also available as a git tree at:

	git://git.infradead.org/nvme-fabrics.git nvmf-all.2

Gitweb:

	http://git.infradead.org/nvme-fabrics.git/shortlog/refs/heads/nvmf-all.2
