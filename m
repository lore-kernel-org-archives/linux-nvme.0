Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A192CD13DE
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 23:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Zx7tNOQxheZFMtji4QfQ9WofDZ29ktBRsriqpgn1Kc0=; b=Og2+WmuF7hB1cR7dY7uQbyCpGL
	yU8Pd8iYU18XhKF29IXxmGjBoiGwVJ6da7RGzS59Aph7sjYRIlH1CiTzJQsanZu8q+ntwi/4JEmWD
	lVqdG8rHKCuR8FPFDWwJ8RF2RAIrVvilOdb0E67Lpz4JzBvpwQpRjZnUtAp3I9HqTcZXkhtVYEKb1
	GOzRAbfP8cdgH1CK9ggQMjMl8pJ5Qyxi6azIIv5V7pKsVFDWs0Ia8TTEpeedZUAgJ90hXX+NbtA4F
	AbIPhhcNZ2Tq6espM1J/NIt55YRBAG4Cftp9ZkOWgFFpkXNUaCYYPaUIp3Xjxyd/ph3hMyN8EyApe
	CGUTKLpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapN-000000066dv-0FRT;
	Thu, 30 Apr 2026 23:29:53 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapK-000000066dH-1Uxd
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 23:29:51 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so14809675e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 16:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777591788; x=1778196588; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zx7tNOQxheZFMtji4QfQ9WofDZ29ktBRsriqpgn1Kc0=;
        b=H/8wYcjJOHBuDIXx8UHKtYWpdqGQv628jDJZU+7BDDHKWsJgweSbjcoeoFmglqyg34
         OzplMSvygIig7u730GXPNWMOcAmZx+quvXWQH6kUU5OJpChz9zjmDTX8XZh2QkJoCtjF
         0nO+3cwxZnTypxiyEvcuE9EHRF2Oc0OQx3/IoZaTq4ehm74dks9XNj2LqNpGyj74SY2i
         tfjbXzBrTqGmrrAvtBwp2yEhCnr7DhZiO0NV8CweQTx0VwapGmEIkdr28mGIchninwrc
         MPG0gRctnZV+AOpJpEYjPWkm/EBwr89+PRoLh69QIksjliP3+bKARDjuerMhG+79MXJ+
         qQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591788; x=1778196588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx7tNOQxheZFMtji4QfQ9WofDZ29ktBRsriqpgn1Kc0=;
        b=lGLk11mhBP81pQa11rGFy/P/vngGHwzwIRFR1Z9kczFCzqEUpPxH8mvkIvF8SRHqRA
         dFjpVzAduKBTOIo5r/b5EpeJqlBOIvBnmjQzpU0CVR0ay/hiqfmufMIUKSWsjLDUiwSR
         wSSIFNK8MpdNWf1Gva5qrUHWC7HJoFma1ErCGRi8p8GXj1II2nQb8+hWryQzYmnsoT8W
         Aek3CyuoRZPuMnl6Fp16Q+Fg1cA7EuGFg3sp9gzI8r7egGPiBVOrWdwvyCQgd/CvqKa/
         4AMFcRm+N77OV0FGDtCl9MiI0WFEakxveMil5tHJgldBRInnICYaMox8rZ0jHc3LocyP
         a53w==
X-Forwarded-Encrypted: i=1; AFNElJ89Y/PmTrxhZKeDuEP1CdcMLn388IDofFsbL9gSfHGPBehBS3ILhgTlCEtjRY5mhTDeE95OdoRo1nkU@lists.infradead.org
X-Gm-Message-State: AOJu0YyK7MfCw6kuR5yV7iw23zkMmuTMoM4CmLVetcvIxIf/yz+z9wKB
	k25G8FAGU9CxEqybqMJCOS1I/P2BxtOdGGp7q13RFqIjHS1B7yqsW4yu2ZIPamY85zg=
X-Gm-Gg: AeBDiev6/kvJJz00enT36kJtdXBLcoceQzh8K4jeEW5gW3VsvpGD0Z4m4T9r6PlcUBN
	EAQj0vim14+zfVKO+GGGwaCGWgQxifQfWcuVzTE9fdedRL90yxoVe4qhAOypxU65/G8hp6A1kXu
	duchSQgGokr83cfN7ymbtfsth3EXH6r4YCzNL/qDp+CU8Q/kBwsyFfxy7jiFtJ3sIC0L+E6FKFq
	qzAIcNiY7Q/yDK7YQZ3EoEAPBrFsi2dqFchkC5H4bWICRqebM0ZLnVlQg/xdcgM5ZRzOjWXuxG0
	vWwTiYBmMNmpoUSYRezucSXi9WHWCVIm49lQ8C3N/DIDyy4FPkXZpMk6ELTyNnC6PBlFHzYTKnI
	TjPxxMkw2NCUImKCTw1tVsZsHrfHP6O23nzrtyGvvqv5IY4qpEzmCqO3rwnT5U6tjDn+nXEWRK7
	sSeuOUn6DoUL7MljdJI3GuJThHzkv25Iv+UsOvYwKXHTdo3uMphyqc5z12WCtOBYLwbgQ3VGr2e
	eNqK9ZP8yUkXufbbHBhhi2yF/R2fFAPrDw5Y3wVkxU986/2pHY=
X-Received: by 2002:a05:600c:8286:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-48a8eb61e2dmr8983925e9.6.1777591788565;
        Thu, 30 Apr 2026 16:29:48 -0700 (PDT)
Received: from dev-randyj3.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm11942715e9.10.2026.04.30.16.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:29:48 -0700 (PDT)
From: Randy Jennings <randyj@purestorage.com>
To: lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org
Cc: cleech@redhat.com,
	mkhalfella@purestorage.com
Subject: [PATCH 0/7] NOT FOR MERGE nvmet code to exercise CCR/CQT
Date: Thu, 30 Apr 2026 17:29:06 -0600
Message-ID: <20260430232913.129271-1-randyj@purestorage.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_162950_437410_27EA4D28 
X-CRM114-Status: GOOD (  10.11  )
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

This code is not for check-in or as an RFC.

This post is just an FYI of code used on the target for
a functional test for CCR/CQT for this presentation:
https://lore.kernel.org/linux-nvme/CAPpK+O03nHvHGESXsDDARz_kgbNkmeHmu-G3XWto7CqHtyVedQ@mail.gmail.com/

The code by Chris Leech comes from the NVMe Cancel implemetation posted here:
https://lore.kernel.org/linux-nvme/20250324102310.658007-1-mlombard@redhat.com/

Code built on:
v3 of the CCR+CQT patches as described here:
https://lore.kernel.org/linux-nvme/20260214042753.4073668-1-mkhalfella@purestorage.com/T
* 011e0880d366 - nvmet: report NPDGL and NPDAL (8 weeks ago) <Caleb Sander Mateos>
(which was nvme-next a few weeks ago):

Chris Leech (3):
  nvmet: put all nvmet_req.execute calls behind a function name
  nvmet: add delay debugfs file to nvmet_ctrl
  nvmet: delay requests

Mohamed Khalfella (4):
  fixup: nvme fix CCR command
  nvmet: Added debugfs fatal opcode
  nvmet: kill nvme controller when fatal opcode is received
  Force CCR operation to fail

 drivers/nvme/target/Kconfig     | 19 ++++++++
 drivers/nvme/target/admin-cmd.c | 11 ++---
 drivers/nvme/target/core.c      | 37 ++++++++++++++++
 drivers/nvme/target/debugfs.c   | 78 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/fc.c        |  4 +-
 drivers/nvme/target/loop.c      |  2 +-
 drivers/nvme/target/nvmet.h     | 17 +++++++
 drivers/nvme/target/rdma.c      |  4 +-
 drivers/nvme/target/tcp.c       |  4 +-
 include/linux/nvme.h            |  4 +-
 10 files changed, 166 insertions(+), 14 deletions(-)

-- 
2.54.0


