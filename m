From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 18 Jun 2014 11:45:32 -0400
Subject: [PATCH] NVMe: Fail SCSI->NVMe translation for UNMAP when anchor
 is set
In-Reply-To: <alpine.WNT.2.00.1406180929430.12984@DMCLERAN-DESK.amr.corp.intel.com>
References: <1403082188-4852-1-git-send-email-daniel.mcleran@intel.com>
 <alpine.LRH.2.03.1406180908390.4699@AMR>
 <20140618152708.GH12025@linux.intel.com>
 <alpine.WNT.2.00.1406180929430.12984@DMCLERAN-DESK.amr.corp.intel.com>
Message-ID: <20140618154532.GI12025@linux.intel.com>

On Wed, Jun 18, 2014@09:30:24AM -0600, Dan McLeran wrote:
> Good point. So, is Anchor == 1 still illegal for non-resource-provisioned
> devices? The spec seems to imply that must be the case.

The current revision of the spec seems contradictory.  On the one hand,
it says that ANC_SUP shall be set to 0.  SBC says you're not allowed to
set the ANCHOR bit if ANC_SUP is 0.  And then the NVMe-SCSI spec says that
you can set ANCHOR if the underlying namespace is "resource provisioned"
which isn't something that actually exists in NVMe.

Since there's no way to actually pass the ANCHOR bit through, and we
always set ANC_SUP to 0, I think we should go with your original patch,
failing the command if ANCHOR is set.
