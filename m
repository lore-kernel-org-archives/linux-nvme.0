Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694B8CFA76B
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 10:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJyVRNZOtQqKe7tfE+8bLRPSTjQYbFyCIpb/8HJmjgw=; b=04/dg0QGvBhfH7fFQBKrvxSB5A
	V9z8gexgxmy3SpJlmQnbBsTbv4Q581stRBb/G2gixVWkHjtTcV6HVMyYXPLHy9l3yBM0E9QcjSdA9
	ee7+4t1QGCF95F+CmJV0/ZFkA4eP+ujIol34FT8+R+VfEfbMHwODeHNVWeZWTT8Xuj9epBwykZ6Pn
	vbcufj7/brezDvzlVKQ0MZ5iuXXB2Rg3rXdkRpRKyX1agQe1b69zSemSj3fQx8K056/WC8wIpkyE/
	MIlXw5N/1Gc1XM1A/aRJ+UHbAEVh1wbqug9D8dKf8pvAhAV45vljvBI2d0r6O8YQfivzRwmqfpjth
	DMdmrzPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMOQB-00000008Ens-0z3D;
	Fri, 21 Nov 2025 10:31:19 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMOQ9-00000008End-0Odg;
	Fri, 21 Nov 2025 10:31:17 +0000
Date: Fri, 21 Nov 2025 02:31:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: zhangshida <starzhangzsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn
Subject: Re: [PATCH 1/9] block: fix data loss and stale date exposure
 problems during append write
Message-ID: <aSA_dTktkC85K39o@infradead.org>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121081748.1443507-2-zhangshida@kylinos.cn>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 21, 2025 at 04:17:40PM +0800, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index b3a79285c27..55c2c1a0020 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
>  
>  static void bio_chain_endio(struct bio *bio)
>  {
> -	bio_endio(__bio_chain_endio(bio));
> +	bio_endio(bio);

I don't see how this can work.  bio_chain_endio is called literally
as the result of calling bio_endio, so you recurse into that.

Also please put your analysis of the problem into this patch as
said by Johannes.  And please wrap it at 73 characters as the wall of
text in the cover letter is quite unreadable.


