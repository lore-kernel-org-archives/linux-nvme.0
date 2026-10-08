Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19947CA600C
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NvBBYt0QHaBsGt4sgK0v6LDNYZqIUkl6IROUmRuxWdQ=; b=EYc/UlIG654/KTCs4326PLxA56
	djp4WAw/TiUogDhjFJQJ0qi1pdWF22kqFogtX/BpLwTdT+tfVo9hAGWpab3Eh2PctttPQkZU/kLXy
	ga7awQW/v94w3A4fDgnxNYfCCw0tT4RMEbz2rEVaKwts74Z7ooSxbRIdVfi3mbAvQFG5bvomvJKgb
	LN0ZYgCiLvij/V6s8qMy0BfwDmhfih4y/6TjXW3Q9aYWBJS3Ffxi+dis/1RnjNtp7zqmF87OURn1b
	94Hsqw/Yok42C3DuzMlOyh/vPS5HLppNW2Z5CSgiQo6++WCRolLe4sUFMQ8XeZ6V4xJRvjshqnvxJ
	aULIvNjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEtdq-00000004v1v-2OJj;
	Thu, 08 Oct 2026 19:18:58 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEtdn-00000004uz5-0foA
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 19:18:56 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-48c6955a7c3so1029626f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2026 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791487133; x=1792091933; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NvBBYt0QHaBsGt4sgK0v6LDNYZqIUkl6IROUmRuxWdQ=;
        b=YEB0Cuh1FOsiEVyJTSqTpaY4Tz6iz7kOK1byuvg54pDe/6TXX4eTU6lcqhg3dYm2j2
         Tdc985fK1ihufXG2nmkoYvvg5IRQAKxIY5hdJbG5EqihkUSNaEtmfCq8Gj9Bnntnsfun
         ediZ1jCoYyVl/8rshEkA1hK+jP+tPlVAWSrD04EjzfVhGBhD6leFClU0EFtEYusPDc+1
         v1Rrjpepi2UehXYEZKeMgX1RoIeWralOp9qtlCzurUHFEK3j1C+cYkE6+eFDduenGxqV
         fuEF9k27b0NIQAxYNMn0Z7vaZqRQi9sahiBKLQ2gcHHCsRjDJU4jJx7YmbcZQN+RVCOb
         0pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487133; x=1792091933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NvBBYt0QHaBsGt4sgK0v6LDNYZqIUkl6IROUmRuxWdQ=;
        b=JcAI6Yr5Vct7uZoLK8to699aF3Gbx2H0tKovV21H/s8Iil5UvoJQN3Hz/gV/s8Q3Hh
         4WQ6JPaNnR4LWAD21/UfAo7ubhw7tIwWtAU8ClKUKy39I6qFrP4LmQqxIZUpgWHIu2X/
         ka6IVaajeMSzVYjQbmE1ELvILhSTKuaBA5ane5mMxcET3gCnY7E754CmfzBDHXYr0QdF
         gBxKAtRaL2tKSBALXlPYg3caTTNaYCPIB2STB8qdylHmplDVXAx3NldZz1WVL5vRdWZd
         j9iYwmJbfIRZTbkHyI+L5KMYRR0iYCd2X54OIt0KPnBJvZHnCtZr9IplSZjpavd4UNFt
         c+gw==
X-Forwarded-Encrypted: i=1; AKwUvBySxZZX6JOy9zCkGHJ0/sSxU76n6gIYg4dOyx6jM8qpsyWEAZkqPfKc74jhhxUa8CWPyTan+y4zO3fp@lists.infradead.org
X-Gm-Message-State: AFq9FYKD3hxHNIQOgq+aq06HgllA8gpZ5Qm2pnmNghs7EBUwfOusdHpK
	4uE3ErYqM3Kpz80b1WCRAaAtnfj+zerKi+DPTNsZng+48stG+PUsPhDZ
X-Gm-Gg: AYBFou3LzguWpOiN6lBGppMQR3LAGwC50goNw+f0ZPEFUOaR49CG1mANFIysdg/rfLz
	hTyVo8leK0WA9TjIVhJso0yMKJo4kO5vzgEvPe/5dZvV223Ex14miXd6nZrTihbFY5oHQakQpGD
	27YKhT5tjlKAGIp1cZWbPcdupjYq/nwZOW6gHglAE2ixmqISjT1K0kyFkY9yYlCwJ7FW/qHWn74
	9F9F3Ztvcy01pCcalEt1WKl3Zu0cnBEpB+Hk7FlvPeflhB1bMw+uOdW7PzwH1XHKsEfWMxOWS9f
	SpbULEsu5+f6hg8pKfF3ZyfSPoo1I7XopSEuu2C4SooBMd2Bdhcf/EuZukur4zxYHUrmpD43AnA
	JALyMCIni3sdBBPlPRoUGw1yHUjeM25Q8Zk5+MC612sQGxLTyiRgd4Nq789mOGYdA7vJaX3lcbC
	XtL5jnuYAoxl0/MyrFGN55sU8WLVaHaWtRTY8SjcOWPkTkIc13pG68wJkd/yfnDcZVM/m6xnWRM
	NMW77wT8uJOWhDKIZAOLNqWaOGS2GdBncfJQWkAcUpH861VW1jaQTuhQD1BYScDeS9N
X-Received: by 2002:a5d:64c9:0:b0:48c:7037:aee9 with SMTP id ffacd0b85a97d-48c72890fdcmr12484231f8f.50.1791487132477;
        Thu, 08 Oct 2026 12:18:52 -0700 (PDT)
Received: from Raghu007.. (sgyl-44-b2-v4wan-174108-cust110.vm6.cable.virginm.net. [80.1.81.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db650fe17sm1104128f8f.9.2026.10.08.12.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:18:52 -0700 (PDT)
From: Palla Raghunath <raghunathpalla.0209@gmail.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	raghunathpalla.0209@gmail.com,
	syzbot+da94a51633758d13bd63@syzkaller.appspotmail.com
Subject: [PATCH] nvmet-fc: don't drop the last assoc reference in nvmet_fc_delete_ctrl()
Date: Thu,  8 Oct 2026 20:18:48 +0100
Message-Id: <20261008191848.47066-1-raghunathpalla.0209@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_121855_220432_18A1A758 
X-CRM114-Status: GOOD (  15.18  )
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

syzbot hit a recursive locking report on subsys->lock when a subsystem
is unlinked from an FC port.

nvmet_port_del_ctrls() holds subsys->lock while it calls ->delete_ctrl()
for each controller. nvmet_fc_delete_ctrl() grabs a reference on the
association, queues del_work and then drops the reference. If del_work
gets to run to completion before that put, ours is the last reference.
Freeing the assoc tears down the queues, the last nvmet_cq_put() drops
the last ctrl reference, and nvmet_ctrl_free() goes for subsys->lock
again:

  WARNING: possible recursive locking detected
  ...
   nvmet_ctrl_free+0xa6/0x8e0 drivers/nvme/target/core.c:1766
   nvmet_cq_put+0x158/0x200 drivers/nvme/target/core.c:848
   nvmet_fc_target_assoc_free+0x418/0x2220 drivers/nvme/target/fc.c:1173
   nvmet_fc_delete_ctrl+0x717/0x7e0 drivers/nvme/target/fc.c:1581
   nvmet_port_del_ctrls+0xfb/0x150 drivers/nvme/target/core.c:311
   nvmet_port_subsys_drop_link+0x1e8/0x310 drivers/nvme/target/configfs.c:1119

It's a real hang, not only a lockdep warning. I reproduced it with
fcloop by putting an msleep() before the put: rm on the configfs link
gets stuck in D state for good.

I don't think we need that reference at all. del_work does
list_del_rcu() and synchronize_rcu() before it drops the initial
reference, so an assoc we find on assoc_list can't go away before
rcu_read_unlock(). nvmet_fc_schedule_delete_assoc() doesn't sleep, so
just call it inside the RCU section and get rid of the get/put. If the
assoc is already being deleted, terminating is set and the call is a
no-op, which matches what happened before when the get failed.

With the same msleep() in place the patched kernel unlinks cleanly and
the assoc is freed from the workqueue.

Fixes: 4049dc96b8de ("nvmet-fc: defer cleanup using RCU properly")
Reported-by: syzbot+da94a51633758d13bd63@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=da94a51633758d13bd63
Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>
---
 drivers/nvme/target/fc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033..eecdffefa24f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1567,8 +1567,14 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 			queue = assoc->queues[0];
 			if (queue && queue->nvme_sq.ctrl == ctrl) {
-				if (nvmet_fc_tgt_a_get(assoc))
-					found_ctrl = true;
+				/*
+				 * No assoc reference here: we're called with
+				 * subsys->lock held, and if del_work beat us,
+				 * our put would free the ctrl under that lock.
+				 * RCU keeps the assoc alive until unlock.
+				 */
+				nvmet_fc_schedule_delete_assoc(assoc);
+				found_ctrl = true;
 				break;
 			}
 		}
@@ -1576,11 +1582,8 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 
 		nvmet_fc_tgtport_put(tgtport);
 
-		if (found_ctrl) {
-			nvmet_fc_schedule_delete_assoc(assoc);
-			nvmet_fc_tgt_a_put(assoc);
+		if (found_ctrl)
 			return;
-		}
 
 		spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
 	}
-- 
2.34.1


