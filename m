From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 4 Jan 2018 11:26:03 -0500
Subject: [for-4.16 PATCH v2 0/5] block, nvme, dm: allow DM multipath to
 use NVMe's error handler
In-Reply-To: <20180104102631.GA4864@lst.de>
References: <20171227032257.8182-1-snitzer@redhat.com>
 <20180102232943.GC26533@localhost.localdomain>
 <20180104102631.GA4864@lst.de>
Message-ID: <20180104162603.GA20081@redhat.com>

On Thu, Jan 04 2018 at  5:26am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Jan 02, 2018@04:29:43PM -0700, Keith Busch wrote:
> > Instead of hiding NVMe path related errors, the NVMe driver needs to
> > code an appropriate generic block status from an NVMe status.
> > 
> > We already do this translation whether or not CONFIG_NVME_MULTIPATHING is
> > set, so I think it's silly NVMe native multipathing has a second status
> > decoder. This just doubles the work if we need to handle any new NVMe
> > status codes in the future.
> > 
> > I have a counter-proposal below that unifies NVMe-to-block status
> > translations, and combines common code for determining if an error is a
> > path failure. This should work for both NVMe and DM, and DM won't need
> > NVMe specifics.
> > 
> > I can split this into a series if there's indication this is ok and
> > satisfies the need.
> 
> You'll need to update nvme_error_status to account for all errors
> handled in nvme_req_needs_failover

These weren't accounted for (I may have mis-categorized them in this
patch, so please feel free to correct):

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 25ef349fd4e4..835a9c60200e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -165,10 +165,18 @@ static blk_status_t nvme_error_status(struct request *req)
 	case NVME_SC_ACCESS_DENIED:
 	case NVME_SC_READ_ONLY:
 		return BLK_STS_MEDIUM;
+	case NVME_SC_INVALID_OPCODE:
+	case NVME_SC_INVALID_FIELD:
+	case NVME_SC_INVALID_NS:
+	case NVME_SC_LBA_RANGE:
+	case NVME_SC_CAP_EXCEEDED:
+	case NVME_SC_BAD_ATTRIBUTES:
+		return BLK_STS_TARGET;
 	case NVME_SC_GUARD_CHECK:
 	case NVME_SC_APPTAG_CHECK:
 	case NVME_SC_REFTAG_CHECK:
 	case NVME_SC_INVALID_PI:
+	case NVME_SC_COMPARE_FAILED:
 		return BLK_STS_PROTECTION;
 	case NVME_SC_RESERVATION_CONFLICT:
 		return BLK_STS_NEXUS;

And of those, these aren't currently used:

NVME_SC_LBA_RANGE
NVME_SC_CAP_EXCEEDED
NVME_SC_BAD_ATTRIBUTES
NVME_SC_COMPARE_FAILED

At least not that I can see.
