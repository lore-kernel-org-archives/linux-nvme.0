Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1612C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 05:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zXXktuCSS0wMZL9EG+s+pP6UqCnhzNUgUVk1bLEfSZM=; b=rP2K180STDje+xmcZU4etVEGYf
	BbS1NdZSbttTzlbRB2ngHc8V8PaVrBPDJlKHt98Wq4WcgR+jQmRVEV1yQsQLTlVOT77FwdJQrlR4n
	L/ONh1+UNm/q42Hk+K3g+TcqK+dXWNN9hjNVg6Rp8ld/BOFPz0Sxrd3x8KlzdN+EM/7BsNeghyg0W
	Swqbn6dS5hqmfmYtTKUIgJRkFTeLl+ZUEF5c3+QlXBGOpYkNIWTNWCh3JfmsIRaQ0ElvvUIs1uz95
	X6wsxFwl5EU/y3DzkY+0ZU8ean20MceYG1BQ2gTz8p40dRJfJ5Y2RzMJkl+Lks6hVPuUrJ9AxJudQ
	56oGq3iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrvAT-00AbPR-9f; Fri, 20 May 2022 05:27:17 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrvAL-00AbLm-Cj
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 05:27:11 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220520052656epoutp035ed18f2063ef8cf9be4b2938cc72da69~wuPL18xfb1527115271epoutp03e
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 05:26:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220520052656epoutp035ed18f2063ef8cf9be4b2938cc72da69~wuPL18xfb1527115271epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1653024416;
 bh=zXXktuCSS0wMZL9EG+s+pP6UqCnhzNUgUVk1bLEfSZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NjshoxN8cnBDM0tHr0XZ3lk7XOZYiYfymH2OUMAMlXWBScsPSGnfIAhCtFTx3KxIp
 4z6lDCmtdZna+nXR55Q41oJHXxGw8WT5s/j+PZYDfqGLR778rtq+IE0BGjdSr9+OgY
 voi6nZSRLY7tYRIiRkBUb5WAsEMNuGK/X2w3Tl7U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20220520052656epcas5p141969b5ad23e7a5b818e24f4b5d6dcd3~wuPLdgZ0D0594305943epcas5p1A;
 Fri, 20 May 2022 05:26:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4L4Fb02NHVz4x9Q2; Fri, 20 May
 2022 05:26:52 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 4C.D7.09762.99627826; Fri, 20 May 2022 14:26:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20220520050119epcas5p3de7be37ffc16b99627173bd1c4900439~wt40QTzth1582115821epcas5p3T;
 Fri, 20 May 2022 05:01:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220520050119epsmtrp28ed75c65822fa9d62bfd31b382a9d1bd~wt40PXJql1281612816epsmtrp2B;
 Fri, 20 May 2022 05:01:19 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-e2-628726995097
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 79.36.11276.F9027826; Fri, 20 May 2022 14:01:19 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220520050118epsmtip1c2117401c1db0c6aa7c65cd05ccfadeb~wt4zHz3ns2700327003epsmtip1T;
 Fri, 20 May 2022 05:01:18 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: [PATCH v2 1/2] nvme: helper for uring-passthrough checks
Date: Fri, 20 May 2022 10:25:59 +0530
Message-Id: <20220520045600.3773-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520045600.3773-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTS3emWnuSwb7N5har7/azWdw8sJPJ
 YuXqo0wW598eZrKYdOgao8X8ZU/ZHdg8ds66y+5x+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
 W1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
 ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE
 7Iyu/gaWgje8Ffu6tzI2MG7j7mLk5JAQMJGYd7eHpYuRg0NIYDejxLyQLkYuIPMTo8Sc5e+Z
 IJxvjBKbbz9ihmn41tfFDJHYyyjx7vhjFgjnM6PE8t8PmUBGsQloSlyYXApiiggYSdx+GwPS
 yyzgL3Fl/T52EFtYwFHi4KtnTCA2i4CqxM5nL9hAbF4Bc4ll87axQ+ySl5h56TuYzSlgIfHy
 2yV2iBpBiZMzn7BAzJSXaN46G+weCYFH7BLTtt2DOtRF4u303VCDhCVeHd8CZUtJfH63lw3C
 TpZo3X6ZHeROCYESiSUL1CHC9hIX9/wF+4QZ6JP1u/QhwrISU0+tY4JYyyfR+/sJE0ScV2LH
 PBhbUeLepKesELa4xMMZS6BsD4njh7ezQkKqm1Gi/+UF9gmMCrOQvDMLyTuzEFYvYGRexSiZ
 WlCcm55abFpgnJdaDo/h5PzcTYzgVKnlvYPx0YMPeocYmTgYDzFKcDArifAy5rYkCfGmJFZW
 pRblxxeV5qQWH2I0BYb3RGYp0eR8YLLOK4k3NLE0MDEzMzOxNDYzVBLnFfjfmCQkkJ5Ykpqd
 mlqQWgTTx8TBKdXAdLlgYoKg6yPTB/vcz23Tf+09Xczn5eT/kZNeOURP+s+wULy9cSnzObH6
 U4Vv3pqcPHtw0Z2bAocW8HBuW5zGWrmksdgxYeLJS5+WCyk93GuxxfLc+RlXPyoGd2+e0Cri
 MLNhYS7/6bdb+3fGLPy7b+5EW9sFJxcEPN2+6eJjxpzK2NjmdckvondpvH8ZUPnY04SPJX31
 ctd8s+d9LIcza49ZrBXy/63wbsK+FN8Ln3dtn2xy4P6DTfwzTuVbngwU2MMhwrJGzL5NIbA7
 yKDmPV/k3D8bLOseaT6RPXznw2fhT1Nbbbnumk/2q/j14V2DZtfVw8laXYUvk5T5n80XZUvn
 iFX0fdqxMENnlVDYwSglluKMREMt5qLiRABKMazVHgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnO58hfYkgy0P5C1W3+1ns7h5YCeT
 xcrVR5kszr89zGQx6dA1Rov5y56yO7B57Jx1l93j8tlSj02rOtk8Ni+p99h9s4HNo2/LKsYA
 tigum5TUnMyy1CJ9uwSujK7+BpaCN7wV+7q3MjYwbuPuYuTkkBAwkfjW18XcxcjFISSwm1Hi
 w6VlbBAJcYnmaz/YIWxhiZX/nrNDFH1klNh05CBrFyMHB5uApsSFyaUgNSICZhILFsxjAbGZ
 BQIlunvug9nCAo4SB189YwKxWQRUJXY+ewE2n1fAXGLZvG1Q8+UlZl76DmZzClhIvPx2CcwW
 AqrZevczE0S9oMTJmU+g5stLNG+dzTyBUWAWktQsJKkFjEyrGCVTC4pz03OLDQsM81LL9YoT
 c4tL89L1kvNzNzGCQ1pLcwfj9lUf9A4xMnEwHmKU4GBWEuFlzG1JEuJNSaysSi3Kjy8qzUkt
 PsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoFpwodA5pM3P00LX//Ioqnlfqb2py3T
 +g9eec0bp2yZo5KoWDdzHescgRWmFqwLeAy292pJmu27mPjNe2FF0QfZhqPGRfWTt699Hx8i
 qqrzcpX5O3nhnVwvHb2jmpzu6h5Rn7WgfaLZ5quGd4ru3DFd/vJy7inBTcUFds+bnj2//Gvz
 Khfm5LiyxNrfP16cF3u1yrtY4ImIuVG+2YJK7iKe04Eb9jhJrLWf4r1Pa9s5W4c76Qt5bq85
 zFlR8ORBmgdjofU2/jOTixtj9XU3GB8xOdWvHb/VdftMH1/v0t3foz9pHjZfcnWv5KN7dnd+
 l63Q2ygsbCLFoRLAmsSXXeq4O/1fyAb1q/+qH78TNb2pxFKckWioxVxUnAgAzMC7AtgCAAA=
X-CMS-MailID: 20220520050119epcas5p3de7be37ffc16b99627173bd1c4900439
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520050119epcas5p3de7be37ffc16b99627173bd1c4900439
References: <20220520045600.3773-1-joshi.k@samsung.com>
 <CGME20220520050119epcas5p3de7be37ffc16b99627173bd1c4900439@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_222709_854827_E2BD5E58 
X-CRM114-Status: GOOD (  18.18  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


