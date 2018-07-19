From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 19 Jul 2018 17:06:26 -0600
Subject: [RFC PATCH 0/2] Re-work CMB and add WDS support.
Message-ID: <20180719230628.31494-1-scott.bauer@intel.com>

The first patch adds CMB into a generic pool, from there we'll allocate
from the pool for the submission queues. In the future we can allocate SGLs
and PRPs from the pool as well.

The second patch unfortunately bounces (memcpys) the data from host to CMB.
I originally tried to map the CMB into userspace via a custom nvme mmap
handler, but I'm dumb and could never get gup for direct io working correctly.
