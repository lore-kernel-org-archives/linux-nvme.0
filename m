Return-Path: <SRS0=YlYz=BJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED1C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2020 20:55:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB106204EA
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2020 20:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dWTPjUSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB106204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UWwUhqeK+wn2d/1kepZL8U5eOl69m7EuD4e3Za4qBRY=; b=dWTPjUSUue1qZFihT1ML/Y/SpC
	Niozh4kORYlFqGfytZbdmtjx5aKNInvz1Smu0m7nwWBqaYENzJApngpyZ+7qt9jMfCCBuVlKkaDAA
	ghiTn1Crc6j5RkJtnENaVw7qJr6vJOyTYgD/EpL+hR8DnF0QcS9SXwKboTZq79nhULWC2ddymgjWh
	8uLIkzaJhA3MqPRGouukgsBSmmTMibJB9M/FUmvFiD3JofzlwiqbU527YZ0s9F45BZm5Uo0QEr59U
	aLndcOIFQSZ1NZYxFVDS+zugIcEQld7s/JtxjG1IDSHfk9HpwpghyhGrIfI8QCyzFaf+pm1YC3MUO
	xmzfISfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k1FaI-0005tw-9N; Thu, 30 Jul 2020 20:55:26 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k1FaC-0005sx-MC
 for linux-nvme@lists.infradead.org; Thu, 30 Jul 2020 20:55:21 +0000
Received: by mail-pj1-f68.google.com with SMTP id ha11so5686296pjb.1
 for <linux-nvme@lists.infradead.org>; Thu, 30 Jul 2020 13:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eCqiFKrBZwhE2rascCXYzh/stm44cPTWoAZEh1GYr9w=;
 b=GaKmynOfPHSQNwXsqPHx+nNlC8IyD2XdKmbd/BN04fjoN2Y68BUTXxCrUQPGcCWJ9k
 Yinw/dbOC3sa5ZTMbep/A0rFzd+1e6UJ3+lEnwVyFZnGUgC3xQ9NC6azoSY4JzhfV7S6
 H+LcMWKcBGGNKkifxt1khuDVB2uMFfScDeAn138Cn2MvWoizM2wplNJLKBe+aaYGsyTV
 Y7h2cbZZ1SpS3n7J8S/JvsDCjIrhhYniiGlh1UD32mXs0l0kZTlfF98aPdeB2hqRslvt
 nakDZpgSjMA0TmNgpUChpJW8zB+8TYDA0q4VSPZbsN+wgGB25sGxaeorgOVsBu66P1By
 vKlw==
X-Gm-Message-State: AOAM530GXRpP1XTDQnhV4tD1+H8Rwc/o972N5MdRhdWxaY8wSyuOWZZL
 bzgpxFKOOVJQ3rXEEiYIJNH4YzVv
X-Google-Smtp-Source: ABdhPJx1p5harUCRUoocCxSdQ/lMgWcV9V50k/G/9o0pZlmQWyMwKzCh5cHYrr1RT7UjQY3r6o+j2Q==
X-Received: by 2002:a17:90b:19cc:: with SMTP id
 nm12mr896651pjb.144.1596142519211; 
 Thu, 30 Jul 2020 13:55:19 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:9d7e:b2ea:15f4:b0b0])
 by smtp.gmail.com with ESMTPSA id z67sm8374125pfc.162.2020.07.30.13.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:55:18 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvmet: fix a memory leak
Date: Thu, 30 Jul 2020 13:55:16 -0700
Message-Id: <20200730205516.20954-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200730_165520_741018_6FDB32D8 
X-CRM114-Status: GOOD (  12.41  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We forgot to free new_model_number

Fixes: 013b7ebe5a0d ("nvmet: make ctrl model configurable")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/configfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 74b2b61c773b..37e1d7784e17 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1136,6 +1136,7 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 	up_write(&nvmet_config_sem);
 
 	kfree_rcu(new_model, rcuhead);
+	kfree(new_model_number);
 
 	return count;
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
