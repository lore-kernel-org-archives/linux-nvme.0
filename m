Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862B3ECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 16:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rw5cDAOzeohfj0PEvF2Bc6XpGCQfagrCU1JouWOjxds=; b=TSsuyZkD1jqvUia+Qy7k0BjqbG
	UrukLFAdZV1o2QnFBeSCq2135kF7LRANQpPIpLo0Npj+POvEMtguF41sIfKWxfRt/KqPyR7jhIcwh
	xkRQBxNEDcu2OWjaO6ta2NeeTTD8OTAlRbM9ODmEDCJ6S7SkQcTSxNr2etJGlku9RpDADFOoNxLxr
	cqP5dBdQSqm8HmvDXC5HSUCNYM1mogJgRF0v9vPJBtt8BHw+rLYMr+GHPyXFuXT1Adq1Rgm/L/p6o
	Lhm5Ejm7P9zaIuxjKJO7rPTHTEnQzGPx686r/e9SOXH4sFBFv2M6oAr1N06LeVtcwAXJX456WabLa
	Z2aazNVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opXlL-00D0fL-8X; Mon, 31 Oct 2022 16:35:47 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opXlD-00D0dK-Bm
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 16:35:42 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221031163530epoutp02377c5a6b94fa2867341fca040f37eb6f~jNJuuKg8i1289712897epoutp026
	for <linux-nvme@lists.infradead.org>; Mon, 31 Oct 2022 16:35:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221031163530epoutp02377c5a6b94fa2867341fca040f37eb6f~jNJuuKg8i1289712897epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1667234130;
	bh=Rw5cDAOzeohfj0PEvF2Bc6XpGCQfagrCU1JouWOjxds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcJCTtxXW7L4+EEc2W/Q0u9Ur9cuAKq7Lk+MnQG1Re2a8ql50njLGp0kKDPf2Bhm7
	 uw5jNNWGLn4w5RRRGdB1fnTG7CbuiY7dJCUx5hXV+j7J7jH5lUwyUBeA6u63CHG2rl
	 jAezy9dj8CZruOV98A8hDxQa/YKqP2Nu+c7izWz4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20221031163529epcas5p40ef3966e9d27ea366599c56517a972e2~jNJubQv-X2209822098epcas5p4I;
	Mon, 31 Oct 2022 16:35:29 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4N1Jfl5N46z4x9Pp; Mon, 31 Oct
	2022 16:35:27 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B0.E7.56352.F49FF536; Tue,  1 Nov 2022 01:35:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20221031163527epcas5p115ca58519ef3301b9f146680396fd264~jNJr_ycvP3076930769epcas5p1n;
	Mon, 31 Oct 2022 16:35:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221031163527epsmtrp2b4eb9ea1bf3b04732b2444c57f76ae6a~jNJr_Aikf1683016830epsmtrp2e;
	Mon, 31 Oct 2022 16:35:27 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-1e-635ff94f3de2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B7.8B.14392.F49FF536; Tue,  1 Nov 2022 01:35:27 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221031163525epsmtip29b347e481f0ff26d42451af25a867ef0~jNJqsfQLX0638806388epsmtip2E;
	Mon, 31 Oct 2022 16:35:25 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH v4 1/2] nvme: fine-granular CAP_SYS_ADMIN for nvme io
 commands
Date: Mon, 31 Oct 2022 21:53:50 +0530
Message-Id: <20221031162351.31856-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162351.31856-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmuq7/z/hkg1kfVSxW3+1ns3h/8DGr
	xc0DO5ksVq4+ymRx9P9bNotJh64xWsxf9pTdYt3r9ywOHB7n721k8bh8ttRj06pONo/NS+o9
	dt9sYPPobX7H5tG3ZRVjAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
	Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi
	0rx0vbzUEitDAwMjU6DChOyMvzMXshfsCas42tTE3MD4wq2LkZNDQsBEomPXedYuRi4OIYHd
	jBJLj3xng3A+MUrMW/GNEcL5xijxdetzJpiWxot/oKr2MkrcmTGNCcL5zCgx/88voGEcHGwC
	mhIXJpeCNIgIxEpc2riWHcRmFoiXuPl3MxuILSwQILH42WywoSwCqhK7Tk1lBLF5BSwk1uy7
	BLVMXmLmpe9gvZwClhJ3+z+zQdQISpyc+YQFYqa8RPPW2cwgN0gINHJIvN/+lBmi2UVi9ZqH
	ULawxKvjW9ghbCmJz+/2skHYyRKXZp6DWlYi8XjPQSjbXqL1VD8zyC/MQL+s36UPsYtPovf3
	EyaQsIQAr0RHmxBEtaLEvUlPWSFscYmHM5ZA2R4S//79ZIYETw+jxNkJ8xgnMMrPQvLCLCQv
	zELYtoCReRWjZGpBcW56arFpgXFeajk8YpPzczcxgtOmlvcOxkcPPugdYmTiYDzEKMHBrCTC
	W382OlmINyWxsiq1KD++qDQntfgQoykwjCcyS4km5wMTd15JvKGJpYGJmZmZiaWxmaGSOO/i
	GVrJQgLpiSWp2ampBalFMH1MHJxSDUxqJ8Q1t8cb8f+zPNGly8lzbYrD5y/sYvySDWo7/+1t
	F4k5rhacWd4hsWnFQ+6i1sPXHa5ZmDnL1K74vJ8xw+PcrwLtZbu8o8LdXsSVrvD8znfp4nGT
	rz7Mv4t3/FXfH/1tAmvpI7NM/2i5bYZztk/Jafqf7r7BzbJtZsm5Dj4OHnvnrrQLu45Els4N
	eBZ22Uzc46JYfnuK7Napzi9+F02+3CQTfqW0+jm/7WmupY8LzU/vyH3S/f/t1sbKj7qXYwy6
	PnrGPVM5PquYI9c64rNU81f5Jdu425Y8WPDZ8If8QQnXCmlf1lNruzo2yl6suTqZk/+CQgDL
	sthqW0+ZLHbLz1kC8VFt0plHG7U2K7EUZyQaajEXFScCAAY34k0kBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvK7/z/hkg2fbBCxW3+1ns3h/8DGr
	xc0DO5ksVq4+ymRx9P9bNotJh64xWsxf9pTdYt3r9ywOHB7n721k8bh8ttRj06pONo/NS+o9
	dt9sYPPobX7H5tG3ZRVjAHsUl01Kak5mWWqRvl0CV8bfmQvZC/aEVRxtamJuYHzh1sXIySEh
	YCLRePEPWxcjF4eQwG5GibuHf7FAJMQlmq/9YIewhSVW/nvODlH0kVHiU38/UAcHB5uApsSF
	yaUgNSICyRKntn9iArGZBRIl3h99zApiCwv4STzZtRHMZhFQldh1aiojiM0rYCGxZt8lJoj5
	8hIzL30H28UpYClxt/8zG4gtBFRzZ+NpJoh6QYmTM5+wQMyXl2jeOpt5AqPALCSpWUhSCxiZ
	VjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBAe8luYOxu2rPugdYmTiYDzEKMHBrCTC
	W382OlmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGprVz
	Ij9dkzz55oLTcrOl95p1dTfNMmH+KveF++Cd6XEzjxbM8i2a6s++gP8fe8KVnU4mp4/m3stb
	HLZv7jm3WqG2+z25r+eeka7+PSWn90vU2/3fdh/tFCy50uBRIFFgV7G3dZlBiumpk9s3OB47
	rPVsinmDyVE5k3PrCwqY55sLy+XN9nxZpv268LVFItutywFtSr7ly5yTWCx0trFc/jj161/r
	V7L9HovYL/3cIrZwKcvKMzH+wbNPMmeldClXiSrfP/10R5pigVPAb422FUsfXTv77Me1lwfl
	jaXdyvO9tNyypOc6nFR5cyt2fXnB5NRLL9JX7kq3ioq9qz/jxo+SjpstCosCfkhtfnIuz0mJ
	pTgj0VCLuag4EQBJ/3Fa5wIAAA==
X-CMS-MailID: 20221031163527epcas5p115ca58519ef3301b9f146680396fd264
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221031163527epcas5p115ca58519ef3301b9f146680396fd264
References: <20221031162351.31856-1-joshi.k@samsung.com>
	<CGME20221031163527epcas5p115ca58519ef3301b9f146680396fd264@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_093539_745493_23E45485 
X-CRM114-Status: GOOD (  23.85  )
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

Currently both io and admin commands are kept under a
coarse-granular CAP_SYS_ADMIN check, disregarding file mode completely.

$ ls -l /dev/ng*
crw-rw-rw- 1 root root 242, 0 Sep  9 19:20 /dev/ng0n1
crw------- 1 root root 242, 1 Sep  9 19:20 /dev/ng0n2

In the example above, ng0n1 appears as if it may allow unprivileged
read/write operation but it does not and behaves same as ng0n2.

This patch implements a shift from CAP_SYS_ADMIN to more fine-granular
control for io-commands.
If CAP_SYS_ADMIN is present, nothing else is checked as before.
Otherwise, following rules are in place
- any admin-cmd is not allowed
- vendor-specific and fabric commmand are not allowed
- io-commands that can write are allowed if matching FMODE_WRITE
permission is present
- io-commands that read are allowed

Add a helper nvme_cmd_allowed that implements above policy.
Change all the callers of CAP_SYS_ADMIN to go through nvme_cmd_allowed
for any decision making.
Since file open mode is counted for any approval/denial, change at
various places to keep file-mode information handy.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/ioctl.c | 97 ++++++++++++++++++++++++++-------------
 include/linux/nvme.h      |  1 +
 2 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 81f5550b670d..9c581b1a8956 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -8,6 +8,29 @@
 #include <linux/io_uring.h>
 #include "nvme.h"
 
+bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c, fmode_t mode)
+{
+	u8 opcode = c->common.opcode;
+
+	if (capable(CAP_SYS_ADMIN))
+		return true;
+
+	/* admin commands are not allowed */
+	if (!ns)
+		return false;
+
+	/* exclude vendor-specific io and fabrics commands */
+	if (opcode >= nvme_cmd_vendor_start || opcode == nvme_fabrics_command)
+		return false;
+
+	/* allow write cmds only if matching FMODE is present */
+	if (nvme_is_write(c))
+		return mode & FMODE_WRITE;
+
+	/* allow read cmds as the device permission allows access */
+	return true;
+}
+
 /*
  * Convert integer values from ioctl structures to user pointers, silently
  * ignoring the upper bits in the compat case to match behaviour of 32-bit
@@ -261,7 +284,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd __user *ucmd)
+			struct nvme_passthru_cmd __user *ucmd, fmode_t mode)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
@@ -269,8 +292,6 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	u64 result;
 	int status;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
 	if (cmd.flags)
@@ -291,6 +312,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
+	if (!nvme_cmd_allowed(ns, &c, mode))
+		return -EACCES;
+
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
@@ -308,15 +332,14 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 }
 
 static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd64 __user *ucmd, bool vec)
+			struct nvme_passthru_cmd64 __user *ucmd, bool vec,
+			fmode_t mode)
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
@@ -337,6 +360,9 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
+	if (!nvme_cmd_allowed(ns, &c, mode))
+		return -EACCES;
+
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
@@ -483,9 +509,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	void *meta = NULL;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
 	c.common.opcode = READ_ONCE(cmd->opcode);
 	c.common.flags = READ_ONCE(cmd->flags);
 	if (c.common.flags)
@@ -507,6 +530,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(READ_ONCE(cmd->cdw14));
 	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
 
+	if (!nvme_cmd_allowed(ns, &c, ioucmd->file->f_mode))
+		return -EACCES;
+
 	d.metadata = READ_ONCE(cmd->metadata);
 	d.addr = READ_ONCE(cmd->addr);
 	d.data_len = READ_ONCE(cmd->data_len);
@@ -570,13 +596,13 @@ static bool is_ctrl_ioctl(unsigned int cmd)
 }
 
 static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
-		void __user *argp)
+		void __user *argp, fmode_t mode)
 {
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp);
+		return nvme_user_cmd(ctrl, NULL, argp, mode);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, false);
+		return nvme_user_cmd64(ctrl, NULL, argp, false, mode);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -601,14 +627,14 @@ struct nvme_user_io32 {
 #endif /* COMPAT_FOR_U64_ALIGNMENT */
 
 static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp)
+		void __user *argp, fmode_t mode)
 {
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
 		return ns->head->ns_id;
 	case NVME_IOCTL_IO_CMD:
-		return nvme_user_cmd(ns->ctrl, ns, argp);
+		return nvme_user_cmd(ns->ctrl, ns, argp, mode);
 	/*
 	 * struct nvme_user_io can have different padding on some 32-bit ABIs.
 	 * Just accept the compat version as all fields that are used are the
@@ -620,19 +646,20 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, argp);
 	case NVME_IOCTL_IO64_CMD:
-		return nvme_user_cmd64(ns->ctrl, ns, argp, false);
+		return nvme_user_cmd64(ns->ctrl, ns, argp, false, mode);
 	case NVME_IOCTL_IO64_CMD_VEC:
-		return nvme_user_cmd64(ns->ctrl, ns, argp, true);
+		return nvme_user_cmd64(ns->ctrl, ns, argp, true, mode);
 	default:
 		return -ENOTTY;
 	}
 }
 
-static int __nvme_ioctl(struct nvme_ns *ns, unsigned int cmd, void __user *arg)
+static int __nvme_ioctl(struct nvme_ns *ns, unsigned int cmd, void __user *arg,
+			fmode_t mode)
 {
-       if (is_ctrl_ioctl(cmd))
-               return nvme_ctrl_ioctl(ns->ctrl, cmd, arg);
-       return nvme_ns_ioctl(ns, cmd, arg);
+	if (is_ctrl_ioctl(cmd))
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, arg, mode);
+	return nvme_ns_ioctl(ns, cmd, arg, mode);
 }
 
 int nvme_ioctl(struct block_device *bdev, fmode_t mode,
@@ -640,7 +667,7 @@ int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
 
-	return __nvme_ioctl(ns, cmd, (void __user *)arg);
+	return __nvme_ioctl(ns, cmd, (void __user *)arg, mode);
 }
 
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -648,7 +675,7 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct nvme_ns *ns =
 		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
 
-	return __nvme_ioctl(ns, cmd, (void __user *)arg);
+	return __nvme_ioctl(ns, cmd, (void __user *)arg, file->f_mode);
 }
 
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
@@ -716,7 +743,8 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 }
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
+		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
+		fmode_t mode)
 	__releases(&head->srcu)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -724,7 +752,7 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 
 	nvme_get_ctrl(ns->ctrl);
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
+	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp, mode);
 
 	nvme_put_ctrl(ctrl);
 	return ret;
@@ -749,9 +777,10 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 	 * deadlock when deleting namespaces using the passthrough interface.
 	 */
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
+					mode);
 
-	ret = nvme_ns_ioctl(ns, cmd, argp);
+	ret = nvme_ns_ioctl(ns, cmd, argp, mode);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -773,9 +802,10 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		goto out_unlock;
 
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
+				file->f_mode);
 
-	ret = nvme_ns_ioctl(ns, cmd, argp);
+	ret = nvme_ns_ioctl(ns, cmd, argp, file->f_mode);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -849,7 +879,8 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 	return ret;
 }
 
-static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
+static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
+		fmode_t mode)
 {
 	struct nvme_ns *ns;
 	int ret;
@@ -873,7 +904,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 	kref_get(&ns->kref);
 	up_read(&ctrl->namespaces_rwsem);
 
-	ret = nvme_user_cmd(ctrl, ns, argp);
+	ret = nvme_user_cmd(ctrl, ns, argp, mode);
 	nvme_put_ns(ns);
 	return ret;
 
@@ -890,11 +921,11 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp);
+		return nvme_user_cmd(ctrl, NULL, argp, file->f_mode);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, false);
+		return nvme_user_cmd64(ctrl, NULL, argp, false, file->f_mode);
 	case NVME_IOCTL_IO_CMD:
-		return nvme_dev_user_cmd(ctrl, argp);
+		return nvme_dev_user_cmd(ctrl, argp, file->f_mode);
 	case NVME_IOCTL_RESET:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 050d7d0cd81b..1d102b662e88 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -797,6 +797,7 @@ enum nvme_opcode {
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
+	nvme_cmd_vendor_start	= 0x80,
 };
 
 #define nvme_opcode_name(opcode)	{ opcode, #opcode }
-- 
2.25.1


