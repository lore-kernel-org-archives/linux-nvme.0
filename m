Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84ACC5321E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 12:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uDbSCRVb62WPuOUWEOiR233b1J5xG5lQox4Y5acq8D8=; b=xn9q6VHfQ0bBhivGU/Ei78EOZ6
	D4lhO5BYOGOx2dqkyzY53W6ProS1+2szyndlljfViiTZiJf0wblwHlvjDaZGiE62v+IujG+2AR7GH
	H8hIVpIADezN2q3bRrzZiXUMxuaUKCwjgyUrzPoU883jODBlZ6UPl27SrkpokiMY7sGkYC8KCQJZJ
	WTGJGiHRiOo9CZzPvwIiBr1oK3+GcZ4jNWLctXJyCD+/FBo2AmcjoBspZBROEexCcAeEDLp4OqYAS
	5XnItG/5RuFFGgBfNFSCrXvufF9amczc+IckWi4rGfYkO0NywEaE+ezQ3kSZ43IyuZUXEgb1eMKQv
	4hbcJASQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siYRh-00000007E4F-31GX;
	Mon, 26 Aug 2024 12:03:41 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siYRe-00000007E2m-2D1b
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 12:03:39 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-371afae614aso2241417f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 26 Aug 2024 05:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724673816; x=1725278616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDbSCRVb62WPuOUWEOiR233b1J5xG5lQox4Y5acq8D8=;
        b=o2OZKr5yReqQ03Ns4iqOMTSQXEycU6+L7F3lEGbHFL6LnS0lDqaLP9HowpmKQ8oCLV
         AUOsKO2jCSlU5OnbzS+5n2P7ccpXcwJnXw0CZiuU4M7q59AI9hszYP+YRDveB8SZeqlV
         6wsFJPq1hQXeyAUm4hMaW40NZDGnTMrfV+s2fyoNC+p5AxAjflIgyc+RT4o81IAp8skG
         RcIgsOWD7cypX5I7bCCWJAMiDpDsbR9yY9cdnt2ai0ZlXarBCgQKq9tHZNBGdYychemp
         1V0lw0EB1VURndxVr9mnPcB/qhm8zV05UuWhD6tdZFYQMLbyj+f3nnD5+FbvbnXdU3Jb
         vV4A==
X-Gm-Message-State: AOJu0YzIfDnYRZkLy4xTwxA77eG3qcT93xggZNM5q+RmFK6MutwQbR+l
	9t+hqccpAdF0Y60ITrDqTkyeDsNEaiMk0gwFCyXtjAVc5gtuJX+WD3vKig==
X-Google-Smtp-Source: AGHT+IFS26Rzkztx1cri9GxrLgCLMyZtUUSEShzsiTIOZLWptsAagw74YNwlAhFZV0EIOgPEvdWThA==
X-Received: by 2002:a05:6000:1c4:b0:364:6c08:b9b2 with SMTP id ffacd0b85a97d-373118c83aemr6336383f8f.45.1724673815832;
        Mon, 26 Aug 2024 05:03:35 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308141dc3sm10624464f8f.41.2024.08.26.05.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 05:03:35 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet-tcp: get rid of a high-order allocation
Date: Mon, 26 Aug 2024 15:03:33 +0300
Message-ID: <20240826120333.529128-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_050338_587773_D8031286 
X-CRM114-Status: GOOD (  12.82  )
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

Allocating the queue commands array leads to a high order
allocation.

The current size of nvmet_tcp_cmd is 704 bytes. Allocating
128 of those (default queue depth) means that we are allocating
an array of 90K bytes. There is no reason why this will be
a single contiguous allocation. Change the allocation to be
kvcalloc instead.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Hannes, I did not test tls (I wish there were blktests for it)
Can you please double check that nothing breaks? Given that now
cmd->recv_cbuf is coming from a virtually contiguous allocation
(which shouldn't be a problem as far as I can tell...)

 drivers/nvme/target/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5bff0d5464d1..ba50474c8afc 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1516,7 +1516,7 @@ static int nvmet_tcp_alloc_cmds(struct nvmet_tcp_queue *queue)
 	struct nvmet_tcp_cmd *cmds;
 	int i, ret = -EINVAL, nr_cmds = queue->nr_cmds;
 
-	cmds = kcalloc(nr_cmds, sizeof(struct nvmet_tcp_cmd), GFP_KERNEL);
+	cmds = vcalloc(nr_cmds, sizeof(struct nvmet_tcp_cmd));
 	if (!cmds)
 		goto out;
 
@@ -1532,7 +1532,7 @@ static int nvmet_tcp_alloc_cmds(struct nvmet_tcp_queue *queue)
 out_free:
 	while (--i >= 0)
 		nvmet_tcp_free_cmd(cmds + i);
-	kfree(cmds);
+	vfree(cmds);
 out:
 	return ret;
 }
@@ -1546,7 +1546,7 @@ static void nvmet_tcp_free_cmds(struct nvmet_tcp_queue *queue)
 		nvmet_tcp_free_cmd(cmds + i);
 
 	nvmet_tcp_free_cmd(&queue->connect);
-	kfree(cmds);
+	vfree(cmds);
 }
 
 static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
-- 
2.43.0


