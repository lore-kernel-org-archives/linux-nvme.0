From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 7 Jun 2018 08:29:04 -0600
Subject: [PATCH 6/6] nvme-pci: Make CMB SQ mod-param read-only
In-Reply-To: <20180607071958.g5qlkslgajo7ysfl@linux-x5ow.site>
References: <20180606141309.19389-1-keith.busch@intel.com>
 <20180606141309.19389-7-keith.busch@intel.com>
 <20180607071958.g5qlkslgajo7ysfl@linux-x5ow.site>
Message-ID: <20180607142904.GC19462@localhost.localdomain>

On Thu, Jun 07, 2018@09:19:58AM +0200, Johannes Thumshirn wrote:
> This could evnet be a stable candidate, couldn't it?

Yep, I intend to combine this with a back-port of 815c6704bf9f1
("nvme-pci: Remap CMB SQ entries on every controller reset") for stable.
