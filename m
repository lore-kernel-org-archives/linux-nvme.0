Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E361C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5vbI71yMujXYkEGW8ngeGEGRX6ABcmrOjyoSmpUJRr8=; b=0bw9UcPMUF36h+a/6j/WYFS+AS
	mlrK+wnqe31OsEaHvCwEmUeVBeMvWRbS13G79qvuYQtKRNKDPWX9dp1tPT89fVowuvJsLlerBGIcf
	PS4z48EGB9sFtyJFuYtdwbzDK1SS1bqZ4oS0K9H1n30Irh5jBKPxqwDf33tdU4DfKXsOymzfLboxg
	Nrm10DjcxDo0gLi+UGa3IoRlWf8ihBiv7jrGgEtiYDj0FwyKvsGvPUcnofUgItXHXkVa5CDTBUzPq
	VS3S+IhSEHuzDzCVBHGi8FvgEbYzlFJuVrPlN6Ffk2LWlh6NpGYxRQqcSVz8ymdeJJNldFYQWsYL0
	xbeL6R5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnHPR-00000003pwi-1mtG;
	Wed, 26 Feb 2025 13:25:09 +0000
Received: from [203.254.224.24] (helo=mailout1.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnFba-00000003Tfi-13jI
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 11:29:38 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250226112927epoutp0167ff0c008b2e07725175574daa280a5c~nvp4xE4qJ2723727237epoutp01E
	for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 11:29:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250226112927epoutp0167ff0c008b2e07725175574daa280a5c~nvp4xE4qJ2723727237epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740569367;
	bh=5vbI71yMujXYkEGW8ngeGEGRX6ABcmrOjyoSmpUJRr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxNE4A4AbWUqx7fZ5ADxF8TGOhv0yjk8TjPU6AIB9u276UbsLzJvHAW1EjJKK84w3
	 eWDaHXb88YmTIyLmrSD1l+pYVne/xRzFiVBrKB2Wajv2M4c8k+qVq+aJyxCZ/8TNuc
	 MO0g+hqn+bT3T8Vv+FVGUd+ig2wh/ctpYxoVdSqw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250226112924epcas5p1d17df23d087611e70d97ed813c5773be~nvp1sxt_i2155121551epcas5p14;
	Wed, 26 Feb 2025 11:29:24 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z2sgk49zyz4x9Q1; Wed, 26 Feb
	2025 11:29:22 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1E.E8.19956.21BFEB76; Wed, 26 Feb 2025 20:29:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250226112857epcas5p1654e62b5fff4551926622f19269c6ff4~nvpcXpYku0435004350epcas5p1d;
	Wed, 26 Feb 2025 11:28:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250226112857epsmtrp2791aed2b8ed4aaff9f58ff0f891162c4~nvpcW06o30959209592epsmtrp2W;
	Wed, 26 Feb 2025 11:28:57 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-33-67befb126755
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.60.18949.8FAFEB76; Wed, 26 Feb 2025 20:28:57 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250226112855epsmtip26ae1a3ed89ddfba8811322b56fea514d~nvparzCXT1116211162epsmtip2a;
	Wed, 26 Feb 2025 11:28:55 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Cc: anuj1072538@gmail.com, nikh1092@linux.ibm.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, dm-devel@lists.linux.dev, Anuj Gupta
	<anuj20.g@samsung.com>, M Nikhil <nikhilm@linux.ibm.com>
Subject: [PATCH v2 1/2] block: ensure correct integrity capability
 propagation in stacked devices
Date: Wed, 26 Feb 2025 16:50:34 +0530
Message-Id: <20250226112035.2571-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226112035.2571-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmhq7Q733pBq+WKFh8/PqbxaJpwl9m
	i9V3+9ksFiyay2KxcvVRJou9t7Qt5i97ym7RfX0Hm8Xy4/+YLO5efMpssbP9GKMDt8fOWXfZ
	PS6fLfWYsOgAo8fmJfUeLzbPZPTYfbOBzePj01ssHn1bVjF6fN4kF8AZlW2TkZqYklqkkJqX
	nJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SrkkJZYk4pUCggsbhYSd/O
	pii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE749qdz2wFl7kqZjzu
	YWlgbOXsYuTkkBAwkbi7eBdTFyMXh5DAbkaJHb93MIEkhAQ+MUo0LROBSHxjlLjQ380G03F4
	128WiMReRolVT05AOZ8ZJe5sOwfWziagLnHkeStjFyMHh4iAtcT71+IgNcwC7xklXvd3gU0S
	FkiW2L50LRNIDYuAqsTJ1c4gYV4BC4ntkxqglslLzLz0nR3E5hSwlOhYuIIRokZQ4uTMJywg
	NjNQTfPW2cwg8yUEFnJIzH98gBmi2UVi+9T1LBC2sMSr41vYIWwpic/v9kItSJf4cfkpE4Rd
	INF8bB8jhG0v0XqqnxnkNmYBTYn1u/QhwrISU0+tY4LYyyfR+/sJVCuvxI55MLaSRPvKOVC2
	hMTecw1QtofEk1mnWCCh28MoMXG73gRGhVlI3pmF5J1ZCJsXMDKvYpRMLSjOTU8tNi0wzkst
	h8dxcn7uJkZw6tXy3sH46MEHvUOMTByMhxglOJiVRHg5M/ekC/GmJFZWpRblxxeV5qQWH2I0
	BQb3RGYp0eR8YPLPK4k3NLE0MDEzMzOxNDYzVBLnbd7Zki4kkJ5YkpqdmlqQWgTTx8TBKdXA
	xM5/IMppcn3D3zcd/00X9By49sjT5qzdhMLCCruCBStl/13YNPfaRAuuBSFpH4VMc+Z9v7t7
	ksQRvlD3m3Vz5+y50fRPXofBbnJvfFF7150tjZ31+Xvf1i4RMAycExhz+MjstMDs2bN3H8mx
	bwhjYmmVSppzxauMQTQr3F777PWYv+0ei1mmv4/XNKiriwvTPhooxTxJLF3AK/KxoE6GmsCF
	ndu8WzWFVKL9WuM8Y7JNvj6pYnm3euYp/yrOwz2VE87+rPy13i+vQtojjctptSVbjUtH0ZHE
	L1/kKs9VqJ+Y4BDLm9Uqejoo6CiHx7/GWIUj/5uNJ8mKbDZPfDhzYlpoiCl/3efaDz/i8pVY
	ijMSDbWYi4oTASZKnehGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvO7PX/vSDZo6mCw+fv3NYtE04S+z
	xeq7/WwWCxbNZbFYufook8XeW9oW85c9Zbfovr6DzWL58X9MFncvPmW22Nl+jNGB22PnrLvs
	HpfPlnpMWHSA0WPzknqPF5tnMnrsvtnA5vHx6S0Wj74tqxg9Pm+SC+CM4rJJSc3JLEst0rdL
	4Mq4duczW8FlrooZj3tYGhhbObsYOTkkBEwkDu/6zdLFyMUhJLCbUaL54xRGiISExKmXy6Bs
	YYmV/56zg9hCAh8ZJWZsDgax2QTUJY48bwWq4eAQEbCXuPejAmQOs8B3RokTLdfZQGqEBRIl
	NuxsYgGpYRFQlTi52hkkzCtgIbF9UgMbxHh5iZmXvoON5xSwlOhYuIIRYpWFxM49W5gg6gUl
	Ts58wgJiMwPVN2+dzTyBUWAWktQsJKkFjEyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNz
	NzGCo0NLawfjnlUf9A4xMnEwHmKU4GBWEuHlzNyTLsSbklhZlVqUH19UmpNafIhRmoNFSZz3
	2+veFCGB9MSS1OzU1ILUIpgsEwenVANTvlrxnQPqmow8/grWvs8UWqSLVrR4TrnwYK10x9Xp
	CQ+2qZXPPWr2TUMq5mhC7S7RD5ffGjCalV8xW1NikG9gcKv8e0/4kvUJrzIajhTH/cy5fMJ4
	7etqTx+vf1mZaz35PWWNF60NydmczZ4vP2O1anRoyHe2fWZn/ywufpW5T/hk+p21fvcL3+5f
	pZmbd8G/bq7NsaJZG37Jp0qV8JU/vyriKhB0SOPuFJfEGO0HP/ZufzllcXjT4et6B00e7hBw
	te8M8ihbE2n7/s5XQe7Q71JB9qGzth/faSztdUHQQcDX3opXglnh+r134s9SeDjc7Xo/rPhi
	KMIjNS9ccMvF9xdnpec2O2xyCvc+s0CJpTgj0VCLuag4EQB3vle1/QIAAA==
X-CMS-MailID: 20250226112857epcas5p1654e62b5fff4551926622f19269c6ff4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250226112857epcas5p1654e62b5fff4551926622f19269c6ff4
References: <20250226112035.2571-1-anuj20.g@samsung.com>
	<CGME20250226112857epcas5p1654e62b5fff4551926622f19269c6ff4@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_032934_954571_5E1FB7CD 
X-CRM114-Status: GOOD (  18.76  )
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

queue_limits_stack_integrity() incorrectly sets
BLK_INTEGRITY_DEVICE_CAPABLE for a DM device even when none of its
underlying devices support integrity. This happens because the flag is
inherited from the first base device, even if it lacks integrity support.
This patch ensures that BLK_INTEGRITY_DEVICE_CAPABLE is only inherited if
the first device actually supports integrity.

Reported-by: M Nikhil <nikhilm@linux.ibm.com>
Link: https://lore.kernel.org/linux-block/f6130475-3ccd-45d2-abde-3ccceada0f0a@linux.ibm.com/
Fixes: c6e56cf6b2e7 ("block: move integrity information into queue_limits")
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-settings.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c44dadc35e1e..8bd0d0f1479c 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -861,7 +861,8 @@ bool queue_limits_stack_integrity(struct queue_limits *t,
 
 	if (!ti->tuple_size) {
 		/* inherit the settings from the first underlying device */
-		if (!(ti->flags & BLK_INTEGRITY_STACKED)) {
+		if (!(ti->flags & BLK_INTEGRITY_STACKED) &&
+		    (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE)) {
 			ti->flags = BLK_INTEGRITY_DEVICE_CAPABLE |
 				(bi->flags & BLK_INTEGRITY_REF_TAG);
 			ti->csum_type = bi->csum_type;
-- 
2.25.1


