Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E7AC30653
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CddwOBmVKHfCIekEQ0xwuipaf4radU9oHxoG3DHT28I=; b=tVef0cHrZj1TyzXrgvFzwIjylU
	elMh/78h/F3zhJEK6Ou5xESIBhDOMJAv6CAYfBdI+iv21wXx/BBtNIvu3vitMLY0W+4gRmA0QYtoH
	5ZBaJt9pCr/BuoAUu5x/7QUc+ZKUi4vk4McpxxbxFH1XUze+i9tVLlzGLYwUhmc4/IWRu63AGf+Es
	F75k+lW3GpFKXjk6ADp4f2qSPu2VNl2jjDuh2inYyp0w2eclZ34FALfS+RzggzVo8sTniKDtSvdWx
	HvTmEJ3W/uppkeOqpy9Ig0Aietf09f2n+Zq15T3zAAZUkxn3I/DtICzU1gVqibD+QEmbxbKLSWo9E
	uaWC9qhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMR2P-00000006aLn-1XhP;
	Wed, 26 Jun 2024 11:42:09 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMR2K-00000006aIx-3tqu
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 11:42:07 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240626114200epoutp03f4cb80c5210969a17547240dc3fb0d83~cix5ts5Af0690706907epoutp031
	for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 11:42:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240626114200epoutp03f4cb80c5210969a17547240dc3fb0d83~cix5ts5Af0690706907epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719402120;
	bh=CddwOBmVKHfCIekEQ0xwuipaf4radU9oHxoG3DHT28I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnq1+7shfd+oITixvUjmZ4W3xtAcCtdITQSIMn2cv/PzwOBGxQI7IchYE1ObDxj+/
	 CmPQpsw9QMlv1GBnnkxn32tr45JZNf7ZPMmqxLA7nz+OE2pTyzOVcfvCz5HH//g+lA
	 0qYVtJO+is6uV8cTHY9MfB0JBTcTiW48Cgdc1KKw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240626114200epcas5p3d0f26fedd94965b2a16a9a978e7d1d34~cix5anObS2803828038epcas5p3D;
	Wed, 26 Jun 2024 11:42:00 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W8KYK6Zjkz4x9Pp; Wed, 26 Jun
	2024 11:41:57 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	29.08.09989.58EFB766; Wed, 26 Jun 2024 20:41:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240626101513epcas5p10b3f8470148abb10ce3edfb90814cd94~chmIrqYUZ0829808298epcas5p1f;
	Wed, 26 Jun 2024 10:15:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240626101513epsmtrp2eeaa7a869685d6ca50a408eaa6d5ffab~chmIq6IEq1237112371epsmtrp2N;
	Wed, 26 Jun 2024 10:15:13 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-25-667bfe853d33
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7E.6B.29940.13AEB766; Wed, 26 Jun 2024 19:15:13 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240626101512epsmtip15b7099c4bf924e901811582bd44caed0~chmG6euMQ0147101471epsmtip1P;
	Wed, 26 Jun 2024 10:15:11 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: asml.silence@gmail.com, mpatocka@redhat.com, axboe@kernel.dk,
	hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 02/10] block: set bip_vcnt correctly
Date: Wed, 26 Jun 2024 15:36:52 +0530
Message-Id: <20240626100700.3629-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626100700.3629-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmpm7rv+o0g8nrjS2aJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxeLo/7dsFpMOXWO02HtL22L+sqfsFsuP/2OymNhxlcmB22PnrLvs
	HpfPlnpsWtXJ5rF5Sb3H7psNbB4fn95i8Xi/7yqbR9+WVYwenzfJBXBGZdtkpCampBYppOYl
	56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAN2qpFCWmFMKFApILC5W0rez
	KcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO6Fr8lr3gOkfF+qkz
	2RoYF7B3MXJySAiYSFy+eYsVxBYS2M0o8fujQhcjF5D9iVFi2cm9bBDON0aJ21vXwnX0Nxxg
	gUjsZZTYM/8IE4TzmVHi2Kx1jCBVbALqEkeet4LZIgK1Eitbp7ODFDELLGWU+PDgOjNIQljA
	XGLi1d9gY1kEVCUetXxiArF5BSwktr+/wQKxTl5i5qXvYDWcApYSdzZvZ4SoEZQ4OfMJWA0z
	UE3z1tnMIAskBOZySPx7uxZoEAeQ4yIx/xcjxBxhiVfHt0C9ICXx+R3IbyB2usSPy0+ZIOwC
	ieZj+6Dq7SVaT/Uzg4xhFtCUWL9LHyIsKzH11DomiLV8Er2/n0C18krsmAdjK0m0r5wDZUtI
	7D3XAGV7SJz99IoRElg9jED3/GCcwKgwC8k7s5C8Mwth9QJG5lWMkqkFxbnpqcWmBUZ5qeXw
	WE7Oz93ECE6/Wl47GB8++KB3iJGJg/EQowQHs5IIb2hJVZoQb0piZVVqUX58UWlOavEhRlNg
	eE9klhJNzgdmgLySeEMTSwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGph2
	vK6L1hZ98v7sU3Ndc1WpDROb57rFHrG/knziWZKz54pdZ+8deu74dNp+zcakxwsZDqza6GXl
	xnjlYvez21WMDG3usosUtX1Ormk/s5B3x6p35qvjJwfPYzqpYTGDzXSG8TFW071vtmTP1eg7
	um/rstluRoveb+DrqlVc4Z61VW3WlW9GZ98ujp+SNHs2a4TMjX/xzIX3DeZ1er0+HLTFZdaK
	S2wX5ZUn/lM1uaki9JzzVv+V/re/rs0LrXC+ccXsnXK8kqcfz+Et1rfe5X79+vad/VE9ht+B
	TbFLH5dJ+rM7nnRtvfHhzsl4e48PSp5nV/5fbZ0RHrP1i1X2stRL51l3aR+1vqI8ccu1vtn2
	rUosxRmJhlrMRcWJAH857pxIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSnK7hq+o0g2OnTSyaJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxeLo/7dsFpMOXWO02HtL22L+sqfsFsuP/2OymNhxlcmB22PnrLvs
	HpfPlnpsWtXJ5rF5Sb3H7psNbB4fn95i8Xi/7yqbR9+WVYwenzfJBXBGcdmkpOZklqUW6dsl
	cGV0LX7LXnCdo2L91JlsDYwL2LsYOTkkBEwk+hsOsHQxcnEICexmlHhwdDcbREJC4tTLZYwQ
	trDEyn/P2SGKPjJKPNq7HKybTUBd4sjzVkaQhIhAK6PEgaktYA6zwEpGiduLXjCBVAkLmEtM
	vPobrINFQFXiUcsnsDivgIXE9vc3WCBWyEvMvPQdrIZTwFLizubtYKuFgGoePG9mhagXlDg5
	8wlYPTNQffPW2cwTGAVmIUnNQpJawMi0ilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMj
	OEq0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHe0JKqNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96
	U4QE0hNLUrNTUwtSi2CyTBycUg1M60paLqz4qGbaPqlBUb7t4O+avsyVJWEHm1+3tEdu7bI7
	XcPWKHAyyLvYXUB5Zd77k1s3m8TX8KyK5/kToejXJ70m7UPQ2teV9z5Xc7rd99y4XjtJ9N2r
	9is52cn1zxIcbRImbXNMP8aYIHvk05yISYFPPgmJbjjyPHxlW1TskmlHJC1VT6d9/X+G34Kx
	on32VH+h5Lg1WVq24vzm4eyxAiUyu+U+Bmea9WZrruHMfya9x07A7vYeOcsFjTOsIxcY5uXd
	Dnu42ugfq9iWWy8nys+ZsE2BVfQ1/8kj2/pVTfN2eakbf9m3/Oty0zOaD9vXKz03mSfZ8b/E
	yGFnzMKrc2bUczwzkkx49H9G1hMlluKMREMt5qLiRABZ/IQIAQMAAA==
X-CMS-MailID: 20240626101513epcas5p10b3f8470148abb10ce3edfb90814cd94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240626101513epcas5p10b3f8470148abb10ce3edfb90814cd94
References: <20240626100700.3629-1-anuj20.g@samsung.com>
	<CGME20240626101513epcas5p10b3f8470148abb10ce3edfb90814cd94@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_044205_824223_A967645F 
X-CRM114-Status: GOOD (  14.55  )
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

Set the bip_vcnt correctly in bio_integrity_init_user and
bio_integrity_copy_user. If the bio gets split at a later point,
this value is required to set the right bip_vcnt in the cloned bio.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index dab70370b2c7..af79d9fbf413 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -276,6 +276,7 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 
 	bip->bip_flags |= BIP_INTEGRITY_USER | BIP_COPY_USER;
 	bip->bip_iter.bi_sector = seed;
+	bip->bip_vcnt = nr_vecs;
 	return 0;
 free_bip:
 	bio_integrity_free(bio);
@@ -297,6 +298,7 @@ static int bio_integrity_init_user(struct bio *bio, struct bio_vec *bvec,
 	bip->bip_flags |= BIP_INTEGRITY_USER;
 	bip->bip_iter.bi_sector = seed;
 	bip->bip_iter.bi_size = len;
+	bip->bip_vcnt = nr_vecs;
 	return 0;
 }
 
-- 
2.25.1


