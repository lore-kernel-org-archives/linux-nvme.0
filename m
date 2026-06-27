Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C503C43458
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 01:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z/CmrupfxEbqvdymOr0KYrLCg1DOvL9/cDXxDowDgHc=; b=OsUlzAA25PemNfTZYOthNZu8Jj
	L7JKYwsBqxW7Q9fpwW1kH2iAj56WexkwOLCTnawXv95YjHeR0fZ7GbI8H6l9BPWuTJcEmC/Q2zvfm
	7h+HK91tVw5PQPBBNTWPN0c/nEwzZh5KoGq2+LKABszoyaixxwPOnCA0Kv3A1NFN+nUZ14Ia9pc4k
	VKaOJODk79F74joTMBdkLS5W6qfpG+BJ1zHyRnQg8alZepv0WxAr+oyByTFOJRSZJ3xTzDpWUsWNO
	dpE4p3n8r2y/eXqxpzbLaCH4HY89o0XylkdBT0n1gdNRZKu41B5DFIRQcJcnCXM9iBr75KaOkdje/
	+GT8oMfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdHVL-0000000C2u9-0vax;
	Sat, 27 Jun 2026 01:06:43 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdHVJ-0000000C2tn-28P1
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 01:06:42 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-37d46e0d246so778759a91.2
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 18:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782522400; x=1783127200; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z/CmrupfxEbqvdymOr0KYrLCg1DOvL9/cDXxDowDgHc=;
        b=otBwXOVTUN4QIaz2RBebfq7EOlgr/dqvatlWsgDGew3C+lul3or7Ld7AWM+ASvGCy+
         mDzaWM5x1RcB2gvqLtjkd5RuEgd8hBgSqoxFuaWB9qOCgniB6mi2A71DkzSZVSDSq7bw
         kieSPI8xncOXB8PRvySrZHnGzzy6hVIo8x7tJvOFRClV5Wd6mQKGyKSVPwg0yQ3lHk2E
         zduqYCk2yF5fpjF9S1AvTnuSVkjhYRmXbUJAC0Du4l6umf1iFYi8w/BbWtN0ekKJgxYT
         UOL4V7mr27SalMjMo2s4zJtZPtKjT+JTl/6HLAOtvQvdSiqViiVzQ9BcNZ2l7EJNFAPn
         fKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782522400; x=1783127200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/CmrupfxEbqvdymOr0KYrLCg1DOvL9/cDXxDowDgHc=;
        b=qJqvM5ICE5aze6ntHN/yI2I79RYgcS7Ni5EZoCJWGQ+wdvfG/JtMNu9vPlOTdcc5eR
         ufco/8QUgfeyVBbQUHHDuWuakcJR6rLj2IGDyC4ye+pT49Mi5bMU0oZBjCXEdGB3CLfl
         MSxjDOcvODwz2eWMy7wMOI0SPNqhriiRgj8oSU9wOba//8AaGh5/ig3bxgTGiM/QiPe2
         fl8xnuUOACFB8TQx0+0gk9smlNWFxY+FLJ7qkagRfaDzv7luO0P/de7l77af2Oq+6anf
         I76/+fQKA6nHABwRa167HufSSZxk1Kj94osLWxbCE4Tm2wW6lTx6fdu1kxZLc0ouUUoj
         T0pA==
X-Gm-Message-State: AOJu0YydDzXTorgEBn4/A8DjrWKA1Wao2Czg0gsfd9G+GrsHjHkPjfTP
	5NrQ9Y/WZLrfvY3OStkfuXKNQi6rsgGvnbucDE89MwqQggn35Y1EzLI3
X-Gm-Gg: AfdE7cncymvcnc0w+QFA2iU2QH+9B8RDdJlGcZb5PTXkfPYACC1ur1ABUMv+1KU9IJg
	ETCiIa2RBTN3pPqGKD/WLB48fYIw+lQzt032sOaoTMCi9zp9iJtpCZwniKhzYq7x7eh7/u4kAU7
	MT4/4JRH0gbxgK0wKtqiramdtiqbAMQZZVUhNxI9WHzGT4SQRf0+9fFxLrxcFXWgUHVhPVRtyah
	1WF/I9zUXWL1C3vD6U0YJYlGf1IVJbb+0yybH+auJRJ78SNi0MjBppehbXqlPFo5Fp4IDa2hqpX
	mC1Dsw4Vg+6J8Ldz3T/31f7qUU7bDDP75Idg4ylPG6mAn9UDbPSVnlazKZmyOuuuSo5DN2pAZtN
	xgV5ESsAZya7q9ZifChke9yyhzDg9ZVy+dlIoIgiDLIpYDfRSrZvO4hC24wwkPjOA1Kd6lcr7XY
	mUCXC38NqTVl5C+YU=
X-Received: by 2002:a17:90b:270b:b0:37d:edb2:830d with SMTP id 98e67ed59e1d1-37dfa1f3e14mr7957053a91.9.1782522400035;
        Fri, 26 Jun 2026 18:06:40 -0700 (PDT)
Received: from n232-175-066.byted.org ([240e:83:200::354])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b27dasm48028825ad.45.2026.06.26.18.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 18:06:39 -0700 (PDT)
From: guzebing <guzebing1612@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: [PATCH] nvme: make firmware activation poll interval configurable
Date: Sat, 27 Jun 2026 09:06:10 +0800
Message-Id: <20260627010610.47768-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_180641_601623_49BA7D5A 
X-CRM114-Status: GOOD (  12.94  )
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

From: Guzebing <guzebing@bytedance.com>

nvme_fw_act_work() polls the controller processing-paused status every
100 ms while firmware activation is pending. Some devices can complete
online activation in only a few hundred milliseconds, so the fixed
interval can add noticeable latency before the driver observes
completion.

Add an nvme_core.fw_act_poll_interval_ms module parameter to make the
poll interval tunable. Keep the default at 100 ms to preserve existing
behavior, and accept values from 10 ms to 100 ms so systems that need
faster completion detection can opt in to a shorter interval.

Signed-off-by: Guzebing <guzebing@bytedance.com>
---
We recently observed this issue while performing online firmware
updates for Gen5 NVMe SSDs in a production environment.

During firmware activation, the kernel quiesces I/O. Detecting the end
of firmware activation earlier lets the driver unquiesce I/O earlier,
which is important for the long-tail I/O latency of production
workloads.

Operation steps:
  nvme fw-download /dev/nvme13n1 \
    -f ./Inventec_G238B_NVME_LDD5902Q_MZWL61T9HFLT-00B07.bin
  nvme fw-commit /dev/nvme13n1 -s 0 -a 3
  nvme fw-log /dev/nvme13n1

Operation device:
  Samsung PM9D3a Gen5 NVMe SSD, model MZWL67T6HBLC-00B07
  Firmware update: LDD5702Q -> LDD5902Q

Operation results:
  100 ms polling interval: 3 polls, 311 ms
   10 ms polling interval: 24 polls, 266 ms

 drivers/nvme/host/core.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3b7a8f7a35426..784da06fee559 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -58,6 +58,21 @@ module_param_named(io_timeout, nvme_io_timeout, uint, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 EXPORT_SYMBOL_GPL(nvme_io_timeout);
 
+#define NVME_FW_ACT_POLL_INTERVAL_MIN_MS	10
+#define NVME_FW_ACT_POLL_INTERVAL_MAX_MS	100
+static int fw_act_poll_interval_ms_set(const char *val,
+				       const struct kernel_param *kp);
+static const struct kernel_param_ops fw_act_poll_interval_ms_ops = {
+	.set = fw_act_poll_interval_ms_set,
+	.get = param_get_uint,
+};
+
+static unsigned int fw_act_poll_interval_ms = 100;
+module_param_cb(fw_act_poll_interval_ms, &fw_act_poll_interval_ms_ops,
+		&fw_act_poll_interval_ms, 0644);
+MODULE_PARM_DESC(fw_act_poll_interval_ms,
+		 "firmware activation polling interval in ms (10-100)");
+
 static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
@@ -106,6 +121,13 @@ module_param(disable_pi_offsets, bool, 0444);
 MODULE_PARM_DESC(disable_pi_offsets,
 	"disable protection information if it has an offset");
 
+static int fw_act_poll_interval_ms_set(const char *val,
+				       const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, NVME_FW_ACT_POLL_INTERVAL_MIN_MS,
+				     NVME_FW_ACT_POLL_INTERVAL_MAX_MS);
+}
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -4798,7 +4820,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 			nvme_try_sched_reset(ctrl);
 			return;
 		}
-		msleep(100);
+		msleep(READ_ONCE(fw_act_poll_interval_ms));
 	}
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
-- 
2.20.1

