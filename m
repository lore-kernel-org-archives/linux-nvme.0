From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Dec 2017 23:46:50 +0100
Subject: [PATCH rfc 2/2] nvmet: expose option to emulate a nvm
 subsystem in read-only mode
In-Reply-To: <8abf14b8-53a0-c39d-e17e-99bd7840b7a7@grimberg.me>
References: <20171204092435.20000-1-sagi@grimberg.me>
 <20171204092435.20000-3-sagi@grimberg.me> <20171204161930.GA12277@lst.de>
 <c3d78077-b5b0-c05e-fca1-ca9ef5a0e1eb@grimberg.me>
 <20171204200653.GA17023@lst.de>
 <8abf14b8-53a0-c39d-e17e-99bd7840b7a7@grimberg.me>
Message-ID: <20171206224650.GB14274@lst.de>

On Tue, Dec 05, 2017@09:22:05AM +0200, Sagi Grimberg wrote:
> Just to be clear, that is exactly what I intended to do.

My point is that we should not have a configfs nob to turn
on the r/o nob, but do it based on an error from the lower
block device.
