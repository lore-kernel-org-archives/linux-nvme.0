From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Nov 2018 11:17:52 +0100
Subject: [PATCH] nvme: allow ANA support to be independent of native
 multipathing
In-Reply-To: <bbaf4637-209c-5cfe-2749-3fcc54f7a35f@suse.de>
References: <20181113180008.GA12513@redhat.com>
 <20181114053837.GA15086@redhat.com>
 <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de>
 <20181114174746.GA18526@redhat.com>
 <87c931e5-4ac9-1795-8d40-cc5541d3ebcf@suse.de>
 <20181115174605.GA19782@redhat.com> <20181116091458.GA17267@lst.de>
 <37098edd-4dea-b58f-bca6-3be9af8ec4ee@suse.de>
 <20181116094947.GA19296@lst.de>
 <bbaf4637-209c-5cfe-2749-3fcc54f7a35f@suse.de>
Message-ID: <20181116101752.GA21531@lst.de>

On Fri, Nov 16, 2018@11:06:32AM +0100, Hannes Reinecke wrote:
> Ok, so would you be happy with making ANA support configurable?

I've looked a bit over the whole situation, and what I think we need
to do is:

 a) warn if we see a ANA capable device without multipath support
    so people know it is not going to work properly.
 b) deprecate the multipath module option.  It was only intended as
    a migration for any pre-existing PCIe multipath user if there
    were any, not to support any new functionality.  So for 4.20
    put in a patch that prints a clear warning when it is used,
    including a link to the nvme list, and then for 4.25 or so
    remove it entirely unless something unexpected come up.

This whole drama of optional multipath use has wasted way too much
of everyones time already.
