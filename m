Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9BEC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 01:52:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAB161027
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 01:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAB161027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Dljwb95PT8xFThf0FHX4T8i3dyW7uzZaljoZKaLfjPM=; b=ND/0VO4lrPSWq6QGyrcktxH9o
	csVznR/aQR7+fw52rLsURTfLY5mxI5BFhozBAYGFZ313t+aXsdWsctvhWpqQDvkMmUn/O/mfTh7ZK
	7jsCvNe0gBvcX5K4RtJUs61jOVMa7OAlFVQQapY7SnCwRoCzO23YDgqwNbJZYiFpA7dlHKLwFAvlq
	LlQ9Tg/Vzq8BxskGuHAQrVqOQS2G49j2dA7ck5vvGIZQoEYjLxuYu5L6quFVZ/OlXX4xqlisZ6U8j
	2p8yYWCNF1zi6uuZdhSCNfOEaixGPXQMAdYF1+IcJrAa2zP1+9lE2oX+pLgrGunG5a7zb1Nh4RZjy
	skvUxgh7w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lepex-005oWI-Eu; Fri, 07 May 2021 01:52:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lepef-005oUJ-JX
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 01:51:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=U/bcS7vLi+fMyerbIk/4mzUfDEH5aLi049WnRmX9tlE=; b=mxKDDSa0iuUhldsdzG/0w+634n
 hg2oBuawxrdX8C2nw7yw/nNvzhQAYlU4Cxn43tldRuGw4LtfxpEvrtWJxNxVwP+0MVZK1WU5aBd8+
 5VsyEyCki+zUdt8mpFMV6U8o2a5/Z09j20Qtl4kLrqG+6BPscvNx6mbhD2XtRMLUiifjwBn53GWJ7
 Iam4bDXHeWM8kAlKcKR1BySouhDGlJzJy9WmAA+AlipzLmBdiho+WZJsrZLLbS4LAcwAqjAJkP2AL
 izMx1xIS3nQMT+83S8H7YlONPi6c3lYXQcVHO+HqxbkxeDUGP0ibgLv2djizGSm5fNISRnQ19tJAn
 RDO0F2Fw==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leped-006Vq9-24
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 01:51:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620352306; x=1651888306;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZjoHcPYs5P/EqtoA+AVV9JHmomtRku8j2VlgOUJh7Ws=;
 b=nyoD5ovHrlC+uPTUUqRhENIi+P5mAZiZ+XyJ7Vneg1mhlJnOrZlQRtYX
 f1cEfqHrC1UeriVHivs1luem53edBFxpqyvfecVOJXTUwoFx+FElX4mlP
 g9qWfqF97O0QOVU8p6HpQu+CUz8adBps8AbC8lak2oOzsAYjEA8olcn1P
 /LT+NKL9igQT6hwlUrBhkQO5YmJJ+RCYt1oJNtZgBDuwuSpzjk3jjNPqI
 P+qC8QX3Draz/nkHzJhsTrYQHe9MfeunaD8p1gSGEfEipkjw7BaUsz10o
 XOFS00uUcCisNjEJl6AhPXwZ/zswgce3eQVgVbOh5LTx2LrXJNKN/lESb Q==;
IronPort-SDR: 6yY3ULfyf/NLoCQnaD8LELH7e/foP8y85TbHF5FOjMyjzBYGP7bz2erW4hRjouTUxHTFZvjREW
 TJAn34y/N0BUZ/DbnzaNc6eBkU13tKQMdzTO1+BLKx3ork/BNGFuhmgeUulEiD5x5neuA5IUFa
 4F70/Ni4Y/v51FSOwhWnZLsRRj/wYPrQq+3/rNroq+it+MYGZ1eFxywcfcKmQBoPWqsutrGaGL
 A9xCkTws2gXQI5xU+WrMxbEXzWWiakeMHIMMyeAd80mf0VLbPR7mVemvjjAdeXHIAmx0ofVTct
 S1c=
X-IronPort-AV: E=Sophos;i="5.82,279,1613404800"; d="scan'208";a="166711740"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 May 2021 09:51:46 +0800
IronPort-SDR: zyFLxhfBNd3/R4UWqN+JyNg4pRnaBz6Gda7ZBjF3Mkwxy2/qyIJOD/N3B/KDrsStpMKbM8e/6d
 kv/Hbtvb4nUmGPs1rxaZijU5kybbMboy/DQl8/ZiUvvxB1XEFO/yHMb/s08ZdIM2NXRpvywR7g
 gMeZEEuNVTKuQcOnH/RRZu+HlF9q5LdvPNs5m6XSxodrnZpQHwRClC3xu3PT6a1HafjNKYwcS0
 yDwkxrebPMdJS8kWHfaVsMlTJ+IxBAGTxcljuWPgl0w+k9r5+1wXqmZclxYE8+9O9sfpg1IGHp
 JroOxF258NOHm99+R8NXgJhB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2021 18:30:26 -0700
IronPort-SDR: keCQqgMzvP0WjNXvqOiuLJZZu5k7Vle3QiqBECLMjGJVwgE3yxm+pwR9EkaqXQKTNSAMI3iCtZ
 Iipr7SYM5cnPq2qtUtwRqmq6+4pKBcFjvYOagehfx+bZpNtA8Cl7LioEGnvfkWu9DHZh1KJ4D9
 SupF9fwBV14PsQJBrf+mHFvcYMML3MlGFP15gAkWeW9CRv7g7uCXVcCPYRn+HOdlf7TgeEQJSl
 UipFBYsNcetdQrGHO5XbhyazOxL6NyjqmDmvvLpBkt/w+wKr8QVC4HxkaaRaPgIsYt+zDWJ9eG
 Tw0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 May 2021 18:51:47 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 2/2] nvmet: fix inline bio check for passthru
Date: Thu,  6 May 2021 18:51:36 -0700
Message-Id: <20210507015136.11069-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210507015136.11069-1-chaitanya.kulkarni@wdc.com>
References: <20210507015136.11069-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_185147_181361_34F51265 
X-CRM114-Status: GOOD (  16.07  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When handling passthru commands, for inline bio allocation we only
consider the transfer size. This works well when req->sg_cnt fits into
the req->inline_bvec, but it will result in the early return from
bio_add_hw_page() when req->sg_cnt > NVMET_MAX_INLINE_BVEC.

Consider an I/O of size 32768 and first buffer is not aligned to the
page boundary, then I/O is split in following manner :-

[ 2206.256140] nvmet: sg->length 3440 sg->offset 656
[ 2206.256144] nvmet: sg->length 4096 sg->offset 0
[ 2206.256148] nvmet: sg->length 4096 sg->offset 0
[ 2206.256152] nvmet: sg->length 4096 sg->offset 0
[ 2206.256155] nvmet: sg->length 4096 sg->offset 0
[ 2206.256159] nvmet: sg->length 4096 sg->offset 0
[ 2206.256163] nvmet: sg->length 4096 sg->offset 0
[ 2206.256166] nvmet: sg->length 4096 sg->offset 0
[ 2206.256170] nvmet: sg->length 656 sg->offset 0

Now the req->transfer_size == NVMET_MAX_INLINE_DATA_LEN i.e. 32768, but
the req->sg_cnt is (9) > NVMET_MAX_INLINE_BIOVEC which is (8).
This will result in early return in the following code path :-

nvmet_bdev_execute_rw()
	bio_add_pc_page()
		bio_add_hw_page()
			if (bio_full(bio, len))
				return 0;

Use previously introduced helper nvmet_use_inline_bvec() to consider
req->sg_cnt when using inline bio. This only affects nvme-loop
transport.

Fixes: dab3902b19a0 ("nvmet: use inline bio for passthru fast path")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 2798944899b7..39b1473f7204 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -194,7 +194,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	if (req->sg_cnt > BIO_MAX_VECS)
 		return -EINVAL;
 
-	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+	if (nvmet_use_inline_bvec(req)) {
 		bio = &req->p.inline_bio;
 		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	} else {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
