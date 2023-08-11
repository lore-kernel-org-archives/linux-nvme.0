Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7670C001DE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 16:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rqUGWX6hJQ+8VJeZV4sLA910b0p+tO5xDEctHMpk0dk=; b=Vj5VcnxBQ870NHJ6xoIfsfHbEE
	Ayt5IwJlhl+RTL6L5bEYYXoxJuIpLuM8dw4N/r8vDO7DRFW8kYiTftl5JBT6axBByUDp1yKLn78c2
	S0bpn92xe+KFdDhuZQHWWquahlkWXDXydCopIaJkluJTDgOLGAUFrFQczbZLHnoJUaLJfZXe7X5pC
	6eKMPICuTHNnoFMQLKQKqe5dYEGgPxMTQayBsIWhkZikBDCJ4ekVJ/IO8pXRla1rFOxwEHoZZ5cP1
	P1My9O8acLD/ktxrlJCz1GOTf8FRKDV0BpjvUGGypBpSGN4WWvUJ+9Fr3TS2//T65V7ZegFc9C63e
	LYN/ckMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUUdM-00B2Tf-0A;
	Fri, 11 Aug 2023 16:05:04 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUUdH-00B2Qm-1L
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 16:05:02 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230811160457epoutp0267640a03ec29437090edcda5c103f24e~6X8Il2_tN2757427574epoutp023
	for <linux-nvme@lists.infradead.org>; Fri, 11 Aug 2023 16:04:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230811160457epoutp0267640a03ec29437090edcda5c103f24e~6X8Il2_tN2757427574epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691769897;
	bh=rqUGWX6hJQ+8VJeZV4sLA910b0p+tO5xDEctHMpk0dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1QCUz6TkvptGlaOcES677dUzkHJ9tAFiH6LIiG+YiIzkiTJOinnXmXBYzE18qKMg
	 7bxpdDsSv3eVMBXv0R6ZIeO3k/DZo/cByf99OLi4MyPiFVJJaV/qc7zwYgDk5eCwHj
	 SdiJyEO+NqTy8GI/yBKIyP7Yyy3gV4dW7EqG0HTY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20230811160457epcas5p3244d4439653f293993b9d615952e147e~6X8IKWq7t1729417294epcas5p3F;
	Fri, 11 Aug 2023 16:04:57 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4RMpXR3Xbmz4x9Pp; Fri, 11 Aug
	2023 16:04:55 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.D4.06099.72C56D46; Sat, 12 Aug 2023 01:04:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230811160454epcas5p2635d208557749a2431b99c27b30a727f~6X8GKnrN91744217442epcas5p2s;
	Fri, 11 Aug 2023 16:04:54 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230811160454epsmtrp1563c640fb15e6d39b1af4aaebf6dabee~6X8GJxWqA1820518205epsmtrp1B;
	Fri, 11 Aug 2023 16:04:54 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-cb-64d65c279fa1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	97.E8.64355.62C56D46; Sat, 12 Aug 2023 01:04:54 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230811160452epsmtip21a743cd52a0d588a38424eae84cc0074~6X8Dyeln62904129041epsmtip21;
	Fri, 11 Aug 2023 16:04:52 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com, Kanchan
	Joshi <joshi.k@samsung.com>, stable@vger.kernel.org, Vincent Fu
	<vincent.fu@samsung.com>
Subject: [PATCH 1/2] nvme: fix memory corruption for passthrough metadata
Date: Fri, 11 Aug 2023 21:29:05 +0530
Message-Id: <20230811155906.15883-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811155906.15883-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmpq56zLUUgxmnRC3WXPnNbrH6bj+b
	xc0DO5ksVq4+ymRx9P9bNovzbw8zWUw6dI3RYv6yp+wW616/Z7FYsPERo8Xj7g5Giw1tgg48
	Hjtn3WX3OH9vI4vH5bOlHptWdbJ5bF5S77H7ZgObR9+WVYwenzfJBXBEZdtkpCampBYppOYl
	56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAN2qpFCWmFMKFApILC5W0rez
	KcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOuLvqB1vBPoGKM+s+
	szcwbuPtYuTkkBAwkfj66h8riC0ksJtR4tNjky5GLiD7E6PEx4/HmOGc/jtXWLoYOcA6dh2O
	hojvZJT41fKVFcL5zCix+vBvJpAiNgFNiQuTS0Gmigi4SDT8e8MIUsMs8JhRYkfvPSaQhLCA
	p8T5RfPZQGwWAVWJ/b2HweK8AhYSb35dYYc4T15i5qXvYDangKXExnUgg0BqBCVOznzCAmIz
	A9U0b50NdqmEwFwOiePb+5khml0kpi/9yAphC0u8Or4FaqiUxMv+Nig7WeLSzHNMEHaJxOM9
	B6Fse4nWUyBzOIAWaEqs36UPsYtPovf3EyZIQPBKdLQJQVQrStyb9BRqk7jEwxlLoGwPiRVn
	97JAQreHUaL1kt4ERvlZSD6YheSDWQjLFjAyr2KUTC0ozk1PLTYtMM5LLYdHa3J+7iZGcILV
	8t7B+OjBB71DjEwcjIcYJTiYlUR4b7lfSxHiTUmsrEotyo8vKs1JLT7EaAoM4onMUqLJ+cAU
	n1cSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8TB6dUA9PD2jDLY+yLN/44
	NO3MoqnVFTNyjC8xZKzqe/7suXN7/wL9p73KL1Jbtv/Iy2q53Nyz5S/TVvlZXryS+5yvMTwO
	nXWd6+G9ltWbEvoMUvqf/zi7uSpqTrO/HW9AMs+vKQWiz7r5JRZdCri8MuqqipNEcZWdvJzN
	Rb0rGfztPmdnXJE6XWzO1pAxZX/Ew5sBGj+kON4t8D92wuVNbkNi2HLlk83WyvvWfGH60mA7
	U2lewZqP3cZ/xfit599MfS6rmCp8TdRkq6jhnKvBcW+S5Et45/bofPgnevzIYpmX6pf21pnf
	1rF8u+HUcvHfid4rF9WZH5pR1s1paxeZ4vt5TfLzYoMWwWvO073n/VT9n63EUpyRaKjFXFSc
	CACgE9CtOQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSvK5azLUUg67lmhZrrvxmt1h9t5/N
	4uaBnUwWK1cfZbI4+v8tm8X5t4eZLCYdusZoMX/ZU3aLda/fs1gs2PiI0eJxdwejxYY2QQce
	j52z7rJ7nL+3kcXj8tlSj02rOtk8Ni+p99h9s4HNo2/LKkaPz5vkAjiiuGxSUnMyy1KL9O0S
	uDLurvrBVrBPoOLMus/sDYzbeLsYOTgkBEwkdh2O7mLk4hAS2M4osWPaJpYuRk6guLhE87Uf
	7BC2sMTKf8/ZIYo+Mkp8af/LBtLMJqApcWFyKUiNiICXxLzZC1hAapgFXgMN6t/OCJIQFvCU
	OL9oPhuIzSKgKrG/9zATiM0rYCHx5tcVqAXyEjMvfQezOQUsJTauewPWKwRUs2vPZUaIekGJ
	kzOfgB3HDFTfvHU28wRGgVlIUrOQpBYwMq1iFE0tKM5Nz00uMNQrTswtLs1L10vOz93ECI4L
	raAdjMvW/9U7xMjEwXiIUYKDWUmE95b7tRQh3pTEyqrUovz4otKc1OJDjNIcLErivMo5nSlC
	AumJJanZqakFqUUwWSYOTqkGpt0GzCsZTHbltrSsUvHjl7tUKmGvf+n00ZNcMdfvPIu6GCR5
	QcBwacONC83Hv6zdtjfobbXE7QKdHs6FMgYb4/p+/JWTljr6eusFxgMX7lS9+Xnv2eqZbUfn
	vPE2sD/s4Lfo9wo5nndnlmZ84hR4c/N4Kv+lV27PznVxyD2xizWdveRfmdB+nqhvHi5iwhPX
	Xdyd+tC688u/Y6fk3lWkHZetnFDq/GGT3frgT0+jLjwrX8jd/miu7IVr72VmuP9etk7eZgnb
	mWT/qz3fn+8XedPW8vJT85f/dp92/7I5fzEwZIbdpQtcJtfiP/KpuXz6mtAoNkH48JejHyQ4
	88wZo6YdknBtfvsnxOL38SkBWey/lFiKMxINtZiLihMBSZMUUPoCAAA=
X-CMS-MailID: 20230811160454epcas5p2635d208557749a2431b99c27b30a727f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811160454epcas5p2635d208557749a2431b99c27b30a727f
References: <20230811155906.15883-1-joshi.k@samsung.com>
	<CGME20230811160454epcas5p2635d208557749a2431b99c27b30a727f@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_090459_905808_15EF0AE5 
X-CRM114-Status: GOOD (  15.66  )
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

User can specify a smaller meta buffer than what the device is
wired to update/access.
This may lead to Device doing a larger DMA operation, overwriting
unrelated kernel memory.

Detect this situation for uring passthrough, and bail out.

Fixes: 456cba386e94 ("nvme: wire-up uring-cmd support for io-passthru on char-device")
Cc: stable@vger.kernel.org

Reported-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 19a5177bc360..fb73fa95f090 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -320,6 +320,30 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			meta_len, lower_32_bits(io.slba), NULL, 0, 0);
 }
 
+static bool nvme_validate_passthru_meta(struct nvme_ctrl *ctrl,
+					struct nvme_ns *ns,
+					struct nvme_command *c,
+					__u64 meta, __u32 meta_len)
+{
+	/*
+	 * User may specify smaller meta-buffer with a larger data-buffer.
+	 * Driver allocated meta buffer will also be small.
+	 * Device can do larger dma into that, overwriting unrelated kernel
+	 * memory.
+	 */
+	if (ns && (meta_len || meta)) {
+		u16 nlb = lower_16_bits(le32_to_cpu(c->common.cdw12));
+
+		if (meta_len != (nlb + 1) * ns->ms) {
+			dev_err(ctrl->device,
+			"%s: metadata length does not match!\n", current->comm);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 					struct nvme_ns *ns, __u32 nsid)
 {
@@ -593,6 +617,10 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	d.metadata_len = READ_ONCE(cmd->metadata_len);
 	d.timeout_ms = READ_ONCE(cmd->timeout_ms);
 
+	if (!nvme_validate_passthru_meta(ctrl, ns, &c, d.metadata,
+					 d.metadata_len))
+		return -EINVAL;
+
 	if (issue_flags & IO_URING_F_NONBLOCK) {
 		rq_flags |= REQ_NOWAIT;
 		blk_flags = BLK_MQ_REQ_NOWAIT;
-- 
2.25.1


