From: javier@cnexlabs.com (Javier Gonzalez)
Date: Mon, 26 Feb 2018 11:21:52 +0000
Subject: [PATCH 1/1] nvme: implement log page low/high offset and dwords
In-Reply-To: <20180213124916.28653-2-mb@lightnvm.io>
References: <20180213124916.28653-1-mb@lightnvm.io>
 <20180213124916.28653-2-mb@lightnvm.io>
Message-ID: <4189F394-D92A-412A-B81F-FE27E7D302BC@cnexlabs.com>

> On 13 Feb 2018,@13.49, Matias Bj?rling <mb@lightnvm.io> wrote:
> 
> NVMe 1.2.1 extends the get log page interface to include 64 bit
> offset and increases the number of dwords to 32 bits. Implement
> for future use.
> 
> Signed-off-by: Matias Bj?rling <mb at lightnvm.io>
> ---
> drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++------------
> 1 file changed, 24 insertions(+), 12 deletions(-)
> 
> 

Looks good to me.

Reviewed-by: Javier Gonz?lez <javier at cnexlabs.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180226/a93ae2e8/attachment.sig>
