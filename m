Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E6FF43683
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 10:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mKMTmrjCcICgSQXz4u0hmUlvqN+uZXoVAXQrXwB9CuU=; b=KhDRUZ46jvdxGedvo2IZN58l6Z
	uPT/AMsu7J7zIJ7LhA2z3rjpp/4xuFRcdPTfEqw/BiqUBig140w1fom7Nie7rvPsRbcsV7dLt+Hyu
	jU4NuwS2i7SRQWeOdsmA+t6HbJvqpEAObml0vSsWeLwNJU62la/PtRY0yT+SZpBQP6PIqEZKJtUdA
	t0SB3IZ8hZFXOSBC2ddAC011GEcEFJx66qjXDMOR1xiz+4ctXFvlNGc+94MtWEe7fMtx8gM24O8JE
	TU6Lxbp/zzE3ITy2+/g/sEty+RXGDEGLBPzbiAimKy7jUvfvQAdvufNZuJS131N6am5DQwfIYwzcy
	u9UhExFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDgFK-00000003tSj-2mRA;
	Fri, 17 Apr 2026 10:16:22 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDgFH-00000003tRo-1PST
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 10:16:21 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260417101609epoutp03d323c08f898de34a6e2caec210a4190c~nHXWzRO1V1649016490epoutp032
	for <linux-nvme@lists.infradead.org>; Fri, 17 Apr 2026 10:16:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260417101609epoutp03d323c08f898de34a6e2caec210a4190c~nHXWzRO1V1649016490epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776420969;
	bh=mKMTmrjCcICgSQXz4u0hmUlvqN+uZXoVAXQrXwB9CuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ROWg8L5gRbqqmMpmwUxGBJf1dGsYghFMKAsoUiQlG/iPDupbe2ux99f4Y0FdwDfQt
	 CgPwCdE8aO8RfrutB6ZklKVLEADChQu2Vl0L47sTrbwLz+N047Clt4iDCU3oeJK6Nj
	 c4ll2XX+a63G28wYW6/4fEr4LUaxhUCh4BIL6+6g=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260417101608epcas5p34ab6abece4a948679a75b9a349cb0279~nHXWKjvh52808728087epcas5p3n;
	Fri, 17 Apr 2026 10:16:08 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4fxrPg4f39z6B9mB; Fri, 17 Apr
	2026 10:16:07 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260417101607epcas5p204981188700b5f9e3135d80ed7f16eb1~nHXUzaUUJ3187631876epcas5p2s;
	Fri, 17 Apr 2026 10:16:07 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260417101605epsmtip2a5dcdcc651cd4df1a7aa945ba063c6dc~nHXS_iqX91345213452epsmtip2H;
	Fri, 17 Apr 2026 10:16:05 +0000 (GMT)
Date: Fri, 17 Apr 2026 15:41:27 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	kmodukuri@nvidia.com
Subject: Re: [PATCH V3 1/3] block: clear BLK_FEAT_PCI_P2PDMA in
 blk_stack_limits() for non-supporting devices
Message-ID: <20260417101127.uku7q65akj6gwwh4@green245.gost>
MIME-Version: 1.0
In-Reply-To: <20260416212633.72650-2-kch@nvidia.com>
X-CMS-MailID: 20260417101607epcas5p204981188700b5f9e3135d80ed7f16eb1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----9zlBZcaXwhNlkY1lQONG7VXpdyX9cJiniG-eU7bnr-KNWM7L=_219b6_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260417101607epcas5p204981188700b5f9e3135d80ed7f16eb1
References: <20260416212633.72650-1-kch@nvidia.com>
	<20260416212633.72650-2-kch@nvidia.com>
	<CGME20260417101607epcas5p204981188700b5f9e3135d80ed7f16eb1@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_031620_031776_8DA4B637 
X-CRM114-Status: GOOD (  10.93  )
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

------9zlBZcaXwhNlkY1lQONG7VXpdyX9cJiniG-eU7bnr-KNWM7L=_219b6_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 16/04/26 02:26PM, Chaitanya Kulkarni wrote:
>BLK_FEAT_NOWAIT and BLK_FEAT_POLL are cleared in blk_stack_limits()
>when an underlying device does not support them.  Apply the same
>treatment to BLK_FEAT_PCI_P2PDMA: stacking drivers set it
>unconditionally and rely on the core to clear it whenever a
>non-supporting member device is stacked.
>
>Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>---
> block/blk-settings.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/block/blk-settings.c b/block/blk-settings.c
>index 78c83817b9d3..8274631290db 100644
>--- a/block/blk-settings.c
>+++ b/block/blk-settings.c
>@@ -795,6 +795,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> 		t->features &= ~BLK_FEAT_NOWAIT;
> 	if (!(b->features & BLK_FEAT_POLL))
> 		t->features &= ~BLK_FEAT_POLL;
>+	if (!(b->features & BLK_FEAT_PCI_P2PDMA))
>+		t->features &= ~BLK_FEAT_PCI_P2PDMA;
>
> 	t->flags |= (b->flags & BLK_FLAG_MISALIGNED);
I think you need below patch[1] as well to unset this here.
Also I feel better to include Mike,Mikulas and dm-devel mailing list as well.

Thanks,
Nitesh

[1]
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index dc2eff6b739d..0442c1f4c686 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -590,7 +590,8 @@ int dm_split_args(int *argc, char ***argvp, char *input)
  static void dm_set_stacking_limits(struct queue_limits *limits)
  {
  	blk_set_stacking_limits(limits);
-	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
+	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL \
+	BLK_FEAT_PCI_P2PDMA;
  }

------9zlBZcaXwhNlkY1lQONG7VXpdyX9cJiniG-eU7bnr-KNWM7L=_219b6_
Content-Type: text/plain; charset="utf-8"


------9zlBZcaXwhNlkY1lQONG7VXpdyX9cJiniG-eU7bnr-KNWM7L=_219b6_--

