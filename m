From: hch@lst.de (Christoph Hellwig)
Date: Sat, 4 Nov 2017 09:18:25 +0100
Subject: [PATCH 1/3] nvme: do not check for ns on rw path
In-Reply-To: <20171103150203.GA11300@localhost.localdomain>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-2-git-send-email-javier@cnexlabs.com>
 <20171103125339.GA25186@lst.de>
 <20171103150203.GA11300@localhost.localdomain>
Message-ID: <20171104081825.GA19180@lst.de>

On Fri, Nov 03, 2017@09:02:04AM -0600, Keith Busch wrote:
> If the namespace has metadata, but the request doesn't have a metadata
> payload attached to it for whatever reason, we can't construct the command
> for that format. We also can't have the controller strip/generate the
> payload with PRACT bit set if it's not a T10 format, so we just fail
> the command.

The only metadata payload a READ or WRITE request can have is a protection
information one.  For a namespace formatted with protection information
bio_integrity_prep as called from blk_mq_make_request will ensure we
always have metadata attached.

If a namespace is formatted with non-PI metadata we will never have
metadata attached to the bio/request and should not even present the
namespace to the kernel.
