Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59426C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 24 May 2023 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/vkoZnjEiFEiaLxKlTRXPlr7NRnuoQjbavXFFmh9F3Q=; b=j3HdXBmPutNet7PxCAIhW1O7nC
	4Y2Yvw6uWv11u0aP2CJ0YETcZfeUPgC9iV9joQ1QAXajHtsxhNfKQtlbDrPT/qA91fRHM8jqk90RD
	ScUU8tbQ4hdRovin5BGO9lfSmj9M1HEbL5qH9fGrOAFjEthUcA+8Vz0smWCh6k9sjUx/kUxlgg34p
	iTnf3FdhKRA5D9IczU6B3CrjA3QNXsBr3+G1bgdnR1v66Q/45KplmAeMRQRVAw+A8RMRr7W1KmUev
	kVE93hvR7i4JJGC/x/kpG5VayOKrD7hqtId1mWvXyZq+PMKj8tpun6CT7K7pXx/EIkShMjcD+kEc1
	Ih/gQQxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1xoh-00EwEY-1d;
	Wed, 24 May 2023 23:22:51 +0000
Received: from mail-il1-x161.google.com ([2607:f8b0:4864:20::161])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1xod-00EwBE-0P
	for linux-nvme@lists.infradead.org;
	Wed, 24 May 2023 23:22:48 +0000
Received: by mail-il1-x161.google.com with SMTP id e9e14a558f8ab-3318bd82810so3592255ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 24 May 2023 16:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684970563; x=1687562563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vkoZnjEiFEiaLxKlTRXPlr7NRnuoQjbavXFFmh9F3Q=;
        b=f6dyEQqcXXYi+uHZOBnvWsmJyAtrsJ7bk2NGaUQYTpnXbFzZqqsmtLX2drgIgmgdxi
         sUzr7Ad409GEaFzIuRE/IzHqNWM3SXSKPbR8ChFV+/K2tHsh3kOdMkSHi5sA2bpW/lHJ
         2/hXWvzzhwXv08gxQpdjC7djBAL9GU8V14eqd7tmVPWOOwEYiuPNmuyI/YyqR3fYvlTw
         89D/IlozVaiYe5UjlitTKwUxZ/dP4udCz8gqDK82/xxVVQY3OPn3WlhP5aNRqtVjzlNv
         2cjBIiFf0vBG5uhJSqzhHduD4vfNa+XYrXVd1lbbZMhV86HCnXaaDZLx8rYeZjdSh+ho
         sR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684970563; x=1687562563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vkoZnjEiFEiaLxKlTRXPlr7NRnuoQjbavXFFmh9F3Q=;
        b=P3pLsN31eODZpUe10i7a2fmood7B0jmSCNAIi3wmOJuN3DuOKstDYtEXzQ6sASjf3j
         ktnXnumtEY8aBqUGCAanUi/F9Mucw0rIO3GKAv4XrGz/9c96KFuyI1QBn09W/JvqWYCq
         prSBK0b3f0kIGe7+ssnXDxDM/WRj8iRtR5alewM0KVbtKCz8DwbXchIPCFwlix91oNl1
         WxzQPPotXaYDzUqgbJIrc0AFztWFxY4rO9vGVI4lAhqSoat/Zxc6GP3+elS7Rp42Evau
         DAzFXbGhbIOYlbak6tdQ9zK5gOoLQI79KM6FXePQ/A8O9AVt1ax+AHlrqzQ+ECssYbhY
         avTw==
X-Gm-Message-State: AC+VfDwZZz886Gjah6gzba6Mjo/1ZkLUDe28L678bKFwMWb3Q0ZjvA4S
	RPECKnJnMeSG+IGawaxpZdojYZonlzSjnnMpqMkS43OA+5pODQ==
X-Google-Smtp-Source: ACHHUZ6XevUet1b7BxvB2/pGSPWikUrjITkm8U5DanGjAX+Q417S45uUZ4gFJ14At4EnWq+PLSLFOtMuz594
X-Received: by 2002:a92:d68a:0:b0:339:f9d:9f6b with SMTP id p10-20020a92d68a000000b003390f9d9f6bmr9466635iln.1.1684970563452;
        Wed, 24 May 2023 16:22:43 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id l27-20020a02cd9b000000b0041aad7130edsm7701jap.54.2023.05.24.16.22.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 May 2023 16:22:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id A599222278;
	Wed, 24 May 2023 17:22:42 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 9FB73E4009B; Wed, 24 May 2023 17:22:42 -0600 (MDT)
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
Subject: [PATCH v5 1/3] nvme: double KA polling frequency to avoid KATO with TBKAS on
Date: Wed, 24 May 2023 17:22:16 -0600
Message-Id: <20230524232218.1584605-2-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524232218.1584605-1-ushankar@purestorage.com>
References: <20230524232218.1584605-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_162247_182923_C6F3E550 
X-CRM114-Status: GOOD (  15.70  )
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


