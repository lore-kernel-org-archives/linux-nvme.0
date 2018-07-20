From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 20 Jul 2018 07:46:28 -0700
Subject: [RFC PATCH 0/2] Re-work CMB and add WDS support.
In-Reply-To: <20180719230628.31494-1-scott.bauer@intel.com>
References: <20180719230628.31494-1-scott.bauer@intel.com>
Message-ID: <20180720144628.GA29886@infradead.org>

On Thu, Jul 19, 2018@05:06:26PM -0600, Scott Bauer wrote:
> The second patch unfortunately bounces (memcpys) the data from host to CMB.
> I originally tried to map the CMB into userspace via a custom nvme mmap
> handler, but I'm dumb and could never get gup for direct io working correctly.

Why?
