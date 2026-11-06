Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120B606A31B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XmoDvoDD;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=h3WGvEAm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=X52wzN28qPl1RdnrC2RFCsdi8e17kKS880IufqjlqhM=; b=XmoDvoDDQuGcWT
	v4wozFURtcskUAf8OHezM4AEqCrJcmwAh8jaAE25/uuKffndaF+VcPpR24CU/MUgkssSdEQWG+hiy
	LI2O+J1vzsZMrAYkqfJ0qUVu7Dx+2V5Raysxb1a1bSzoJPk6Dkk+ITcaRuREiuu7c47IF9dCdD3e2
	tyc1BT9SHq+9JQtHs1lD/08vNj+ZB+0GgPMTClvqW1/UGisFX/XzspUQGJ+DAvoRONc3XfTAxeV3n
	J7bJ4URzu4GLq4OFp7pT/TQO/Pv6rNOFDpdv9ID0tiLUHJb2XIifD5FV05r3BHe6HWIFPx48U1wH1
	AaiU9IVduD9dXbGcp4cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9EE-0000000B1Dk-1Xnq;
	Fri, 06 Nov 2026 01:58:54 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9EB-0000000B1C1-1qDg
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 01:58:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793930329; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=X52wzN28qPl1RdnrC2RFCsdi8e17kKS880IufqjlqhM=;
	b=h3WGvEAmLoIt/YfhOFSqvI4Ev3ohd8jrfqSoJDWUe/gdIKV/ODYEg5wtk/TcaexhaGago6hGBGUX0R6Lj5qrO59TkBtki/YcjxcFHTgXcufzRDRnRoUEEmc9AYQ8Y8TG2xjHjCAkU6O4AjKz0e03YlTX6SzeNu/3DoT38xZmrcI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA1qIN_1793930327;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA1qIN_1793930327 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:58:48 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/6] nvme: reject a reconnect_delay of 0 through sysfs
Date: Fri,  6 Nov 2026 09:58:37 +0800
Message-ID: <20261106015842.3534898-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106015842.3534898-1-kanie@linux.alibaba.com>
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_175851_850671_232482CD 
X-CRM114-Status: GOOD (  10.81  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme_ctrl_reconnect_delay_store() accepts any value the option parser
also accepts, except that it misses the lower bound: writing 0 is
rejected by nvmf_parse_options() but not by the sysfs attribute.
nvme_ctrl_loss_tmo_store() then divides by opts->reconnect_delay in
DIV_ROUND_UP(), so writing 0 followed by any ctrl_loss_tmo update
crashes the kernel with a division by zero.

Reject 0 like the option parser does.

Fixes: 42a45274c2258 ("nvme-fabrics: Allow ctrl loss timeout configuration")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---

Reproduced on an unfixed 7.3.0-rc7 kernel in a VM with a fabrics
controller connected:

  echo 0 > /sys/class/nvme/nvme1/reconnect_delay
  echo 30 > /sys/class/nvme/nvme1/ctrl_loss_tmo

  Oops: divide error: 0000 [#1] SMP KASAN PTI
  CPU: 7 UID: 0 PID: 1542 Comm: bash Not tainted 7.3.0-rc7
  RIP: 0010:nvme_ctrl_loss_tmo_store+0xce/0x120 [nvme_core]
  Code: ... 8d 44 08 ff <f7> f1 ...
  RAX: 000000000000001d RCX: 0000000000000000

Verified on the patched kernel: writing 0 returns -EINVAL and the
ctrl_loss_tmo update succeeds without an oops.
---
 drivers/nvme/host/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 10018c6356b6..bae0d6258d01 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -634,6 +634,9 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 	if (err)
 		return err;
 
+	if (!v)
+		return -EINVAL;
+
 	ctrl->opts->reconnect_delay = v;
 	return count;
 }
-- 
2.43.7


