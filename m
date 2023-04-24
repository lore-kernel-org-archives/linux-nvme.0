Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B81BC77B7E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 23:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j3HCSioOeJXFSPlCibS27441TM6Kh7PMK0gBVRq2cxs=; b=vfFL11XS8/fNccJ8s4bVnHVA/r
	0GMN5F0guZauPyDsllLFRklBbnn5UFqlhSlZ0GtwcbC15RR53fQRuWHvWeoVRxBkrMI++ezLAO7BE
	7CJ/bNwSDdPNDiNNUC/l5Dojs0c2pP2nMThIddByvyX3QtGCCt6fFYJObwUDttpBKBu4kQkg1p/uh
	4T0GsgymEuOazguNMIe9jv/5CeAfEk4hdLquJBl8IGZw1naWwNwBqQmYZqLN14YYH9dD4HpLW9kpP
	fkqKzMLoQgPEHm4RRSqEk4wjrVwxt6Bdsx/JyJcVtvJBlBC2jbLs9AgYmtAjNgUmofCD3HtzXqh/b
	hR4FRxtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pr5Wk-00HQ4k-2f;
	Mon, 24 Apr 2023 23:23:22 +0000
Received: from mail-qk1-x764.google.com ([2607:f8b0:4864:20::764])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pr5Wd-00HPzu-0a
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 23:23:19 +0000
Received: by mail-qk1-x764.google.com with SMTP id af79cd13be357-74e00fcdec6so269569585a.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Apr 2023 16:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1682378592; x=1684970592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3HCSioOeJXFSPlCibS27441TM6Kh7PMK0gBVRq2cxs=;
        b=KEw+4Gd3RN6bkTBhmEr0szOWK6R8WckAccXSoLav3reIq+FT/1Qtfic325PhWjdDHt
         SrIgmAbpluHW7W/HlfHvYNXK/xM3LQSVv9iyg3vwNZ/GZLX7b0Gd75L6REx62i9lnKQP
         XX4+MjxXxjeaVTH8P/ymZJzS81Yywo8zMR+HPXkyeSi3FXuHQe++vRqrdBtf3rJfIfYu
         nkpFKs8FElcG+3W6XJoZIC+q2i2w9RkX52g9uovNWOHGfXSIcodZdFMUCzw6nuqMn+pB
         pRUUKWw3kvoViB/JxweYUjNoqG5t4pGNrQzWpplPGGdz7Y/p1CZGlbHtns14QCzFiwHL
         u8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682378592; x=1684970592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3HCSioOeJXFSPlCibS27441TM6Kh7PMK0gBVRq2cxs=;
        b=cGTkSByRZnnYrAzuvF/6Eoj5YqCpCLtWuOMpqIEVZxSSKKSPP/BUTYtFIglIiqxQrY
         Vr9CAVjdH0mQHmB5sKW2cDgpZL6e6+bscqBn8br+3dytXUO4TNKSzhIqol5JvkwB0fz+
         SaRvD47ompnpnsbo6Z5b/4KTqKWbvVM6iF4IbSDjhKD91peqWP7F70cMsIkwlC7cy/qw
         Qc30ZPE0y7QoWTYhXKemqUyXNDTFjqUXti3qNh7nfS3Kn8NBlwB59Y4e79gIY9I4J8wi
         Fn/X6QGQXk1riDFmG1O8hnI60ffwYFjbg8UmxQF9Dp1oRCcKQ6To9Dk9SHvCE6xJFp56
         awEw==
X-Gm-Message-State: AAQBX9cb+YyYi0u2g+qqZGEGLbJBh/SODo3rftdZvryiStU3ZZzjTosd
	np50oOoRp+qCHxH6+t+RMhARgPKrtR1dnBXnz6uFBoidkwtOEsTygqmXbLybYg3q9Q==
X-Google-Smtp-Source: AKy350a7Uyy9GzS2jYsa5ypKG12h7jqfVWFNilSBLgsbtW0mNeAhaEXpuuYdbnVGkxw5h8IOMzPr3EAkTzCS
X-Received: by 2002:a05:6214:5184:b0:5ef:5245:df77 with SMTP id kl4-20020a056214518400b005ef5245df77mr23856253qvb.35.1682378592474;
        Mon, 24 Apr 2023 16:23:12 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id qh29-20020a0562144c1d00b00612b696b6bcsm151128qvb.64.2023.04.24.16.23.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2023 16:23:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 93206221A8;
	Mon, 24 Apr 2023 17:23:11 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 824F6E40054; Mon, 24 Apr 2023 17:23:11 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/3] nvme: double KA polling frequency to avoid KATO with TBKAS on
Date: Mon, 24 Apr 2023 17:22:23 -0600
Message-Id: <20230424232225.1975793-2-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230424232225.1975793-1-ushankar@purestorage.com>
References: <20230424232225.1975793-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_162315_624419_CD13F037 
X-CRM114-Status: GOOD (  14.56  )
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

With TBKAS on, the completion of one command can defer sending a
keep alive for up to twice the delay between successive runs of
nvme_keep_alive_work. The current delay of KATO / 2 thus makes it
possible for one command to defer sending a keep alive for up to
KATO, which can result in the controller detecting a KATO. The following
trace demonstrates the issue, taking KATO = 8 for simplicity:

1. t = 0: run nvme_keep_alive_work, no keep-alive sent
2. t = ε: I/O completion seen, set comp_seen = true
3. t = 4: run nvme_keep_alive_work, see comp_seen == true,
          skip sending keep-alive, set comp_seen = false
4. t = 8: run nvme_keep_alive_work, see comp_seen == false,
          send a keep-alive command.

Here, there is a delay of 8 - ε between receiving a command completion
and sending the next command. With ε small, the controller is likely to
detect a keep alive timeout.

Fix this by running nvme_keep_alive_work with a delay of KATO / 4
whenever TBKAS is on. Going through the above trace now gives us a
worst-case delay of 4 - ε, which is in line with the recommendation of
sending a command every KATO / 2 in the NVMe specification.

Reported-by: Costa Sapuntzakis <costa@purestorage.com>
Reported-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6c1e7d6709e0..1298c7b9bffb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1150,10 +1150,16 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
  * 
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
+ * 
+ * When TBKAS is on, we need to run nvme_keep_alive_work at twice this
+ * frequency, as one command completion can postpone sending a keep alive
+ * command by up to twice the delay between runs.
  */
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
-	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
+	unsigned long delay = (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) ?
+		ctrl->kato * HZ / 4 : ctrl->kato * HZ / 2;
+	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
 static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
-- 
2.25.1


