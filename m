Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF409C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 06:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LKzGfvPgJTDMD6DERZrk/y0T24HalJ230e0TpkLFoN4=; b=mOcngagNysfNgJGnZCGiAdTlHP
	5VsH6ZPUxZpSMhcGYPjTN0mE7fNkefApn8y2FKSVp2bRh7frJJqATV1nmGwUUQ8e/1B/vGBhLLjmZ
	zcwoMOcTtrs8U1cXYvfIuyKSOYbGXdu+8fxZwO+pMP2Pak0Ta4oJ2g8AfCVaXFxUhtIMbqVn/69Va
	yj5ybK5rr2Bmaz+2aNhbOtkkT1Hl2gpSymW6xnjOXH8UTQrE7v7y3PYI8rYZJb36vEJTgHo4IPJ4m
	lGwMfO5uf0q0tUVelpduHlnN5oISPQ22kKqPsM0BGEro093k574QGtVPS9oHioP2gs5i6LIynzStg
	ZsaB9ixA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqr1p-00Bt3y-Tv; Tue, 17 May 2022 06:49:57 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqr0W-00BsKl-9s
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 06:48:40 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20220517064828epoutp04fe47d7472c3f1df6f7b94cf04fd3fa12~v0agqOCql1299512995epoutp04G
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 06:48:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20220517064828epoutp04fe47d7472c3f1df6f7b94cf04fd3fa12~v0agqOCql1299512995epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652770108;
 bh=LKzGfvPgJTDMD6DERZrk/y0T24HalJ230e0TpkLFoN4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tbjvs3+71Tlfq2Kq9sNy4435rUaJycRtrnBm7897ZowAf4eBocH+Hlc8HohMRCRZG
 AeEuow/zOAQPih51byEF8NaqmcA84yfQrvBPlJ5QtwIXncWClJvcZy2K8qI/OVcZYI
 bllm7fYMnweVbz51Tz0R6o5lJJ/h6T9nnRzJCPSM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20220517064827epcas5p4bc8bc9487c7948646aa741ea8dadb04c~v0agMn5yI2780527805epcas5p4K;
 Tue, 17 May 2022 06:48:27 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4L2RXT3xgzz4x9QK; Tue, 17 May
 2022 06:48:25 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 9B.16.09827.93543826; Tue, 17 May 2022 15:48:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20220517053711epcas5p40f48777253119633d99c8b2b905793ff~vzcRJ9H7H3106831068epcas5p4S;
 Tue, 17 May 2022 05:37:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220517053711epsmtrp18338a403ccee56a4edb0a283dc6f2bce~vzcRJQpCm0103601036epsmtrp1i;
 Tue, 17 May 2022 05:37:11 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-80-62834539193f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 E5.1D.08924.78433826; Tue, 17 May 2022 14:37:11 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220517053710epsmtip19d8d37bf4548c481db96bd4cf4acdae1~vzcQLRwPX1995019950epsmtip1E;
 Tue, 17 May 2022 05:37:10 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: [PATCH 1/3] nvme: helper for uring-passthrough checks
Date: Tue, 17 May 2022 11:01:45 +0530
Message-Id: <20220517053147.7925-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517053147.7925-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTS9fStTnJoGuPhMXqu/1sFjcP7GSy
 WLn6KJPF+beHmSwmHbrGaDF/2VN2BzaPnbPusntcPlvqsWlVJ5vH5iX1HrtvNrB59G1ZxRjA
 FpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0hZJC
 WWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAh
 O2PGz0nsBft5K95cncPewNjH3cXIwSEhYCJx9W1+FyMXh5DAbkaJlqWnmCGcT4wSM2e8ZYJw
 PjNK7J15mLGLkROso/XiM6iqXYwS1zcvRqjaeuQcI8hcNgFNiQuTS0FMEQEjidtvY0B6mQX8
 Ja6s38cOYgsL2Ek8vz6RDcRmEVCVaFmzFCzOK2Au0b9gFQvELnmJmZe+s4OM4RSwkJi3xwei
 RFDi5MwnLBAj5SWat84GO0dC4B67xPKF/5khel0kXmy+AWULS7w6voUdwpaSeNnfBmUnS7Ru
 v8wOCYkSiSUL1CHC9hIX9/xlAgkzAz2yfpc+RFhWYuqpdUwQa/kken8/YYKI80rsmAdjK0rc
 m/SUFcIWl3g4YwmU7SHxb1sXNNS6GSXWtVxjmsCoMAvJO7OQvDMLYfUCRuZVjJKpBcW56anF
 pgVGeanl8BhOzs/dxAhOlVpeOxgfPvigd4iRiYPxEKMEB7OSCK9BRUOSEG9KYmVValF+fFFp
 TmrxIUZTYHBPZJYSTc4HJuu8knhDE0sDEzMzMxNLYzNDJXFegf+NSUIC6YklqdmpqQWpRTB9
 TBycUg1Ma8p5dm18LPNUyPfHu2sTD7y+W+AUK3m2g6VGRWL2tRj1L5EB3yWSNwqZhS5ufhC5
 0S40fbN2bNnzkFoFy9z7dbtCNqtyvLRQ/FvJLnpWOVl+/x62ee2zBYWak0XDVAViPznzTn09
 xXPZ48xajSln+Jz1/3Duuhk2/WvJz9B7jl8NjZr0nTT2nbpud6fHb3e59Z5uu1SR3U+5v8wV
 eKjwzH31uv2eM7f2xvmz199g+qBxiS3lhIBJ2sTioD+Oa5xTwyaqPtlgtvLm2ctx6x/fyM0u
 tdw8pdRydpf4Kfu6qyyHDi79ua9Fn6tG/5/179ALO7Yad88IeacxdeO5Fy8v6jVaK9x01BC2
 7Uh++4VPiaU4I9FQi7moOBEAAi9NBR4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSnG67SXOSwbxrHBar7/azWdw8sJPJ
 YuXqo0wW598eZrKYdOgao8X8ZU/ZHdg8ds66y+5x+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
 WxSXTUpqTmZZapG+XQJXxoyfk9gL9vNWvLk6h72BsY+7i5GTQ0LARKL14jPmLkYuDiGBHYwS
 LZ9eMUIkxCWar/1gh7CFJVb+e84OUfSRUeLT8VYgh4ODTUBT4sLkUpAaEQEziQUL5rGA2MwC
 gRLdPffBbGEBO4nn1yeygdgsAqoSLWuWgs3kFTCX6F+wigVivrzEzEvfwUZyClhIzNvjAxIW
 Air59+0kI0S5oMTJmU+gxstLNG+dzTyBUWAWktQsJKkFjEyrGCVTC4pz03OLDQuM8lLL9YoT
 c4tL89L1kvNzNzGCA1pLawfjnlUf9A4xMnEwHmKU4GBWEuE1qGhIEuJNSaysSi3Kjy8qzUkt
 PsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoGp66HTi4q6yfJWFoptvilvYl6GxN1a
 12h8uyL0gfg+0fr9inyzFgicmF/X82z/k0zXT+w2DUdtKntLOv00ls6cXrLH+q5k+8Rl8/8X
 hzfKRfZ4LVlneTDy5LpvRn//8bufWn0osfdpS/qXxU35+jt0d6XlKs2zXjLf+k2hrNnCLS2P
 vxpy/5kyUaG28bKf3mMl3dIjAQIfzwmrlfQrbWL1PnymVMxflbF5utgsPYEgnjVPr/pmCnYI
 9pcf3yBVwn09TTa/nmNOHs/sR3I2P7KkU53S9INCVkn77vs+10PweaVL5Mv+/YUatzsXuc18
 4yXzoucu/7U7SyQ67D7MiqnqtP58JOa4iOyc8rQlhkosxRmJhlrMRcWJAIsZeSrXAgAA
X-CMS-MailID: 20220517053711epcas5p40f48777253119633d99c8b2b905793ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517053711epcas5p40f48777253119633d99c8b2b905793ff
References: <20220517053147.7925-1-joshi.k@samsung.com>
 <CGME20220517053711epcas5p40f48777253119633d99c8b2b905793ff@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_234836_926575_53603ADF 
X-CRM114-Status: GOOD (  17.63  )
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

Factor out a helper consolidating the error checks, and fix typo in a
comment too. This is in preparation to support admin commands on this
path.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 7b0e2c9cdcae..114b490592b0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -556,22 +556,30 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return __nvme_ioctl(ns, cmd, (void __user *)arg);
 }
 
-static int nvme_ns_uring_cmd(struct nvme_ns *ns, struct io_uring_cmd *ioucmd,
-			     unsigned int issue_flags)
+static int nvme_uring_cmd_checks(unsigned int issue_flags)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
-	int ret;
-
-	BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
-
 	/* IOPOLL not supported yet */
 	if (issue_flags & IO_URING_F_IOPOLL)
 		return -EOPNOTSUPP;
 
-	/* NVMe passthrough requires bit SQE/CQE support */
+	/* NVMe passthrough requires big SQE/CQE support */
 	if ((issue_flags & (IO_URING_F_SQE128|IO_URING_F_CQE32)) !=
 	    (IO_URING_F_SQE128|IO_URING_F_CQE32))
 		return -EOPNOTSUPP;
+	return 0;
+}
+
+static int nvme_ns_uring_cmd(struct nvme_ns *ns, struct io_uring_cmd *ioucmd,
+			     unsigned int issue_flags)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
+
+	ret = nvme_uring_cmd_checks(issue_flags);
+	if (ret)
+		return ret;
 
 	switch (ioucmd->cmd_op) {
 	case NVME_URING_CMD_IO:
-- 
2.25.1


