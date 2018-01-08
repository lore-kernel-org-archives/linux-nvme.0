From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Jan 2018 16:34:36 +0100
Subject: [PATCH 1/5] nvme: Add more command status translation
In-Reply-To: <20180108152933.GA9920@redhat.com>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-2-keith.busch@intel.com> <20180108095512.GC4673@lst.de>
 <2beb72a9-8502-fec8-8892-208cbb0967ac@suse.com>
 <20180108101937.GA5423@lst.de> <20180108152933.GA9920@redhat.com>
Message-ID: <20180108153436.GA11632@lst.de>

On Mon, Jan 08, 2018@10:29:33AM -0500, Mike Snitzer wrote:
> No argument needed.  Definitely needs fixing.  Too many upper layers
> consider BLK_STS_NOSPC retryable (XFS, ext4, dm-thinp, etc).  Which
> NVME_SC_LBA_RANGE absolutely isn't.
> 
> When I backfilled NVME_SC_LBA_RANGE handling I categorized it as
> BLK_STS_TARGET.  Do you have a better suggestion for how
> NVME_SC_LBA_RANGE should be categorized?

It's basically a kernel bug as it tries to access lbas that do not
exist.  BLK_STS_TARGET should be fine.
