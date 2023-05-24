Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A75FC77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 24 May 2023 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y3FR7irv3GbFGpmHEDK8qss7yTibxYKN45y+/57jXeY=; b=VV1JhEcAnxFA2tiDVHMpUzt61N
	pWTJXm7owal7K1EFmxb0YSbsgp8z8JTOe7XSnJEA8SyAZc/XynQL2knl2W8VQXwoGWuKht/3cUYvZ
	0J8E8qyScK/XMt48Tx4AH/PWhtq/8KaSY2tG8o8pK+x5ErmwLbSfxOJIC/KLezS3uZ90MJai7hmo3
	eqUQYp0Uj2IIsJPcAu/gtGwawyq+aP/OKX4OKG6vBCQT4YuwYVrSWk1jCf+DVl3aXX8K3Q9U/LH7V
	nyVGuvIfbd/5qXUj/EQs8uTDpFQYhE7K7r+oYEKBp4YlJcXZV+ORD9aHX3OgSiihcPi4wk235JJk/
	pEEPFJfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1uJm-00EUZX-1r;
	Wed, 24 May 2023 19:38:42 +0000
Received: from mail-io1-xd66.google.com ([2607:f8b0:4864:20::d66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1uJi-00EUY2-1R
	for linux-nvme@lists.infradead.org;
	Wed, 24 May 2023 19:38:40 +0000
Received: by mail-io1-xd66.google.com with SMTP id ca18e2360f4ac-76c636b6306so108739839f.3
        for <linux-nvme@lists.infradead.org>; Wed, 24 May 2023 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684957116; x=1687549116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3FR7irv3GbFGpmHEDK8qss7yTibxYKN45y+/57jXeY=;
        b=D5XqzeFqLwGaLMZVO8ASqbKSu8qNzhsPrzXjphjteXJ1QHS+Km7cP+QQ2KXcBgkpo1
         8ju0FZ0zfVM7hzCrtbNiyzeWa34otvJdSIwcF5q09P8/oj0mXQ8WgvSWuAil+zrZKXVK
         WF+P5LbyQP73JPUbVGmOUb6gbt4gL/kE0HH5acjsqBCGpUL8EEJ1yv0ebyCwUhIEXPtf
         IU2Q6Rh7VOpNMXni3zJkmc/KKTyod66x/lHRF6F91ieHErll3e9xGDBuxogoZbXv9Dv6
         l8K9VIIfrVrgOfMueA8p/XQqQ6J3qzDAzC5JQu0x7ysj8dNYvQCb+04iYxyXMv/+UnR/
         NWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957116; x=1687549116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3FR7irv3GbFGpmHEDK8qss7yTibxYKN45y+/57jXeY=;
        b=Zaw/w1YxSagiRqXvSwZEqbL+VDx6Nlc6YrV2+h3jQI66JMmKsYkyLVmUNgeDpuLOR7
         XOEr4tO97/8f+WEDSbay+cJ+7SPPaXLq5cv09lfzrJEmvuGKx1pgo84tUe1dmG0bCZ7u
         xn06wVDkAFCeBVuPxNhV+sFBSkccmeJUX0/4n+HfJW52ptYtiEluyzpCpmtVNoepBrok
         Mwo0hP3eONxXkD+9ETGHFTGUbe32oewQ5g7Bbwp24lT4UCILnXH7DpHTNgpDnom6IFqn
         gNc6RSZTSa2UUDiDzkW+h0QK0HZi2uodYgeFZ2oeb0U6jA4BvIX0nBvfKVUTa0dns6mD
         A+SA==
X-Gm-Message-State: AC+VfDy03TUIbiI6p6FYbXCQk1ygdWF7d3I9mfcugL0/L1VRr45g91/P
	6YFi8BSMCpEjoJlbgul/SHixXe3fGvo1VZs0/4Adw8+wSeGvGGd4rXVafZvmuLccxQ==
X-Google-Smtp-Source: ACHHUZ4DZjyLk/e7ZblK++PtiA5pnk3HOdwUHAVxV8EzuheA2jqxcNvslx60OjqYrNiRUqlfWAmkBxon8DMV
X-Received: by 2002:a6b:e204:0:b0:774:9b75:b463 with SMTP id z4-20020a6be204000000b007749b75b463mr783677ioc.7.1684957116093;
        Wed, 24 May 2023 12:38:36 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id n11-20020a5e8c0b000000b0076c67a68ff4sm243832ioj.18.2023.05.24.12.38.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 May 2023 12:38:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 2E8EB20B59;
	Wed, 24 May 2023 13:38:35 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 29F3FE42CC3; Wed, 24 May 2023 13:38:35 -0600 (MDT)
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
Subject: [PATCH v4 0/3] keepalive bugfixes
Date: Wed, 24 May 2023 13:38:06 -0600
Message-Id: <20230524193809.1360269-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_123838_844204_B73371DF 
X-CRM114-Status: GOOD (  10.48  )
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

While reviewing the Linux KATO implementation in an attempt to better
understand the current NVMe Keep Alive specification, we found a
few issues in the host implementation that could contribute to spurious
Keep Alive timeouts being detected by controllers.

Changes v3-v4 (https://lore.kernel.org/linux-nvme/20230518183311.3224326-1-ushankar@purestorage.com/):
- Patch 1: fix style, improve readability, include helper from patch 3
- Patch 2: refactor to remove need for WRITE_ONCE/barriers
- Patch 3: fix comment style, move helper to patch 1

Changes v2-v3 (https://lore.kernel.org/linux-nvme/20230424232225.1975793-1-ushankar@purestorage.com/):
- Patch 3: add a warning log line for long keepalive RTT

Changes v1-v2 (https://lore.kernel.org/linux-nvme/20230417225558.2890062-1-ushankar@purestorage.com/):
- Patch 2: fix indentation, set start_time even when stats disabled

Uday Shankar (3):
  nvme: double KA polling frequency to avoid KATO with TBKAS on
  nvme: check IO start time when deciding to defer KA
  nvme: improve handling of long keep alives

 drivers/nvme/host/core.c | 46 +++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  4 ++--
 2 files changed, 45 insertions(+), 5 deletions(-)

-- 
2.25.1


