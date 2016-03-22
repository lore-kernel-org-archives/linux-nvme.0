From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 22 Mar 2016 00:45:31 -0700
Subject: guaranteed progress for NVME commands?
Message-ID: <20160322074531.GA32289@infradead.org>

Hi All,

in SCSI and other block drivers we go through great pains to only
use mempool backed allocations in the I/O path, so that we can make
guaranteed progress for swap or the writeback daemons.  But it seems
like the NVMe driver is using plain kmalloc everywhere and seems to
be getting away with that just for now.  Is no one using swap on
NVMe or am I missing a secret trick somewhere?
