From: phil.cayton@intel.com (Cayton, Phil)
Date: Mon, 28 Sep 2015 16:06:13 +0000
Subject: [PATCH 1/4] nvme: move driver into subdirectory
In-Reply-To: <1443455894.2826.2.camel@linux.intel.com>
References: <1443317710.4357.25.camel@linux.intel.com>
 <20150927064104.GB18398@infradead.org>
 <1443455894.2826.2.camel@linux.intel.com>
Message-ID: <14D8B1FAF8567C4FBE58AB68AB695A9D9B8498D7@ORSMSX115.amr.corp.intel.com>



> So, why not drivers/nvme/host?  As said I'm not dead set on the host 
> name, but having a drivers/nvme sounds useful with all the additional 
> nvme-related code we're going to get soon.

Two questions:
1. Since this is the block driver for NVMe why would we not put this under block (e.g., drivers/block/nvme)
2. Are we assuming any target code will go in this path as well?  Why would not any target code go under drivers/target?
