Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AC6C7EE2D
	for <linux-nvme@archiver.kernel.org>; Wed, 24 May 2023 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/vkoZnjEiFEiaLxKlTRXPlr7NRnuoQjbavXFFmh9F3Q=; b=2gNPnAKgMS/C2u4kRXKvETDlMx
	zj+QDvy8FV3MD9epZ65dRUPKPxXJgmupfdsaaLYfU/UgXn4GpTsznybZ25PYsi3L06em2f/Xad8Q+
	6w5fMAkGyd4J89lspUxF8TcBXtNJRsOkv5aUCoJzOCGeTA6PwwfA+tw/6hetXFtwkR6mJlhMBWkik
	dUanqBVFw/Cj/Wcz4PZCEBLW1Cj9zw65Hp1gL5MCPsKVouYQLmu/7WkQYC9ZQHngxO45/77JrztS8
	3ZKkKsgJvJ67S2jahHFX6N03oRVEQFKcOzVbRQpDpKNTdxYRUBo4uWtVbzEvY+dtL+jJPMHQKXvVu
	Xbq5E1qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1uJn-00EUZw-34;
	Wed, 24 May 2023 19:38:43 +0000
Received: from mail-pg1-x561.google.com ([2607:f8b0:4864:20::561])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1uJj-00EUY1-1J
	for linux-nvme@lists.infradead.org;
	Wed, 24 May 2023 19:38:42 +0000
Received: by mail-pg1-x561.google.com with SMTP id 41be03b00d2f7-53eee18a192so652291a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 24 May 2023 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684957116; x=1687549116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vkoZnjEiFEiaLxKlTRXPlr7NRnuoQjbavXFFmh9F3Q=;
        b=H7En2AQwirw01gBOdgqkJwvaDSnZtlkcI9a696WMC2G+eyd9qV3GY9GngL1qr4T79W
         Oa9O/W/WajLBVQtlmyPSKLbxl9E0dJbwkPKeNYg+angMcqdEY38Gc7rP/3UY5f+UpStH
         cBSxVbUxTAlN4oPvUCKTPaCt0OcNDEvO/lxc3V2DJzdZjUJ/7OvRPWCONhd18GP1y+GW
         mI0IDLCj8bJQxu/dNISDiL3ll063GlbtW+UwfsYH/pSKZfA4Ifcf/vWz671NgSRkBH1V
         Y4hciZsHX6iBWgsjHm43GQeWFkna8ULFLhcNqIw+iTLFMJJOzN/t5e59G/dO79grDMYb
         +kcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957116; x=1687549116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vkoZnjEiFEiaLxKlTRXPlr7NRnuoQjbavXFFmh9F3Q=;
        b=iqoJhQ4kHrx5lnEc9Cv26Hy2u5LSSHBCi3Soo/fhIEAOksN+RJZBymKhS87U+EVyRK
         vMv1dcrBdfAQSNe/awTNCSH4U3eLnhTKozrQkvlJjRl2eI1ItrFygiYikKuODvbImwNF
         cjgVUd5dWsgbzBKXuMLJwbUvFEL83ZwN0rg8fwL6XmggOR07UjK9TnvLYKolcouxgIhJ
         oBbYwO+0VUjm5VILdcXi21C0FfIPmg5KGvmSbc3k9xhC5Dp9U9SxQ2iA3bJpRg88Ku6q
         dSXQpmtTw0pQG78VxPB4C3INCLGb4G4NtLSHMC2mQNrW77QXD0s+OIwt7AEW3IaxhwGF
         BDOQ==
X-Gm-Message-State: AC+VfDwKO5Gs9SPa+zRLLawqxoRuH6/VjR2fjQL0jzg3/rC275JY6lWv
	xFq4/wT/CUV36LUhQ0trpo8UVimNhDAAQVsN3EVD/mkULwzzgQ==
X-Google-Smtp-Source: ACHHUZ6CaBMWo2dA+3Glk23gJU4YgNFhNEd0a4ZEg0DFdq8BkHZerz5PPMYjO+dR5R8E12uBCzEgBdiyjZdQ
X-Received: by 2002:a17:903:1d2:b0:1af:d812:d16 with SMTP id e18-20020a17090301d200b001afd8120d16mr4958258plh.21.1684957115942;
        Wed, 24 May 2023 12:38:35 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ja17-20020a170902efd100b001ab01cf5a52sm961581plb.8.2023.05.24.12.38.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 May 2023 12:38:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 318EC221D6;
	Wed, 24 May 2023 13:38:35 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2BFBEE42EBF; Wed, 24 May 2023 13:38:35 -0600 (MDT)
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
Subject: [PATCH v4 1/3] nvme: double KA polling frequency to avoid KATO with TBKAS on
Date: Wed, 24 May 2023 13:38:07 -0600
Message-Id: <20230524193809.1360269-2-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524193809.1360269-1-ushankar@purestorage.com>
References: <20230524193809.1360269-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_123839_447111_EA79C9DC 
X-CRM114-Status: GOOD (  15.71  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f586a4808e6e..5ad2b9b0d3b9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1161,9 +1161,25 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
  */
+static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
+{
+	unsigned long delay = ctrl->kato * HZ / 2;
+
+	/*
+	 * When using Traffic Based Keep Alive, we need to run
+	 * nvme_keep_alive_work at twice the normal frequency, as one
+	 * command completion can postpone sending a keep alive command
+	 * by up to twice the delay between runs.
+	 */
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		delay /= 2;
+	return delay;
+}
+
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
-	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
+	queue_delayed_work(nvme_wq, &ctrl->ka_work,
+			   nvme_keep_alive_work_period(ctrl));
 }
 
 static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
-- 
2.25.1


