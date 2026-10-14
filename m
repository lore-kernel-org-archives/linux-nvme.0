Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFA7CC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 05:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Te6l21hW9qV56/tTnd6h/0gZVDPhgs1uIbxUt8nEzU=; b=NUciEWnef3A81N8yPkcqTig+vG
	+OOz3QWtnKDd6nA7MZQeGYlVA58rgiFOdYsxp7ruO+6WSDriuEQm6va3nAT0OsqieojaPACOqj5EG
	zXUuj8/V7XM3ahT9uEkfcu9/N+FWM5zsoeD8m5MpAkpP1qAiBIqP557wYmya08Yz/qAwk+ZMqA6gt
	ddEReNKrTvz45NKhBMPrpnDarislFCyat4feXEXnM0U6qFKsEntZeXIABiPvWfuMCUtwf5NykoWPX
	fBkEd8a+VdaS4uSpq5WPF7lWKbO71Icd4UOQeaYAxIiag4ukWHThkVT3djgtgnh5jONW61O3CPlnM
	38BFb/+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGrq0-0000000EZLb-0BYH;
	Wed, 14 Oct 2026 05:47:40 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGrpx-0000000EZKy-1Z8B
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 05:47:38 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so1631a91.3
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791956856; x=1792561656; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Te6l21hW9qV56/tTnd6h/0gZVDPhgs1uIbxUt8nEzU=;
        b=RpLtYRWEBlDSBdjNfJLJ3ljODaRWedA3syNeaJEUQBx36ha8sVoajOgyQhQDshT7zA
         pUYYOYTr8H4WRk/j6YjLG2rMrAnzmLVcOrz1g/ipGMtIEmUkoougmtxxHLRtUaztucgr
         CFm/J8nezSoKFoPxF5zhIg/CdyDjyym9LyAOUUH3pfXi20j4b1xt04wdPZ9yLGnunuAn
         pmE602lfPShwI7qNJWADIdDmjwZigvFhtmK5TNwJ3xAop7KmwiqJiSPBPhzbp6NQhSt8
         p6PPucRfauAWH/P09h9DfbP0MrULRMfR9yfJQ0MweH+A4N4I1eB+gInWkPh/m1Q8H49O
         qXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791956856; x=1792561656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Te6l21hW9qV56/tTnd6h/0gZVDPhgs1uIbxUt8nEzU=;
        b=Az5QOJ0NEOLVJsg5Iw3M6fPHLYNWNX5y6tVuUe0LaPN69PSxt6UorRlvyODtM5VdrZ
         FUJ4CKlK6qh6j5WfM2jbMRtuB/tAcAxqOGF3lKPw0ga5zLz7z3bsYZpLUNPmTdqedSaI
         26A2ZPFirlI91qQWpXwpcAWM/oYfrjX7V0TQTJCp/v82ReTqai7fqqx7bCpYBXDtlpaT
         zqho4E7zAIgbSmG9lEZhQhTFOaNOIeegcOVW32Ua1Pw46UtI24Ni8qKkrDGFNKWV9ryF
         MCL0bpS/YsFKUu1gcV0sJonOZTVCpW9nXxHFHEzdKt7zUJBXKzFlA0KaCkp2YIBQz9Pm
         Etyg==
X-Gm-Message-State: AFq9FYL6/od2Fl/YBDxGeJFINXj6m17ycpTiF3C+50CV5gjOmJrXbTFu
	R35q9lzaAcPniUSe4ldd+ItPW+O9fPUjYhsRNfqJJBvfVATL4IxigTp+
X-Gm-Gg: AYBFou1hhWLkk6Rk7Sdb5Ca/8BxgvpuBFxVXFJnWiPGrU0DzvMGz0nzuwEVIzU76/Ui
	chAb6PPZlGib44G7yuw16s4foc9dUeLlYLWpOLCEWQJQUBZZeFrkYPPrwiEupIn5wlwem+x/nDy
	gOCGHm6HyC6OSREyYTN5KHwhfFeaMt9lkTFuO/tWT6glEusgBjZVxXr2KNTY2dL/v5bzlwHGBtp
	Y0WykYJRq1c9IZv0nABGmMZTmC1RcOwcPHnnUvOO6E/qzG8gOF7T9PyMQOt3WS+I26comsa/3ae
	aSOqh2FoS5/VA62LvMwAt+pSILlyUG5JxQoHUU1ImKGEqScecC+VaS/ErLek98oVjPh9qt7B/+h
	KO5hSihIjVpkbyV6iify1rUD1WlBFI1ZJsxC/zFXpB5lTtFvcBoStcPyGIdv9542VzFhLMmLmF7
	oDh23Nz4QWN6NSIiXs7ErQphcSMBBAe+EQR13K2q3dKSimyTIqYR4KdAMAjAevcBE1itXS/bzyd
	FWnexuftftzmkdENkLwlEAmk0Cd6wx/KhIMsbg0GNgDgOkzjwbb+pIS1/REQSETa86Fm8Msfy5Q
	p0lNtuBqZ66KJ/5v+NbUv03lbkNWZwSgRpcA1OWhOFVs5N1f
X-Received: by 2002:a17:90b:268f:b0:3a4:6e84:e7f6 with SMTP id 98e67ed59e1d1-3ab3a32cbadmr12480525a91.5.1791956856033;
        Tue, 13 Oct 2026 22:47:36 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f3db2f5sm2852219a91.1.2026.10.13.22.47.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 22:47:35 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] nvmet: take subsys->lock while force-reconnecting in nvmet_subsys_attr_qid_max_store()
Date: Wed, 14 Oct 2026 15:47:27 +1000
Message-ID: <20261014054727.53183-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_224737_416825_7C3DED04 
X-CRM114-Status: GOOD (  11.67  )
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

nvmet_subsys_attr_qid_max_store() sets subsys->max_qid and then walks
subsys->ctrls to force every controller to reconnect, but it holds only
nvmet_config_sem (for write).  subsys->ctrls is protected by subsys->lock:
nvmet_alloc_ctrl() adds an entry under subsys->lock, and nvmet_ctrl_free()
removes it under subsys->lock with list_del() + kfree() (not kfree_rcu).
The free path takes no nvmet_config_sem, so the two locks are independent.

A controller teardown (host disconnect, keep-alive timeout or fatal error
-> nvmet_sq_destroy() -> nvmet_ctrl_put() -> nvmet_ctrl_free()) can
therefore list_del() an entry while qid_max_store() is iterating the list,
corrupting the walk.

KASAN, concurrent "echo 128 > .../subsystems/<nqn>/attr_qid_max" racing
nvme-loop controllers connecting and disconnecting, panics in seconds:

  BUG: KASAN: null-ptr-deref in nvmet_subsys_attr_qid_max_store+0x10d/0x1b0
  Read of size 8 at addr 0000000000000090
  Call Trace:
   nvmet_subsys_attr_qid_max_store+0x10d/0x1b0
   configfs_write_iter+0x1a7/0x250
   vfs_write+0x5df/0x940
   ksys_write+0xfd/0x1e0

(also seen as a general-protection fault dereferencing a LIST_POISON
pointer at the same instruction.)

Take subsys->lock around the list_for_each_entry() loop, matching every
other subsys->ctrls accessor.  ->delete_ctrl() only queues asynchronous
controller teardown, so it does not re-enter subsys->lock under the loop.

Fixes: 3e980f5995e0 ("nvmet: expose max queues to configfs")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
Tested-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/nvme/target/configfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 1111111..2222222 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1683,9 +1683,16 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 	down_write(&nvmet_config_sem);
 	subsys->max_qid = qid_max;

-	/* Force reconnect */
+	/*
+	 * Force reconnect.  subsys->ctrls is protected by subsys->lock
+	 * (nvmet_alloc_ctrl()/nvmet_ctrl_free() add and remove entries under
+	 * it); take it here too so a concurrent controller teardown cannot
+	 * list_del() an entry while this loop walks the list.
+	 */
+	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		ctrl->ops->delete_ctrl(ctrl);
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);

 	return cnt;
--
2.43.0

