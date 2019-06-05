From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Jun 2019 21:24:05 +0200
Subject: properly communicate queue limits to the DMA layer
In-Reply-To: <591cfa1e-fecb-7d00-c855-3b9eb8eb8a2a@kernel.dk>
References: <20190605190836.32354-1-hch@lst.de>
 <591cfa1e-fecb-7d00-c855-3b9eb8eb8a2a@kernel.dk>
Message-ID: <20190605192405.GA18243@lst.de>

On Wed, Jun 05, 2019@01:17:15PM -0600, Jens Axboe wrote:
> Since I'm heading out shortly and since I think this should make
> the next -rc, I'll tentatively queue this up.

The SCSI bits will need a bit more review, and possibly tweaking
fo megaraid and mpt3sas.  But they are really independent of the
other patches, so maybe skip them for now and leave them for Martin
to deal with.
