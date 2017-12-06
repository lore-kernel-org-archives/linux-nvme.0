From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Dec 2017 23:47:46 +0100
Subject: [PATCH rfc 1/2] nvme: support smart read-only critical warning
 event
In-Reply-To: <0c6a853d-c8c5-2144-09e1-8e6cae90fb2a@grimberg.me>
References: <20171204092435.20000-1-sagi@grimberg.me>
 <20171204092435.20000-2-sagi@grimberg.me> <20171204200721.GB17023@lst.de>
 <0c6a853d-c8c5-2144-09e1-8e6cae90fb2a@grimberg.me>
Message-ID: <20171206224746.GC14274@lst.de>

On Tue, Dec 05, 2017@09:28:53AM +0200, Sagi Grimberg wrote:
> 2. handle the event in the kernel, issue the log page with retain bit on
> and only then notify userspace.

The retain bit is a new optional feature in nvme 1.3.  I fear we
won't see all that many controllers respecting it.
