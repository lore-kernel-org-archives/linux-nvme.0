From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 22 Jun 2016 09:14:42 -0700
Subject: [PATCH] nvme: Limit command retries
In-Reply-To: <1466444691-29448-1-git-send-email-keith.busch@intel.com>
References: <1466444691-29448-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160622161442.GB10592@infradead.org>

I've got some work in progress that gets rid of the SCSI-specific
fields in struct request and moves them into a scsi specific private
data structure, and that also does the same for NVMe.

How urgent is this patch?  If it fixes an actual major issue seen
in the field we should probably but the ->retries use in as-is,
otherwise I'd prefer to avoid introducing more users of it for now.
