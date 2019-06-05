From: hch@lst.de (Christoph Hellwig)
Date: Wed,  5 Jun 2019 21:08:23 +0200
Subject: properly communicate queue limits to the DMA layer
Message-ID: <20190605190836.32354-1-hch@lst.de>

Hi Jens,

we've always had a bit of a problem communicating the block layer
queue limits to the DMA layer, which needs to respect them when
an IOMMU that could merge segments is used.  Unfortunately most
drivers don't get this right.  Oddly enough we've been mostly
getting away with it, although lately dma-debug has been catching
a few of those issues.

The segment merging fix for devices with PRP-like structures seems
to have escalated this a bit.  The first patch fixes the actual
report from Sebastian, while the rest fix every drivers that appears
to have the problem based on a code audit looking for drivers using
blk_queue_max_segment_size, blk_queue_segment_boundary or
blk_queue_virt_boundary and calling dma_map_sg eventually.  Note
that for SCSI drivers I've taken the blk_queue_virt_boundary setting
to the SCSI core, similar to how we did it for the other two settings
a while ago.  This also deals with the fact that the DMA layer
settings are on a per-device granularity, so the per-device settings
in a few SCSI drivers can't actually work in an IOMMU environment.

It would be nice to eventually pass these limits as arguments to
dma_map_sg, but that is a far too big series for the 5.2 merge
window.
