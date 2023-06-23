Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167FDEB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jun 2023 07:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=dDPl0OrMTIV/bsbBYntD4lHzEVqcYvZevIdcy+Ma1R4=; b=Su7D9KqvZ80Jwe64Dwi61HKddi
	XTE/OewwYxljZzfbVyRJkPRNrJAkIn4o3cAiHOKUQ35SvW5yf3m6W3OUWwPZtAjMemt4GXdyrfBuT
	8xm8eogEjbOqzKDlB/5EhxDyQOzHlQg+xS2LY6vwqLhY5+ht7Jv81PTqpOKCWE9a6y63YGk6T93We
	TXr5+dLC0kIu+Er+0bIhDFFRtjlczJjgz7/DMY1hHa4QdvIDlSOgdpUzUz75llTJhjDv04yrOP/rS
	a3w9YQYZ0PowQbXiRvKiiLSePh30tdOWfLUjhgomCCF6SBoOiegJvzqVOHWdR+IISgKNaaQ+ey582
	g23xB1Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCb7W-002mAl-1F;
	Fri, 23 Jun 2023 07:22:14 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCb7R-002m97-0k
	for linux-nvme@lists.infradead.org;
	Fri, 23 Jun 2023 07:22:13 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230623072157epoutp04f0ea0af5cc408256cefc8ccf73374be5~rOMg4R83r1091810918epoutp04b
	for <linux-nvme@lists.infradead.org>; Fri, 23 Jun 2023 07:21:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230623072157epoutp04f0ea0af5cc408256cefc8ccf73374be5~rOMg4R83r1091810918epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1687504918;
	bh=dDPl0OrMTIV/bsbBYntD4lHzEVqcYvZevIdcy+Ma1R4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=O6sRxDZsVVkUmVqTmhSi4+NzaoPvuOZCi17+2siHhTnnmyg4Sij+/JbpwPesKHaJY
	 l3nTb6DwQmGjqlvrZwG3vZOfzriaNJKXSjzB1PpewlD8XUrERjR8fPjkIFRzu3jOmi
	 x59JvLaKHuQ9fGRNzMP7kqeh4FDa2Dv1mU8ikCq8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20230623072157epcas5p28042ef564cc8cbb9789f7ae50c30db9e~rOMgk77Rm0355603556epcas5p2D;
	Fri, 23 Jun 2023 07:21:57 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4QnTFc2jCkz4x9QC; Fri, 23 Jun
	2023 07:21:56 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.0A.55522.41845946; Fri, 23 Jun 2023 16:21:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230623071848epcas5p10d8edb4c9c8673ba612f4b81119ed2fb~rOJwXlmkD1222612226epcas5p16;
	Fri, 23 Jun 2023 07:18:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230623071848epsmtrp27e21d48ed8c2dcedd6011de54d7fcd60~rOJwR8Q362849828498epsmtrp2R;
	Fri, 23 Jun 2023 07:18:48 +0000 (GMT)
X-AuditID: b6c32a49-419ff7000000d8e2-a5-64954814c81e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.39.34491.85745946; Fri, 23 Jun 2023 16:18:48 +0900 (KST)
Received: from unvme-desktop.sa.corp.samsungelectronics.net (unknown
	[107.99.41.39]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230623071846epsmtip1feb22c2eee4e7850e3aaafbc913b519e~rOJu_E3fz1556815568epsmtip16;
	Fri, 23 Jun 2023 07:18:46 +0000 (GMT)
From: Ankit Kumar <ankit.kumar@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "Martin K. Petersen"
	<martin.petersen@oracle.com>
Cc: gost.dev@samsung.com, Ankit Kumar <ankit.kumar@samsung.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme:fix the NVME_ID_NS_NVM_STS_MASK definition
Date: Fri, 23 Jun 2023 18:08:05 +0530
Message-Id: <20230623123806.78451-1-ankit.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmlq6Ix9QUg7tdQhZrrvxmt1h9t5/N
	4uaBnUwWK1cfZbKYdOgao8XlXXPYLOYve8pusfz4PyaLda/fszhwepy/t5HF4/LZUo9NqzrZ
	PDYvqffYfbOBzePj01ssHn1bVjF6fN4kF8ARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
	YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
	JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE749bMrIKJrBV37v9kb2Ccy9LFyMkhIWAiMff8
	PdYuRi4OIYHdjBIffu9iB0kICXxilLjWWgCR+MYo0bphGSNMR/Pkj8wQib2MEqf3/YFq72SS
	uHu0A6ydTUBb4tXbG2BVIgK7GCVmL3wEtpBZoF5i+iKQIg4OYQEHiekNriBhFgFViR+vDrKB
	hHkFbCQamqUglslLzLz0HWwkr4CgxMmZT6CmyEs0b50NNl5C4Ce7xPpTO9ggGlwkTrw6CmUL
	S7w6voUdwpaS+PxuL1Q8W2LTw59MEHaBxJEXvcwQtr1E66l+ZpAbmAU0Jdbv0ocIy0pMPbWO
	CWIvn0Tv7ydQrbwSO+bB2KoSf+/dhgaptMTNd1dZQMZICHhIrLtiAgnQWInPbxezT2CUn4Xk
	m1lIvpmFsHgBI/MqRsnUguLc9NRi0wLDvNRyeKwm5+duYgSnUC3PHYx3H3zQO8TIxMF4iFGC
	g1lJhFd206QUId6UxMqq1KL8+KLSnNTiQ4ymwBCeyCwlmpwPTOJ5JfGGJpYGJmZmZiaWxmaG
	SuK8h8/0pggJpCeWpGanphakFsH0MXFwSjUwpYQv835X5+J/oaBnUsuj+56/QqW3+YW1GzKF
	XGhks336VO9G57TJq7+ZrBeYuHxf4kZxxjUtjSG/LnQcq511fva64nT5ScwfXsyM0ouzNRGa
	saI53M5MJiopkblDyfpC5MPLS8MVcs4ruy4w6klxsbm9zibHIu1T1rXpKjx/M0LC73/Z3pYz
	yfrc6iV/8tsUNB6ENHvzHDoddvyD6fYTBm0ea6y9UgTfHQ+r6yrcbev7y6lodePFBzzJDnxT
	mJdzqpXP4T0y66DWiYMKN8/vMKpQzvzdOv+SXdPHya/7lkU+imE72myf/tfa8OW6mIKstbZL
	BFynuiw19jOa6HfX7S9jZjJTUZJdVBXjrl9KLMUZiYZazEXFiQAvbgmsKgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSnG6E+9QUg7k/+C3WXPnNbrH6bj+b
	xc0DO5ksVq4+ymQx6dA1RovLu+awWcxf9pTdYvnxf0wW616/Z3Hg9Dh/byOLx+WzpR6bVnWy
	eWxeUu+x+2YDm8fHp7dYPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugSvj1sysgomsFXfu/2Rv
	YJzL0sXIySEhYCLRPPkjcxcjF4eQwG5GiYN3LzF1MXIAJaQlFq5PhKgRllj57zk7RE07k8S5
	Y3uYQRJsAtoSr97eAGsWEdjHKNH16zobiMMs0MwocfHYMRaQScICDhLTG1xBGlgEVCV+vDrI
	BhLmFbCRaGiWglggLzHz0nd2EJtXQFDi5MwnYMcxA8Wbt85mnsDINwtJahaS1AJGplWMkqkF
	xbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMEBraW5g3H7qg96hxiZOBgPMUpwMCuJ8MpumpQi
	xJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqgWmVc3yP9zzj
	7Jq5ucEq07+eUl+s1paXcYl511feuP6dS7bMvBt4T/pIblymtbO2vOrhXdPNCwyvrr34u++4
	z2ehg5ed9JpU0p7oydR9P/Nk98eVa1Yk3l/rtr/llM6/0MPV1lzqUnE1a0qaxX7mxR50OCn5
	7kTYbfkfUwImzWGuqXu2dJ/etacvngQcvq+ktqAhkOdHl+6T0HfBl944rbr5b7qi3EGzwlus
	CX1tggG8TP5WivGLREKXNR3zvrvr7qpMyb1mCTZn1yqc5NZP91j/+9mHPYGaU8p/xYgfvKx8
	KG3N94DsHVs+3Dx9Pj2wvmLTzxOcVo/8lK7+etUWwHLoiMq956/ENefvTJj3IDRViaU4I9FQ
	i7moOBEArH/CMtcCAAA=
X-CMS-MailID: 20230623071848epcas5p10d8edb4c9c8673ba612f4b81119ed2fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230623071848epcas5p10d8edb4c9c8673ba612f4b81119ed2fb
References: <CGME20230623071848epcas5p10d8edb4c9c8673ba612f4b81119ed2fb@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230623_002209_589043_383676CC 
X-CRM114-Status: GOOD (  16.38  )
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

As per NVMe command set specification 1.0c Storage tag size is 7 bits
Fixes: 4020aad85c67 ("nvme: add support for enhanced metadata")

Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
---
 include/linux/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 779507ac750b..2819d6c3a6b5 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -473,7 +473,7 @@ struct nvme_id_ns_nvm {
 };
 
 enum {
-	NVME_ID_NS_NVM_STS_MASK		= 0x3f,
+	NVME_ID_NS_NVM_STS_MASK		= 0x7f,
 	NVME_ID_NS_NVM_GUARD_SHIFT	= 7,
 	NVME_ID_NS_NVM_GUARD_MASK	= 0x3,
 };
-- 
2.34.1


