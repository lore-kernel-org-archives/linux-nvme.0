Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7C5C52D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 10:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fdfNA1BhNobCcdbbPzAPNJ/9rXGRREf8RhQ25IpYD8c=; b=cRLqc3E3qWXGzrieR1sqCPr+x0
	CatbMhc7ZwWESa9cnnQx3kzQFf/PFIGHtNm6DFMNr+To36iVlLBTbxkyKYVsnx1PB24HQorYqgZIL
	ZgAGYK79zOk2VfyEfNKcMPD0QC/LpJzaqlhUC/+8pGOKqyoZ+wiD1bebMot9ErHQJPBep6gWdSYny
	E6WU3gYZBk/OmKmL1LMuo4mQQKmA4ulIrHfcCKh+qjfPqQXlOSG/oPHxpCPW3+Xo3igKzop3A+0QP
	wXPO7Gi6H1p9VmtzHR4jclLEabBQX5jPz9CH0jiUoCk6AKauXBDdBK3ThKNvp81VFWn2YjPZR3EiY
	Upp7Bvmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shRqm-0000000GPGo-0wS3;
	Fri, 23 Aug 2024 10:49:00 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shRqM-0000000GOlr-2jHp
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 10:48:37 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240823104830epoutp01e4e616c00108d8dfde31707414e53ba2~uVdvzyHuO0367503675epoutp01y
	for <linux-nvme@lists.infradead.org>; Fri, 23 Aug 2024 10:48:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240823104830epoutp01e4e616c00108d8dfde31707414e53ba2~uVdvzyHuO0367503675epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724410110;
	bh=fdfNA1BhNobCcdbbPzAPNJ/9rXGRREf8RhQ25IpYD8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IaH3U1m05Yq56Z7hn3yIih+AQk+KehLWxeJp1gGJ34wrKxTb3vFMnkr0+e2m27HBj
	 sNQtTIKYVa9CbCR7Y7hboZXtiQMihPnR/YNn3mpOB5Ht2DQeht+oyseuZ5P/e9uL6Y
	 bD1nFR16J2gRb4QsvXxhFL25Jx69fLczp8zbXdWo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240823104830epcas5p4826c24b394f3cb5b21217d069f39561b~uVdvg2IsV1745317453epcas5p4t;
	Fri, 23 Aug 2024 10:48:30 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Wqxcr3YY8z4x9Q1; Fri, 23 Aug
	2024 10:48:28 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.8A.19863.CF868C66; Fri, 23 Aug 2024 19:48:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240823104629epcas5p3fea0cb7e66b0446ddacf7648c08c3ba8~uVb-MALz22095320953epcas5p3W;
	Fri, 23 Aug 2024 10:46:29 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240823104629epsmtrp132972e540270c63d4dfd7abdd7d847fe~uVb-LNNz00257302573epsmtrp1N;
	Fri, 23 Aug 2024 10:46:29 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-1e-66c868fc3e24
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.6F.07567.58868C66; Fri, 23 Aug 2024 19:46:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240823104627epsmtip2ec3a72087ba73c78ad139cde0b1e31dc~uVb9G5eM91384313843epsmtip2T;
	Fri, 23 Aug 2024 10:46:27 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH v3 07/10] block: introduce BIP_CHECK_GUARD/REFTAG/APPTAG
 bip_flags
Date: Fri, 23 Aug 2024 16:08:07 +0530
Message-Id: <20240823103811.2421-8-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823103811.2421-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmpu6fjBNpBj/XiVs0TfjLbDFn1TZG
	i9V3+9ksbh7YyWSxcvVRJot3redYLI7+f8tmMenQNUaL7WeWMlvsvaVtMX/ZU3aL7us72CyW
	H//H5MDrsXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49Pb7F49G1Zxeix+XS1x+dNcgGcUdk2
	GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBHKymUJeaU
	AoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM9ZN
	3MlW0CRRcXqKUAPjfeEuRk4OCQETiTufjjKC2EICexglzj8p6WLkArI/MUoc29HDAuF8Y5SY
	ce83G0zH9su7GCESexklTjx6zwThfGaUOHdzDjNIFZuAusSR561gc0UEKiWe7/oBNopZ4Caj
	xKG9z8CKhAVCJL7eOc4KYrMIqEqcbF4IFucVsJCY/KyNHWKdvMTMS9/BbE4BS4mm2Q0sEDWC
	EidnPgGzmYFqmrfOZgZZICGwkkPi2usWqFtdJA4tWgllC0u8Or4FaqiUxMt+mAXpEj8uP2WC
	sAskmo/tY4Sw7SVaT/UDDeUAWqApsX6XPkRYVmLqqXVMEHv5JHp/P4Fq5ZXYMQ/GVpJoXzkH
	ypaQ2HuuAcr2kOg69YYdElo9jBI7Tv5hncCoMAvJP7OQ/DMLYfUCRuZVjFKpBcW56anJpgWG
	unmp5fBoTs7P3cQITslaATsYV2/4q3eIkYmD8RCjBAezkghv0r2jaUK8KYmVValF+fFFpTmp
	xYcYTYEhPpFZSjQ5H5gV8kriDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi
	4JRqYCoUz3ggYfouYu53voI6Z0NFycVbq44ahdu/5rw36WOI25tbymvlWZYeDvjnMmVi0pT7
	rEIxUa9fTv0cNXG36+TKhXx7H9nL5eySjD4kXJLWL8/BtEN9vsXJ7RsvsN94l8CrYimnyn1q
	gf2f5hsrfdd1tN3P7iqVT1nrVsP3kGXV8sLDv89dXr2iQd6iSsvGZH10x53ItFVL2/TUP+XP
	dZBQUb0x1VpguYbC1TIbM8lXaeGGJezzo69c/HXm35fygIoVzY1WnKH31T/z9Gk0m67esyu4
	PmStl9xObafL05hus1azvS7aN9mySPGh07JrOxn3zjJzfWX+XqLu2PHTL/8J1Ga6PuLcd9jA
	WXeujBJLcUaioRZzUXEiADNVJKNSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvG5rxok0g3+NkhZNE/4yW8xZtY3R
	YvXdfjaLmwd2MlmsXH2UyeJd6zkWi6P/37JZTDp0jdFi+5mlzBZ7b2lbzF/2lN2i+/oONovl
	x/8xOfB67Jx1l93j8tlSj02rOtk8Ni+p99h9s4HN4+PTWywefVtWMXpsPl3t8XmTXABnFJdN
	SmpOZllqkb5dAlfGuok72QqaJCpOTxFqYLwv3MXIySEhYCKx/fIuxi5GLg4hgd2MEi//nmWF
	SEhInHq5jBHCFpZY+e85O0TRR0aJX3/XsoAk2ATUJY48bwXrFhFoZJTY0vwFLMEscJ9RYkF3
	CIgtLBAksfDQbDYQm0VAVeJk80JmEJtXwEJi8rM2dogN8hIzL30HszkFLCWaZjeAzRECqlm2
	/AwjRL2gxMmZT6Dmy0s0b53NPIFRYBaS1CwkqQWMTKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz
	0vWS83M3MYJjRktjB+O9+f/0DjEycTAeYpTgYFYS4U26dzRNiDclsbIqtSg/vqg0J7X4EKM0
	B4uSOK/hjNkpQgLpiSWp2ampBalFMFkmDk6pBqaTSr9rrUrWm6w9HHd279VZPzzk3c6Zqv/I
	O9FgXO908qne7HlrbzucqvDyYdj+d4vi0b2LfiQZznXPPq3cK/ysRc/duHjCix9rWz3841ru
	67XbvG7YFzz3eNPc+8tWbIouXXze9/xuzRaufqvcjQHl+y+kn/ygzmztxJEWFHD75PSJSvFW
	hUuvrBPdl2wn8Te3pVjlytEV+kzPJ8Z3P1dSfyrdNiFiJq/qWfk5L3gMPnKckNnvpnp80Qnu
	i/NDnyxoOX6VaXPgugelLOq+xyVMXt1zKHivZh9w4emk536T/1ZcP6qo6P+pXe48x5prz3Yf
	iVFpeyyy//Dj1pJndqwX9E3CvW/a7rKqmiuxepOGEktxRqKhFnNRcSIAQo2TTwgDAAA=
X-CMS-MailID: 20240823104629epcas5p3fea0cb7e66b0446ddacf7648c08c3ba8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240823104629epcas5p3fea0cb7e66b0446ddacf7648c08c3ba8
References: <20240823103811.2421-1-anuj20.g@samsung.com>
	<CGME20240823104629epcas5p3fea0cb7e66b0446ddacf7648c08c3ba8@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_034835_158814_B200CCBD 
X-CRM114-Status: GOOD (  20.18  )
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
indicate how the hardware should check the integrity payload. The
driver can now just rely on block layer flags, and doesn't need to
know the integrity source. Submitter of PI decides which tags to check.
This would also give us a unified interface for user and kernel
generated integrity.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/bio-integrity.c         |  5 +++++
 drivers/nvme/host/core.c      | 12 +++---------
 include/linux/bio-integrity.h |  6 +++++-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index aaf67eb427ab..7fbf8c307a36 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -444,6 +444,11 @@ bool bio_integrity_prep(struct bio *bio)
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
index 33fa01c599ad..d4c366df8f12 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1002,19 +1002,13 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
 		}
-
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
index a1a9031a5985..c7c0121689e1 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -11,6 +11,9 @@ enum bip_flags {
 	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
 	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
 	BIP_COPY_USER		= 1 << 5, /* Kernel bounce buffer in use */
+	BIP_CHECK_GUARD		= 1 << 6,
+	BIP_CHECK_REFTAG	= 1 << 7,
+	BIP_CHECK_APPTAG	= 1 << 8,
 };
 
 struct bio_integrity_payload {
@@ -40,7 +43,8 @@ struct uio_meta {
 };
 
 #define BIP_CLONE_FLAGS (BIP_MAPPED_INTEGRITY | BIP_CTRL_NOCHECK | \
-			 BIP_DISK_NOCHECK | BIP_IP_CHECKSUM)
+			 BIP_DISK_NOCHECK | BIP_IP_CHECKSUM | \
+			 BIP_CHECK_GUARD | BIP_CHECK_REFTAG | BIP_CHECK_APPTAG)
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 
-- 
2.25.1


