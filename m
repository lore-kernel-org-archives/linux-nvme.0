Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E3BC77B7A
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j3HCSioOeJXFSPlCibS27441TM6Kh7PMK0gBVRq2cxs=; b=IvKDxvXqh3WaYoGab3DGzcRN/V
	fVXPSvvriAcpsaYMJDN3j8BicDn2OpPM2Wak88bYpUuQQ11Hpj5S0eIUyWhZkpJkFNBAF/OFDyjVw
	8KmeMF0RurqsmsfR3fcjETgTxOFmS7rE4lBS4/LSiUd6pSDN5xxberZiK34aIHExHHpasB2r8cNap
	GVDEESJt5BUa9BxAdAkoD6hZ4EzcV8/LK6qjUJ35ES7YrGPJPHVgwoFnKnQjaa9DyFC7XufMiNTtR
	UcQZkPnqpTL92aLWxCSSynebjXZl9rBOJAmYtYZDV1/btvq+i6gcl5eMPYkmFgNj5GAbyXG2F39Nm
	mfXRVg3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poXle-000KrI-0b;
	Mon, 17 Apr 2023 22:56:14 +0000
Received: from mail-qt1-x863.google.com ([2607:f8b0:4864:20::863])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poXlY-000KnQ-1D
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 22:56:11 +0000
Received: by mail-qt1-x863.google.com with SMTP id fv6so13859263qtb.9
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1681772166; x=1684364166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3HCSioOeJXFSPlCibS27441TM6Kh7PMK0gBVRq2cxs=;
        b=dx9w6Vub6c7WLUqs84MDQdGorR1EcHMdSakqA0ofRvMKNLYUG9rJzzL8ZehATja+Dz
         cMxY4xw2llR50NXGXFhHTN0K9+F8lTA9aMsvx/VMzdmlm6ZU61vN9eR2Iae3v0/wiy2C
         7MZwKAgZKihgCkJcUNsFtu1ypVJCOI/idYnkXT9A1DfAmlQnt2zWnsP8q8uujL8JJxog
         d2QRZo9/8hf22svQpAJxGsI8ywPXfPD9VGsdwg5eWR5ymL6SwLZMtXPboChV5oOh1rE6
         JEQVkNmEvGDmbGxYCKLuogOa8SKzm3dT+fMCKIMON84kegv2wNqHvJk0P+ZEcBpUsgJW
         oCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681772166; x=1684364166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3HCSioOeJXFSPlCibS27441TM6Kh7PMK0gBVRq2cxs=;
        b=lkyhynzunLJpl4hhjoj0/WytRY0VOuSxzGfHRwWatPsbShiEX0k1iPcarkk6tNBO1N
         cZ8I9sXv5SKysWwfmoGM7Mi8138tGX95TPNfnJHSfk+n4i7FfYC+yXB3KKpBG60T+kII
         52dV5kE8eKUhwiVGB4pIQmMReVk9M+lkn7S4/X5SdxYQt9iIlsKJNu6mqcp7rokcdv3Y
         5Qoo5qECRzZbTb6FN/XNJTFcAuLWkG4rC2BmxMN+xl1JLrKwcTAJFryXOQm1LeWMIDHO
         b1+fRc+tY1LGv2sRGVEHf1mD5YMt4WoJidLSk9LxoxUR/9VJI+DMiQI42Wob5oD4HcQ3
         J4Kw==
X-Gm-Message-State: AAQBX9dZ+MebmLNTAbjlGJSwKvBVccZT0L3XW2yJ2pZJozlBjlNz+AmQ
	JcCSwt0pSAHWFepqGBw4gav7iuKf5C9FPIz8NYv6DVi/fbPSXkxklw5VfSylL9UAnA==
X-Google-Smtp-Source: AKy350aKJXli+YY0NeLx3VuHP0uMddhxSNdpAX3ImwBwtVitBIyJWJ+eWzArgZgegZy09WMY+pqlvupkJRG0
X-Received: by 2002:a05:6214:2025:b0:5cc:75c7:8f19 with SMTP id 5-20020a056214202500b005cc75c78f19mr21271578qvf.10.1681772166466;
        Mon, 17 Apr 2023 15:56:06 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id e9-20020a0cf749000000b005ef4398f1dasm4278751qvo.55.2023.04.17.15.56.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 15:56:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 8BA6222193;
	Mon, 17 Apr 2023 16:56:05 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 7E3F4E432C2; Mon, 17 Apr 2023 16:56:05 -0600 (MDT)
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
Subject: [PATCH 1/3] nvme: double KA polling frequency to avoid KATO with TBKAS on
Date: Mon, 17 Apr 2023 16:55:56 -0600
Message-Id: <20230417225558.2890062-2-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417225558.2890062-1-ushankar@purestorage.com>
References: <20230417225558.2890062-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_155608_444076_8E83DAA7 
X-CRM114-Status: GOOD (  14.29  )
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


