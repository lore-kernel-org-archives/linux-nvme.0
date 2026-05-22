Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15925CD5BB3
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uX2iI66Hm+CicuqBNAeIAQtq4Ur9lk7IGl6o7EIKJi4=; b=ZxPH5jxpUJe/xwKlV39eHxYgbq
	F1Mon9Py+IlkNLYCskUAaoBthbKPmLF9EX3sqjPtXX4hfs8jHz4s6Os8eL4NpRWkZxMp3e5pOdvQY
	bGIFm9sjLzX2QpoCmhYuRjejkUazlKiF/cCQ4RxApELxXgKDOKCVufibZyYHNhdMahDBLonHB0NRJ
	62B6buZLaRX56KZvTHFAPIblbX/VPnQ8wPNiaD7iYSF0rbXpJnJeL5BWIZKszq+57JMv/HXDIuyKU
	RSc2Govc1FQzz4u4KhPc6EznSPJpQc/rXrNjUTvFYQ2SLGWoMKsDaf48N2MBUxJ6VZc4TAkSXP0ir
	+QoiL0eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRnK-0000000BFVn-1Fc5;
	Fri, 22 May 2026 15:28:14 +0000
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRnH-0000000BFUw-2fFb
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 15:28:12 +0000
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-57516e08474so5756225e0c.3
        for <linux-nvme@lists.infradead.org>; Fri, 22 May 2026 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779463689; x=1780068489; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2iI66Hm+CicuqBNAeIAQtq4Ur9lk7IGl6o7EIKJi4=;
        b=ffsIrXV51qLpTjw9wQ5GkvC5d+a7rR4kOiV2OTboeZgClC8jt9uEr+dpTs62kh8kPp
         GedpEAJ/KvoBn64BYVMe8iEQCh6RNahUS+YjeTEYue73CbsRzagk0Dg+9VCRNvsOB+/O
         SlInGxPp55modHBHnfDL2SlSuBTXEe1WoajsOC+qzMra2a7/Ly7dDNEvsexwA3jo2emw
         HJ4j613qy13t19p04cjZOZj6I010bAom7J23WA6HoiKM+u/UJYeNgNyj9RHD85SCkzB/
         Buj1QLOS1/zW39oxbSX+iZog/5imERvmHHXhJ8zM6Q73mHnYboCiWm5+yRee3SCEqKKy
         hFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463689; x=1780068489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX2iI66Hm+CicuqBNAeIAQtq4Ur9lk7IGl6o7EIKJi4=;
        b=h5Zv1uxBILH06XjbLlMV74Mms6s/AIb74CklbH1RBPtr9Va6FmeHJYyaRIp3FZGlXh
         ocuxN8Ve4AvzZ3ZRP9DNcJyPMitCKIaRiV47U5kM5sRyuu4btnZuEXoEpUiSgCGKewfL
         TdG2b6HT6LU62H5sC3OXYlaYTCgvLLESkk/peq3n1j9BnFfh0yMfOu7sQmmQaC0Tn4jX
         74s0RUagvbhS+a7RviEWCCZrnbUpvBrGUUcJOzYgaWh8sxPAGb/LKVVcIJ0lkxGhba5F
         pz3dLKiadPFm6yPYRtiC7RxZAtoWXCLUfQguBTtrHDcB3MmROZU6P0T7dx/C7Q1Usp7x
         qXJw==
X-Gm-Message-State: AOJu0YxFI2bA3k+L2vDRqXZ+FvAAg3IRsnzh8gd2bLrX1PxDD7g7FNNe
	/yi78JjRMCS1wTXoCv726c378esy1zcLA7nvHft8Gf7v93xyUfKVjbRuP4FdTX4zoe8=
X-Gm-Gg: Acq92OET+bfHoYGcKXgTRPpVjSkAsKf4uLRSK3yTksyCdtlcnD+7+70G6eAW6eckesU
	Fy2Fd9yOCXM51nRnhwE3AeX5fWeuuvEBv5gaTMUtqR+umtN9ahMXflEfw94OuwwrQL9e9bOCuQ3
	cMIZ11Ff1ktYj5o9E6ppeNoJQ74s9ZpDz5/N5UcXfZWIpTkuTPq1XR+ad0RxB16Ums5QuURAzwQ
	yRq2xc7brSv6aP4dncfqxaTm6HkwionW4FWSd9A8nQG0OeBph2no7mzCrKVYsyAojo4G+jZbbqo
	tiBuBMs39EADvFhPOur5aiQld3waE+MRox1smjfHW2PJ4KJCUunPq6sdV8Mj/zAUpgw6cOr8gdT
	UzW2SnIOkd0KxF4XwvyPv0MCad3b62dWnqnDoyQ5BLPMM1Vg0kLu5LOu6AvM6Fbe8ClPQu/Bx30
	t29btPC8a2Jl49jyslOe+QTExyMtRxT5l1NMu9G2237NGBkZdTN6u0
X-Received: by 2002:a05:6122:3a0f:b0:56f:8f5:b135 with SMTP id 71dfb90a1353d-58664038c9dmr2497222e0c.14.1779463689466;
        Fri, 22 May 2026 08:28:09 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586ec46c8ddsm2705042e0c.0.2026.05.22.08.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 08:28:08 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v3] nvme: reject keep-alive passthrough on non-fabrics
Date: Fri, 22 May 2026 11:28:07 -0400
Message-ID: <20260522152807.2061501-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_082811_688456_B6981B97 
X-CRM114-Status: GOOD (  20.76  )
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

Since commit b58da2d270db ("nvme: update keep alive interval when kato
is modified"), userspace can start keep-alive on any transport via a
Set Features (KATO) passthrough command. nvme_keep_alive_work() then
allocates with BLK_MQ_REQ_RESERVED, but nvme_alloc_admin_tag_set()
only reserves admin tags for fabrics, so the allocation trips
WARN_ON_ONCE() in blk_mq_get_tag() and fails:

  nvme nvme0: keep-alive failed: -11

Keep Alive is optional on PCIe (NVMe 2.0a section 5.27.1.12) and the
driver only arms keep-alive for fabrics; enabling it elsewhere has no
reserved tag and an active keep-alive command only harms idle power
states.

Reject Set Features commands the driver is not prepared to handle from
userspace passthrough, starting with KATO on non-fabrics. The check
can be extended to other problematic features as they are identified.

This guards the userspace passthrough paths (ioctl and io_uring); the
nvmet target passthru path is out of scope and is not changed here.

Link: https://lore.kernel.org/linux-nvme/20260515071248.2689513-1-coshi036@gmail.com/

Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")

Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---

Reproducer (run as root on a PCIe NVMe device):

    #include <fcntl.h>
    #include <stdio.h>
    #include <string.h>
    #include <sys/ioctl.h>
    #include <linux/nvme_ioctl.h>

    int main(void)
    {
            struct nvme_admin_cmd cmd = {0};
            int fd = open("/dev/nvme0", O_RDWR);
            if (fd < 0) { perror("open"); return 1; }
            cmd.opcode = 0x09;       /* SET_FEATURES */
            cmd.cdw10  = 0x0f;       /* Feature ID: KATO */
            cmd.cdw11  = 5;          /* KATO = 5 seconds */
            if (ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd) < 0) {
                    perror("ioctl");
                    return 1;
            }
            return 0;
    }

On an unpatched kernel, within ~kato/2 seconds after the program exits,
dmesg shows:

    nvme nvme0: keep alive interval updated from 0 ms to 5000 ms
    WARNING: CPU: 0 PID: ... at block/blk-mq-tag.c:148 blk_mq_get_tag+...
    nvme nvme0: keep-alive failed: -11

With this patch the ioctl fails with EOPNOTSUPP on non-fabrics and
keep-alive is never started.

Changes since v2:
- Reject the KATO Set Features passthrough on non-fabrics instead of
  reserving an admin tag for all transports (Keith Busch, Christoph
  Hellwig). PCIe does not need keep-alive, and an active keep-alive
  command only harms idle power states.
- Implement as an extensible passthrough filter for Set Features
  commands the driver cannot handle.
- Drop the core.c reserved_tags change.

Changes since v1:
- v2 added a spec citation and a quirk discussion; both are superseded
  by the filter approach above.

 drivers/nvme/host/ioctl.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a9c097dacad6..7705d9408396 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -86,6 +86,33 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	return capable(CAP_SYS_ADMIN);
 }
 
+/*
+ * Some Set Features commands change controller behaviour that the driver is
+ * not prepared to handle on every transport.  Reject such commands from
+ * userspace passthrough rather than letting them put the controller into a
+ * state the driver cannot deal with.  The list can be extended as other
+ * problematic features are identified.
+ */
+static bool nvme_passthru_cmd_allowed(struct nvme_ctrl *ctrl,
+				      struct nvme_command *c)
+{
+	if (c->common.opcode != nvme_admin_set_features)
+		return true;
+
+	switch (le32_to_cpu(c->common.cdw10) & 0xff) {
+	case NVME_FEAT_KATO:
+		/*
+		 * Keep Alive is optional on PCIe (NVMe 2.0a 5.27.1.12) and the
+		 * driver only arms keep-alive for fabrics.  Enabling it on
+		 * other transports starts a keep-alive command the driver is
+		 * not set up for and harms idle power states, so reject it.
+		 */
+		return ctrl->ops->flags & NVME_F_FABRICS;
+	default:
+		return true;
+	}
+}
+
 /*
  * Convert integer values from ioctl structures to user pointers, silently
  * ignoring the upper bits in the compat case to match behaviour of 32-bit
@@ -311,6 +338,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
 		return -EACCES;
 
+	if (!nvme_passthru_cmd_allowed(ctrl, &c))
+		return -EOPNOTSUPP;
+
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
@@ -358,6 +388,9 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
 		return -EACCES;
 
+	if (!nvme_passthru_cmd_allowed(ctrl, &c))
+		return -EOPNOTSUPP;
+
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
@@ -475,6 +508,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
 		return -EACCES;
 
+	if (!nvme_passthru_cmd_allowed(ctrl, &c))
+		return -EOPNOTSUPP;
+
 	d.metadata = READ_ONCE(cmd->metadata);
 	d.addr = READ_ONCE(cmd->addr);
 	d.data_len = READ_ONCE(cmd->data_len);
-- 
2.43.0


