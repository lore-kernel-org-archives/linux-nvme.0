From: jg@lightnvm.io (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Fri, 20 Oct 2017 21:03:46 +0200
Subject: [PATCH 15/17] nvme: track shared namespaces
In-Reply-To: <20171018165258.23212-16-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-16-hch@lst.de>
Message-ID: <13C5EC7C-6E04-4D10-8F6D-B816BB39CF9A@lightnvm.io>

Javier
> On 18 Oct 2017,@18.52, Christoph Hellwig <hch@lst.de> wrote:
> 
> Introduce a new struct nvme_ns_head that holds information about an actual
> namespace, unlike struct nvme_ns, which only holds the per-controller
> namespace information.  For private namespaces there is a 1:1 relation of
> the two, but for shared namespaces this lets us discover all the paths to
> it.  For now only the identifiers are moved to the new structure, but most
> of the information in struct nvme_ns should eventually move over.
> 
> To allow lockless path lookup the list of nvme_ns structures per
> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
> structure through call_srcu.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Keith Busch <keith.busch at intel.com>
> ---
> drivers/nvme/host/core.c     | 192 +++++++++++++++++++++++++++++++++++++------
> drivers/nvme/host/lightnvm.c |  14 ++--
> drivers/nvme/host/nvme.h     |  21 ++++-
> 3 files changed, 192 insertions(+), 35 deletions(-)
> 
> 
LGTM

Reviewed-by: Javier Gonz?lez <javier at cnexlabs.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171020/73f9b2c1/attachment.sig>
