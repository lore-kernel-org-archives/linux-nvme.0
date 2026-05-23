Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8101ECD4F54
	for <linux-nvme@archiver.kernel.org>; Sat, 23 May 2026 22:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cDes2ImAivF9GmrbE+N4ZQZmqIxy9Q4epmjcP19kqWQ=; b=uELhgj8yfLK/fMVRAokY1lNVGX
	t2wubOwdVCGjf8oBfgbmuTps4LNFVHQG134yxBlv7yXhIu/x2Rz5YAB6l5BoIbnUtgMuTWVcb+XC0
	QNJkPq1AilQZOSCheUYQg7wwXJU8dzr7yNTYKDffWoGfZrjVr5Vn3bQ8IsbS5jFW5mjiZptDVPMAU
	BvJhUySlPBl0gtRZnQWDOoRWyjWz5fKdJH+J2NiFOL9/evfLP5EfbLHMZonMaJf7eQOumJzAVDc/W
	Nemh55VHXFHxQshyzle8kVLbV4xBQm1ewbEqlbGyJ2TvixsNyXQYuJGKVXPoiTKPtD2B7/+PEWUi0
	V4McZQ2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQvGm-0000000E6al-2DJl;
	Sat, 23 May 2026 22:56:36 +0000
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQvGj-0000000E6a6-16dc
	for linux-nvme@lists.infradead.org;
	Sat, 23 May 2026 22:56:34 +0000
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-63145ce291bso6753117137.0
        for <linux-nvme@lists.infradead.org>; Sat, 23 May 2026 15:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779576991; x=1780181791; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDes2ImAivF9GmrbE+N4ZQZmqIxy9Q4epmjcP19kqWQ=;
        b=myGEBrvfcCgJGJpx5zaG5DwQxPm2YkNNG1s03rDMl83TqEWaaM8DzEN/dNF1lMvpZu
         BWC6a5hEMhuBKw4Ysm5S2XGqrApL4KZlDvsMg76QiuuvSyIyYWUNfKOCQJxneiy8BT6k
         DWWhg09Ry0BDTMGOpJmBlkMnc5cMEh8F+H4F4kfTglbV6FPsuDY+PwfI9nbrg/SBQctP
         0UXn76dbLCFkA8lzQhYGUwVhqXuYkT5MIMULrE5bWUckCVGbWbox8wYd86JQ25kJOveh
         /Zv4/5YQgG6qYX4RZ5xJX24zQ4bxyFSh3iFxLiXKcpumZHQl9E0Ae6Z8n3zqfg6DiHD+
         LtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779576991; x=1780181791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDes2ImAivF9GmrbE+N4ZQZmqIxy9Q4epmjcP19kqWQ=;
        b=shOG+qTNRIoKjajjGc5V+ez369E9DPWghIIbCj5LdOG4ig3a0Zma5O7tL4QkXnuntg
         X/ALXCJX50EoyetxvNp+3d+qgIBjROX2TRAGAVRqEpAmqyqsx0bynesFNVBnd4ozzpbj
         012tPT4u1WysgtbZy7CZ6SM7wQKakMPoc/n+FXyC8762arUb6/j5ExbNIWdO2EJZgMJe
         d9+F5CaxMVh5jqCVp/StLr1AzaujjVdvIQDXyfyFOpxfkGnPZXoDuLasrdTsqnyxFcN2
         FbSw3R/0K+qQMvfsGZKnOHqzeFHX8OexVUZZ+D1AJksANS1cxm+0h59bfdVMZjdyxjyr
         tM/w==
X-Gm-Message-State: AOJu0Yxh9Wm31BONMK0MYjB5Jo8bqG7EPx+lMXH9Gtl8okhiqxgymRW0
	6lxPHxqQBOieAGiborbOcZA7UDWdvltsvIJ3t1xUNIXGgjzqWD2rVbLu1obaSPu6dSI=
X-Gm-Gg: Acq92OEW+1FtWCTVttSim/b5Ngd+E1GJbwYyrPCOmx51xEIWfFsk+rkLLEPrfQcQsDc
	pLuNLQZ3Ex/wRyP1F495N5H92FkMdC50vg/dAvEkzrNirVE5cej/xgH1OGLqMbWY9yGr6moGhPv
	XTc3oXYcYNLgAKi7BvXfV4nalip28U6rL4/E27/80w+Knsu8LDDzyBHFpYFnZ0+8YEaZh9mjkvZ
	/YkHDWnUB7j39wuVIux24n7A9wnhFCCCwfn1SXQ765uZeW/2VCH9y4zQDctiugpotrz1y95aXPT
	HcIoKWDC9vl5IIe7c958vQga7LxyPDaIMb1UBzjmZYFv1fXsPAVshLVT48Y2p6Zwkr580YgQB6I
	eYj7TpoktqzMwjkB6q2+ug5yiHD5yjWG5RJodGxQosPc4F6R4eJ9PyiY8FUO92cfoGE4NDY53K/
	twtMDt4EOlm58Y/dwYjW3IYtsrXigv26uxuWHRwuo3ew==
X-Received: by 2002:a05:6102:b07:b0:618:442a:9e76 with SMTP id ada2fe7eead31-67c7cee1428mr5016464137.10.1779576991313;
        Sat, 23 May 2026 15:56:31 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9617383b1a2sm6080769241.4.2026.05.23.15.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 15:56:30 -0700 (PDT)
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
Subject: [PATCH v5] nvme: reject passthrough of driver-managed Set Features
Date: Sat, 23 May 2026 18:56:29 -0400
Message-ID: <20260523225629.3964037-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260523_155633_327965_0C714735 
X-CRM114-Status: GOOD (  20.93  )
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

More generally, several Set Features change controller state that the
driver manages itself and cannot react to correctly when set behind
its back from userspace. Reject these in nvme_cmd_allowed():

  - KATO on non-fabrics (keep-alive is only armed for fabrics; on PCIe
    it has no reserved tag and an active keep-alive harms idle power
    states)
  - Host Behavior Support, Host Memory Buffer, Number of Queues, and
    Autonomous Power State Transition (all driver-managed)

Keep Alive on fabrics is unchanged. I/O commands are unaffected as the
check is confined to the admin path (ns == NULL).

Link: https://lore.kernel.org/linux-nvme/20260522162639.395802-1-coshi036@gmail.com/

Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")

Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---

Reproducer for the keep-alive case (run as root on a PCIe NVMe device):

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

With this patch the ioctl fails with EACCES on non-fabrics.

Changes since v4:
- Fold the check into the existing nvme_cmd_allowed() instead of a
  separate helper, and reject additional driver-managed Set Features
  (Host Behavior, Host Memory Buffer, Number of Queues, Autonomous
  Power State Transition) in the same switch (Keith Busch). The admin
  vs I/O distinction is now structural: the switch lives in the
  ns == NULL branch, so I/O commands (e.g. Dataset Management, which
  shares opcode 0x09 with Set Features) are never inspected.

Changes since v3:
- Only inspect admin commands so a DSM I/O command is not wrongly
  rejected (Keith Busch).

Changes since v2:
- Reject the KATO passthrough on non-fabrics instead of reserving an
  admin tag for all transports (Keith Busch, Christoph Hellwig).

Changes since v1:
- v2 added a spec citation and quirk discussion, superseded by the
  reject approach.

 drivers/nvme/host/ioctl.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a9c097dacad6..31784506e845 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -14,8 +14,9 @@ enum {
 	NVME_IOCTL_PARTITION	= (1 << 1),
 };
 
-static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
-		unsigned int flags, bool open_for_write)
+static bool nvme_cmd_allowed(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			     struct nvme_command *c, unsigned int flags,
+			     bool open_for_write)
 {
 	u32 effects;
 
@@ -50,6 +51,26 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 			case NVME_ID_CNS_CTRL:
 				return true;
 			}
+		} else if (c->common.opcode == nvme_admin_set_features) {
+			/*
+			 * Reject Set Features that change controller state the
+			 * driver manages itself; setting them behind the driver's
+			 * back from userspace leaves it unable to react correctly.
+			 * Keep Alive is only armed for fabrics - on other
+			 * transports it has no reserved tag and harms idle power
+			 * states.
+			 */
+			switch (le32_to_cpu(c->features.fid) & 0xff) {
+			case NVME_FEAT_KATO:
+				if (ctrl->ops->flags & NVME_F_FABRICS)
+					break;
+				fallthrough;
+			case NVME_FEAT_HOST_BEHAVIOR:
+			case NVME_FEAT_HOST_MEM_BUF:
+			case NVME_FEAT_NUM_QUEUES:
+			case NVME_FEAT_AUTO_PST:
+				return false;
+			}
 		}
 		goto admin;
 	}
@@ -59,7 +80,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 * and marks this command as supported.  If not reject unprivileged
 	 * passthrough.
 	 */
-	effects = nvme_command_effects(ns->ctrl, ns, c->common.opcode);
+	effects = nvme_command_effects(ctrl, ns, c->common.opcode);
 	if (!(effects & NVME_CMD_EFFECTS_CSUPP))
 		goto admin;
 
@@ -308,7 +329,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
+	if (!nvme_cmd_allowed(ctrl, ns, &c, 0, open_for_write))
 		return -EACCES;
 
 	if (cmd.timeout_ms)
@@ -355,7 +376,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
+	if (!nvme_cmd_allowed(ctrl, ns, &c, flags, open_for_write))
 		return -EACCES;
 
 	if (cmd.timeout_ms)
@@ -472,7 +493,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(READ_ONCE(cmd->cdw14));
 	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
 
-	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
+	if (!nvme_cmd_allowed(ctrl, ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
 		return -EACCES;
 
 	d.metadata = READ_ONCE(cmd->metadata);
-- 
2.43.0


