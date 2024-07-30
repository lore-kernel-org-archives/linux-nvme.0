Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7A0C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jul 2024 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+L4Ft/kELzWTlysNn6EcImn+LHTENXXmosLKNr+cUUE=; b=WPs0X7OIR/faTQyM1NuTVX5rLc
	0fM1mhLs35RUVFF+BHsSIT0DmFzZ0VgQS2nr/nfNYjIPnbXrHW9/317isIbppH00bd1LLLjK3NGeQ
	Bm5HZjpYltNsz2tSq6yrUTssu46s7rY7wRjX5WIFcVa9ypNSh3XpLEwj4ckWXC030mQZWQ4PM2wNR
	cEZXTxCe2DwJLvLcH0AqVR8g4+drVrVZIn1wU60oIcKPft4eqo7CBMIu0pnyWOZrxbvOzyUE4XvEl
	f/y0g2CswENiTJ5Ni9GWyBVyx2IdwPbUVyNW9GPtuUd0a/6Up8gofmkj1+7v/sJXEKsZ+V9m1CnxV
	X2EJTJ8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYkGx-0000000ElZq-2phR;
	Tue, 30 Jul 2024 10:40:03 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYkGs-0000000ElXc-3Chu
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jul 2024 10:40:00 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240730103947epoutp019b3d19e73eadc1b1ab2784ac596cf002~m93R_2MlU0035200352epoutp01G
	for <linux-nvme@lists.infradead.org>; Tue, 30 Jul 2024 10:39:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240730103947epoutp019b3d19e73eadc1b1ab2784ac596cf002~m93R_2MlU0035200352epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722335987;
	bh=+L4Ft/kELzWTlysNn6EcImn+LHTENXXmosLKNr+cUUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JrKlvJ3u1M0OpZhJs6xqlxo/ghVGFnu4sZuf6ehRBFtwg1u5UQm3rmC2+zb1lnN0k
	 eBK4aynWxVWmmiSvD6jDgtjDW8a+zNh9/thZTs5DB/ngWYuKgWG/t3rc7GWpLLwxkr
	 xn4CxdCyNKQZngc30LHL1ZpJERg2qDimyo3AnJAM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240730103946epcas5p32bd939b6075e24593970b7d92f9b6c2f~m93Rf4SbC2712427124epcas5p3A;
	Tue, 30 Jul 2024 10:39:46 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WYBYs3Qpyz4x9Pp; Tue, 30 Jul
	2024 10:39:45 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.A9.08855.1F2C8A66; Tue, 30 Jul 2024 19:39:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240730103945epcas5p3d07f1d9d6d6fee323ef1ae95abde00c5~m93P8HCx72712527125epcas5p32;
	Tue, 30 Jul 2024 10:39:45 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240730103945epsmtrp1531e18993f77676e7e9aca3914cd3e61~m93P7dyZ93266432664epsmtrp16;
	Tue, 30 Jul 2024 10:39:45 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-ee-66a8c2f11ec6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.DD.07567.0F2C8A66; Tue, 30 Jul 2024 19:39:44 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240730103944epsmtip12deb0728d67d74d86844a31cd8bfc634~m93PGgXE91677916779epsmtip1E;
	Tue, 30 Jul 2024 10:39:44 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 3/3] nvme: reorganize nvme_ns_head fields
Date: Tue, 30 Jul 2024 16:01:38 +0530
Message-Id: <20240730103138.66714-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240730103138.66714-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmhu7HQyvSDN78kbBYufook8XR/2/Z
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6NuyijGANSrbJiM1MSW1
	SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdouZJCWWJOKVAoILG4
	WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2NH/yPmgqkc
	Fbe2PWdrYFzN1sXIySEhYCKx/NIe1i5GLg4hgd2MEnPuTWGDcD4xSsyY+Z0JwvnGKDFtzgZG
	mJaLE7ZBVe1llHh6/QxU1WdGiY73B1i6GDk42AQ0JS5MLgVpEBEwluhc2cACYjMLuEvcftLD
	BGILC1hKfJ+1GCzOIqAqcbv1CNhNvAIWEjsW/GOCWCYvMfPSd3YQmxOofuuKk1A1ghInZz6B
	mikv0bx1NjPIDRIC19glOo7eYododpE4e6UP6mphiVfHt0DFpSRe9rdB2dkSDx49YIGwayR2
	bO5jhbDtJRr+3GAF+YUZ6Jf1u/QhdvFJ9P5+wgQSlhDglehoE4KoVpS4N+kpVKe4xMMZS1gh
	SjwkHnwUh4ROD6PErWvT2Scwys9C8sEsJB/MQli2gJF5FaNkakFxbnpqsmmBYV5qOTxek/Nz
	NzGCk6CWyw7GG/P/6R1iZOJgPMQowcGsJMIbf2VpmhBvSmJlVWpRfnxRaU5q8SFGU2AQT2SW
	Ek3OB6bhvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamAy/iV6u
	j2zi+j1beWLEHuF7HpyJcY+y/5xa91t77bfaD7mzd7Ef4jBc/3kZXzBjs91qblXX63UTzOYk
	tgu1if2/buu37G3dg7zfEjc0JaQzud2aIjfvTZ5TaO2b537VSsVrEdfkz6HSP5qFrIN0L6gJ
	fi02s36oU3bl4O43e44sCebMvf2aU+62taDMTadkrUMZf3asz9n1Y9nseVEt3Qkf9K/wr12W
	WNARcpvlnBnHjBueL+7KGh7omy0uXtTSKbeR0ehL35r4gPO7l9sciXl56JaZ3PwTNtMyLh0w
	8dylKPZx0yH3xkn5x87fMp8z78FKr8vTMhJNb6k1zJ6cnapa7c91Zcf7+QY8LyQeLlZiKc5I
	NNRiLipOBAD/FKFrCwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO6HQyvSDHYdsLZYufook8XR/2/Z
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6NuyijGANYrLJiU1J7Ms
	tUjfLoErY0f/I+aCqRwVt7Y9Z2tgXM3WxcjJISFgInFxwjYgm4tDSGA3o0THx/2sEAlxieZr
	P9ghbGGJlf+es0MUfWSUuNg4j6mLkYODTUBT4sLkUpAaEQFziX0XnrOChJkFPCXWT5QHCQsL
	WEp8n7WYBcRmEVCVuN16BGwvr4CFxI4F/5ggxstLzLz0HWwVJ1D91hUnwWqEgGpmv/vNDFEv
	KHFy5hOwOcxA9c1bZzNPYBSYhSQ1C0lqASPTKkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT8
	3E2M4PDV0tjBeG/+P71DjEwcjIcYJTiYlUR4468sTRPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
	azhjdoqQQHpiSWp2ampBahFMlomDU6qBieX/jzcXTurvUnZ+9Ec8Y1tWu3BZ4s/Z1je+fXp6
	8NzSvyfmPrn82fK81Qa2CVzny4TO62Teyuiv/mFg5p2Welw9YR9vHmvwr8N8xVWJ9ypPCzzm
	clbrY1+yqUVlRttd1RU9/UV2PbvP+VyUCysszj0tkBm6TY2hRjP1qN2cD1bJzB9lBf+eONfH
	cFCwLs+DcfN3w+yVr5/+2P1om1jvIRU5Ccuk5YW8PKzW6qyvT8yRSHSTWOe/q6vG7uShp9ua
	Ar1v/LDhba3dt/4/y+x/H/6UL/NgEPf7L6XnU/CH46CCBQOf245je8RWcx8KPrPczXXr3prV
	W+1+RUWn2Vqf4/C5tun6nn8nRK+cy+O6r8RSnJFoqMVcVJwIAK5TCvLOAgAA
X-CMS-MailID: 20240730103945epcas5p3d07f1d9d6d6fee323ef1ae95abde00c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730103945epcas5p3d07f1d9d6d6fee323ef1ae95abde00c5
References: <20240730103138.66714-1-joshi.k@samsung.com>
	<CGME20240730103945epcas5p3d07f1d9d6d6fee323ef1ae95abde00c5@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_033959_153907_476BF437 
X-CRM114-Status: GOOD (  16.12  )
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

shuffle few fields to reduce the holes within nvme_ns_head.
On x86_64, the size is reduced to 1104 bytes from 1120 bytes.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/nvme.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7bfa410d055e..67ab626861d3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -462,19 +462,19 @@ struct nvme_ns_head {
 	struct srcu_struct      srcu;
 	struct nvme_subsystem	*subsys;
 	struct nvme_ns_ids	ids;
+	u8			lba_shift;
+	u16			ms;
+	u16			pi_size;
+	u8			pi_type;
+	u8			guard_type;
 	struct list_head	entry;
 	struct kref		ref;
 	bool			shared;
 	bool			passthru_err_log_enabled;
-	int			instance;
 	struct nvme_effects_log *effects;
 	u64			nuse;
 	unsigned		ns_id;
-	u8			lba_shift;
-	u16			ms;
-	u16			pi_size;
-	u8			pi_type;
-	u8			guard_type;
+	int			instance;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64			zsze;
 #endif
-- 
2.25.1


