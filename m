Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA9EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 10:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bo6+Wehrg1gclGOhQCzj+FPBfbIlgheRyVvuo0BPLzk=; b=aEL22mcC6VeBnr9UQ5T3bhEGDQ
	TYYna8VoX+xd4X2zJTyJaqJEWsxdvC6ze4qMX3IquEkU3LOkzszBCyl9tSB9WYC43ZjJ3Ju/k5GEb
	QjkX6UXiFpyqpQpFGMuNsdbcv0AYudA8i7Q0pr8FN0GXnmRDxRpKHuL+DHcnTCxbQQDDlcUXAEfwR
	jc57ALrnTRIUySsRdnojY/ME0yg0MxYsjbrKd0dT4+TfJrpKr1k6fvoPXwaITpPI8AUwBVtAAE6vr
	EXC7NPqV2xBlvj6ZZyx4fioYgwZW5NITcvPRW4d+bz2AAHDMVZBLiWFpVNqHpOMnnK+hDm8U+izL2
	KS29LXtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrzm6-00BrMc-IZ; Fri, 20 May 2022 10:22:26 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrzm2-00BrKH-Il
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 10:22:24 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220520102217epoutp0321ddb66a650e9de60dab37934297a7cc~wyRD0agDY2802828028epoutp03e
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 10:22:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220520102217epoutp0321ddb66a650e9de60dab37934297a7cc~wyRD0agDY2802828028epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1653042137;
 bh=Bo6+Wehrg1gclGOhQCzj+FPBfbIlgheRyVvuo0BPLzk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VK5H3xCd2iC/ge4Gt4twzVuUqDcoQlG7OY6aHIO/sXr3J5zbkXzt7aeBXjBQaL5Lt
 zHrlE3QQ4UTRwIvggvZJ6PxMINoDyLjHWp0hzxzvoyRJqLjDm6J7aWrIFa/NjcEdaz
 AkJPXld86LihW+x0ja3QlTE7fw7uafAcuPARXjhc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20220520102217epcas5p29e6279ea0f81faba7adae8d1fa9bc80e~wyRDfHkLI2243422434epcas5p22;
 Fri, 20 May 2022 10:22:17 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4L4N7m5Kvwz4x9Q1; Fri, 20 May
 2022 10:22:12 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D4.9E.09762.4DB67826; Fri, 20 May 2022 19:22:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20220520091213epcas5p2f54b3eacb5f9698bdee1c81a39281418~wxT4aAqhB0097100971epcas5p2j;
 Fri, 20 May 2022 09:12:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220520091213epsmtrp15d62ffe921bb867b7e870bd79776c254~wxT4ZW3Zi2184021840epsmtrp1D;
 Fri, 20 May 2022 09:12:13 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-a9-62876bd47b55
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 30.1B.08924.D6B57826; Fri, 20 May 2022 18:12:13 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220520091212epsmtip1b1a1166668d1815fa8b8d78130bf9423~wxT3WCmTt1218612186epsmtip1_;
 Fri, 20 May 2022 09:12:12 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: [PATCH v3 2/2] nvme: enable uring-passthrough for admin commands
Date: Fri, 20 May 2022 14:36:30 +0530
Message-Id: <20220520090630.70394-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520090630.70394-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTXfdKdnuSwaqLWhar7/azWdw8sJPJ
 YuXqo0wW598eZrKYdOgao8X8ZU/ZHdg8ds66y+5x+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
 W1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
 ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE
 7IzD5zILHkpUnNx9mr2BsUu0i5GDQ0LARGLZIusuRi4OIYHdjBItZ/eyQjifGCWaLk5ggXA+
 M0p035vJ3MXICdbxd+FzqKpdjBK/H+xDqNoy8ScjyFw2AU2JC5NLQRpEBIwk9n86yQpiMwv4
 S1xZv48dxBYW8JR4t2k/2FAWAVWJQ59+M4LYvAIWEpe/rWWBWCYvMfPSd7B6TgFLiasvVzFB
 1AhKnJz5hAViprxE89bZzCA3SAg8YpfoPjqXBeI3F4lL3VBHC0u8Or6FHcKWknjZ3wZlJ0u0
 br/MDlFeIrFkgTpE2F7i4p6/TCBhZqBP1u/ShwjLSkw9tY4JYiufRO/vJ0wQcV6JHfNgbEWJ
 e5OeskLY4hIPZyyBsj0knn5qYIKEVA+jxIL995gmMCrMQvLNLCTfzEJYvYCReRWjZGpBcW56
 arFpgXFeajk8hpPzczcxglOllvcOxkcPPugdYmTiYDzEKMHBrCTCy5jbkiTEm5JYWZValB9f
 VJqTWnyI0RQY3BOZpUST84HJOq8k3tDE0sDEzMzMxNLYzFBJnFfgf2OSkEB6YklqdmpqQWoR
 TB8TB6dUA1OSae4kncSTf5beVO5au4Pbw3KX/e1mp/BFqTwvwq2FbzaLnRISfXhDVnOyywUz
 vikHWTbWVtbcdzbSjagPjXx3xNaVz9+a98SlB0XSPxlVYv6439w4O5Er1PF2yy8FP70VASv+
 v3Q8WcpXcjXF9n8Fq0d4tmve11MxjG5RZu2VQdP07v/ZEqlsF/DCR3yv6q/7lbaxV+71eVV5
 2fJaZzLaf4lK3LDca0H76Sk7bVW0nsz0CNme/W7Hzbvva//OYc9Krj1QZWLPwDV9i61c+QSm
 khtJs93ZE7KrXZxWnHx/IclhX9m6CjGZQwyytQITF/wwZa4KSvA+keTBkZsenDm3ave6K+oX
 jS/W3r6ixFKckWioxVxUnAgAjY4v9h4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSnG5udHuSwa25qhar7/azWdw8sJPJ
 YuXqo0wW598eZrKYdOgao8X8ZU/ZHdg8ds66y+5x+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
 WxSXTUpqTmZZapG+XQJXxuFzmQUPJSpO7j7N3sDYJdrFyMkhIWAi8Xfhc9YuRi4OIYEdjBKL
 HjQwQyTEJZqv/WCHsIUlVv57zg5R9JFRom/XBiCHg4NNQFPiwuRSkBoRATOJpYfXsIDYzAKB
 Et0998FsYQFPiXeb9oPNZBFQlTj06TcjiM0rYCFx+dtaFoj58hIzL30H28UpYClx9eUqJhBb
 CKjm6ZTFbBD1ghInZz6Bmi8v0bx1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwykst1ytO
 zC0uzUvXS87P3cQIDmgtrR2Me1Z90DvEyMTBeIhRgoNZSYSXMbclSYg3JbGyKrUoP76oNCe1
 +BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYm4U2/MvYXXb2wrtPwWrs5R4dxzqnO
 OrEF62fy6F+fHlQQt8D/14PiecaHlzqfNZjxrSMqi/Xe1hIfBY5dK0RDnn8SOuHleOrm3787
 9y9Inp5k/nrNkglREzM+BinbBXdY70iPnXV4T0hHXfDHj6w/eJdvWa3Zv1Pg/rzJhl2L3A8L
 6ExqO2t6wJLL8vqnDXJ7NikW3K78JOU4qaPn+Gbvtst92/7O1TuUl+auKXbb8ozAAvXOjMrj
 HKvDHDZ4T8zx7/3hFH7s/CK5m/NmN/yzOqecZ7j+DF+2gbzPz9mJmzQqlkx8mbSwXuyB0sq2
 YLVZ/h/NXrQrFa5ZwHzm64SXPXI3fz/7bhycqpbIN7/kqxJLcUaioRZzUXEiACor7GnXAgAA
X-CMS-MailID: 20220520091213epcas5p2f54b3eacb5f9698bdee1c81a39281418
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520091213epcas5p2f54b3eacb5f9698bdee1c81a39281418
References: <20220520090630.70394-1-joshi.k@samsung.com>
 <CGME20220520091213epcas5p2f54b3eacb5f9698bdee1c81a39281418@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_032223_049159_9BE4C793 
X-CRM114-Status: GOOD (  18.75  )
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

Add two new opcodes that userspace can use for admin commands:
NVME_URING_CMD_ADMIN : non-vectroed
NVME_URING_CMD_ADMIN_VEC : vectored variant

Wire up support when these are issued on controller node(/dev/nvmeX).

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c        |  1 +
 drivers/nvme/host/ioctl.c       | 23 +++++++++++++++++++++++
 drivers/nvme/host/nvme.h        |  1 +
 include/uapi/linux/nvme_ioctl.h |  2 ++
 4 files changed, 27 insertions(+)

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
index 114b490592b0..096b1b47d750 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -686,6 +686,29 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
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
+	case NVME_URING_CMD_ADMIN_VEC:
+		ret = nvme_uring_cmd_io(ctrl, NULL, ioucmd, issue_flags, true);
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
index 0b1876aa5a59..2f76cba67166 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -108,5 +108,7 @@ struct nvme_uring_cmd {
 /* io_uring async commands: */
 #define NVME_URING_CMD_IO	_IOWR('N', 0x80, struct nvme_uring_cmd)
 #define NVME_URING_CMD_IO_VEC	_IOWR('N', 0x81, struct nvme_uring_cmd)
+#define NVME_URING_CMD_ADMIN	_IOWR('N', 0x82, struct nvme_uring_cmd)
+#define NVME_URING_CMD_ADMIN_VEC _IOWR('N', 0x83, struct nvme_uring_cmd)
 
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
2.25.1


