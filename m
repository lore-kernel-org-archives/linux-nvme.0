From: keith.busch@intel.com (Keith Busch)
Date: Fri, 18 Mar 2016 16:56:16 +0000
Subject: [PATCH] NVMe Add Support for Solid State Media Log Page
In-Reply-To: <BL2PR04MB16375598B6306A175B683CD928C0@BL2PR04MB163.namprd04.prod.outlook.com>
References: <BL2PR04MB16375598B6306A175B683CD928C0@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <20160318165616.GC13054@localhost.localdomain>

On Fri, Mar 18, 2016@03:43:29PM +0000, Jeff Lien wrote:
> 
> Attached the subject matter patch for review.  

The translation itself looks fine, but are we applying new SCSI
translations upstream anymore? The entire component is disabled by
default, I believe with the intention of removing it in the future.
