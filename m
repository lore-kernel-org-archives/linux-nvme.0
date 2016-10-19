From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 19 Oct 2016 09:53:18 -0700
Subject: nvme header updates
In-Reply-To: <1475236270-18329-1-git-send-email-hch@lst.de>
References: <1475236270-18329-1-git-send-email-hch@lst.de>
Message-ID: <20161019165318.GA28931@infradead.org>

On Fri, Sep 30, 2016@01:51:05PM +0200, Christoph Hellwig wrote:
> This series resyncs nvme.h to that it can be reused by nvme-cli, and
> while at that brings over another enums so far only used in nvme-cli.

Jens, is this something still doable for 4.9?  It would help us to keep
nvme.h in sync with nvme-cli.
