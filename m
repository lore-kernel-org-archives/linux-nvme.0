From: snitzer@redhat.com (Mike Snitzer)
Date: Tue, 4 Aug 2015 13:53:49 -0400
Subject: Persistent Reservation API
In-Reply-To: <1438672271-11309-1-git-send-email-hch@lst.de>
References: <1438672271-11309-1-git-send-email-hch@lst.de>
Message-ID: <20150804175349.GA29013@redhat.com>

On Tue, Aug 04 2015 at  3:11am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> This series adds support for a simplified persistent reservation API
> to the block layer.  The intent is that both in-kernel and userspace
> consumers can use the API instead of having to hand craft SCSI or NVMe
> command through the various pass through interfaces.  It also adds
> DM support as getting reservations through dm-multipath is a major
> pain with the current scheme.

The DM changes need to go through linux-dm.git.  Once the block and SCSI
bits land I'll rebase accordingly.  That cross-maintainer logisitics
aside, I'll reply with feedback on the DM patches.
