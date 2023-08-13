Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE17C001B0
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tUuuKbL8ydFNPda8N4HOTsW5STdP9ERZYuHURXlNIxg=; b=1+uCV6MLYDq6NBjNUnnhAnsjAK
	7dy1Q4sBNesuEt+KWlyoi7zcb1NhZXkU92FIbrteXP8uYWYZmwGkUcwEkc73OczwRGP/PjcFUmN2c
	/DSsXGi7DswVrVckkU0NvHG2JjwB9QPMMHmhn19FG6LjvtZowmDTed1jxlI5KA54cPqSVNQlZIYZr
	px9kF649tdn/DYdR8uCTvAU/8wXL9D8hEtVznCqxc5BaNUpYikpfEjDkOdCsngj/wG0rkuwoqJLN4
	lh8tMTvD024useL8uYP3oAGWzoCoSI9mv0pqpvDa1UzjJumsqqN7EG7DXGVUog1HH2FEXW4fcJ/gg
	y1lnzlpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVC8L-00FETS-0B;
	Sun, 13 Aug 2023 14:31:57 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVC8H-00FESB-0Y
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:31:55 +0000
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-94ea38c90ccso80317266b.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937110; x=1692541910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUuuKbL8ydFNPda8N4HOTsW5STdP9ERZYuHURXlNIxg=;
        b=ShD8eC3C235KdjsTch8KFruCZPks1jMpGNPwUF3CGzAZwAbgSkvpVavpWLhn8iUGGp
         MFTX49iAb03ZU00F6V7XSpyg6qTyoyBTrzAUhE8yH2ra0g+JRiZatEIz0GleV6XImIrP
         k9KVWwmoeP3CNcznMIlIwRKPB8HmNG76TcaYbI7i8ssPJ7zEIT9TdFr2XpF3IDQ7kTZs
         JNIhV55RtcJPBvZaotEp7WmL1MXMUT5O2xOBTu9qRRk/EiRvovvAONmaUN9bY96NgaVz
         3MeNL4yx+KpPUlhZ0uh6iflHI2/2uup5WdECNnl3eOXdGjoMqi8YLfRTNTYNL+zJDK3S
         jSrQ==
X-Gm-Message-State: AOJu0YyhoIO3P5XqLINk0Iq1whoplVkE5r6huNPT1UzKsaaEHWCPXkYl
	3DXMwKoefcmXARl+ErmeKZANV2PgOGM=
X-Google-Smtp-Source: AGHT+IF7AyJqz3aIfRpSbZ9xLZ1M+kSDJRrU7dv6kXD6bIh27hcxdNqbXzo9iNEUYDD7slY/fB5r4Q==
X-Received: by 2002:a17:906:74d9:b0:99c:adfb:713 with SMTP id z25-20020a17090674d900b0099cadfb0713mr5140735ejl.5.1691937110413;
        Sun, 13 Aug 2023 07:31:50 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id pj18-20020a170906d79200b009932337747esm4612773ejb.86.2023.08.13.07.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:31:49 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: stable@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 5.10.y] nvme-tcp: fix potential unbalanced freeze & unfreeze
Date: Sun, 13 Aug 2023 17:31:48 +0300
Message-ID: <20230813143148.12471-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081227-freeing-squeak-4a28@gregkh>
References: <2023081227-freeing-squeak-4a28@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_073153_207585_C9344614 
X-CRM114-Status: GOOD (  12.66  )
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

From: Ming Lei <ming.lei@redhat.com>

Move start_freeze into nvme_tcp_configure_io_queues(), and there is
at least two benefits:

1) fix unbalanced freeze and unfreeze, since re-connection work may
fail or be broken by removal

2) IO during error recovery can be failfast quickly because nvme fabrics
unquiesces queues after teardown.

One side-effect is that !mpath request may timeout during connecting
because of queue topo change, but that looks not one big deal:

1) same problem exists with current code base

2) compared with !mpath, mpath use case is dominant

Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1dc7c733c7e3..8d67cdd844f5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1884,6 +1884,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(ctrl);
 		nvme_start_queues(ctrl);
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -1892,6 +1893,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -1996,7 +1998,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (ctrl->queue_count <= 1)
 		return;
 	nvme_stop_admin_queue(ctrl);
-	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.41.0


