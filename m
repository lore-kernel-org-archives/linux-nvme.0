Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41F9C46CA1
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 18:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pd2fQXUmI5x8L/mYfVk2E8PAemrLxsUQqcQIrJFj6jI=; b=QvMiJ8Yi+wyvVaQfGzN0lA9lvO
	yTYs46X2D5tOEbPOtge2YzgXwGoE/SRlYW3PiGF4nxkOjy0z0nRk89NguQncLl6is+A0eNNx12cXs
	nfJDMeiAiugHOFplWwGjucdN7HzrpXtPZCMit9vsKmBy89Zrv+tvV2ciBl6O5T3TMjWn6R2ifWnQP
	DdKu37u8TLWUDDn+tuv5HIirkQsipYOxc58sOuMjwoR4SyXUlzFX/3IRvGyzA7LdNcYcyVrEJoHZS
	h8kZ8BVufoQVMuq2LZUEpWjVRwlWMjLfK9Bp9uUqP1nO+gnsZBkhmt7rPL47enmXGDV86wMN+6yLV
	R2WX3gqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtBPN-00FTD1-2B;
	Wed, 18 Oct 2023 18:36:41 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtBPJ-00FTB3-2F
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 18:36:40 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231018183632epoutp0331d28a835b9152278d96b7e2ab20dfcd~PR346gU252007120071epoutp03H
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 18:36:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231018183632epoutp0331d28a835b9152278d96b7e2ab20dfcd~PR346gU252007120071epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697654192;
	bh=pd2fQXUmI5x8L/mYfVk2E8PAemrLxsUQqcQIrJFj6jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXSl8kh29y4hzkYbeeHIIoGc7crKUYDYQ39rp+xot9YpMHF+ST6cMVclFp8XhZOGF
	 yBAwThmoKej4tTtGX3r+PFMVFqfNIgXmhqi7iFFyVcg5D3IudzncwL3fSKs1Bg/lCq
	 V99S/sZWZRL39Ii8BfQVy0vOiNPshC3ObngXxePE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231018183631epcas5p1519923d48487bba966465a8564108ee8~PR34VQh9c1436914369epcas5p13;
	Wed, 18 Oct 2023 18:36:31 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4S9fgy1V4Lz4x9Pp; Wed, 18 Oct
	2023 18:36:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.A9.09672.DA520356; Thu, 19 Oct 2023 03:36:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231018183629epcas5p4e11e71226c3990c304765c14c7defe6d~PR32gc4Al0493504935epcas5p41;
	Wed, 18 Oct 2023 18:36:29 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231018183629epsmtrp2907edb1627a092a6d4ce0502e2a69fc5~PR32fuO4u0427204272epsmtrp2L;
	Wed, 18 Oct 2023 18:36:29 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-32-653025ad3fe2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F6.89.18939.DA520356; Thu, 19 Oct 2023 03:36:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231018183627epsmtip147e7e468df6d1d40f18be53377e1143d~PR31HGQ7X1269612696epsmtip1M;
	Wed, 18 Oct 2023 18:36:27 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 2/2] nvme: fine-granular CAP_SYS_ADMIN for nvme io/admin
 commands
Date: Thu, 19 Oct 2023 00:00:03 +0530
Message-Id: <20231018183003.41174-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018183003.41174-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmpu46VYNUgyszmC1W3+1ns7h5YCeT
	xcrVR5ksjv5/y2Zx/u1hJotJh64xWsxf9pTdYt3r9ywOHB47Z91l9zh/byOLx+WzpR6bVnWy
	eWxeUu+x+2YDm0ffllWMAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
	ibmptkouPgG6bpk5QEcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OL
	S/PS9fJSS6wMDQyMTIEKE7IzNi44xFTwMqvi7MI7bA2M38O6GDk5JARMJJa+vcjaxcjFISSw
	m1HixvxNUM4nRok1/bfY4JzFx9ewwbT82/2OHSKxk1Hi/OJGJgjnM6PEpH07WLoYOTjYBDQl
	LkwuBWkQEXCRaPj3hhHEZhYokTgwayIriC0sECzx+NUeJhCbRUBV4tCD7+wgNq+AhUTj7eUs
	EMvkJWZegohzClhKzOzfxQhRIyhxcuYTFoiZ8hLNW2czg9wgIfCVXWLj8XZ2kBskgBY3rzKD
	mCMs8er4FnYIW0ri87u9UM8kS1yaeY4Jwi6ReLznIJRtL9F6qp8ZZAwz0Cvrd+lDrOKT6P39
	hAliOq9ER5sQRLWixL1JT1khbHGJhzOWQNkeEjdedkODqodR4sf0H2wTGOVnIflgFpIPZiFs
	W8DIvIpRMrWgODc9tdi0wDgvtRwer8n5uZsYwUlTy3sH46MHH/QOMTJxMB5ilOBgVhLhTQ/W
	SRXiTUmsrEotyo8vKs1JLT7EaAoM4onMUqLJ+cC0nVcSb2hiaWBiZmZmYmlsZqgkzvu6dW6K
	kEB6YklqdmpqQWoRTB8TB6dUA1P4MaVjLNrqPPLHFcP1Exr0J51dy/5RSeeQi+Lmxpwpc5fP
	WDD3+PQLLgoXZTociz+ezuR6kHL5z3ef0h9J+6MyBBt+BJyeWjf31dyG2eK/Od20vKSnP94z
	dW9hE4tqc5RbxVGBDy+tYn+IbMxKfdv1Y5nDrg2THvcI7XRSdbiuVFZQbVA4j90iTjB0+cLf
	7Uf2JDN/mRzAcitg+fQaC1vTvt8htpkc2eJ+y7Zo8HUmrZ+to3FjY4HnpY8trGrmub33QktT
	Lu2753d6zi6/83+YjMycm6efavnHE3Y4w/XoRVWObqYM42rPOy0mc/SNex56lYuXRc/NXnvp
	rJCpEONhfsGD914l5i8ovu7ioMRSnJFoqMVcVJwIAM65mWIjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnO5aVYNUg787BS1W3+1ns7h5YCeT
	xcrVR5ksjv5/y2Zx/u1hJotJh64xWsxf9pTdYt3r9ywOHB47Z91l9zh/byOLx+WzpR6bVnWy
	eWxeUu+x+2YDm0ffllWMAexRXDYpqTmZZalF+nYJXBkbFxxiKniZVXF24R22BsbvYV2MnBwS
	AiYS/3a/Y+9i5OIQEtjOKLH/dzcjREJcovnaD3YIW1hi5b/nUEUfGSU2/L7K2sXIwcEmoClx
	YXIpSI2IgJfEvNkLWEBsZoEKif+vX4LNERYIlLj8/DcziM0ioCpx6MF3sJm8AhYSjbeXs0DM
	l5eYeQkizilgKTGzfxdYrxBQzcd3W5kg6gUlTs58AjVfXqJ562zmCYwCs5CkZiFJLWBkWsUo
	mlpQnJuem1xgqFecmFtcmpeul5yfu4kRHOhaQTsYl63/q3eIkYmD8RCjBAezkghverBOqhBv
	SmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILUIpgsEwenVANTcaBAqQFXdaBQ
	8pfpRscmNzUEW5unM546kn46IjVk3bbTG9Xa/AR/mD1as3fP0ubF1uEPhXdcv5V13VD0PrNb
	r6ZcBQunes8jCSW/yO2lPPM3lz/nkGBQMre3eq/Wte01C4/bH1/frE+qz04ZdOT8Fd5xW+fO
	JbsPBbFekqkh/1+1zzz8O/HE6fM9OXanVO1LGJ7aHlseHaSWyPzPY+aNxKOtnr/WiK6v2DVX
	4gvT53mrdMy0SwysdHs37VbX7TB79Z+taYOcbehyMbGdVz6wbwldeXzb91+ly3edc5X82T7f
	1qG3+bd53s2LN6X6Lz683qtyX43rYqfH91UJP9xDuh68UjKSeHv9QNJL6xVKLMUZiYZazEXF
	iQCLm1934wIAAA==
X-CMS-MailID: 20231018183629epcas5p4e11e71226c3990c304765c14c7defe6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018183629epcas5p4e11e71226c3990c304765c14c7defe6d
References: <20231018183003.41174-1-joshi.k@samsung.com>
	<CGME20231018183629epcas5p4e11e71226c3990c304765c14c7defe6d@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_113638_052884_1CAF05E1 
X-CRM114-Status: GOOD (  28.98  )
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

Passthrough commands are guarded by heavy-handed CAP_SYS_ADMIN checks
that neglects the file-mode completely.

Add a fine-granular policy that considers file-mode and various other
parameters for any approval/denial. Also enable few admin commands that
are necssary to get the information required to form the i/o commands.
The policy is implemented in a new helper 'nvme_cmd_allowed'.

I/O commands needing data-transfers are sent only via SGL.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 162 ++++++++++++++++++++++++++++++--------
 include/linux/nvme.h      |   2 +
 2 files changed, 130 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index eb2ef3e14961..3d0d91633946 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -10,8 +10,80 @@
 
 enum {
 	NVME_IOCTL_VEC		= (1 << 0),
+	NVME_IOCTL_PARTITION	= (1 << 1),
 };
 
+static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
+		unsigned int flags, bool open_for_write)
+{
+	u32 effects;
+
+	if (capable(CAP_SYS_ADMIN))
+		return true;
+
+	/*
+	 * Do not allow unprivileged passthrough on partitions, as that allows an
+	 * escape from the containment of the partition.
+	 */
+	if (flags & NVME_IOCTL_PARTITION)
+		return false;
+
+	/*
+	 * Do not allow unprivileged processes to send vendor specific or fabrics
+	 * commands as we can't be sure about their effects.
+	 */
+	if (c->common.opcode >= nvme_cmd_vendor_start ||
+	    c->common.opcode == nvme_fabrics_command)
+		return false;
+
+	/*
+	 * Do not allow unprivileged passthrough of admin commands except
+	 * for a subset of identify commands that contain information required
+	 * to form proper I/O commands in userspace and do not expose any
+	 * potentially sensitive information.
+	 */
+	if (!ns) {
+		if (c->common.opcode == nvme_admin_identify) {
+			switch (c->identify.cns) {
+			case NVME_ID_CNS_NS:
+			case NVME_ID_CNS_CS_NS:
+			case NVME_ID_CNS_NS_CS_INDEP:
+			case NVME_ID_CNS_CS_CTRL:
+			case NVME_ID_CNS_CTRL:
+				return true;
+			}
+		}
+		return false;
+	}
+
+	/*
+	 * Check if the controller provides a Commands Supported and Effects log
+	 * and marks this command as supported.  If not reject unprivileged
+	 * passthrough.
+	 */
+	effects = nvme_command_effects(ns->ctrl, ns, c->common.opcode);
+	if (!(effects & NVME_CMD_EFFECTS_CSUPP))
+		return false;
+
+	/*
+	 * Don't allow passthrough for command that have intrusive (or unknown)
+	 * effects.
+	 */
+	if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
+			NVME_CMD_EFFECTS_UUID_SEL |
+			NVME_CMD_EFFECTS_SCOPE_MASK))
+		return false;
+
+	/*
+	 * Only allow I/O commands that transfer data to the controller or that
+	 * change the logical block contents if the file descriptor is open for
+	 * writing.
+	 */
+	if (nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC))
+		return open_for_write;
+	return true;
+}
+
 /*
  * Convert integer values from ioctl structures to user pointers, silently
  * ignoring the upper bits in the compat case to match behaviour of 32-bit
@@ -134,6 +206,9 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		}
 		*metap = meta;
 	}
+	/* Data transfer for unprivileged passthrough is only via SGL */
+	if (bdev && !capable(CAP_SYS_ADMIN))
+		nvme_req(req)->flags |= NVME_REQ_FORCE_SGL;
 
 	return ret;
 
@@ -267,7 +342,8 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd __user *ucmd)
+		struct nvme_passthru_cmd __user *ucmd, unsigned int flags,
+		bool open_for_write)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
@@ -275,8 +351,6 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	u64 result;
 	int status;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
 	if (cmd.flags)
@@ -297,6 +371,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
+	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
+		return -EACCES;
+
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
@@ -313,16 +390,14 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 }
 
 static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd64 __user *ucmd,
-			unsigned int flags)
+		struct nvme_passthru_cmd64 __user *ucmd, unsigned int flags,
+		bool open_for_write)
 {
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
 	int status;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
 	if (cmd.flags)
@@ -343,6 +418,9 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
+	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
+		return -EACCES;
+
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
@@ -492,9 +570,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	void *meta = NULL;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
 	c.common.opcode = READ_ONCE(cmd->opcode);
 	c.common.flags = READ_ONCE(cmd->flags);
 	if (c.common.flags)
@@ -516,6 +591,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(READ_ONCE(cmd->cdw14));
 	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
 
+	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
+		return -EACCES;
+
 	d.metadata = READ_ONCE(cmd->metadata);
 	d.addr = READ_ONCE(cmd->addr);
 	d.data_len = READ_ONCE(cmd->data_len);
@@ -572,13 +650,13 @@ static bool is_ctrl_ioctl(unsigned int cmd)
 }
 
 static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
-		void __user *argp)
+		void __user *argp, bool open_for_write)
 {
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp);
+		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, 0);
+		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -603,16 +681,14 @@ struct nvme_user_io32 {
 #endif /* COMPAT_FOR_U64_ALIGNMENT */
 
 static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp)
+		void __user *argp, unsigned int flags, bool open_for_write)
 {
-	unsigned int flags = 0;
-
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
 		return ns->head->ns_id;
 	case NVME_IOCTL_IO_CMD:
-		return nvme_user_cmd(ns->ctrl, ns, argp);
+		return nvme_user_cmd(ns->ctrl, ns, argp, flags, open_for_write);
 	/*
 	 * struct nvme_user_io can have different padding on some 32-bit ABIs.
 	 * Just accept the compat version as all fields that are used are the
@@ -627,32 +703,39 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		flags |= NVME_IOCTL_VEC;
 		fallthrough;
 	case NVME_IOCTL_IO64_CMD:
-		return nvme_user_cmd64(ns->ctrl, ns, argp, flags);
+		return nvme_user_cmd64(ns->ctrl, ns, argp, flags,
+				       open_for_write);
 	default:
 		return -ENOTTY;
 	}
 }
 
-int nvme_ioctl(struct block_device *bdev, fmode_t mode,
+int nvme_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	bool open_for_write = mode & BLK_OPEN_WRITE;
 	void __user *argp = (void __user *)arg;
+	unsigned int flags = 0;
+
+	if (bdev_is_partition(bdev))
+		flags |= NVME_IOCTL_PARTITION;
 
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
-	return nvme_ns_ioctl(ns, cmd, argp);
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
+	return nvme_ns_ioctl(ns, cmd, argp, flags, open_for_write);
 }
 
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns =
 		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
+	bool open_for_write = file->f_mode & FMODE_WRITE;
 	void __user *argp = (void __user *)arg;
 
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
-	return nvme_ns_ioctl(ns, cmd, argp);
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
+	return nvme_ns_ioctl(ns, cmd, argp, 0, open_for_write);
 }
 
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
@@ -716,7 +799,8 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 }
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
+		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
+		bool open_for_write)
 	__releases(&head->srcu)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -724,7 +808,7 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 
 	nvme_get_ctrl(ns->ctrl);
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
+	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
 
 	nvme_put_ctrl(ctrl);
 	return ret;
@@ -734,9 +818,14 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns_head *head = bdev->bd_disk->private_data;
+	bool open_for_write = mode & BLK_OPEN_WRITE;
 	void __user *argp = (void __user *)arg;
 	struct nvme_ns *ns;
 	int srcu_idx, ret = -EWOULDBLOCK;
+	unsigned int flags = 0;
+
+	if (bdev_is_partition(bdev))
+		flags |= NVME_IOCTL_PARTITION;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
@@ -749,9 +838,10 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 	 * deadlock when deleting namespaces using the passthrough interface.
 	 */
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
+					       open_for_write);
 
-	ret = nvme_ns_ioctl(ns, cmd, argp);
+	ret = nvme_ns_ioctl(ns, cmd, argp, flags, open_for_write);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -760,6 +850,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
+	bool open_for_write = file->f_mode & FMODE_WRITE;
 	struct cdev *cdev = file_inode(file)->i_cdev;
 	struct nvme_ns_head *head =
 		container_of(cdev, struct nvme_ns_head, cdev);
@@ -773,9 +864,10 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		goto out_unlock;
 
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
+				open_for_write);
 
-	ret = nvme_ns_ioctl(ns, cmd, argp);
+	ret = nvme_ns_ioctl(ns, cmd, argp, 0, open_for_write);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -824,7 +916,8 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 	return ret;
 }
 
-static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
+static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
+		bool open_for_write)
 {
 	struct nvme_ns *ns;
 	int ret;
@@ -848,7 +941,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 	kref_get(&ns->kref);
 	up_read(&ctrl->namespaces_rwsem);
 
-	ret = nvme_user_cmd(ctrl, ns, argp);
+	ret = nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);
 	nvme_put_ns(ns);
 	return ret;
 
@@ -860,16 +953,17 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
+	bool open_for_write = file->f_mode & FMODE_WRITE;
 	struct nvme_ctrl *ctrl = file->private_data;
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp);
+		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, 0);
+		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
 	case NVME_IOCTL_IO_CMD:
-		return nvme_dev_user_cmd(ctrl, argp);
+		return nvme_dev_user_cmd(ctrl, argp, open_for_write);
 	case NVME_IOCTL_RESET:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index df3e2c619448..26dd3f859d9d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -642,6 +642,7 @@ enum {
 	NVME_CMD_EFFECTS_CCC		= 1 << 4,
 	NVME_CMD_EFFECTS_CSE_MASK	= GENMASK(18, 16),
 	NVME_CMD_EFFECTS_UUID_SEL	= 1 << 19,
+	NVME_CMD_EFFECTS_SCOPE_MASK	= GENMASK(31, 20),
 };
 
 struct nvme_effects_log {
@@ -833,6 +834,7 @@ enum nvme_opcode {
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
+	nvme_cmd_vendor_start	= 0x80,
 };
 
 #define nvme_opcode_name(opcode)	{ opcode, #opcode }
-- 
2.25.1


