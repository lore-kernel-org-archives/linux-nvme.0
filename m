Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F4DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I35qQFK0enOoaV9/O3Pbc4mWuZUa1zao+8/QBtn9w8A=; b=bEJtWueuAkf5ZnXEmVgqXepXjy
	ZkADnZ9vreuNURoSVX6EHRcZ+Ir1UHhfmbBXix5QYJU9dwHS0/3ELkrngHn9f5IACZ+D+HpxXUGWI
	IKri7hGlZZNeK/2cGV3DXeQqEr0yd4V6m2UeAmNAcv/dp1SrlKKIhyCo9uuukdz0u0o9oNixyplGL
	uWU3MC5upWsFz7CmaQMD1/MBAgcRB1R1XU5koRTru7InwfNnLdguI1ciTZ3v4LPru9t4hUIhp7+v2
	WhjixWOh7m0CXHaj+FP52X16UfDLpcs2W5A43cbxoSvMHjsmzwoJqZYpEPk4ZTedx4ZVqPJx4Stxp
	w0D66+vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRdJ7-005QA4-DW; Tue, 08 Mar 2022 17:07:33 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRd6Y-005Lit-Ae
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 16:54:36 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220308165433euoutp019f4cee623628f2eceac855f31d439868~adhs3PnI_0386603866euoutp01D
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 16:54:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220308165433euoutp019f4cee623628f2eceac855f31d439868~adhs3PnI_0386603866euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1646758473;
 bh=I35qQFK0enOoaV9/O3Pbc4mWuZUa1zao+8/QBtn9w8A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tS2QzxCbenrohW91Vt5PBO91IWlurRUhBBJHm0SeCHDqoxIWObeyYycHk9fylPWJI
 eqOBgKKjneMo7neFln4GPjDrV5WIRt5qr1BnFQWhHnpEUCSwMfKesm+BeeZP/dsIJe
 uuggzS8wQTrNb5a/thrz3c58KFHrWrLc8oZ5eTm8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220308165432eucas1p11f851543691ef1e2b239a4c5aaeff1e3~adhsZzV3k0127001270eucas1p1I;
 Tue,  8 Mar 2022 16:54:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id FA.AD.09887.84A87226; Tue,  8
 Mar 2022 16:54:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220308165432eucas1p18b36a238ef3f5a812ee7f9b0e52599a5~adhr9ejQ63038730387eucas1p1C;
 Tue,  8 Mar 2022 16:54:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220308165432eusmtrp2f1a11e8a3571b9775004065a77e7715e~adhr8aCbQ0464104641eusmtrp2Z;
 Tue,  8 Mar 2022 16:54:32 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-26-62278a48454f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id A8.96.09404.74A87226; Tue,  8
 Mar 2022 16:54:31 +0000 (GMT)
Received: from localhost (unknown [106.210.248.181]) by eusmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20220308165431eusmtip2b29f05515e91ee479562ae7c726e6a1e~adhrl2rHe1222112221eusmtip2-;
 Tue,  8 Mar 2022 16:54:31 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, =?UTF-8?q?Javier=20Gonz=C3=A1lez?=
 <javier.gonz@samsung.com>, kanchan Joshi <joshi.k@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Damien Le Moal
 <damien.lemoal@opensource.wdc.com>, =?UTF-8?q?Matias=20Bj=C3=B8rling?=
 <matias.bjorling@wdc.com>, jiangbo.365@bytedance.com
Cc: Pankaj Raghav <pankydev8@gmail.com>, Kanchan Joshi
 <joshiiitr@gmail.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 3/6] block: add a bool member to request_queue for
 power_of_2 emulation
Date: Tue,  8 Mar 2022 17:53:46 +0100
Message-Id: <20220308165349.231320-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308165349.231320-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djP87oeXepJBucXSFpMP6xosfpuP5vF
 77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
 eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
 ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEdx2aSk5mSWpRbp2yVwZdzskC5o5K34unwDawPjda4u
 Rk4OCQETiR//TjCB2EICKxglTkxm6WLkArK/MErMnjiHFcL5zCjx/+Z7FpiOxW+XsUEkljNK
 /O1Yzg7R/pJRYuUT9y5GDg42AS2Jxk6wsIjABWaJHzcVQeqZBTYzSnyYtIIVJCEsECmx8/ht
 sCIWAVWJc/PWgcV5Bawk3nX+YIdYJi8x89J3MJtTwFriaedMNogaQYmTM5+AHcQMVNO8dTYz
 yAIJgcWcEhuOHmCGaHaRWPb5CRuELSzx6vgWqKEyEv93zmeCaOhnlJja8gfKmcEo0XN4MxPI
 CxJA6/rO5ICYzAKaEut36UP0Okq8fb2eBaKCT+LGW0GIG/gkJm2bzgwR5pXoaBOCqFaS2Pnz
 CdRWCYnLTXOgYeghcfz1E9YJjIqzkHwzC8k3sxD2LmBkXsUonlpanJueWmyUl1quV5yYW1ya
 l66XnJ+7iRGY9E7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4b1/XiVJiDclsbIqtSg/vqg0J7X4
 EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA1OWZmKWNF9t2cJ5UT6Rd+ZvFk1eLCHN
 1LnBTU5M8kGgD7di0uEOuYMNTA9T1H63sTasC1nbrb1s8eNFnZlsi3UcLz6uy15QuXXNS4XH
 t6/OX7PS/zTnl0S2lLU9Opc1uv6oz9XVuv5Xxv6x5+Ed3s5prWXG9wy4V1TX+E9sVwv/8l37
 TuCiI8ICz3LN5jf/0G2/frM/+s4Np9MLTQ/duLRSrS1OsVbZNCvl3eG6iETBtpYVU69d0djN
 /aZP4sWBMLmN6hxrzL/822PuNVv9pd2ii9cN18xf8D76RFHkq+79quaLmIRdi1bHeilqub5K
 8un46ipZledgXLzLVUzx26k1lRbL8os/ZLyanDWvW4mlOCPRUIu5qDgRAFpL91DpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7ruXepJBjN3W1pMP6xosfpuP5vF
 77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
 eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
 ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
 WhmZKunb2aSk5mSWpRbp2yXoZdzskC5o5K34unwDawPjda4uRk4OCQETicVvl7F1MXJxCAks
 ZZR4vGgOI0RCQuL2wiYoW1jiz7UuqKLnjBJ39r5n7WLk4GAT0JJo7GQHiYsI3GCWWDa1jRHE
 YRbYziixYeUcNpBuYYFwiW3v+9lBbBYBVYlz89axgti8AlYS7zp/sENskJeYeek7mM0pYC3x
 tHMmWK8QUM2vA61MEPWCEidnPmEBsZmB6pu3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xUZ6
 xYm5xaV56XrJ+bmbGIExuu3Yzy07GFe++qh3iJGJg/EQowQHs5II7/3zKklCvCmJlVWpRfnx
 RaU5qcWHGE2B7p7ILCWanA9MEnkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalF
 MH1MHJxSDUyuh7lEV7++32nKd7fju4RF/CuXk0yKGivuci8u27lYOTQpq/rIvwd3ZLP/Sq6+
 cHLO0ivGK5sutGoXPz409f+jgAD2FptekZM93f0bHdKucU+6E2JdFXTuhtq3tHpOVtVtr7Z7
 3pU4rPVzCk/MhmMLBdVP88mePqy9x/HlswJ9xo6zxpM31kv4T/iR0+68N1jsz20RA4fvBgsj
 0q0r3dvdlrat0bxs37N7skaKmM/H/B1b+3+vevPUVr1V1UVt64G5a+e+L3Y5tnmHT8nmqZcY
 RO9UN7dsFa6LavVTCY1w73WSDzdqZxL5E7d8QcOs26xRnaZtun9urrplpPwhLNP7jqHqyyzO
 sKuMTzctWqnEUpyRaKjFXFScCADx9YTAWgMAAA==
X-CMS-MailID: 20220308165432eucas1p18b36a238ef3f5a812ee7f9b0e52599a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220308165432eucas1p18b36a238ef3f5a812ee7f9b0e52599a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165432eucas1p18b36a238ef3f5a812ee7f9b0e52599a5
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165432eucas1p18b36a238ef3f5a812ee7f9b0e52599a5@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_085434_746250_ABA2B639 
X-CRM114-Status: GOOD (  14.03  )
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

A new member is added to request_queue struct to indicate if power_of_2
emulation is enabled. Helpers are also added to get and set that member.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/blkdev.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 08cf039c1622..3a5d5ddc779c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -463,6 +463,7 @@ struct request_queue {
 	unsigned long		*seq_zones_wlock;
 	unsigned int		max_open_zones;
 	unsigned int		max_active_zones;
+	bool			po2_zone_emu;
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 	int			node;
@@ -705,6 +706,18 @@ static inline unsigned int queue_max_active_zones(const struct request_queue *q)
 {
 	return q->max_active_zones;
 }
+
+static inline void blk_queue_po2_zone_emu(struct request_queue *q,
+					  bool po2_zone_emu)
+{
+	q->po2_zone_emu = po2_zone_emu;
+}
+
+static inline bool blk_queue_is_po2_zone_emu(struct request_queue *q)
+{
+	return q->po2_zone_emu;
+}
+
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
 {
@@ -728,6 +741,17 @@ static inline unsigned int queue_max_active_zones(const struct request_queue *q)
 {
 	return 0;
 }
+
+static inline bool blk_queue_is_po2_zone_emu(struct request_queue *q)
+{
+	return false;
+}
+
+static inline void blk_queue_po2_zone_emu(struct request_queue *q,
+					  unsigned int po2_zone_emu)
+{
+}
+
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 static inline unsigned int blk_queue_depth(struct request_queue *q)
-- 
2.25.1


