From: javigon.napster@gmail.com (javigon)
Date: Mon, 28 Aug 2017 14:04:01 +0200
Subject: [PATCH 07/10] nvme: track shared namespaces
In-Reply-To: <20170823175815.3646-8-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-8-hch@lst.de>
Message-ID: <373E3FB5-D8FC-41E3-8BDB-9474228BF7D6@gmail.com>

> On 23 Aug 2017,@19.58, Christoph Hellwig <hch@lst.de> wrote:
> 
> Introduce a new struct nvme_ns_head [1] that holds information about
> an actual namespace, unlike struct nvme_ns, which only holds the
> per-controller namespace information.  For private namespaces there
> is a 1:1 relation of the two, but for shared namespaces this lets us
> discover all the paths to it.  For now only the identifiers are moved
> to the new structure, but most of the information in struct nvme_ns
> should eventually move over.
> 
> To allow lockless path lookup the list of nvme_ns structures per
> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
> structure through call_srcu.
> 
> [1] comments welcome if you have a better name for it, the current one is
>    horrible.  One idea would be to rename the current struct nvme_ns
>    to struct nvme_ns_link or similar and use the nvme_ns name for the
>    new structure.  But that would involve a lot of churn.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
> drivers/nvme/host/core.c     | 218 +++++++++++++++++++++++++++++++++++--------
> drivers/nvme/host/lightnvm.c |  14 +--

Nothing big here. Looks good.

Reviewed-by: Javier Gonz?lez <javier at cnexlabs.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170828/4199c587/attachment.sig>
