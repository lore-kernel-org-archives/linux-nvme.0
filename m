From: hch@lst.de (Christoph Hellwig)
Date: Tue, 14 Jun 2016 16:52:43 +0200
Subject: [RFC-v2 00/11] nvmet: Add support for multi-tenant configfs
In-Reply-To: <1465878946-26556-1-git-send-email-nab@linux-iscsi.org>
References: <1465878946-26556-1-git-send-email-nab@linux-iscsi.org>
Message-ID: <20160614145243.GA29949@lst.de>

On Tue, Jun 14, 2016@04:35:35AM +0000, Nicholas A. Bellinger wrote:
> Comments..?

Still no good reason for doing anything like this.

On a conceptual level:

The NVMe target is front end implementing a simple protocol to export
block devices to a remove host.  The SCSI target is larger front end to
expose a more complex protocol to remote hosts.  None of them should
actually implement any real protocol independent behavior, and except for
persistent reservations in the SCSI neither of them does.

On a practical level it means we drag in over 25.000 lines of code
as a dependency, without actually dropping any code in the nvmet module,
and vastly more complicated object hierarchies that don't make any
sense for the tight-knit NVMe standard.  We'd also get dragged into
into the nightmare of diverging an incompatible user space tooling,
and we'd lose all the test coverage we've built up.  We'd also have
to deal with tons of tunables that neither fit the protocol we
implement nor the philosophy of the project.
