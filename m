Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B00C44508
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9aijD+fPo0qOczwKPInOUobCTh5sBI95W49BowR2h/g=; b=LUgUYvBjjCh4Gq0BC08WKWCHbw
	jcopRN6+x+OceGc2d9GhlHi+JSilspVFnvL+KHObl9mX6IFUnIDKYSXQqlpArIa4jtlAeZn8mggI4
	ixkWLrvCABUcv3OI2+cf3zgIu6S7jfW2XOK84y+gwOT2sMdGfaXgl08amRqFVBcC314wKMqTgo6yY
	GmJZ+js4+F2dO/OFsPtmhZgxl78DuzQquYMemzIUjXFzdOBO/Z4r5yTSjT/pEHDAc1g6oShUIiJef
	pht5PDUTeiyTW6ha2b6Qv4atgYQ4iQY8tSCiDDI6tObYKA5TvTrtE+O0yAms15feCNuqi3uzEyCq8
	DlGPpyCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk1zj-0000000FNnf-3jiH;
	Wed, 15 Jul 2026 15:57:59 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk1zg-0000000FNmk-1fT3
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 15:57:58 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-5bdcbb1f3f2so774069e0c.3
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jul 2026 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784131075; x=1784735875; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9aijD+fPo0qOczwKPInOUobCTh5sBI95W49BowR2h/g=;
        b=BrwEdkWXPS257X9IW/WTGpZi7a50kxnk/Ez5KPBlvJDtEyxM2nrlf3uwbMXk96yejJ
         n3xfQ1TXV7+oyvG5bFBW2mvKaBqAfwc1prhQ8/77TJw88iUu4Xf75RH/gaEDSkFrVNtv
         +guiksD0zPfFQBEcXCAZtZ56SZh1KAcyOVhBDScViXP1SKA+RvvNn/SVx/W0nBLE+Ce+
         EVQanWuRd2KA/H+6Z80JYPBYbiLXzwPwdWFyowkFUDDsYezya67BY7za5rGa3aUWVtWr
         +fBS8R2E6T6SdtYwAAx26vt2/cdzSVgzdHJPaVlgrmRct42mLMov+Y/vtMMDB1HDXO+q
         +SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784131075; x=1784735875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9aijD+fPo0qOczwKPInOUobCTh5sBI95W49BowR2h/g=;
        b=H175i6b0oOZT3upDSP0uhDLTqGB5mKTXYgSZ6ImNa9RS5wwF1zh+t6k9pZ4aesPsho
         4sfgx5oCVFoxj0MBxr38IgGjwNK/UwHGY3v7PBzaN1JlkunCOpAGNtvo9pT6jXZyCJ9B
         czW9abEPmBf+LEPunAE7CqNM/1/y8g+9XO5HlGS60yjEQDXs8dNzsBpOkTVZVtU6L3Ax
         OhoDOwWH1r4nxNxyRNBYuALux6oJOaf0x9sOOYsEir13e1cF0LMCdGWQ268C0r4elz5g
         lw66NsAw9DiDTVN/AsbSvZtaNcBHiuWW2SW4zLzteOxpRNDpcx2xaq18XrdX6FEkYRji
         CFVA==
X-Gm-Message-State: AOJu0YymykzpfhgVdOAm++BhG0fnCQkuIyU6QkZmtoPG0FzEPfaGHGB6
	gcB3iNg1N0TaoO0TjF1nF5Ucuqt6P/G1EQtpCvGknMn5dxlbEJsH1nDexr0ro+jqrlM=
X-Gm-Gg: AfdE7cldC5dtG0dIpPARi3+VtBWzfSMuGcUMRAcUk0o4C3jLIAEFtDB03KJLH7tl3fM
	bebkh+f+inIRUXZtrAX2dbtzcOUpyElhGnzcIkKCiDg01slnT21poD/KeGwuOnrCnFux9RCyl2o
	tZPkHO8CEUV0aWMqsMaUuZTkIHgys4nZEyf/a+z0W1IOFCOcsL1IwIo7EqxdxjWw1s/IOtgK1Q4
	cQtGKq50TvygJxdwuuh0MWSg5xFER6r+T9673bvnWq07gcSDDjTHwvxymvBEgSEz3il77ce+StH
	M1uVc8U5QG/YcN/K4dfEH2VbxeUrrr7SjdOZEXpuyx5bp/dprgUWtLfA/fKjhHexV3sKh6qE33L
	E2pNkwbAbQhVi0UFKfItIEzYbWurqjI22t25cly59eNXKyU3wPKcSJC/HlXcUjTMbCsUFBjm9Ch
	Qaj+u6GMGGNaEa1icyWLO5a1YIiymC+yU=
X-Received: by 2002:a05:6122:1682:b0:5bd:9c71:11e with SMTP id 71dfb90a1353d-5bfbf116fb5mr10853644e0c.4.1784131074738;
        Wed, 15 Jul 2026 08:57:54 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bfb1aefafcsm8774511e0c.4.2026.07.15.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:57:54 -0700 (PDT)
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
Subject: [PATCH v6] nvme: reject passthrough of driver-managed Set Features
Date: Wed, 15 Jul 2026 11:57:52 -0400
Message-ID: <20260715155752.3363247-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_085756_462075_663C59BB 
X-CRM114-Status: GOOD (  24.09  )
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
is modified"), a Set Features (KATO) passthrough command lets userspace
start keep-alive on any transport. nvme_keep_alive_work() allocates with
BLK_MQ_REQ_RESERVED, but nvme_alloc_admin_tag_set() reserves admin tags
only for fabrics, so on other transports the allocation trips
WARN_ON_ONCE() in blk_mq_get_tag() and fails:

  nvme nvme0: keep-alive failed: -11

Several Set Features change controller state the driver manages itself
and cannot react to when set behind its back. Reject these in
nvme_admin_cmd_allowed():

  - KATO on non-fabrics (keep-alive is only armed for fabrics; on PCIe
    it has no reserved tag and harms idle power states)
  - Host Behavior Support, Host Memory Buffer, Number of Queues, and
    Autonomous Power State Transition (all driver-managed)

Keep Alive on fabrics is unchanged; I/O commands are unaffected as the
check is confined to the admin path (ns == NULL).

Link: https://lore.kernel.org/linux-nvme/20260523225629.3964037-1-coshi036@gmail.com/

Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")

Found by FuzzNvme.

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

Changes since v5:
- Split nvme_cmd_allowed() into nvme_admin_cmd_allowed() and
  nvme_ns_cmd_allowed(), switch on the command, and fix the overly
  long lines (Christoph Hellwig).
 drivers/nvme/host/ioctl.c | 109 +++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a9c097dacad6..ccd0120ad2e6 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -14,45 +14,54 @@ enum {
 	NVME_IOCTL_PARTITION	= (1 << 1),
 };
 
-static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
-		unsigned int flags, bool open_for_write)
+static bool nvme_admin_cmd_allowed(struct nvme_ctrl *ctrl,
+				   struct nvme_command *c)
 {
-	u32 effects;
-
-	/*
-	 * Do not allow unprivileged passthrough on partitions, as that allows an
-	 * escape from the containment of the partition.
-	 */
-	if (flags & NVME_IOCTL_PARTITION)
-		goto admin;
-
-	/*
-	 * Do not allow unprivileged processes to send vendor specific or fabrics
-	 * commands as we can't be sure about their effects.
-	 */
-	if (c->common.opcode >= nvme_cmd_vendor_start ||
-	    c->common.opcode == nvme_fabrics_command)
-		goto admin;
-
 	/*
 	 * Do not allow unprivileged passthrough of admin commands except
 	 * for a subset of identify commands that contain information required
 	 * to form proper I/O commands in userspace and do not expose any
 	 * potentially sensitive information.
 	 */
-	if (!ns) {
-		if (c->common.opcode == nvme_admin_identify) {
-			switch (c->identify.cns) {
-			case NVME_ID_CNS_NS:
-			case NVME_ID_CNS_CS_NS:
-			case NVME_ID_CNS_NS_CS_INDEP:
-			case NVME_ID_CNS_CS_CTRL:
-			case NVME_ID_CNS_CTRL:
-				return true;
-			}
+	switch (c->common.opcode) {
+	case nvme_admin_identify:
+		switch (c->identify.cns) {
+		case NVME_ID_CNS_NS:
+		case NVME_ID_CNS_CS_NS:
+		case NVME_ID_CNS_NS_CS_INDEP:
+		case NVME_ID_CNS_CS_CTRL:
+		case NVME_ID_CNS_CTRL:
+			return true;
 		}
-		goto admin;
+		break;
+	case nvme_admin_set_features:
+		/*
+		 * Reject Set Features that change controller state the driver
+		 * manages itself; setting them behind the driver's back from
+		 * userspace leaves it unable to react correctly. Keep Alive is
+		 * only armed for fabrics - on other transports it has no
+		 * reserved tag and harms idle power states.
+		 */
+		switch (le32_to_cpu(c->features.fid) & 0xff) {
+		case NVME_FEAT_KATO:
+			if (ctrl->ops->flags & NVME_F_FABRICS)
+				break;
+			fallthrough;
+		case NVME_FEAT_HOST_BEHAVIOR:
+		case NVME_FEAT_HOST_MEM_BUF:
+		case NVME_FEAT_NUM_QUEUES:
+		case NVME_FEAT_AUTO_PST:
+			return false;
+		}
+		break;
 	}
+	return capable(CAP_SYS_ADMIN);
+}
+
+static bool nvme_ns_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
+				bool open_for_write)
+{
+	u32 effects;
 
 	/*
 	 * Check if the controller provides a Commands Supported and Effects log
@@ -61,7 +70,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 */
 	effects = nvme_command_effects(ns->ctrl, ns, c->common.opcode);
 	if (!(effects & NVME_CMD_EFFECTS_CSUPP))
-		goto admin;
+		return capable(CAP_SYS_ADMIN);
 
 	/*
 	 * Don't allow passthrough for command that have intrusive (or unknown)
@@ -70,7 +79,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
 			NVME_CMD_EFFECTS_UUID_SEL |
 			NVME_CMD_EFFECTS_SCOPE_MASK))
-		goto admin;
+		return capable(CAP_SYS_ADMIN);
 
 	/*
 	 * Only allow I/O commands that transfer data to the controller or that
@@ -79,11 +88,34 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 */
 	if ((nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC)) &&
 	    !open_for_write)
-		goto admin;
+		return capable(CAP_SYS_ADMIN);
 
 	return true;
-admin:
-	return capable(CAP_SYS_ADMIN);
+}
+
+static bool nvme_cmd_allowed(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			     struct nvme_command *c, unsigned int flags,
+			     bool open_for_write)
+{
+	/*
+	 * Do not allow unprivileged passthrough on partitions, as that
+	 * allows an escape from the containment of the partition.
+	 */
+	if (flags & NVME_IOCTL_PARTITION)
+		return capable(CAP_SYS_ADMIN);
+
+	/*
+	 * Do not allow unprivileged processes to send vendor specific or
+	 * fabrics commands as we can't be sure about their effects.
+	 */
+	if (c->common.opcode >= nvme_cmd_vendor_start ||
+	    c->common.opcode == nvme_fabrics_command)
+		return capable(CAP_SYS_ADMIN);
+
+	if (!ns)
+		return nvme_admin_cmd_allowed(ctrl, c);
+
+	return nvme_ns_cmd_allowed(ns, c, open_for_write);
 }
 
 /*
@@ -308,7 +340,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
+	if (!nvme_cmd_allowed(ctrl, ns, &c, 0, open_for_write))
 		return -EACCES;
 
 	if (cmd.timeout_ms)
@@ -355,7 +387,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
+	if (!nvme_cmd_allowed(ctrl, ns, &c, flags, open_for_write))
 		return -EACCES;
 
 	if (cmd.timeout_ms)
@@ -442,6 +474,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 	const struct nvme_uring_cmd *cmd = io_uring_sqe_cmd(ioucmd->sqe);
 	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
+	bool open_for_write = ioucmd->file->f_mode & FMODE_WRITE;
 	struct nvme_uring_data d;
 	struct nvme_command c;
 	struct iov_iter iter;
@@ -472,7 +505,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(READ_ONCE(cmd->cdw14));
 	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
 
-	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
+	if (!nvme_cmd_allowed(ctrl, ns, &c, 0, open_for_write))
 		return -EACCES;
 
 	d.metadata = READ_ONCE(cmd->metadata);
-- 
2.43.0


