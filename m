From: hch@lst.de (Christoph Hellwig)
Date: Fri, 11 Dec 2015 21:06:53 +0100
Subject: [PATCH] nvme: Allow controllers to specify a min queue depth
 for CMB
In-Reply-To: <1449862594-26103-1-git-send-email-jonathan.derrick@intel.com>
References: <1449862594-26103-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20151211200653.GA26595@lst.de>

Hi Jon,

this patch confuses me for ? few reasons:

 - please don't overload the quirks bitmap with actual values
 - why do we even need to set a size instead of using up the CMB
   size?
 - why do we even need to add a quirk?  I quick look at the spec
   doesn't seem to require us to align the submission queue size
 - this patchs adds a quirk, but no use of it so it's effectively just dead
   code
