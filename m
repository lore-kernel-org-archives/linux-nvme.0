From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 20 Jul 2018 08:50:12 -0600
Subject: [PATCH 2/2] scsi: set timed out out mq requests to complete
In-Reply-To: <20180720144146.GA22454@infradead.org>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
 <20180720144146.GA22454@infradead.org>
Message-ID: <20180720145011.GD4093@localhost.localdomain>

On Fri, Jul 20, 2018@07:41:46AM -0700, Christoph Hellwig wrote:
> Has this been tested?  Especially with the blk_abort_request corner
> case?

Yes, that's what Jianchao's modification to scsi_debug used.
