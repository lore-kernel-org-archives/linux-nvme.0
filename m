Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206D0D65C7E
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 11:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n6LNHR2UxOEOGCqUSfrJ4D/dcAXYHqklNM5hsVN/lLY=; b=wWzFF4N3GqZHgO4X2W21rNmMxI
	5wjBNO5BdTBf9jJHtj0eT0Ql0f8+PsYiYnnWXeU64tVsyS7ZZt/RQlqAnIg/f75Z9S/Y0C9dJ/28P
	v2POsvBhLTgLOtDYMzU4huuGcJFFJV1Ktisu4plQhp46BAH4NGKd/qN66jJoX1L8/Ul75zctyG2um
	b6yY6nAA0ORmPRv8mxZhMUQ4Dh+ksAdS3W4xt+JgQASEWUKAVeWSmsWtk8Xeb4LdkMSCa2v80x9a/
	hAdbtNI6JccclDUjAsCba13gA/d3ddHffQNQgaLXeoZk4UTRW5YAWB/O08EpC3T3Xa7ZCo12/P6jA
	8UXO3O4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYTr-00000009oJA-1ave;
	Thu, 14 Nov 2024 11:57:47 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBXth-00000009hxa-0z17
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 11:20:29 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241114112022epoutp04993dfa2d2fb8b233ca3abdae85ec84ac~H0cRSWhpD2083220832epoutp04Q
	for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2024 11:20:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241114112022epoutp04993dfa2d2fb8b233ca3abdae85ec84ac~H0cRSWhpD2083220832epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731583222;
	bh=n6LNHR2UxOEOGCqUSfrJ4D/dcAXYHqklNM5hsVN/lLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OM6NmlR52Cq2DMdAggMa8MQtckr72iZZ0CEu6K/p9h082lCqLnBe5ZijP0l5km1t3
	 r+Ye7UquJz5u61n5YE5ZjJGAi0AAoj9k25ScClzkPs4GaRwPz/fo72tk+KzqmDBarY
	 +4T+lN++ZTNZKERnehHiqOxnUH859FzkYPj/6me8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241114112022epcas5p4dd08b555c954d3b09f3284c37456fadd~H0cQfbZ250985409854epcas5p4c;
	Thu, 14 Nov 2024 11:20:22 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XpyPJ0wMlz4x9Q6; Thu, 14 Nov
	2024 11:20:20 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E6.4F.37975.43CD5376; Thu, 14 Nov 2024 20:17:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241114105352epcas5p109c1742fa8a6552296b9c104f2271308~H0FHthlII2293722937epcas5p1j;
	Thu, 14 Nov 2024 10:53:52 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241114105352epsmtrp1bd5dd694a5fd20726a4d1a142a50e997~H0FHsqFUZ1625716257epsmtrp1s;
	Thu, 14 Nov 2024 10:53:52 +0000 (GMT)
X-AuditID: b6c32a50-0e7f370000049457-80-6735dc3485ee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	07.5A.07371.FB6D5376; Thu, 14 Nov 2024 19:53:51 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241114105349epsmtip2dea0f764454904e67d42a12e5e3f9985~H0FFVzS1y1405814058epsmtip2G;
	Thu, 14 Nov 2024 10:53:49 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v9 01/11] block: define set of integrity flags to be
 inherited by cloned bip
Date: Thu, 14 Nov 2024 16:15:07 +0530
Message-Id: <20241114104517.51726-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241114104517.51726-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVRTZRzHe+69u9vojDMY6XN2jjFvGQeUl+W2Lm+ZwencSovTy6lTCi52
	Hcje2ktmp2xJUAxpDPGFQaEcMxkBneEIkoENAlkIBCSwoLfDNBIlJULSddq4WP73+f2e7+/1
	eR4OGjmBCzn5GiOt18hVBB6GtXbHxsQvTEmVSbbKKPL64i2MPFAeQMkaRysgG6atOHml+wYg
	J8+1I2R9wzcIea1oECOrjxYiZIXnIiDdvo1kh7sfI2tP+dlk6XgbTn7W9w9CDgX6WOSQvYb9
	WATVbp9mU6MXTJTTUYJTLSffpc5OmnHqut+HUR+dcQBq4HgPm1pw3k85Z64iWWGvFKTl0XIF
	rRfRmlytIl+jTCeefj4nI0cqSxLHi5PJRwiRRq6m04nMbVnxT+SrguMQojfkKlPQlSU3GIjE
	R9P0WpORFuVpDcZ0gtYpVDqJLsEgVxtMGmWChjamiJOSHpYGhbsK8qy+U0A3cu+bvVYnMINr
	XAvgciBfAkc6K0GII/kdADbPciwgLMg3APzy+zmEMf4CsP+nUrYFcFYifqnfyvjdAL5f0ogy
	xgKArg4XK5QK58fAnstFIHQQFUpbduJbLGSg/FkAP3XUYSGVgJ8NRy4dwkNpMf4GOD/1TsjN
	4yfDo1d9LKa/aFg1ssQOMZefAk+bXSijiYD9VTMradCgptBVjTL6MQ4c82oZzoRNAxM4wwL4
	e98ZNsNCOGstXmUlvDnqRxjWwcLeTsDwFljktaKh1lB+LGz+KpFxr4OHvU0IUzYclt2aWQ3l
	wbZP7jABP6ivWWUI3YPmVaZgwFaPM8sqC656eQArByL7XePY7xrH/n/p4wB1ACGtM6iVdK5U
	J47X0Hv/u+VcrdoJVp54XFYbaPgikOABCAd4AOSgRBTPm7FZGclTyPe9Reu1OXqTijZ4gDS4
	bxsqvC9XG/wjGmOOWJKcJJHJZJLkzTIxsZZ3pehjRSRfKTfSBTSto/V34hAOV2hGdlfU2XpO
	iH++h3uhu+Vibx6vK2VvxWnw2vYtD5UsC/ze5rGu24YPE0c32Rel0/Tnc/M1YcuJgoOys5zn
	rLuoiXD2XNzNY4FUSwad8mTxuF+wZuiBxqXXBRuxpfY03/genLdpsbAVLR1aF61+Rur6c9I8
	/953Ik/E1P4/KrJl1bGWI+cteybTdhSzjz24r/+l2vb8If/623gRGr5m7bBq96t1OY3UJS/7
	x5fH3BtSdS2tkhdiBk4e2dnwrM20NbOa5Voof3F/fpMwYbpqeIqaiqp7+7dfv378h1Sec2nQ
	KRsMxCT7dnRu//vQueyy4cB6QQFLUlt54KmqLtnOwZnF6Mve7PMEZsiTi+NQvUH+Lwp5Ag1r
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXnf/NdN0g4t3TSw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBaTDl1jtNh7S9tiz96TLBbz
	lz1lt+i+voPNYvnxf0wW5/8eZ7U4P2sOu4Ogx85Zd9k9Lp8t9di0qpPNY/OSeo/dNxvYPD4+
	vcXi0bdlFaPHmQVH2D0+b5Lz2PTkLVMAVxSXTUpqTmZZapG+XQJXRv+tZYwFl7grjvVvYmxg
	fMfZxcjBISFgIvFwpWMXIxeHkMBuRom/D+6wdDFyAsUlJE69XMYIYQtLrPz3nB2i6COjxJIv
	i8ESbALqEkeet4LZIgInGCXmT3QDKWIGKZrwZTYLyAZhgRiJb+/FQEwWAVWJ93dqQcp5BSwl
	pr+9xQoxX15i5qXv7CA2p4CVxIqGrcwg5UJANd/Xi0CUC0qcnPkE7DRmoPLmrbOZJzAKzEKS
	moUktYCRaRWjZGpBcW56brJhgWFearlecWJucWleul5yfu4mRnCEaWnsYLw3/5/eIUYmDsZD
	jBIczEoivKecjdOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xrOmJ0iJJCeWJKanZpakFoEk2Xi
	4JRqYFJY0qKXd+7a7WVX5r7c+8igeYuLZs6B5XoLtJmNOfKPiE4Rv5vVMs1ba1JFeP6NnhfN
	y5frTksPYEu4/qg4ceOfeotGSZPri+/WPhHu0XxioTJ/1dy9T4VWRpixqFX2T51n+1a/NOvj
	q0pd5Xc22QsUtv/dU1J/dcJX9cU7eitNTta27zQr9PAsiYlv3/39/Y23OYumyMccV12zQvKH
	fGd/9/7bGmGTFytG6Dg9vSXgqmJptufHfuNZPflKNvOi9RnOLF78rFPq7MtbMXvv7mdr3mWp
	6XFm/8vjzfOaizxFFp6sLz3k9FjI+eL9z6Ey3pc/ms5xCkz4Z2zRwFto9vzFRlvTON73j1wM
	1k3bzKfEUpyRaKjFXFScCABMjY5XHwMAAA==
X-CMS-MailID: 20241114105352epcas5p109c1742fa8a6552296b9c104f2271308
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241114105352epcas5p109c1742fa8a6552296b9c104f2271308
References: <20241114104517.51726-1-anuj20.g@samsung.com>
	<CGME20241114105352epcas5p109c1742fa8a6552296b9c104f2271308@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_032025_689648_74C204F5 
X-CRM114-Status: GOOD (  17.09  )
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

Introduce BIP_CLONE_FLAGS describing integrity flags that should be
inherited in the cloned bip from the parent.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c         | 2 +-
 include/linux/bio-integrity.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 2a4bd6611692..a448a25d13de 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -559,7 +559,7 @@ int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 
 	bip->bip_vec = bip_src->bip_vec;
 	bip->bip_iter = bip_src->bip_iter;
-	bip->bip_flags = bip_src->bip_flags & ~BIP_BLOCK_INTEGRITY;
+	bip->bip_flags = bip_src->bip_flags & BIP_CLONE_FLAGS;
 
 	return 0;
 }
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index dbf0f74c1529..0f0cf10222e8 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -30,6 +30,9 @@ struct bio_integrity_payload {
 	struct bio_vec		bip_inline_vecs[];/* embedded bvec array */
 };
 
+#define BIP_CLONE_FLAGS (BIP_MAPPED_INTEGRITY | BIP_CTRL_NOCHECK | \
+			 BIP_DISK_NOCHECK | BIP_IP_CHECKSUM)
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 
 #define bip_for_each_vec(bvl, bip, iter)				\
-- 
2.25.1


