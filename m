Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E26C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 05:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jOAcoz9Uzahv8XUzxGUKeOLh5Z0CZm28+eeIcfrHcIU=; b=w1pQRX0XdCPmPjkp2/LipheXnv
	WcnzMgZSV4AX4y+2xLT/kHvlw63rD30IGYhf+9zzme97e/KssHIcBg5aC45YqEb39P7dukv3sl40T
	9kvTIIDCseLgQnnXyz6bXkxQgLw69FY96xK/ThjLOSDGO3qaa0yerZyRLAayJJQoCG8hwdrguhH1e
	q4+r9HvATguF35FAMSa/jU598R8vLZXCWKkonJvmQTGoLf6A3+eOGJa9CizeGlZDnnhLerUKh7H3V
	rdn4aTlczTMKLZF42TYKp9sCPnVFsfetpExqoJYSFFXPe/efl1yMcnu39Lhr2TQXF/8qpC5LxQK2k
	rshLN5hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrvAX-00AbQm-I2; Fri, 20 May 2022 05:27:21 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrvAP-00AbMa-QH
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 05:27:15 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20220520052708epoutp028af29ecd208a4b09bc80d6136b154b5a~wuPWb7j412929729297epoutp02i
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 05:27:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20220520052708epoutp028af29ecd208a4b09bc80d6136b154b5a~wuPWb7j412929729297epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1653024428;
 bh=jOAcoz9Uzahv8XUzxGUKeOLh5Z0CZm28+eeIcfrHcIU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ayRWA/pdVzI3LU6rILeBJDQQX8+YuN4MYyUMTn+lRraZ1jCKaQSfZ3NssBgQaXRzv
 /sdYPAeiqA3YlrVoAZYPHZ5rRJYQlzNn/yiLs2hIX+yv6CN+y+dnMts+lNfhCxOKFq
 43ddFPK8z7qQ534RcbqD8j7uiNefpvA8BeLsDaJM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20220520052708epcas5p273677838936ff9b683ac467f191d0fd7~wuPWMRXV61546215462epcas5p2E;
 Fri, 20 May 2022 05:27:08 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4L4Fb95tdFz4x9Q1; Fri, 20 May
 2022 05:27:01 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 56.E7.09762.4A627826; Fri, 20 May 2022 14:27:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20220520050120epcas5p41c6262e3c3ac9029f5895c696c233228~wt41TaBwI0106201062epcas5p4l;
 Fri, 20 May 2022 05:01:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220520050120epsmtrp13f097503e4391ff258b734c249d46902~wt41Sd-Kn0424304243epsmtrp1I;
 Fri, 20 May 2022 05:01:20 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-03-628726a476e4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 6A.36.11276.0A027826; Fri, 20 May 2022 14:01:20 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220520050119epsmtip17e2a545537888b38904664aeeabd6818~wt40PsW8K3145431454epsmtip1Z;
 Fri, 20 May 2022 05:01:19 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: [PATCH v2 2/2] nvme: enable uring-passthrough for admin commands
Date: Fri, 20 May 2022 10:26:00 +0530
Message-Id: <20220520045600.3773-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520045600.3773-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTXXeJWnuSwc6XKhar7/azWdw8sJPJ
 YuXqo0wW598eZrKYdOgao8X8ZU/ZHdg8ds66y+5x+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
 W1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
 ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE
 7IyGacdZCtaIVbxeGN7A+Fuoi5GDQ0LAROJrb3AXIxeHkMBuRonb3w+wQjifGCUOdy5h7mLk
 BHK+MUpMnewJYoM0zFv5iA2iaC+jxKldt6E6PjNKPDl9gAlkLJuApsSFyaUgpoiAkcTttzEg
 vcwC/hJX1u9jBwkLC3hKPPseAmKyCKhK7DroA1LBK2AusenabzaITfISMy99ZwexOQUsJF5+
 u8QOUSMocXLmExaIifISzVtnM4McICHwiF3iYNNMqGYXiYPTrjBB2MISr45vYYewpSRe9rdB
 2ckSrdsvs0PCoURiyQJ1iLC9xMU9f8H+YAb6Y/0ufYiwrMTUU+uYINbySfT+fgI1nVdixzwY
 W1Hi3qSnrBC2uMTDGUugbA+J3bs3skPCqZtR4sXr04wTGBVmIXlnFpJ3ZiGsXsDIvIpRMrWg
 ODc9tdi0wDgvtRwevcn5uZsYwUlSy3sH46MHH/QOMTJxMB5ilOBgVhLhZcxtSRLiTUmsrEot
 yo8vKs1JLT7EaAoM7onMUqLJ+cA0nVcSb2hiaWBiZmZmYmlsZqgkzivwvzFJSCA9sSQ1OzW1
 ILUIpo+Jg1OqgWn3+n9ONwX1fM+f3DP3x/qELPtru17xVQuLWMlWSnerTtbvjFmwWCmhz+5E
 h42OmwOz9q7Aq2rVJQK5B5fGPyjV+tDyv+PAfgOdiAhhOzbxB0c/zfIXe3G2htHg9Lwzc+u+
 r/Z42HPmqO2jVRZGT5MPvFS3/7p60uXn7j90eFUaDRZIMTL9earPdWt56pHdbzWrr1xgrWFr
 PsSck7Z6ebuR8eG9bBHzZhXd3OzwM2ehoePDf6xvfep3vEri925py1/3a/e2qbd2vlmRxvfU
 asP9Nf3iP3x1b1Vl/vb5+nbxL8ddv/+FzfZJiZD6eKKtSq2Ho9iY7cxvp58veVOOnLihlbj0
 WM7GvbdDbJbeVripxFKckWioxVxUnAgAEou6sxsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSnO4ChfYkg/8ftC1W3+1ns7h5YCeT
 xcrVR5kszr89zGQx6dA1Rov5y56yO7B57Jx1l93j8tlSj02rOtk8Ni+p99h9s4HNo2/LKsYA
 tigum5TUnMyy1CJ9uwSujIZpx1kK1ohVvF4Y3sD4W6iLkZNDQsBEYt7KR2xdjFwcQgK7GSUm
 /VnCDJEQl2i+9oMdwhaWWPnvOTtE0UdGiX1LjjB2MXJwsAloSlyYXApSIyJgJrFgwTwWEJtZ
 IFCiu+c+C0iJsICnxLPvISAmi4CqxK6DPiAVvALmEpuu/WaDmC4vMfPSd7BNnAIWEi+/XQKz
 hYBqtt79zARRLyhxcuYTqOnyEs1bZzNPYBSYhSQ1C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3i
 xNzi0rx0veT83E2M4GDW0tzBuH3VB71DjEwcjIcYJTiYlUR4GXNbkoR4UxIrq1KL8uOLSnNS
 iw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgOtg/b92M0CM3PeUsd/S2b0u9JWmz
 O//FRLmlP6+yTOn/y+vxpqn3Ggt/tJLGw/a+B3Y+UStf/noV8OU+36XCAoE29Zs5m1OypkQw
 veVdrr9aqk1/k8ypxGPFvg1PXQpO/W+TXfliQtC8TUwB1uUP4sOOpU1PfmDWPGHtpxCXzbFc
 Fb7tm2+Vr3/XzRz9RUd8wbk/8rVXVKe94mNkjzsm1d9nXhVbeHJy9hPpxSuedjSt8t7x5/lU
 /fOKq/K3J637yZXXziwge+K6AM+HMrnNyp0bM9Rnpy3oZZihpFQrviI4oX/3T5mTVQyB1keu
 X255k3j32HG3A+Yrn2QcNjN4M2FCbOGLbctvLOaSfiZoqMRSnJFoqMVcVJwIAEggfJPVAgAA
X-CMS-MailID: 20220520050120epcas5p41c6262e3c3ac9029f5895c696c233228
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520050120epcas5p41c6262e3c3ac9029f5895c696c233228
References: <20220520045600.3773-1-joshi.k@samsung.com>
 <CGME20220520050120epcas5p41c6262e3c3ac9029f5895c696c233228@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_222714_273141_7C821605 
X-CRM114-Status: GOOD (  18.89  )
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

Add a new opcode NVME_URING_CMD_ADMIN that userspace can use.
Wire up support for the case when this is issued on controller node
(/dev/nvmeX).

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c        |  1 +
 drivers/nvme/host/ioctl.c       | 20 ++++++++++++++++++++
 drivers/nvme/host/nvme.h        |  1 +
 include/uapi/linux/nvme_ioctl.h |  1 +
 4 files changed, 23 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b7095ef6586b..895f70d8f56c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3148,6 +3148,7 @@ static const struct file_operations nvme_dev_fops = {
 	.release	= nvme_dev_release,
 	.unlocked_ioctl	= nvme_dev_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
+	.uring_cmd	= nvme_dev_uring_cmd,
 };
 
 static ssize_t nvme_sysfs_reset(struct device *dev,
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 114b490592b0..7902fd5c69e1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -686,6 +686,26 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
+int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
+{
+	struct nvme_ctrl *ctrl = ioucmd->file->private_data;
+	int ret;
+
+	ret = nvme_uring_cmd_checks(issue_flags);
+	if (ret)
+		return ret;
+
+	switch (ioucmd->cmd_op) {
+	case NVME_URING_CMD_ADMIN:
+		ret = nvme_uring_cmd_io(ctrl, NULL, ioucmd, issue_flags, false);
+		break;
+	default:
+		ret = -ENOTTY;
+	}
+
+	return ret;
+}
+
 static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d60024032012..9b72b6ecf33c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -788,6 +788,7 @@ int nvme_ns_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags);
 int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
+int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct pr_ops nvme_pr_ops;
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 0b1876aa5a59..6bcda1be6456 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -108,5 +108,6 @@ struct nvme_uring_cmd {
 /* io_uring async commands: */
 #define NVME_URING_CMD_IO	_IOWR('N', 0x80, struct nvme_uring_cmd)
 #define NVME_URING_CMD_IO_VEC	_IOWR('N', 0x81, struct nvme_uring_cmd)
+#define NVME_URING_CMD_ADMIN	_IOWR('N', 0x82, struct nvme_uring_cmd)
 
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
2.25.1


