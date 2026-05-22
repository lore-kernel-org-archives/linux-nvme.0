Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0A7CD5BB3
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W8xZQehkh3ianc7VYzDNDYXbFb1UAJo0G6OX86ibadI=; b=x+Cu5XlFsHrA0/yNJuMxtCCrUl
	nD3++FsvJhJnRwr8iVvwbqVD1IVtfmHieEHEkGk36hIe0GF7i7sur2CGTVhd2hTJ/MZTO98y1gCpj
	d+SdHF0Tfsc7GnATGqzWFXWNmYMwFGCJ3pJ99+6OrwLjXSrF7RVdfSiJpQpWt68iN/AH4xyzZ22eg
	fKn9JP+C43r9cBCkQLxp35vswjI1emEdUB8fIOl8yXp1tRSopU4ZZcitLm2qKZjDp6pZtwWOuT1pr
	VST7BaZ7EWS5VG/rnseX8KZUsos8mmlTgiVEdOLoUfdyKk7bQUzPlgQp2A1W1WTkqi5+3isdBSi8J
	uUwLP3rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQSi0-0000000BQVF-3KzK;
	Fri, 22 May 2026 16:26:48 +0000
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQShy-0000000BQUL-0rdl
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 16:26:47 +0000
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-631466587e9so5558530137.1
        for <linux-nvme@lists.infradead.org>; Fri, 22 May 2026 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779467205; x=1780072005; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W8xZQehkh3ianc7VYzDNDYXbFb1UAJo0G6OX86ibadI=;
        b=jaH27AR7pBrJ25pmNtT3SZzyQ7X2gvRl9GGfL9/2lJcftOkZxW3QkjrnLSa4Oq1udy
         cSLHNIiU1hQq31ddoiWJPo392p6lYt4yKjxJinPsCtcDXycp1/egPdcuL2jfJAm4G5dK
         oC4lH/IMLHirTKmWN5zX7lsICzItVeCy7Rv+zE8VbQXY3Gsu1Ku/bLx8J88DAomsSo6w
         AocBHWR9jvDLj86REG6iE7Mb0BxZEeCE39X1trLk1gjobSsowoQPlAUnrfo21Cu8yQ7C
         AXIqx0J5s4idXFcbZj0qmA/IRZYojof5ixphSRkbBYH8Ji6a3Or2Y7IEqzqDUKRf+1Lb
         en7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779467205; x=1780072005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8xZQehkh3ianc7VYzDNDYXbFb1UAJo0G6OX86ibadI=;
        b=sqZNj41rDncKtAku+7A+kbN99wbXQHRwghOCLaPDZe0uGivhrPAXWJLw+oa6gC9HoF
         kSn4cOR4ePHm1KtWI59OLfw7Z4BsMY/PZXNXsWjEDVBqHXhRPCzeTJTYN9Cu/R3euDKO
         HkUz0eVkbAd6LpCWAO4sGkA4NVpNNHkPFykgGSFk70aS3Zjl457/n54nDi2+Dx1sh2a5
         jaymoo95xlqx9nlgu3UfdRX+P6My0O0BqkU9NE2g4hPR2ZlViuqJ7BrzZMaxJX9Sw4an
         kU/TF1v94BCTkp08cFNfYshJyeHhPff88ANzFLBdXaECYj3TW+i3B4+7H5yB/GDaJ9Is
         CrYw==
X-Gm-Message-State: AOJu0YxducNyHt1/9jf/fI9EAY8JbXN/VoG+YnLYnEAqO6jZ98am/4KS
	wqZSv/Ln98FuWKFjNlPfSwWCWVxmTz2XmE/BtDuTQXvkb8uV81Rz4rYbsVYx4yznnRQ=
X-Gm-Gg: Acq92OHbiM1ravkeP0zINvG6flPchZZ+S9V3nClw7EeA2vYBpjnDVfhGinQRbdcZbZA
	e6hXji9OfHek9aU958XdDCAJH67zXNhZFpf/CodCuhIdlc7ElQr5hzPSz0aYfwaZA8HfTtLx1n3
	wj+gEitNMXZNyPPIL3XCGkMxxvRFkn7CNa26bxxRf+CytPRQFS+A4G4/iGGQLH65YhyrdyastpG
	3KrRs3OI3DMsC0IoN/BOprAYdQr5zirspYOCjV+9vl/hhOmD+8WVsYAcMjQFl1bSsP+QbNuHErS
	KnLZuK/NIqW2rINt3SVnw4a9YXS7vIkqa6IYRVwTPHjbWBrrCYNhZGs0P0eGjUG6GbrCBK8AZf3
	iQwCmV0tkf31JvKpOfZidiAKahvnlinMGGrBgmQRn/6hDVwHqQNxdB/753BlIUXJWZ4p1tolSQA
	VHpV8JIwRoowaCUN15qMQmy+HXM/FfWgyHfWuZprEidQ==
X-Received: by 2002:a05:6102:5e98:b0:631:7781:fe91 with SMTP id ada2fe7eead31-67c738ae6a4mr2707048137.9.1779467204825;
        Fri, 22 May 2026 09:26:44 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96173afb1ecsm2151019241.9.2026.05.22.09.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 09:26:44 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v4] nvme: reject keep-alive passthrough on non-fabrics
Date: Fri, 22 May 2026 12:26:39 -0400
Message-ID: <20260522162639.395802-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_092646_257563_6B7E859E 
X-CRM114-Status: GOOD (  21.89  )
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

Changes since v3:
- Only inspect admin commands (ns == NULL). I/O commands share the
  opcode space with admin commands (Dataset Management is 0x09, same
  as Set Features), so the previous version could wrongly reject a DSM
  I/O command. Pass ns to the helper and bail out for I/O (Keith Busch).

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

 drivers/nvme/host/ioctl.c | 42 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a9c097dacad6..33caa3ae79e5 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -86,6 +86,39 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
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
+				      struct nvme_ns *ns,
+				      struct nvme_command *c)
+{
+	/*
+	 * This only filters admin commands (ns == NULL).  I/O commands share
+	 * the opcode space with admin commands - Dataset Management is 0x09,
+	 * the same value as Set Features - so they must not be inspected here.
+	 */
+	if (ns || c->common.opcode != nvme_admin_set_features)
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
@@ -311,6 +344,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
 		return -EACCES;
 
+	if (!nvme_passthru_cmd_allowed(ctrl, ns, &c))
+		return -EOPNOTSUPP;
+
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
@@ -358,6 +394,9 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
 		return -EACCES;
 
+	if (!nvme_passthru_cmd_allowed(ctrl, ns, &c))
+		return -EOPNOTSUPP;
+
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
@@ -475,6 +514,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
 		return -EACCES;
 
+	if (!nvme_passthru_cmd_allowed(ctrl, ns, &c))
+		return -EOPNOTSUPP;
+
 	d.metadata = READ_ONCE(cmd->metadata);
 	d.addr = READ_ONCE(cmd->addr);
 	d.data_len = READ_ONCE(cmd->data_len);
-- 
2.43.0


