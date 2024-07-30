Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C93DC3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jul 2024 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v3TXK2XIXhF0wFfi8Dqc21oAuJIbryUsHee1G3lRwzA=; b=M4hoKkhr1aDSy8A+Fd/mf7C4vy
	/bb+XjBk+y/55AMIgHZ6sg8HjVs0NLnILm05b8cFhDylKxQDR7OrXbkBd5lpPqxXNCMxFrtlSm+XO
	vvNqX2Ao60A9awc1BTsheidSkEJhfgIGp/aJXrWeuVk95yN0aAN6oAjpL4FPUEnGmPNdGz5X/SpsQ
	L+xD7DziQYLKbfCuWG6XaufR4DbcoNuS5LidvQJaGIBTgAXdGYh2dI0HpzvXsRVKHVjwOcqAz6I8I
	yc8ozSyjoLPR+E4VCzUE4bA3RBC+ovo4kpmuPF1zy2dRiZKYG6UUPe3qKDPos3l+LV6DKvBGaJM3K
	X5fXIItg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYkGy-0000000Ela6-2IyX;
	Tue, 30 Jul 2024 10:40:04 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYkGs-0000000ElXh-48kV
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jul 2024 10:40:02 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240730103946epoutp03e259e648c3b3d50203c89461bafc6279~m93RQ8CVX2190421904epoutp03Y
	for <linux-nvme@lists.infradead.org>; Tue, 30 Jul 2024 10:39:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240730103946epoutp03e259e648c3b3d50203c89461bafc6279~m93RQ8CVX2190421904epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722335986;
	bh=v3TXK2XIXhF0wFfi8Dqc21oAuJIbryUsHee1G3lRwzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKZD7wtx2tOxbgWuSqU9KrqA3M75MG/F2SDMR3/muAszMNDDWg7jMC/yZmsbLu8sH
	 RbHWQOisW/rAwooe7mVz7KttHnbWIGeShzwxBjOGTXbJfPqUFHgGZhA+LF60UipGv2
	 vN6awYKHjYhY3X3Q/YPaLWvF/H4ZYQxs3OIdWaAk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240730103945epcas5p224533261e1e7c3586dbc36e6097f650e~m93Q0frTR0638606386epcas5p2V;
	Tue, 30 Jul 2024 10:39:45 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WYBYr2HYpz4x9Q1; Tue, 30 Jul
	2024 10:39:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EB.22.09743.FE2C8A66; Tue, 30 Jul 2024 19:39:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240730103942epcas5p3aecd4ed3b49c99fa3e14b7b7e2d93ba5~m93OCP9O73199231992epcas5p3P;
	Tue, 30 Jul 2024 10:39:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240730103942epsmtrp28345308bcca4d22e0d6753028d3a94b3~m93OA_6PF0352303523epsmtrp2Z;
	Tue, 30 Jul 2024 10:39:42 +0000 (GMT)
X-AuditID: b6c32a4a-3b1fa7000000260f-3c-66a8c2ef4e68
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0D.6B.08456.EE2C8A66; Tue, 30 Jul 2024 19:39:42 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240730103942epsmtip1096ead2a960b7627c21552305042196f~m93NJDN201684416844epsmtip1C;
	Tue, 30 Jul 2024 10:39:41 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 1/3] nvme: remove a field from nvme_ns_head
Date: Tue, 30 Jul 2024 16:01:36 +0530
Message-Id: <20240730103138.66714-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240730103138.66714-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmuu77QyvSDD78ELRYufook8XR/2/Z
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6NuyijGANSrbJiM1MSW1
	SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdouZJCWWJOKVAoILG4
	WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+Pke7WCnTIV
	+7usGhhPiHcxcnJICJhIHD/ynw3EFhLYzSjxe0txFyMXkP2JUeLuoT+MEM43RokDMzrYYDpa
	JrUyQST2MkpM6WxmgXA+M0qcezEXqIWDg01AU+LC5FKQBhEBY4nOlQ0sIDazgLvE7Sc9TCC2
	sIC1xLeV58CGsgioSlzefoQZxOYVsJA4emQnM8QyeYmZl76zg9icApYSW1ecZIOoEZQ4OfMJ
	1Ex5ieats6Hqr7FLnJ+iAWG7SGzdc5wRwhaWeHV8CzuELSXx+d1eqGeyJR48esACYddI7Njc
	xwph20s0/LnBCvIKM9Ar63fpQ6zik+j9/YQJJCwhwCvR0SYEUa0ocW/SU6hOcYmHM5ZA2R4S
	vz5/g4ZhD6PEk70/mSYwys9C8sEsJB/MQti2gJF5FaNkakFxbnpqsWmBUV5qOTxSk/NzNzGC
	05+W1w7Ghw8+6B1iZOJgPMQowcGsJMIbf2VpmhBvSmJlVWpRfnxRaU5q8SFGU2AQT2SWEk3O
	BybgvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamDT8xQqen4o3
	1/wR7vLJK3vJvqQTUhO6pvbl/tz8VsRiydVp785IrHKtXrL4FqPwRwmfCMPzq2X2nJW8UFPw
	+sVEnx+n0j7G/n6VHT77zr1FvevYQqZ7bjnEHNnKsIJR4r+aSU318uoW+x1uRhenHfE1v/nb
	KWzijPAyc2HLyIim64rXF+5vXXvB4P6W4NkitUEcp6p2VCxVqf4hw63EZjapzdXtonqqTmTL
	NZ+7fSzW8SJXb9dOeBB3Y8XPh6m31IKK7i5Jdd12dfdpk3nf/FP5Fc9uspB21Q98PJ/1yY+4
	+RHn/8kEzCj/em/1S9usu8EL/rU7egVPmLDtf9FKUeNnTFx6Nb8PrD2xtO7mwydKLMUZiYZa
	zEXFiQBQERC7CAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnO67QyvSDCYsMLdYufook8XR/2/Z
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6NuyijGANYrLJiU1J7Ms
	tUjfLoEr4+R7tYKdMhX7u6waGE+IdzFyckgImEi0TGpl6mLk4hAS2M0osevHXEaIhLhE87Uf
	7BC2sMTKf8/ZIYo+MkqsbjsK5HBwsAloSlyYXApSIyJgLrHvwnNWkDCzgKfE+onyIGFhAWuJ
	byvPsYHYLAKqEpe3H2EGsXkFLCSOHtnJDDFeXmLmpe9gqzgFLCW2rjgJVi8EVDP73W+oekGJ
	kzOfsIDYzED1zVtnM09gFJiFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95Pzc
	TYzg0NXS2sG4Z9UHvUOMTByMhxglOJiVRHjjryxNE+JNSaysSi3Kjy8qzUktPsQozcGiJM77
	7XVvipBAemJJanZqakFqEUyWiYNTqoEp7tJln9mbXn6olI9/a7zo7cYpXZKpwZwFQT2LvaSE
	zwkHd6l4Kr2fHPjA9aTX5Yi9M85/e+yUlbKwf7mmX+9/nrmfXQwqr+kFq863vC4jyVmvto1X
	/rm2seHyB9tcT+69kf4rfvvhrV8/6DNPv8bwu/uoyOPefQlrWt5GmdW79pjvfJbSe21KdSmb
	vBhTVN49N/ETKZVnvuaeZNpxUXePVf+XJveXIWZKEyawdwRsL6vsWBa6rY2V8bjH7Z0tYdyR
	62LTjD1uFGzqsH1yPe9g6BzxzyFbN/88W/948rlIJluDHD42ZbFVsXX1Il1ec19s2CU7T3Td
	qajFe9SlA4QOzF2U6fde7VyQA9tVk21KLMUZiYZazEXFiQDr7A+VzAIAAA==
X-CMS-MailID: 20240730103942epcas5p3aecd4ed3b49c99fa3e14b7b7e2d93ba5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730103942epcas5p3aecd4ed3b49c99fa3e14b7b7e2d93ba5
References: <20240730103138.66714-1-joshi.k@samsung.com>
	<CGME20240730103942epcas5p3aecd4ed3b49c99fa3e14b7b7e2d93ba5@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_033959_375998_063E5D90 
X-CRM114-Status: GOOD (  18.85  )
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

pi_offset field is not required to be present in nvme_ns_head.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 16 ++++++++--------
 drivers/nvme/host/nvme.h |  1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d7f5b24ce003..4a00f400bd8f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -36,6 +36,7 @@ struct nvme_ns_info {
 	struct nvme_ns_ids ids;
 	u32 nsid;
 	__le32 anagrpid;
+	u8 pi_offset;
 	bool is_shared;
 	bool is_readonly;
 	bool is_ready;
@@ -1757,7 +1758,7 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 static bool nvme_init_integrity(struct nvme_ns_head *head,
-		struct queue_limits *lim)
+		struct queue_limits *lim, struct nvme_ns_info *info)
 {
 	struct blk_integrity *bi = &lim->integrity;
 
@@ -1815,7 +1816,7 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 	}
 
 	bi->tuple_size = head->ms;
-	bi->pi_offset = head->pi_offset;
+	bi->pi_offset = info->pi_offset;
 	return true;
 }
 
@@ -1901,12 +1902,11 @@ static void nvme_configure_pi_elbas(struct nvme_ns_head *head,
 
 static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 		struct nvme_ns_head *head, struct nvme_id_ns *id,
-		struct nvme_id_ns_nvm *nvm)
+		struct nvme_id_ns_nvm *nvm, struct nvme_ns_info *info)
 {
 	head->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
 	head->pi_type = 0;
 	head->pi_size = 0;
-	head->pi_offset = 0;
 	head->ms = le16_to_cpu(id->lbaf[nvme_lbaf_index(id->flbas)].ms);
 	if (!head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		return;
@@ -1921,7 +1921,7 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 	if (head->pi_size && head->ms >= head->pi_size)
 		head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	if (!(id->dps & NVME_NS_DPS_PI_FIRST))
-		head->pi_offset = head->ms - head->pi_size;
+		info->pi_offset = head->ms - head->pi_size;
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		/*
@@ -2155,7 +2155,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 
 	lim = queue_limits_start_update(ns->disk->queue);
 	nvme_set_ctrl_limits(ns->ctrl, &lim);
-	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm);
+	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
@@ -2175,7 +2175,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	 * I/O to namespaces with metadata except when the namespace supports
 	 * PI, as it can strip/insert in that case.
 	 */
-	if (!nvme_init_integrity(ns->head, &lim))
+	if (!nvme_init_integrity(ns->head, &lim, info))
 		capacity = 0;
 
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
@@ -2279,7 +2279,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		if (unsupported)
 			ns->head->disk->flags |= GENHD_FL_HIDDEN;
 		else
-			nvme_init_integrity(ns->head, &lim);
+			nvme_init_integrity(ns->head, &lim, info);
 		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
 
 		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9ac587e64166..09303454bb24 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -474,7 +474,6 @@ struct nvme_ns_head {
 	u16			ms;
 	u16			pi_size;
 	u8			pi_type;
-	u8			pi_offset;
 	u8			guard_type;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64			zsze;
-- 
2.25.1


