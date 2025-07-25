Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08870C87FCE
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jul 2025 20:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+7CxWng/6yV3C/vih/JoVMAM53+8hoZqlb7N702ZCEM=; b=2KK7sZ23jyPujrwTtheRxIvL4s
	JsONDHF8f7AbpRS1JXo6ee2771ISJ65MarWmhz6CWcmdlQb397q994RTfa+7Wzip5xL/v7SZVbZqd
	SUXah4LdCp7u5O5Zic4Rlz85DG5SgQvl44xdpVJVrLkGAHubHTrQW7i9CMhFJZMFMEsDVIq93fQtn
	ARAFbZxysUTyWzMxCs241qdJSws/mlluRbn4QJr04IrzsSZPuFLGOw89WzcENNFlt2Y49ipCK924x
	61v/Gykra6VS6gbnGi4EEshtcTZ5C1ZMsC9F6MOwqREIPoi40nUFjaAiPibvo68B0iKrSV5nsi+Sm
	FszAr6Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufPNJ-0000000AgVo-0erR;
	Fri, 25 Jul 2025 20:50:41 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufPNG-0000000AgVS-1mPZ
	for linux-nvme@lists.infradead.org;
	Fri, 25 Jul 2025 20:50:39 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-236377f00a1so23761585ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 25 Jul 2025 13:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1753476637; x=1754081437; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+7CxWng/6yV3C/vih/JoVMAM53+8hoZqlb7N702ZCEM=;
        b=c1FNXyY9KhT9YTGJRgiON8U8zQhzamNuIqWHpsYKIAs425D05IMB75433uVQOX5BEG
         9PyXas05lNTd+adFcmSBPweN8gBujpOFtzQ9RlpSPneFgGlrga+wjNSvhTuUPJo7AqU9
         kwZkHEGjFllQMhw7/CNST8mPr8+ozJu1sRC4Ow/GleYUets70u09fyp2FR9LqCvNkUdB
         P0sx25Y3pQfEEzha8wFzJzRwcRAw6PcNqZZJuC340T6dIVQ2UKvUNjIupgB1LV2Jp/40
         9+PzqJMZPHxQ1PfXnbpCbEXnUfxCSRZUv+SAlYq2+kTKg8CBX6UoQQt/C5MPWvFlAwUL
         ZAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753476637; x=1754081437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7CxWng/6yV3C/vih/JoVMAM53+8hoZqlb7N702ZCEM=;
        b=ep3CMD8gsJVEFI1PZPLkgNsYLF7OXWRSln02JrBNZIYADopN12163BXqyRfTGl3EEN
         QhYS3LyGzcgwweCIVUBiuALVYvmHQTUECODFZG091zG8dyrMNpNztxTWbiom8Gljat0+
         ZaiQNW0YsLMOowFTrw0PhIyLJuYWrFReHyLuF0tnDRxkpNzpAvvi1nKoIu5E4xUxo/3h
         FO3N3yRATtEMSuxZN0yswa0stCZSb3whCruf10/df7k52yckD167B2QN3lN5sdIaARp+
         U4iOwJpoGiEus+WV+qBMu9V1+CFtNMJHbQl9QUUJVs04XQuv0qNNoDi3ezPz8ob8UiVE
         U6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWWLneZyXwxlvqriBXT6kxurbXr+8ayFiH6gctDq02HH79JTfEi6OAVyRw9mYSFgL1PCrugtKD4g0Ub@lists.infradead.org
X-Gm-Message-State: AOJu0YzkVhR+YlIVAmdVlNFrJhgCKjGUBGmQ3tFU0KoltUK2xKKAeMFA
	BJXqXD0w7Dbo5UquoLGZRNM/G/rVhhjX/mDJD6RxubtmLDJKZMxs8a5XgYw7C/SfZ2E=
X-Gm-Gg: ASbGnctHTQyzeXVso33FfiFhaM533Y1KVkj3bbl7V50ejWj0u9S9tdHSkrTzEqSMZNM
	UnRw2Z10RsSfrxfnhSOJzKHxiVpezpKXMk5N23d/SCYNTWM5g0NeQlxPcqzHUzLJFPCC5iU6Q9B
	XystMTzkVtyB4OgYbtkVvgD2nbytlQn8UCgUI3U+h2DUYvOAN3gbkZuCb0P6ljb20o4ftcyXeeQ
	+9tkk7/JzSnT3sDrIf2mwuUwEVM1VzlTJUId8fVPHZZccO24kFhvG2dZ/4rQGpBVnjZRwO9bIip
	wa65QWvZvzbJatN0asvRvTaTVpoDSeSeRxosR74/t5JQvVm6F/0j/EUVTxYMbK+1hh01M1YCwbf
	gUSHidv4QduyaqRLq8AvmpvVxa0nOyKJ7915seFjcyK0jtg==
X-Google-Smtp-Source: AGHT+IEDQ87H8ajZgmrcoy7AQkaFkGRZDiUZ3CUFGkJjETMa1Gw2W0pltyotcDJxADSW+OypslSKeg==
X-Received: by 2002:a17:903:2345:b0:235:e1d6:4e22 with SMTP id d9443c01a7336-23fb3040f6cmr42762535ad.18.1753476637079;
        Fri, 25 Jul 2025 13:50:37 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23fbe5656adsm3725935ad.188.2025.07.25.13.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 13:50:36 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: Initialize discovery subsys after debugfs is initialized
Date: Fri, 25 Jul 2025 13:50:05 -0700
Message-ID: <20250725205005.1983426-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.49.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250725_135038_600659_4E215D9C 
X-CRM114-Status: GOOD (  12.00  )
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

During nvme target initialization discovery subsystem is initialized
before "nvmet" debugfs directory is created. This results in discovery
subsystem debugfs directory to be created in debugfs root directory.

nvmet_init() ->
  nvmet_init_discovery() ->
    nvmet_subsys_alloc() ->
      nvmet_debugfs_subsys_setup()

In other words, the codepath above is exeucted before nvmet_debugfs is
created. We get /sys/kernel/debug/nqn.2014-08.org.nvmexpress.discovery
instead of /sys/kernel/debug/nvmet/nqn.2014-08.org.nvmexpress.discovery.
Move nvmet_init_discovery() call after nvmet_init_debugfs() to fix it.

Fixes: 649fd41420a8 ("nvmet: add debugfs support")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 175c5b6d4dd5..b6247e4afc9c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1962,24 +1962,24 @@ static int __init nvmet_init(void)
 	if (!nvmet_wq)
 		goto out_free_buffered_work_queue;
 
-	error = nvmet_init_discovery();
+	error = nvmet_init_debugfs();
 	if (error)
 		goto out_free_nvmet_work_queue;
 
-	error = nvmet_init_debugfs();
+	error = nvmet_init_discovery();
 	if (error)
-		goto out_exit_discovery;
+		goto out_exit_debugfs;
 
 	error = nvmet_init_configfs();
 	if (error)
-		goto out_exit_debugfs;
+		goto out_exit_discovery;
 
 	return 0;
 
-out_exit_debugfs:
-	nvmet_exit_debugfs();
 out_exit_discovery:
 	nvmet_exit_discovery();
+out_exit_debugfs:
+	nvmet_exit_debugfs();
 out_free_nvmet_work_queue:
 	destroy_workqueue(nvmet_wq);
 out_free_buffered_work_queue:
-- 
2.49.1


