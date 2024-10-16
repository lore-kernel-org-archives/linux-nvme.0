Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4B6D1AD5E
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 13:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j7kMMqrhvwE2U0rxzDSx84hS80YAqcLX62yw/e5POuY=; b=NJzkhiYkQcHpEYZuUjoy6Z8k9j
	hB6SrBL98FCzXlKdOfVA6jUpKzfHOaZo5kzuevBR5h/Ln3WQHy9arHh4U7IU14WvM0NXkPfBZJsyB
	yPU+KP/wdHp+KfNxXLJtjJkU9mPWAwWh4lvf166KygkgHftg3myjHHcizciFtf/WNrraSCxKwqSdy
	nFhjLCKWUvgXIocR24rSRRTIvADREB8Mqv0O5r7ysufFeo91enlODEE9jm1A9MJZb/Qpsi5InC+RM
	g4v6jD5xBV9zC+Zx58+8CnNGCiWFIhnWpx7jPCHglH1PungYocQdvZsU5pKuBl/Kdxb6e8bx20DqX
	jGqndaIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t14LS-0000000Bxub-2Gcw;
	Wed, 16 Oct 2024 13:45:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t13GK-0000000Bl79-3FYt
	for linux-nvme@bombadil.infradead.org;
	Wed, 16 Oct 2024 12:36:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=j7kMMqrhvwE2U0rxzDSx84hS80YAqcLX62yw/e5POuY=; b=iSvmZFoCKDQAZ6k4DQKRDgb+op
	xPOwAWFrQXEcwdVnLnlzXgT0wNA2tSEnjAij90+0o0VYUEAp80DOoPTgcuEXWAunFJuh8OzMr5p2H
	Yqf70DR8y5Z1fPLyZapNU9B7qxMv3VmefRSCd8+cE2eafWhiwSWARJ2Mc8q3s5TUB/k8Z0wYekl8H
	o+aqqh61sJBZ4/aeOeMTx/6r9DN97gNH912lX6+6hvzwc7SsTAUjpfu8XaiynkA8Pu+unQ+mfJM9y
	CCZrvDnJpzCgzMU9aVWLxAjO5Jn0hbrrkV57Ry++dC9d3zYMOcuVgeoCoLAQ7Dz6CQB40UDmwwEWJ
	/MPeMfdw==;
Received: from mailout2.samsung.com ([203.254.224.25])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t13GG-00000006nTP-3kLQ
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 12:36:23 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241016123613epoutp026390fc0c1c84cdb38413ef76d1a8bdb6~_7xNtYTrD1522015220epoutp02T
	for <linux-nvme@lists.infradead.org>; Wed, 16 Oct 2024 12:36:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241016123613epoutp026390fc0c1c84cdb38413ef76d1a8bdb6~_7xNtYTrD1522015220epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729082173;
	bh=j7kMMqrhvwE2U0rxzDSx84hS80YAqcLX62yw/e5POuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTxxlxP2uiHNWdOkVRzGlZtNl38clk5mvooKlLnQkWC/5wbfrM2AqcD0wvincuxeF
	 1csi7r0ovhI3r8H8YEpEs/AQza847ZdUrmHwAIEgJEno5GqOAFK9AgkwIIzkSc+VF0
	 d7r2B2LZluGqF+IvG0iktE7harLsRvv5No1QQvOA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241016123613epcas5p4fefeb190c8f152295a5cdf8c574aa8d7~_7xNa1bVV1646816468epcas5p4f;
	Wed, 16 Oct 2024 12:36:13 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XT9SC1Myxz4x9Px; Wed, 16 Oct
	2024 12:36:11 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E3.01.09770.B33BF076; Wed, 16 Oct 2024 21:36:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241016113736epcas5p3a03665bf0674e68a8f95bbd5f3607357~_6_CEFDD92628326283epcas5p3B;
	Wed, 16 Oct 2024 11:37:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241016113736epsmtrp23f19cc615b949554c87694a6229b48af~_6_CDSKot1555115551epsmtrp2e;
	Wed, 16 Oct 2024 11:37:36 +0000 (GMT)
X-AuditID: b6c32a4a-e25fa7000000262a-c4-670fb33b0423
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EC.BA.08229.085AF076; Wed, 16 Oct 2024 20:37:36 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241016113734epsmtip176042ea87fdd663dbe664cf7e714eea5~_6_AIsgrp2871328713epsmtip12;
	Wed, 16 Oct 2024 11:37:34 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	krisman@suse.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH v4 02/11] block: copy back bounce buffer to user-space
 correctly in case of split
Date: Wed, 16 Oct 2024 16:59:03 +0530
Message-Id: <20241016112912.63542-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016112912.63542-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmuq71Zv50g6Xf2C0+fv3NYtE04S+z
	xZxV2xgtVt/tZ7O4eWAnk8XK1UeZLN61nmOxmHToGqPF9jNLmS323tK2mL/sKbtF9/UdbBbL
	j/9jsjg/aw67A5/Hzll32T0uny312LSqk81j85J6j903G9g8Pj69xeLRt2UVo8fm09UenzfJ
	BXBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2u
	pFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUq
	TMjOmLnyHFPBZbaKm8tDGxhPsHYxcnJICJhITNwzl6WLkYtDSGA3o8TLNb/ZQBJCAp8YJR6u
	8YdIfGOUmDX9InMXIwdYx7rdaRA1exklLp/Oh6j5zCjxYvJ3JpAEm4C6xJHnrYwgtojAJEaJ
	55dDQWxmgVOMEmt/KYDYwgLJEr3bH4PVswioSvRtPgFWzytgKdFyYT8bxHXyEjMvfWcHsTkF
	rCROnTvIDlEjKHFy5hMWiJnyEs1bZzODHCEhsIVD4vuu3+wQzS4SW9rmQw0Slnh1fAtUXEri
	87u9UPF0iR+XnzJB2AUSzcf2MULY9hKtp/rBHmYW0JRYv0sfIiwrMfXUOiaIvXwSvb+fQLXy
	SuyYB2MrSbSvnANlS0jsPdcAZXtINLR3MUECq5dRord9OesERoVZSP6ZheSfWQirFzAyr2KU
	TC0ozk1PLTYtMMpLLYdHcXJ+7iZGcFLW8trB+PDBB71DjEwcjIcYJTiYlUR4J3XxpgvxpiRW
	VqUW5ccXleakFh9iNAUG+ERmKdHkfGBeyCuJNzSxNDAxMzMzsTQ2M1QS533dOjdFSCA9sSQ1
	OzW1ILUIpo+Jg1OqgSl1zsS3OcWpVm+EfY0nvD+sr9Ad6fKuwEZARmbGDJnUmQ+mPRF+pXG7
	wKdA131PDZ/1bL2PDuGTbqszibfYbhbr5r16Uj5h4zTdNTl9V0IbFCrbXqsHmDrEm3+4vfmn
	x8s/UU0ZM8s3q6+WZvff028ldOFw153FJyoP9J7uEo+q2Kv5+OJuTZd//xr3yvPP45HZ//bq
	zyMmaaIc+xJfX7urN+lD79IMq/vlFbkeeSm/cyfMuHU5+dUHXXueWt/L/zeFVnPbxfzLSJ2T
	+D6BPSLom05m9YvDuTMffXu5aHKfd+mfsC4l/6tHkuy8RB7u3ZH4RduyM9/xnzBf/ubsfbJ+
	5h0SM82uT5Zj+//xlRJLcUaioRZzUXEiAHslh1VTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnG7DUv50gzUd4hYfv/5msWia8JfZ
	Ys6qbYwWq+/2s1ncPLCTyWLl6qNMFu9az7FYTDp0jdFi+5mlzBZ7b2lbzF/2lN2i+/oONovl
	x/8xWZyfNYfdgc9j56y77B6Xz5Z6bFrVyeaxeUm9x+6bDWweH5/eYvHo27KK0WPz6WqPz5vk
	AjijuGxSUnMyy1KL9O0SuDJmrjzHVHCZreLm8tAGxhOsXYwcHBICJhLrdqd1MXJxCAnsZpSY
	1zYRKM4JFJeQOPVyGSOELSyx8t9zdoiij4wSz14cBkuwCahLHHneygiSEBGYxShxeNZ8JhCH
	WeACo8TVfc/YQVYICyRKTL0mCtLAIqAq0bf5BFgzr4ClRMuF/WwQG+QlZl76zg5icwpYSZw6
	dxDMFgKq+Tf5A1S9oMTJmU9YQGxmoPrmrbOZJzACbUVIzUKSWsDItIpRMrWgODc9t9iwwDAv
	tVyvODG3uDQvXS85P3cTIzh2tDR3MG5f9UHvECMTB+MhRgkOZiUR3kldvOlCvCmJlVWpRfnx
	RaU5qcWHGKU5WJTEecVf9KYICaQnlqRmp6YWpBbBZJk4OKUamBo0Pc3vLkrkZF9S18HPcNCu
	oOdAkeNKiyUZ8vZaUovOzHOtu7jE25+xyTZ98rfU+LMSZxvPtp2sqbf9K/v3fktfyKk9aj0L
	D3dv9ZlXb3d2p7fgsw3r2+3C0rwWe75ef+xkJ/+O1luVbJKq+elndwUp7dXYfrGa6Xd6Xv8h
	nwNP1CeVfbOfGW9QeHXDr/cKnbfObUj3dtyhIVOS93nnYrXiE1kK3477x/M/1dh3bMt1YZ3G
	+n93C4PnZ1dfzj0w7bXRjab90oleuTN0N+18keH+KOvx5kk6+6Mv1EuprZ+isnSVV8XmhNCO
	mFvx61WOd5yw5Zjn/GmHQJzeMrEjR1WTBNmUw+IEChfa5r98p8RSnJFoqMVcVJwIACMVt0YM
	AwAA
X-CMS-MailID: 20241016113736epcas5p3a03665bf0674e68a8f95bbd5f3607357
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016113736epcas5p3a03665bf0674e68a8f95bbd5f3607357
References: <20241016112912.63542-1-anuj20.g@samsung.com>
	<CGME20241016113736epcas5p3a03665bf0674e68a8f95bbd5f3607357@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_133621_619870_343D3980 
X-CRM114-Status: GOOD (  15.56  )
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

Copy back the bounce buffer to user-space in entirety when the parent
bio completes.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 8c41a380f2bd..8948e635432d 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -119,8 +119,8 @@ static void bio_integrity_unpin_bvec(struct bio_vec *bv, int nr_vecs,
 static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 {
 	unsigned short nr_vecs = bip->bip_max_vcnt - 1;
-	struct bio_vec *copy = &bip->bip_vec[1];
-	size_t bytes = bip->bip_iter.bi_size;
+	struct bio_vec *copy = &bip->bip_vec[1], *bvec = &bip->bip_vec[0];
+	size_t bytes = bvec->bv_len;
 	struct iov_iter iter;
 	int ret;
 
-- 
2.25.1


