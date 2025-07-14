Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24B9C83F26
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iVDGsClWXgKxSO2BpECdn4szfc3jJtVDkXhP2dDZtYo=; b=wPBUUK01a2OXKZfzDw1ZhA1ZHK
	kAvsbwU0C9NjX4Wk4DbFPmqwIYS2uWUJ+cgEyKh4O6abkep4de32aPr/U9n5DRuUaEYgVfkSZCk0j
	joxsZl1GOmflTWa8JO7ZGv3EyKGII7rdoZ0PFk6HKxmJP9yiE2TfIC+OYU5nioBJRNX79jrcKFetd
	QXAV4zXBkymuMRybF0ewfPWZg2WdfKPXaSr+GGilkNJ9W8UzcQ8E7bY7H74cAy5wp0OuJD0xCZdAE
	uuZB4pK79qUjsYH4ed41OQEoS3fa10ZQSBqlYiHVhKSiicJNL1ijGnCW1LtX95U4ugX1viPeSJeWH
	JkRaPnFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIc-00000001kan-0XjE;
	Mon, 14 Jul 2025 09:16:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIW-00000001kXs-3Ozq
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 09:16:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1B5F661428;
	Mon, 14 Jul 2025 09:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE43AC4CEF8;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752484591;
	bh=El37Gj/bO4g5zQC6jForLJm2KfkQjW+oJE5NpN3BFes=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XmLcoTaFIRGtlZ/dEwW7fMhbaDgr8GgZXbTWgHo7zGVxDn4qXZL5uo4KsA1NUdZR4
	 pQuYQzUo0yVkUhVtuL/W1LQWyTGGitBK5p25Psm2pSyOfwMJ8qu9F4Y25lMyZdaWns
	 QyMAyfuhSqX4fLts90/+ma9/kt+ok/NZGSqWY7Xv1IWfbWj8xerKXghPIgxxMto1Mo
	 z/2BbVz4eMnn8fgwnaCZMnL3Be2iy8iRlqwt+z/e31Ob0q2Wtx+Jd1E7ReQSc4arNC
	 TDx+iJvMBgwnIdmN1lXvoBUjn/LtabaqpXWMMj+TTNAyxFbk44B/6aElz+NwzLY+3j
	 8vKPlvfOvrPKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E80C83F1B;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 14 Jul 2025 11:15:39 +0200
Subject: [PATCH RFC 8/8] nvme: Connect CDQ ioctl to nvme driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-jag-cdq-v1-8-01e027d256d5@kernel.org>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
In-Reply-To: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3054;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=El37Gj/bO4g5zQC6jForLJm2KfkQjW+oJE5NpN3BFes=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGh0yu1QDNzxro8uFOrjz5Om6eL02tjmaGJu5
 aLz1ZtA3CJvJIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJodMrtAAoJELqXzVK3
 lkFPKYcL/Aj/dE4mCCSzsfDlmLZU5vG9LCjMgMNhbWmVgR1IikffXCVuR95AW50beEaxpCO6FpL
 WK1u0mq6NGFl2m+TL7VzOFZefVQecM01MKSUtmKS5G+aigVL8qpkdMY36cHEd5HBr0bPN1sMpIQ
 6QnIUxpDFntnTtBapJaHqof42yxORjUq7gFbi0jKgrL5UZ6spXnV7aQ0+Dl+QpOdyRJBg1HxSO3
 +br6NweNXKCOJ9BJCZrNXrz79sT8dIwmWh252JUDz++ifiJ2soO4czczOocyHzG8ebgVHtTmUg5
 uunhZFf+cpwVR1ImceGMvwGDE8uuFnqirmYW+1DAzuTbteOIlZBZYulJ1y9uGvORgRlQj7Pymnf
 PmMj7KpRXwx8LWEcPhH71fJFEqX0R9ZtbRhkuI3qqEM8OyBB+p2zFUWno1kPruI5BJVVDj+65T9
 0BdD93axnX4v8CYxlXO715PwNSQ3Z9XqVY5PnvBDE5T3Boz6kX54C+OrQcgl0rbfY8J35G1Q1q7
 6o=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
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

When deleting, call the nvme_cdq_delete directly as there is no
additional preparation needed. Construct the nvme admin command to
create before sending it down to the driver; this effectively sets mos
and cqs among other variables. Once the controller has returned, set the
cdq_id and cdq_fd for the ioctl caller.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/ioctl.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index ca86d3bf7ea49d0ec812640a6c0267a5aad40b79..6ab42381b6fe4e88bae341874b111ed4b7ade397 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -378,6 +378,46 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return status;
 }
 
+static int nvme_user_cdq(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+		struct nvme_cdq_cmd __user *ucmd, unsigned int flags,
+		bool open_for_write)
+{
+	int status;
+	u16 cdq_id = 0;
+	int cdq_fd = 0;
+	struct nvme_command c = {};
+	struct nvme_cdq_cmd cmd = {};
+
+	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
+		return -EFAULT;
+
+	if (cmd.cdqp_offset >= cmd.entry_nbyte)
+		return -EINVAL;
+
+	c.cdq.opcode = nvme_admin_cdq;
+	c.cdq.sel = NVME_CDQ_SEL_CREATE_CDQ;
+	c.cdq.mos = cpu_to_le16(cmd.mos);
+	c.cdq.create.cdq_flags = cpu_to_le16(NVME_CDQ_CFG_PC_CONT);
+	c.cdq.create.cqs = cpu_to_le16(cmd.cqs);
+	/* >>2: size is in dwords */
+	c.cdq.cdqsize = (cmd.entry_nbyte * cmd.entry_nr) >> 2;
+
+	status = nvme_cdq_create(ctrl, &c,
+				 cmd.entry_nr, cmd.entry_nbyte,
+				 cmd.cdqp_offset, cmd.cdqp_mask,
+				 &cdq_id, &cdq_fd);
+	if (status)
+		return status;
+
+	cmd.cdq_id = cdq_id;
+	cmd.read_fd = cdq_fd;
+
+	if (copy_to_user(ucmd, &cmd, sizeof(cmd)))
+		return -EFAULT;
+
+	return status;
+}
+
 struct nvme_uring_data {
 	__u64	metadata;
 	__u64	addr;
@@ -541,7 +581,8 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 static bool is_ctrl_ioctl(unsigned int cmd)
 {
-	if (cmd == NVME_IOCTL_ADMIN_CMD || cmd == NVME_IOCTL_ADMIN64_CMD)
+	if (cmd == NVME_IOCTL_ADMIN_CMD || cmd == NVME_IOCTL_ADMIN64_CMD ||
+	    cmd == NVME_IOCTL_ADMIN_CDQ)
 		return true;
 	if (is_sed_ioctl(cmd))
 		return true;
@@ -556,6 +597,8 @@ static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
 		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write);
 	case NVME_IOCTL_ADMIN64_CMD:
 		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
+	case NVME_IOCTL_ADMIN_CDQ:
+		return nvme_user_cdq(ctrl, NULL, argp, 0, open_for_write);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -874,6 +917,8 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 			return -EACCES;
 		nvme_queue_scan(ctrl);
 		return 0;
+	case NVME_IOCTL_ADMIN_CDQ:
+		return nvme_user_cdq(ctrl, NULL, argp, 0, open_for_write);
 	default:
 		return -ENOTTY;
 	}

-- 
2.47.2



