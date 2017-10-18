From: daniel.verkamp@intel.com (Verkamp, Daniel)
Date: Wed, 18 Oct 2017 23:52:04 +0000
Subject: NVMe target log page offset not supported
Message-ID: <A5F28D4A728A7E41839CDC5C3B5A01E887295CEF@FMSMSX103.amr.corp.intel.com>

Hello,

It looks like the Linux NVMe over Fabrics target Get Log Page implementation is missing support for the Log Page Offset field, which is part of the optional "extended data for Get Log Page" feature.

Of the two Get Log Page implementations, in drivers/nvme/target/{admin-cmd.c,discovery.c}, both advertise support for extended data for Get Log Page in the Identify Controller LPA field (bit 2), but neither looks at the offset field (CDW12 and CDW13, named LPOL and LPOU in the spec).

In theory, it is tempting to just stop advertising the extended log page feature, but reading between the lines in the NVMe-oF 1.0 spec, it seems like this might be intended to be a required feature for at least discovery controllers (e.g. the Discovery Log Page section says "The Log Page Offset is used (if needed) to retrieve specific records").  Maybe the feature should be temporarily disabled anyway until the offset is correctly implemented?

It also looks like the discovery.c Get Log Page implementation has some funny ideas about the meaning of the log page length (Number of Dwords field).  A request with a length that doesn't fully cover a discovery log entry will not return the partial data as requested but will instead stop at the last full entry and skip the entire final partial entry, leaving it as zeroes.  To be fair, as is usual with NVMe, the spec doesn't actually say what to do in this situation (it only defines expected behavior when the user requests more than the total length of the log page), but it seems like the right thing to do would be to return exactly the [offset, offset + length) bytes of the log page, even if that range overlaps the beginning/end of a discovery entry (or the header, which can happen once offset is implemented).

Unfortunately, I don't have time right now to write and thoroughly test a patch for this, so I thought I'd at least make it known.  It's on my todo list...

Thanks,
-- Daniel
