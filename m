Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12022606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mGIuEOs+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IBUDF8L1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=IuDvY+GZo871EJkCLit2ojV8/CoV5VnvDfBzzstEvUM=; b=mGIuEOs+60r9GHn/V0oMuKLWYp
	jtimfYxAtvxT8lPznMht9R6VMGVLm0KJmxm4gTWZP/nXWHXSvWkDLNy6Hr156by57OSBdwcOIG4+u
	YJ9jeyQ2MIUthV2bIXRQYzYGb4NUY/X7hsPx7LCnXBmqCx1soTgYdrV2pSYl1joiF2iOujQYPw03B
	8whQPlWA1AWFYTOsUrdQUfZHrPnpPtSHrDGzZBsCMNaR76sSGGnt/4pyD6RXvRwO81DnSqRWf2ctb
	RZ3iSugll2py6dAl6nhh5vJbbdiZPhceIElNYVXzL0XPwTUMFLxtR4OwpbhdZsklpGWm0tGET77IK
	QctCunng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKDZc-0000000GEr0-1gJN;
	Fri, 23 Oct 2026 11:36:36 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKDZZ-0000000GEqg-2nXL
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 11:36:34 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso467722a91.3
        for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2026 04:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792755392; x=1793360192; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IuDvY+GZo871EJkCLit2ojV8/CoV5VnvDfBzzstEvUM=;
        b=IBUDF8L1VSUjNl9hLh6Nrv32qa2OQGd5OdsZgKNyOzbJcP+OKrke1SL5wsxQEEksbP
         NTo2PVyKrqzYaOLxpEmgglqQk+Blix5PgdfvT2Um2KhjRfsLC8EmcOKyafFgX930SJTd
         VyY7aGDb6yXZhotPngh6FJ84auhbAg8UC7B6/s857vkvfKJKEgpmefB99aLSm30hlBy9
         loPPZ0dVK53FJqvWbjKZE0kQbhg+SntuHfT8kLAQOr9sPakonSsTLk+BRmBt1o74Hw0X
         DEBJ0rdH3RsONSdoq0mTxelp8/HHXrerFDgrVr6c46dRFtZPoO/N7WpTCDjVr9nnAiiD
         po9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792755392; x=1793360192;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IuDvY+GZo871EJkCLit2ojV8/CoV5VnvDfBzzstEvUM=;
        b=wFcOTXw67wQgVh12LVTLdZ2+YebR68IFVT8UKzI88bTev9Xpxh0dFMNco9n9yoWcKu
         lzrNe/NScU8/r8hnB1JctVAKc8QjigcV8ArMmGZH5xx/MaataeiJJzB/+D1H7FL4h8Wn
         Xb29fOFEH0tzq2T5dNuP/3BrgmUVXv9UjNyAeMPhTbkxFL56fVVleo+qvnAcBBYzu7S/
         XwENUN9jdZB5yAzsGNpMNYD6Vpf9nBiNuH+4nJFj3wYBo/7Vr4L0tw3oiCuEUMlAVDbF
         QClOWsQur4x5Py79EvzxwNcZgL6fryhEHwtDjHywjkzEmEOdPMPx/daRaVJ696Jam4bG
         M3YQ==
X-Gm-Message-State: AFq9FYLQZe9SkPk4jVnWjl22CyA1QAIR9P+I7i351qEUrzzPKuaQC6hi
	AnFaQSAAiSd3Uoxd9Rl+LxTDbGTtd5NJwwf1PtecPUTsedwFxMSqRRpESH+MW/4r
X-Gm-Gg: AYBFou1u7NJ2oRS5313bOy5R2t6bzKhelwLhsQwM9g7UYRAu0avW3JPTOS12fWWMoZw
	YSynbdng1LTqrgObPtZKr9QooP9mA14uazhT+KHKQi5S1goyrMoI2r8HmFHNVsyL9hrvEZW4+4O
	3BZ3EvjRrhsxz61bu1DaoTQk31toi6RTr/BlGB3z9GuH+Iw+lX9vmVKGnctAjKOMf42yTGGWClP
	HdDUp+bewwGQSJWUlp8YPrXYBX96Z37mR1Ex2T0WE6xyT0XAFtvYDKKCWeB7fC+wQKdWwLIXuod
	OhhPn8BOkTk22VjweLfwjHtFsk1os5ivgr6QhQpBByROrX/MBO0rTxYDK+4qrbHmpgQEGXBmm9s
	qoAzkUW2qE4ZeSlqi8E91e5kBVdpaPQRbVCFP7NwjwS3eW2Ztik0JFZRjx6xLwsfBeKg27CAnrb
	7oF1jZTJVMI+6zK5/qJsCU/VL0imIOV4F8Fyj37lHnmTIFwF3yVN8J87GoVoHnJWN6EqI/qIA8x
	E6zss7nbivu4blu015tS5LNH3HW92YBOZoRK1dUvBZj2/LkABQ+CvgZwR1JedI=
X-Received: by 2002:a17:90a:d40f:b0:3ac:9a5e:9cde with SMTP id 98e67ed59e1d1-3adce02f85dmr1515815a91.30.1792755392224;
        Fri, 23 Oct 2026 04:36:32 -0700 (PDT)
Received: from [127.0.0.1] ([152.136.45.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b3dc41dsm9276295ad.59.2026.10.23.04.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:36:31 -0700 (PDT)
From: Qing Zhang <diasyzhangqing@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: protect nvmet_ports_list with nvmet_config_sem
Date: Fri, 23 Oct 2026 19:36:28 +0800
Message-ID: <179275538809.275862.8334230595898232727@tencent.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_043633_730845_DA8AA1F6 
X-CRM114-Status: GOOD (  13.13  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>From 554233f4165842a0a104896c30ed4d2e89c11931 Mon Sep 17 00:00:00 2001
From: Qing Zhang <diasyzhang@tencent.com>
Date: Fri, 23 Oct 2026 19:29:28 +0800
Subject: [PATCH] nvmet: protect nvmet_ports_list with nvmet_config_sem

Readers of nvmet_ports_list (e.g. nvmet_subsys_disc_changed()) hold
nvmet_config_sem and assert it via lockdep.  The writers --
nvmet_ports_make() and nvmet_port_release() -- do not take the lock;
they rely on the parent directory's VFS inode lock for serialization,
which is an implementation detail of configfs and not a guaranteed
contract.  Align the writers with the lock the readers already require.

Also move list_add() in nvmet_ports_make() to after the port is fully
initialized: the old position published the port on the global list
before INIT_LIST_HEAD(&port->subsystems), so a concurrent reader
could traverse uninitialized list heads.

flush_workqueue() in nvmet_port_release() stays outside the semaphore
to avoid a lock dependency on nvmet_wq.

Fixes: b662a078576e ("nvmet: enable Discovery Controller AENs")
Signed-off-by: Qing Zhang <diasyzhang@tencent.com>
---
 drivers/nvme/target/configfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b03b5d1c2dc3..75cb9e63025f 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2009,7 +2009,9 @@ static void nvmet_port_release(struct config_item *item)
=20
 	/* Let inflight controllers teardown complete */
 	flush_workqueue(nvmet_wq);
+	down_write(&nvmet_config_sem);
 	list_del(&port->global_entry);
+	up_write(&nvmet_config_sem);
=20
 	key_put(port->keyring);
 	kfree(port);
@@ -2070,8 +2072,6 @@ static struct config_group *nvmet_ports_make(struct con=
fig_group *group,
 			port->ana_state[i] =3D NVME_ANA_INACCESSIBLE;
 	}
=20
-	list_add(&port->global_entry, &nvmet_ports_list);
-
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
 	INIT_LIST_HEAD(&port->referrals);
@@ -2105,6 +2105,10 @@ static struct config_group *nvmet_ports_make(struct co=
nfig_group *group,
 	configfs_add_default_group(&port->ana_default_group.group,
 			&port->ana_groups_group);
=20
+	down_write(&nvmet_config_sem);
+	list_add(&port->global_entry, &nvmet_ports_list);
+	up_write(&nvmet_config_sem);
+
 	return &port->group;
 }
=20
--=20
2.43.7


