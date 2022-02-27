Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DFAC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Feb 2022 23:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CuV6bZm6+Tvp4Pdji59uVuBLNwa5+Q5hK3f1bpYPxOg=; b=cqOzqhtJipfG8fLJ1JSi8KKw54
	2arjBhGpJdfiMWf1frZN1wxJDHlGJNaE99NoK9hyhD2FXZ0+FU3p4nBgI90OAAfSNgU2juwIT1kdS
	BeKhkGIhX/O0S/AWpigNGuHZu9EvTNweAe0ZaMekI6CmpPhv2Clz7Ly6zW3WrThUDv5fdpBj66OWn
	j8Xykq+9OWXFyAYs3tKm7zPP0ZL3qzo2Vau6uM6rof5YygFemhWIyapE28b9BWZF2HeqeQfV9cmli
	Z0taMzMGp/X+z1e1nd2UYkfS3k4WTsTjyXaj042mDK2mMHSySbpMuQrKX2FSJs3Tlc28Jc2sM0l5Q
	in8quyqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOTC5-00ALEb-RH; Sun, 27 Feb 2022 23:43:13 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOTC2-00ALEJ-Vu
 for linux-nvme@lists.infradead.org; Sun, 27 Feb 2022 23:43:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B1B3212BB;
 Sun, 27 Feb 2022 23:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646005386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CuV6bZm6+Tvp4Pdji59uVuBLNwa5+Q5hK3f1bpYPxOg=;
 b=fBJrOfJ3EE9mBbUoIvXDE4Tk+DSSVjbjcPZ+uzH41Dcqcdlbmt0DOa9YnIt3v+Q6d9jtIE
 UrBlgginZP6QBNKmeYLVR469Y9xO63Er3vb49RgLfJaS/T6geiDS9Ro8E0343LX+jElrn6
 NT7kQTQeTdehi1q7RnisKmSg6AB2TKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646005386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CuV6bZm6+Tvp4Pdji59uVuBLNwa5+Q5hK3f1bpYPxOg=;
 b=k7itSJ4L86rBKq33/Q+EPVa4Rrg8O83+X9uEuc0pdG2LBFe/xJhiSq9CDi2s3yM/o3lyWo
 /KfD0PAGky7hMiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFC4912FC5;
 Sun, 27 Feb 2022 23:43:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ze4gIIkMHGLrKQAAMHmgww
 (envelope-from <ematsumiya@suse.de>); Sun, 27 Feb 2022 23:43:05 +0000
From: Enzo Matsumiya <ematsumiya@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Enzo Matsumiya <ematsumiya@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: trigger disk activity LED
Date: Sun, 27 Feb 2022 20:42:58 -0300
Message-Id: <20220227234258.24619-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220227_154311_220194_0D833017 
X-CRM114-Status: UNSURE (   9.48  )
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

Users can enable an LED to indicate I/O activity on NVMe PCIe devices:

  # echo "disk-activity" > /sys/class/leds/<led>/trigger

for the composite activity, or disk-{read,write} for individual
activities/LEDs.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..3e49d5980beb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/leds.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -1037,6 +1038,8 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
 			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
 	if (blk_rq_nr_phys_segments(req))
 		nvme_unmap_data(dev, req);
+
+	ledtrig_disk_activity(req_op(req) == REQ_OP_WRITE);
 }
 
 static void nvme_pci_complete_rq(struct request *req)
-- 
2.34.1


