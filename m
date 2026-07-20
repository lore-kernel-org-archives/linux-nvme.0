Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC31BC44515
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 06:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/Q/pV0BHewCj6TMUR7rjMp0Y6vbhI+08hcM/QYp42kg=; b=dGjL4ODaLDVKlE8QYNZygpjgw+
	g5Y6y9jqpqez99AvDcuU/VuEtPhjL8d3LiywSWGTJd8rKuQlRdOTqKNAWX/G+U6X67re+9wtxr/Ai
	tBlNCMvXXc+CmbEwAli0wpDwp0eqogrN2Sy0EugnKolK+kyqpGRlb/9/lzsl7n/1fq+nJKCPwyt3c
	RD5BLMP+qgqvxUwVnYOXdAeBGhp2eZ47ORw1QK0mCYIfxpVN1Cw/LfGyW5mUX7Kmuq+2OF3dYE1aV
	bnz1C1TVCMYSL61bTo8f607TKWahDPWfcJlGK0JIoQzLLmtEovD9t6Gdsbxt1i2ce2G9mHhhtRCPo
	hDrq2sbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlh6f-00000005ubo-0uvQ;
	Mon, 20 Jul 2026 06:04:01 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlh6c-00000005uam-0Dbd
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 06:04:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/Q
	/pV0BHewCj6TMUR7rjMp0Y6vbhI+08hcM/QYp42kg=; b=VIDOA5bBPMkcfEjbBa
	C1JyT9o4Sm7s2o4eUUoX8ZUAlkVL/herKwLtCVnLWXPOAYPSnfbUIqrQG8F++Q4h
	5U+ek0Uq0RJ+CZucVl84b+l7xk7cSpMi5kfAIAhdDckVLunu644yUi73evhSthwR
	eeSZuA5+rEJkBeZCagJFfgGNs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3PzQlul1qVm5qIA--.13283S2;
	Mon, 20 Jul 2026 14:03:17 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH] nvme/ioctl: check SUBMIT_IO with nvme_cmd_allowed()
Date: Mon, 20 Jul 2026 14:03:05 +0800
Message-Id: <20260720060305.885535-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgD3PzQlul1qVm5qIA--.13283S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw47XF1rXr4Dtw4UXr47Arb_yoW8Ar13pF
	ZxXay2kF12gr45u34DJa1UZFyFq3WI9ryxG3yxW3yFvr90yryrCFWYk3ZIv343GF4v9F48
	ZFW0kF1aqr4kWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdWrZUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6QWpOmpduiXhnAAA3q
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_230358_465737_BD98A45B 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
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

Unlike IO_CMD / IO64_CMD, NVME_IOCTL_SUBMIT_IO never calls
nvme_cmd_allowed(). Unprivileged callers can thus issue I/O on a
partition device or write through a read-only file descriptor.

Pass flags and open_for_write through and reject disallowed commands
with -EACCES.

Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
 drivers/nvme/host/ioctl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 664216eece4a..752d7b249000 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -202,7 +202,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	return ret;
 }
 
-static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
+static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio,
+		unsigned int flags, bool open_for_write)
 {
 	struct nvme_user_io io;
 	struct nvme_command c;
@@ -260,6 +261,9 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.lbat = cpu_to_le16(io.apptag);
 	c.rw.lbatm = cpu_to_le16(io.appmask);
 
+	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
+		return -EACCES;
+
 	return nvme_submit_user_cmd(ns->queue, &c, io.addr, length, metadata,
 			meta_len, NULL, 0, 0);
 }
@@ -595,7 +599,7 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	case NVME_IOCTL_SUBMIT_IO32:
 #endif
 	case NVME_IOCTL_SUBMIT_IO:
-		return nvme_submit_io(ns, argp);
+		return nvme_submit_io(ns, argp, flags, open_for_write);
 	case NVME_IOCTL_IO64_CMD_VEC:
 		flags |= NVME_IOCTL_VEC;
 		fallthrough;
-- 
2.25.1


