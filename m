Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26ACC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 06:58:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D64F20888
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 06:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xZ/mh8jl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W7jp/kmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D64F20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j4xgwuY4c3vvpAO2d59b8m6OOE24dzbLAP+8qKfJhv8=; b=xZ/mh8jlQ+K5zkNfOl2HaV4Wt
	8b1dY9LVAPHY32e2R3eoigEOgVTGPZdUe9zVsIcEn7qSWqoEvRlJwd5G6cW4OeG7/QRG65gZeo00g
	UbatlM0WDryCXV9XntLiM4AyrfTLGWbcHEAnR1BUIjKOMiDPgNfCis9wuPxdhqsduzoJNRFuQwDKu
	e31A5BXIMee6ZjgRku/bgfbtl4IsMKq13rbepKE9R36KJ9hH2rmsgy9Z6HK/Kvud5heudLRUk4Fu3
	bzgr2iZB+aFoBFXXINOiKUWc/DynGmKft1wQ31Vgvfzt2SH6lJjmAVGN6v5npLKbV4/ql6zmRpWUk
	UjoXVPQFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8I2t-0005mf-Rx; Wed, 19 Aug 2020 06:58:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I0y-0004s7-4Y; Wed, 19 Aug 2020 06:56:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=eBdiOi8NPtkzomu53YzYl2srwsK9DIz9xkGY00o46Kk=; b=W7jp/kmQRNQmUKHIQCbWiH2UzD
 GHchOhkvpQXWR6G8uHdQkx6sUQhPxtEOypHvMit0pnMaJ96seYjUrPxSxVC6yzpyGBSOC2Nrgsh8t
 habu4qVEkcucriWPKkm9BybK9fhXZoRM6VZxHk19H4GtftcZP4mFNmDQh9R4d6euSpnVjF/IT+4VA
 fQn1gjBdhax7V48K7ChncjzQBXjHEdp34pMLA0HCN9PETDLnVwDoWAMZ6z8zDxVD+JSzcAWRs6/Yh
 jvj7ygz03LhQShxpipeKs0B45bhtyQCSewe+tNF4boY9o+jka2d5wVanpf8IakmCQfRJXxYOcqDdr
 mCnhF8Kg==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I0v-0008L8-G8; Wed, 19 Aug 2020 06:56:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 03/28] drm/nouveau/gk20a: stop setting DMA_ATTR_NON_CONSISTENT
Date: Wed, 19 Aug 2020 08:55:30 +0200
Message-Id: <20200819065555.1802761-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819065555.1802761-1-hch@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DMA_ATTR_NON_CONSISTENT is a no-op except on PARISC and some mips
configs, so don't set it in this ARM specific driver part.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c
index 985f2990ab0dda..13d4d7ac0697b4 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c
@@ -594,8 +594,7 @@ gk20a_instmem_new(struct nvkm_device *device, int index,
 
 		nvkm_info(&imem->base.subdev, "using IOMMU\n");
 	} else {
-		imem->attrs = DMA_ATTR_NON_CONSISTENT |
-			      DMA_ATTR_WEAK_ORDERING |
+		imem->attrs = DMA_ATTR_WEAK_ORDERING |
 			      DMA_ATTR_WRITE_COMBINE;
 
 		nvkm_info(&imem->base.subdev, "using DMA API\n");
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
