From: keith.busch@intel.com (Keith Busch)
Date: Tue, 14 Jul 2015 19:25:53 +0000 (UTC)
Subject: Partitions and end-to-end protection
In-Reply-To: <yq11tgash12.fsf@sermon.lab.mkp.net>
References: <55A40881.5000108@ranbarg.com>
 <alpine.LNX.2.00.1507131909210.15930@localhost.lm.intel.com>
 <20150714180634.GB10203@infradead.org> <yq1a8uyshso.fsf@sermon.lab.mkp.net>
 <20150714184344.GA29437@infradead.org> <yq11tgash12.fsf@sermon.lab.mkp.net>
Message-ID: <alpine.LNX.2.00.1507141916210.15930@localhost.lm.intel.com>

On Tue, 14 Jul 2015, Martin K. Petersen wrote:
> But the fundamental question remains: Why is it a prerequisite for the
> NVMe integrity profile to be added before the disk is live? Nobody else
> requires this (sd, md, dm).

NVMe doesn't provide a way to disable transferring metadata
per-io. Capacity zero prevents IO when it's added because we don't have
a metadata buffer to assign CMD.MPTR. The drive will unconditionally
attempt DMA to/from MPTR, so it's potential memory and data corruption
if we let it happen.

An alternative to requiring blk integrity provide the metadata buffer,
we could have the driver allocate a large scratch buffer just so we have
something valid to set MPTR even. I didn't do that initially because we
can't use the metadata for anything at that point, and it seems odd to
have the driver implement this special case just to satisfy add_disk().
