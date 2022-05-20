Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CFBC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 10:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zXXktuCSS0wMZL9EG+s+pP6UqCnhzNUgUVk1bLEfSZM=; b=btihx/5THraOAiGlQB1Tl+8yiq
	F2ZjnvWkCVXZ7lSXMsdjXy0F2XuSitHt0vkpGPrz9kPIcmOxfg2mI8BQ1peuJPPAWgF0l4RLgT6CT
	QV16Fp1jjgFBeoRS9V7giWJX/TII5IdXN/EQKl6oYY5a32HelN0bTrlu/o8KMrvNpOynNe5z4NYFz
	AOkEMcfvsL/uz6/q+pY+wz/p5KTFTClGoEEs/zoL2pdqCZwGdT8JoxO1b5ww56RWyBBqpg4G162hT
	RFWzn2t2sDHmoaMwf6vkY3RxYd/ZyQ43nDsDlSRcq0GSZ3uWrYiIdZX4PMkzdjry0BLA91nYWThFH
	95A+LKmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrzll-00BrG3-Uh; Fri, 20 May 2022 10:22:05 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrzli-00BrEH-P2
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 10:22:04 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20220520102157epoutp04730dfbd8751587accb316898cdf83675~wyQwrWOu22773027730epoutp04X
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 10:21:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20220520102157epoutp04730dfbd8751587accb316898cdf83675~wyQwrWOu22773027730epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1653042117;
 bh=zXXktuCSS0wMZL9EG+s+pP6UqCnhzNUgUVk1bLEfSZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FAjfWnk/u0HMBqx5WRp3ZXHrgTycZFeDTOtkkqACbXD/+gX7ueiel4DCeyq0h7iY6
 edKNkNNVftUlRqqs27HHbnAcKMiAXv5NVHXIFIQ1A4B0ROkGml+LShigvCm8ksLV1d
 yvfWNw/LWjyMebhZTEfvrwQ0LRtM0UzoKT/ixZUA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20220520102157epcas5p3c28a796976088fff8be0004badc7bdea~wyQwfJQJh0285302853epcas5p3d;
 Fri, 20 May 2022 10:21:57 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4L4N7P1fZKz4x9Q0; Fri, 20 May
 2022 10:21:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 47.6B.10063.DBB67826; Fri, 20 May 2022 19:21:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20220520091212epcas5p4da8c22b626a6b30bff00c9d4e0c7c265~wxT3SbWjG1115911159epcas5p4n;
 Fri, 20 May 2022 09:12:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220520091212epsmtrp2b7177313d169b5bcc2981643684b232d~wxT3RvtY22958929589epsmtrp2H;
 Fri, 20 May 2022 09:12:12 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-1c-62876bbda1f7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 4F.0B.08924.C6B57826; Fri, 20 May 2022 18:12:12 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220520091211epsmtip1027d214a2a8fcc4b93edcac30b5d7bce~wxT2Osw701723017230epsmtip1d;
 Fri, 20 May 2022 09:12:11 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: [PATCH v3 1/2] nvme: helper for uring-passthrough checks
Date: Fri, 20 May 2022 14:36:29 +0530
Message-Id: <20220520090630.70394-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520090630.70394-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTXXdvdnuSQX+vqsXqu/1sFjcP7GSy
 WLn6KJPF+beHmSwmHbrGaDF/2VN2BzaPnbPusntcPlvqsWlVJ5vH5iX1HrtvNrB59G1ZxRjA
 FpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0hZJC
 WWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAh
 O6Orv4Gl4A1vxb7urYwNjNu4uxg5OSQETCQWdq1l6WLk4hAS2M0osa69jR3C+cQosWreEqjM
 Z0aJKR9WMMG0rF3QDFW1i1Hi+vpeRriqf19ms3YxcnCwCWhKXJhcCtIgImAksf/TSVYQm1nA
 X+LK+n3sILawgKPEjHV72UBsFgFViUcrPzKC2LwCFhLLXlxhg1gmLzHz0newek4BS4mrL1cx
 QdQISpyc+YQFYqa8RPPW2cwgN0gIvGSXuP9jJSNEs4vEz7c/oAYJS7w6voUdwpaS+PxuL1Q8
 WaJ1+2V2kJslBEoklixQhwjbS1zc85cJJMwM9Mr6XfoQYVmJqafWMUGs5ZPo/f0EGia8Ejvm
 wdiKEvcmPWWFsMUlHs5YAmV7SPz7fxbMFhLoYZR428U1gVFhFpJvZiH5ZhbC5gWMzKsYJVML
 inPTU4tNCwzzUsvhcZycn7uJEZwutTx3MN598EHvECMTB+MhRgkOZiURXsbcliQh3pTEyqrU
 ovz4otKc1OJDjKbA4J7ILCWanA9M2Hkl8YYmlgYmZmZmJpbGZoZK4rwC/xuThATSE0tSs1NT
 C1KLYPqYODilGphk14W28zBqbrz+R4fht+3T/vr2ObF7P+Ye3LFevvJV+dlvmdfE90WfaW/6
 4V94pNWFuaeXY1Fa+9+uCdGVq7bKWcoqG6YcTaz1sVdNlwxZaLGmefK/Xr6tM7X2CTdk5R7t
 5r+7buL0gh9SM3YxvtqWKCGQk5f/l0U67B5/xHWhYKEJT78VbWG4P6e8tDzQNWD5DY9Ovf75
 f9y+LDuo+lfOe1e2l43A+uxwrtDV/ak/XqTMlxVYuOfzPYGb3E4sKpe6vKOesByIjN2Wr7Ld
 pnij4d3wJR331Zpezp2Tu7bpw5OH3kJpeYbXOK+XKps/EtQ/JpL9K9D4X6qaBuO+/jCVD1kS
 ckn6goWHD/p6KrEUZyQaajEXFScCAGG4xcYgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnG5OdHuSQdtcSYvVd/vZLG4e2Mlk
 sXL1USaL828PM1lMOnSN0WL+sqfsDmweO2fdZfe4fLbUY9OqTjaPzUvqPXbfbGDz6NuyijGA
 LYrLJiU1J7MstUjfLoEro6u/gaXgDW/Fvu6tjA2M27i7GDk5JARMJNYuaGbvYuTiEBLYwShx
 rXs7E0RCXKL52g92CFtYYuW/51BFHxkl7vQ8Zuli5OBgE9CUuDC5FKRGRMBMYunhNSwgNrNA
 oER3z30wW1jAUWLGur1sIDaLgKrEo5UfGUFsXgELiWUvrrBBzJeXmHnpO9guTgFLiasvV4Hd
 IARU83TKYjaIekGJkzOfQM2Xl2jeOpt5AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOWllusV
 J+YWl+al6yXn525iBIe0ltYOxj2rPugdYmTiYDzEKMHBrCTCy5jbkiTEm5JYWZValB9fVJqT
 WnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDU2fpau25b2MkQvdvv3J7a9X77+W5
 Iefvlc70CVoX+dh7uVTVCgftkjPWi2e68XXN9WZyYJzR8OCI++HGWJNjVV+elVU/vLT9KMM5
 G9UPFxkeTfK+ofBwwe5ZEZk85/OWT/6+sDvh3fIPE3WvOLzOnMrrqPXM6Vx90CHGu7faFA9M
 3XPps+hObUbhJdUpmcsV5XL3Ofksr289ULYx6Z7Q+1kr6x60WXH8+GpsdPxgy5ncIyWLWRa4
 XbgbwbzC8PDyVbLhTFO8ju2NyNobt6Gv5UFl6mLeXJ2qNOfPJcYrNY5bSGn3zTq/aSXrGwW3
 vMIdzJLvSl9qvlNlKheQv/8/ofwCx10vx2KuE3es3/Zm2CmxFGckGmoxFxUnAgB1xSyS2AIA
 AA==
X-CMS-MailID: 20220520091212epcas5p4da8c22b626a6b30bff00c9d4e0c7c265
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520091212epcas5p4da8c22b626a6b30bff00c9d4e0c7c265
References: <20220520090630.70394-1-joshi.k@samsung.com>
 <CGME20220520091212epcas5p4da8c22b626a6b30bff00c9d4e0c7c265@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_032203_234794_C270CE72 
X-CRM114-Status: GOOD (  18.38  )
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


