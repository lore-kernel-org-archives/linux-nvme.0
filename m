From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 28 Sep 2015 10:26:29 -0700
Subject: [PATCH 1/4] nvme: move driver into subdirectory
In-Reply-To: <14D8B1FAF8567C4FBE58AB68AB695A9D9B8498D7@ORSMSX115.amr.corp.intel.com>
References: <1443317710.4357.25.camel@linux.intel.com>
 <20150927064104.GB18398@infradead.org>
 <1443455894.2826.2.camel@linux.intel.com>
 <14D8B1FAF8567C4FBE58AB68AB695A9D9B8498D7@ORSMSX115.amr.corp.intel.com>
Message-ID: <20150928172629.GA26554@infradead.org>

Hi Phil,

On Mon, Sep 28, 2015@04:06:13PM +0000, Cayton, Phil wrote:
> Two questions:
> 1. Since this is the block driver for NVMe why would we not put this under block (e.g., drivers/block/nvme)

Because we mostly use that for simple block drivers.  Everything that
is growing into a complex subsystems moves out, e.g. drivers/scsi,
drivers/cdrom/, drivers/memstick, drivers/mmc, etc.

> 2. Are we assuming any target code will go in this path as well?  Why would not any target code go under drivers/target?

drivers/target is a SCSI target and a totally different codebase. In
retrospective it really should have been drivers/scsi/target.
