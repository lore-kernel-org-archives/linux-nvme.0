Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD02AC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nXGPzER1JF01Eq/Va1G8I1f4os1fOKXD7EF9v6r4iM4=; b=rBMQ2W/ZzQ2WQkeooMCquQNye0
	TPj1sNZ3AbsO264h4xdG6CP/mY48FEncN4mwHExDA5gMv9j9uhsQAkw2IPgCEFB4pN8uVmw7bg9rN
	zGc6WdWSmTfxRMJiu4kT/alzeLQdydgeQgbPLqlzmNUXLkZr/BO2KejWVDTqi0OqHgFbmL8YMyzf0
	r3FaYt3FI/zgkbDJmrJnDF9GmTlMxa3QukO8+k/CDImxit6eQNIEeHC+58DvVRMHYTM54PupXVe7m
	CZsqaiiS5OZv4ln0V3T0veV5Iabk/kJ7B97QS3uLe1QnPZupQq1l1K1jlnXE81bnPCZhhUMzEYXgn
	RghD+a6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMR2m-00000006aXQ-0yDc;
	Wed, 26 Jun 2024 11:42:32 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMR2h-00000006aTn-1CSe
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 11:42:29 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240626114224epoutp028a3c628a4e24679d8632b4dd15c96ae8~ciyQVQslL3229732297epoutp02J
	for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 11:42:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240626114224epoutp028a3c628a4e24679d8632b4dd15c96ae8~ciyQVQslL3229732297epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719402144;
	bh=nXGPzER1JF01Eq/Va1G8I1f4os1fOKXD7EF9v6r4iM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMIXrI+/z+t9vEIoTmXtgVqAIiSKjt/H+LWGEwxhC35JGNoezhfqDSmRWsyM/1JZw
	 LocCenVyJ8iem/cHUzMmlugaR2VUt6mAvL4BkB8TeGdv+PgaE4b6PTM6j473LouFdr
	 8Ibx13p/3WrekINYi29Y8ZGb5/RSYbwE6aPTfH2A=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240626114224epcas5p47a3e3da5c0bc0c406bfb9ed989ec64e6~ciyP1O5oC0207802078epcas5p4I;
	Wed, 26 Jun 2024 11:42:24 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W8KYp3v2nz4x9Pp; Wed, 26 Jun
	2024 11:42:22 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EC.75.19174.E9EFB766; Wed, 26 Jun 2024 20:42:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240626101519epcas5p163b0735c1604a228196f0e8c14773005~chmOOAph61565315653epcas5p1H;
	Wed, 26 Jun 2024 10:15:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240626101519epsmtrp1fd3887d9cd4992b3258841181ca9ce27~chmONJVY91023810238epsmtrp1k;
	Wed, 26 Jun 2024 10:15:19 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-ed-667bfe9ebdf3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D9.6A.19057.73AEB766; Wed, 26 Jun 2024 19:15:19 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240626101518epsmtip1c3b688bf7716f6795f14ab17527fc687~chmMm6_kR0370603706epsmtip1C;
	Wed, 26 Jun 2024 10:15:18 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: asml.silence@gmail.com, mpatocka@redhat.com, axboe@kernel.dk,
	hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 05/10] block: introduce BIP_CLONED flag
Date: Wed, 26 Jun 2024 15:36:55 +0530
Message-Id: <20240626100700.3629-6-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626100700.3629-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmpu68f9VpBvO2yFrMWbWN0WL13X42
	i5WrjzJZvGs9x2Jx9P9bNotJh64xWuy9pW0xf9lTdovlx/8xWUzsuMrkwOWxc9Zddo/LZ0s9
	Nq3qZPPYvKTeY/fNBjaPj09vsXi833eVzaNvyypGj8+b5AI4o7JtMlITU1KLFFLzkvNTMvPS
	bZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOVFIoS8wpBQoFJBYXK+nb2RTll5ak
	KmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ+y63cxasIK3Ys/OLsYGxudc
	XYycHBICJhLnHtxi7mLk4hAS2MMosefjXFYI5xOjxPWerVDON0aJCfNXsMC0rJ0yixXEFhLY
	yyhxdF4qRNFnRomvjS2MIAk2AXWJI89bwWwRgVqJla3T2UGKmAUaGCW6J3xnB0kIC1hJXPp7
	Hmg5BweLgKrEtEtg9bwCFhLfz5xmhVgmLzHzEkQ5p4ClxJ3N26FqBCVOznwCdhAzUE3z1tlg
	P0gITOWQ2PL6KyPITAkBF4ln73wh5ghLvDq+hR3ClpJ42d8GZadL/Lj8lAnCLpBoPraPEcK2
	l2g91Q92GrOApsT6XfoQYVmJqafWMUGs5ZPo/f0EqpVXYsc8GFtJon3lHChbQmLvuQYo20Pi
	3LqJ0ADtYZR4eXk2ywRGhVlI3pmF5J1ZCKsXMDKvYpRKLSjOTU9NNi0w1M1LLYfHcnJ+7iZG
	cNLVCtjBuHrDX71DjEwcjIcYJTiYlUR4Q0uq0oR4UxIrq1KL8uOLSnNSiw8xmgLDeyKzlGhy
	PjDt55XEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwOR7JO78mjWq
	F25vv2F2lH2F2JP92lbP7HoyOGYtfm1VsvLsn3Idtt6u+qQFimGiO5gS5RcsbnbcbOryqiFh
	nXvzwo0dJ/5phSuHp1xg6FVWT66dcKZtz53pZk0dl1baq0t+ObPpW1GIsNqKNPeMvh2dSyPD
	+38vEv0ge/P0nUAttlM1U4yi/72vb9UEuvRbTSkv31evPe9TzjIk7f3mmm4iqJ9pPrG2/PhL
	btl/K5LcLmzK7FimYHwofWHmStH5kqye2q89D5RqfJ79Jn3qAq3fPa6NrP+WT/Y5+dH0g9wh
	i/z3E/amKyyf/iA/JP9DrrbFyfgFNarPVD6+vjfxd5mDgfWCkylGF03XZVg7KrEUZyQaajEX
	FScCAOfRShtDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnK75q+o0gxtrdS3mrNrGaLH6bj+b
	xcrVR5ks3rWeY7E4+v8tm8WkQ9cYLfbe0raYv+wpu8Xy4/+YLCZ2XGVy4PLYOesuu8fls6Ue
	m1Z1snlsXlLvsftmA5vHx6e3WDze77vK5tG3ZRWjx+dNcgGcUVw2Kak5mWWpRfp2CVwZu243
	sxas4K3Ys7OLsYHxOVcXIyeHhICJxNops1i7GLk4hAR2M0oc2nGNGSIhIXHq5TJGCFtYYuW/
	5+wQRR8ZJd61XAErYhNQlzjyvJURJCEi0MoocWBqC5jDLNDCKDG3tYUdpEpYwEri0t/zQB0c
	HCwCqhLTLoFN5RWwkPh+5jQrxAZ5iZmXvoOVcwpYStzZvB2sRgio5sHzZlaIekGJkzOfsIDY
	zED1zVtnM09gFJiFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgyNDS
	2sG4Z9UHvUOMTByMhxglOJiVRHhDS6rShHhTEiurUovy44tKc1KLDzFKc7AoifN+e92bIiSQ
	nliSmp2aWpBaBJNl4uCUamAKnqtV5diQwRkfYNPmOdHZoyvWi18yL0qv+0Da5yWbqneWJRdX
	ps214tto656VPPWPVqGaopz3fJH6OM8LFU9dFP663astTP9b8a8l+wNDT1PvRN6IAxv2Wtux
	N/pz7vZftPaiRIjyA9v6o/veKk3zYt02y3XF/IIZ8fy/4+5/Z7MWKAj9mxm/+9Myj55/Rftl
	v3cYZ239e9LkeNW2H4mmDKfN/900rtoiFW+TKWfFbP6c4cqTR/IXlk06nj2vQjQ/uunms7kB
	r7dY1jN7eIZ/4GrwPHrg3eLfDjtT3n81LkrdySgw4UpaQm7CtoCZ+3KW9OqFLtmfVpH7SzXn
	1+nNy2+tK8iNWZJrteBlkRJLcUaioRZzUXEiAHW0shj7AgAA
X-CMS-MailID: 20240626101519epcas5p163b0735c1604a228196f0e8c14773005
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240626101519epcas5p163b0735c1604a228196f0e8c14773005
References: <20240626100700.3629-1-anuj20.g@samsung.com>
	<CGME20240626101519epcas5p163b0735c1604a228196f0e8c14773005@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_044227_735662_C526B048 
X-CRM114-Status: GOOD (  18.81  )
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

From: Kanchan Joshi <joshi.k@samsung.com>

Set the BIP_CLONED flag when bip is cloned.
Use that flag to ensure that integrity is freed for cloned user bip.

Note that a bio may have BIO_CLONED flag set but it may still not be
sharing the integrity vecs.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/bio-integrity.c | 5 ++++-
 include/linux/bio.h   | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 845d4038afb1..8f07c4d0fada 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -147,7 +147,8 @@ void bio_integrity_free(struct bio *bio)
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct bio_set *bs = bio->bi_pool;
 
-	if (bip->bip_flags & BIP_INTEGRITY_USER)
+	if (bip->bip_flags & BIP_INTEGRITY_USER &&
+	    !(bip->bip_flags & BIP_CLONED))
 		return;
 	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
 		kfree(bvec_virt(bip->bip_vec));
@@ -662,6 +663,8 @@ int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 	bip->bip_iter = bip_src->bip_iter;
 	bip->bip_flags = bip_src->bip_flags & ~(BIP_BLOCK_INTEGRITY |
 						BIP_COPY_USER);
+	bip->bip_flags |= BIP_CLONED;
+
 	return 0;
 }
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 818e93612947..44226fcb4d00 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -329,6 +329,7 @@ enum bip_flags {
 	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
 	BIP_INTEGRITY_USER	= 1 << 5, /* Integrity payload is user address */
 	BIP_COPY_USER		= 1 << 6, /* Kernel bounce buffer in use */
+	BIP_CLONED		= 1 << 7, /* Indicates that bip is cloned */
 };
 
 /*
-- 
2.25.1


