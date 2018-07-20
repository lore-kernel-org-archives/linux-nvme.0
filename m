From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 20 Jul 2018 07:41:46 -0700
Subject: [PATCH 2/2] scsi: set timed out out mq requests to complete
In-Reply-To: <20180719212618.2406-2-keith.busch@intel.com>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
Message-ID: <20180720144146.GA22454@infradead.org>

Has this been tested?  Especially with the blk_abort_request corner
case?
