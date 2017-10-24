From: jg@lightnvm.io (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Tue, 24 Oct 2017 19:57:25 +0200
Subject: [PATCH 03/17] block: provide a direct_make_request helper
In-Reply-To: <20171023145126.2471-4-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-4-hch@lst.de>
Message-ID: <6E703CAF-4B4C-47BC-92FE-B6937ECBEF16@lightnvm.io>

> On 23 Oct 2017,@16.51, Christoph Hellwig <hch@lst.de> wrote:
> 
> This helper allows reinserting a bio into a new queue without much
> overhead, but requires all queue limits to be the same for the upper
> and lower queues, and it does not provide any recursion preventions.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> block/blk-core.c       | 34 ++++++++++++++++++++++++++++++++++
> include/linux/blkdev.h |  1 +
> 2 files changed, 35 insertions(+)
> 


Reviewed-by: Javier Gonz?lez <javier at cnexlabs.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171024/6cf03741/attachment.sig>
