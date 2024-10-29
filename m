Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0EAD3A679
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OdnEOzPmE6BW4EwF3Q4T8kgPZcMcp2ktM4WfhkvkMt0=; b=1YyWFOcrlbaNNcL9qCjG+VnhPn
	O8MqWIlyLbfEBVnANfndGyrBr0FSPKOoxZoE1KFckgqwbBjo7RyeB02OXMHxgwPAHqQgCLVYxeXwx
	4QJMbne//zW+d/67fjmUQBlpnlUP4BgOyhvtQAx2ZEtqwjr1waxvyRdNE4zgBOi5FKHa97s5Nh//x
	yXZeayROyCcbE4RvVRT/yS3VLoY2KVmL+hJ3+NvcNvEYidJdDzRqEFoGuC+a3AYqnfZ4LORGOuVHi
	ZJHDdM2DZvpOGkVcBE2CH8mbmaXNDiOuSszptO8jGrbi8u7b/43zlVILn2JBtuVgkD3pUbvzlvYKP
	HQjtfbNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qQ1-0000000FOuD-3ygQ;
	Tue, 29 Oct 2024 17:54:14 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pwo-0000000FEyk-2vrw
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 17:24:04 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241029172400epoutp013a675420d33f44ffca4c229b40d3cc8c~C-FMkiZa22983329833epoutp01O
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 17:24:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241029172400epoutp013a675420d33f44ffca4c229b40d3cc8c~C-FMkiZa22983329833epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730222640;
	bh=OdnEOzPmE6BW4EwF3Q4T8kgPZcMcp2ktM4WfhkvkMt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzwrcwJoWpx3qi0WD6meqjI8n2fVLo8UNY8mkWBoUL6CwRti739qaPo/KpVPLmaH1
	 IL+6nqR1f86fdtXFPx36tM1TLn2/sbdUv9VIlWB/A4y6tnDXzk5B8jDZQq5PTrG05A
	 zOgQ3bDF+ujc81rqWRurTWVd1DFgG0kRfsbAregY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241029172400epcas5p35e10bdeb507f2be65e1525872191a877~C-FL3KKcU2485924859epcas5p3E;
	Tue, 29 Oct 2024 17:24:00 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XdHDG3KqKz4x9Pp; Tue, 29 Oct
	2024 17:23:58 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	35.D6.08574.E2A11276; Wed, 30 Oct 2024 02:23:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241029163228epcas5p1cd9d1df3d8000250d58092ba82faa870~C_YMG540n2488624886epcas5p1x;
	Tue, 29 Oct 2024 16:32:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241029163228epsmtrp139fca113c34f528ccc23763785f13784~C_YMF-1lz0723107231epsmtrp1z;
	Tue, 29 Oct 2024 16:32:27 +0000 (GMT)
X-AuditID: b6c32a44-6dbff7000000217e-2d-67211a2e9da0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.67.08229.B1E01276; Wed, 30 Oct 2024 01:32:27 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241029163225epsmtip2d329feefdeb3e08ac163b88a9a07b6eb~C_YJpfwvB0998409984epsmtip2b;
	Tue, 29 Oct 2024 16:32:25 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v5 07/10] block: introduce BIP_CHECK_GUARD/REFTAG/APPTAG
 bip_flags
Date: Tue, 29 Oct 2024 21:53:59 +0530
Message-Id: <20241029162402.21400-8-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029162402.21400-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH97v3cltQzF1B+dEER++y1DFh7SjlstCxRDQ3m1GimyYshl3p
	TWEtbdMWNsncYJWHQ2ghWxgdk/kkPJSIUMFS0AIr4ADnlMdMBRTsWAEDiNuCoC0tuv8+5/y+
	53x/5/fgorxpnM/NVhtYnZpRkXgIZu3dK4yN4wsUopKKCGp5bR2jLpg3UKq20QqoJpcJpzy9
	K4Ca/KYToRqa+hFqqWgEo65WGxGq/59FnKpyjAHKfmcf1WUfxKi6T+c4VNl4B07VOzcRanTD
	GUSNWmo5h3l0p8XFoW8P59Ktje/i9Jcfn6dtkwU4vTx3B6Mr2hoBffN6H4debX2abp1dRNJC
	0pXJWSwjZ3XRrDpTI89WK2Tk0VcznstIkIrEseIkKpGMVjM5rIxMfTEt9oVslXcmMjqPUeV6
	U2mMXk/uP5Ss0+Qa2Ogsjd4gI1mtXKWVaOP0TI4+V62IU7OGg2KR6ECCV3hSmVVurgLassgz
	m9cK8QIwFn4RBHMhIYHzv9fgF0EIl0fYAFx0TgT5gxUATd9/wfEHfwE477iMbpe4pyyBBTuA
	60VLgWAVwLrZDdynwgkh7HMXAd9CONEFYPkH32G+ACXMCCyprOX4VGHEMbjmqUd8jBF7oKvs
	FubjUCIJLhfOBvn9dsGaH+5v6YOJg/BGfxfi1+yEgzWzW3rUqzG2X0V9BpCY5kLP4Hhgs6mw
	eepCoFEYvOds4/iZD+dNxQFWwAe35xA/a6HxRjfwcwosGjJ5+3C9Bnthy9f7/ekoeHnoc8Tv
	+wQsX58NlIbCjve3mYQlDbUBhtA+UhBgGlYuVCH+4yoHcGWmGJhBtOWReSyPzGP53/o6QBtB
	JKvV5yjYzAStWM2e/u+iMzU5rWDrqcekdoCJus04B0C4wAEgFyXDQ5veiFLwQuXMW/msTpOh
	y1WxegdI8B54Jcp/MlPj/StqQ4ZYkiSSSKVSSVK8VExGhHqKrsl5hIIxsEqW1bK67TqEG8wv
	QI7Rwq+UDxIFEXbVldfgmGfgE/c9G7ZjciRmvPn07hD3R0fuTy308DGBpKCTp01Ze9i7eyEd
	JmKc1qlbw+jzq2uXNs+7Iq0D6xpTsdGVz3t5xlEszz76m+3I3c96DoM60LVav2PU2nsqWPHz
	0pWwlYbmwrtZ7m7luZ8ei0+XxL+uI555R6AU39ywJ08Z+mecL5EP8+d/PSXk16qq+h3Vv1SI
	Kn+sF5yV9ealHXi8rfzt97LbZSUdLWdKh/8Y/JPxCFsOlXbvK81kzDUp03PVbbaene7j7Sf6
	Tj77LW/ob8dGFJW30M2XvXIuTPrUh2NnEyffnLDyuQObJ3SKSeOuPcfNJKbPYsQxqE7P/AuH
	DM2QcwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvK40n2K6QetBY4uPX3+zWDRN+Mts
	MWfVNkaL1Xf72SxeH/7EaHHzwE4mi5WrjzJZvGs9x2Ixe3ozk8XR/2/ZLCYdusZosfeWtsWe
	vSdZLOYve8pu0X19B5vF8uP/mCzO/z3OanF+1hx2ByGPnbPusntcPlvqsWlVJ5vH5iX1Hrtv
	NrB5fHx6i8Wjb8sqRo8zC46we3zeJOex6clbpgCuKC6blNSczLLUIn27BK6M3gmTGAu6JSv+
	zW1ka2C8JtLFyMkhIWAi8fz+LPYuRi4OIYHdjBLTl31nhkhISJx6uYwRwhaWWPnvOVTRR0aJ
	lQs7WEESbALqEkeet4IViQicYJSYP9ENpIhZYAaTRM+vFWxdjBwcwgJBEhv2F4LUsAioStzt
	vsgCYvMKWEp8bHzCCrFAXmLmpe/sIDangJXEsaN7mEBahYBqTk5ygygXlDg58wlYKzNQefPW
	2cwTGAVmIUnNQpJawMi0ilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjON60NHcwbl/1
	Qe8QIxMH4yFGCQ5mJRHe1bGy6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGan
	phakFsFkmTg4pRqYdu2/tkXwgPukqDmdjmd8olMimA0frDrxVv3QDp89Xzn3PTqq+kE+8VLT
	z9L2J2KJuQYbbGZsmXtXwsAt7MA0pR23C5I+31JLOXchX9Zy/uWVjJxfLy8/+3Pd5/O7uSfw
	VHWycb8Ozv7IWHK+WniT/nX1q37OV99GfBPu0X3IPuOKW25ZyESm0gt/U/obsxTSH6v7e57p
	Fz9iPed274NvzXaLVMrPnl454eAU5/jHJV8+7S62N0/z0TJZsOOdZp36xSmK9zd0XJvw/um+
	9P4bUY1Wiv5333nGX3PctMnsPIMzS8bLKMvlRx9+WW/SHZ/Cc0H+65H97/4XOE+bpTrliGTV
	ky+BK/JucnrteTjd2EiJpTgj0VCLuag4EQDbS0EhJgMAAA==
X-CMS-MailID: 20241029163228epcas5p1cd9d1df3d8000250d58092ba82faa870
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241029163228epcas5p1cd9d1df3d8000250d58092ba82faa870
References: <20241029162402.21400-1-anuj20.g@samsung.com>
	<CGME20241029163228epcas5p1cd9d1df3d8000250d58092ba82faa870@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_102403_091903_2E8C7E63 
X-CRM114-Status: GOOD (  20.62  )
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

This patch introduces BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags which
indicate how the hardware should check the integrity payload.
BIP_CHECK_GUARD/REFTAG are conversion of existing semantics, while
BIP_CHECK_APPTAG is a new flag. The driver can now just rely on block
layer flags, and doesn't need to know the integrity source. Submitter
of PI decides which tags to check. This would also give us a unified
interface for user and kernel generated integrity.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/bio-integrity.c         |  5 +++++
 drivers/nvme/host/core.c      | 11 +++--------
 include/linux/bio-integrity.h |  6 +++++-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index f56d01cec689..3bee43b87001 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -434,6 +434,11 @@ bool bio_integrity_prep(struct bio *bio)
 	if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
 		bip->bip_flags |= BIP_IP_CHECKSUM;
 
+	/* describe what tags to check in payload */
+	if (bi->csum_type)
+		bip->bip_flags |= BIP_CHECK_GUARD;
+	if (bi->flags & BLK_INTEGRITY_REF_TAG)
+		bip->bip_flags |= BIP_CHECK_REFTAG;
 	if (bio_integrity_add_page(bio, virt_to_page(buf), len,
 			offset_in_page(buf)) < len) {
 		printk(KERN_ERR "could not attach integrity payload\n");
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3de7555a7de7..79bd6b22e88d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1004,18 +1004,13 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 			control |= NVME_RW_PRINFO_PRACT;
 		}
 
-		switch (ns->head->pi_type) {
-		case NVME_NS_DPS_PI_TYPE3:
+		if (bio_integrity_flagged(req->bio, BIP_CHECK_GUARD))
 			control |= NVME_RW_PRINFO_PRCHK_GUARD;
-			break;
-		case NVME_NS_DPS_PI_TYPE1:
-		case NVME_NS_DPS_PI_TYPE2:
-			control |= NVME_RW_PRINFO_PRCHK_GUARD |
-					NVME_RW_PRINFO_PRCHK_REF;
+		if (bio_integrity_flagged(req->bio, BIP_CHECK_REFTAG)) {
+			control |= NVME_RW_PRINFO_PRCHK_REF;
 			if (op == nvme_cmd_zone_append)
 				control |= NVME_RW_APPEND_PIREMAP;
 			nvme_set_ref_tag(ns, cmnd, req);
-			break;
 		}
 	}
 
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 58ff9988433a..fe2bfe122db2 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -11,6 +11,9 @@ enum bip_flags {
 	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
 	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
 	BIP_COPY_USER		= 1 << 5, /* Kernel bounce buffer in use */
+	BIP_CHECK_GUARD		= 1 << 6, /* guard check */
+	BIP_CHECK_REFTAG	= 1 << 7, /* reftag check */
+	BIP_CHECK_APPTAG	= 1 << 8, /* apptag check */
 };
 
 struct bio_integrity_payload {
@@ -31,7 +34,8 @@ struct bio_integrity_payload {
 };
 
 #define BIP_CLONE_FLAGS (BIP_MAPPED_INTEGRITY | BIP_CTRL_NOCHECK | \
-			 BIP_DISK_NOCHECK | BIP_IP_CHECKSUM)
+			 BIP_DISK_NOCHECK | BIP_IP_CHECKSUM | \
+			 BIP_CHECK_GUARD | BIP_CHECK_REFTAG | BIP_CHECK_APPTAG)
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 
-- 
2.25.1


