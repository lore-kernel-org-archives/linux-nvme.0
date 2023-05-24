Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B41C77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 24 May 2023 23:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wCTcxCWoijw6Ro3pdugp95DOww3gmO9W49GhAWL5Sb4=; b=zI7nRas3TBzl/P40PwpOY9sMmU
	OyYmZhSfXtS/SRajc1P5l/Az5WfKCYqpjbKOL4celkXR/GS9zXjUTEMPOhIkscV/Dnq0soHMt4b/i
	HZ42re1y3f6qWAdUf4hHQIDxz0QED9QQY0q8MvZM072nGdh8zTbVCbGEXoo90vtzlEwMCnyFEYPsd
	hZ2v8ITfAl0TTUQoW4LnV9A704ZdHe0aHGehQ40vy01JVApzaNTN4MfnbfLD2EC2mPnsEjVqoqWAw
	tPViBVPH8nxnnUnt5umQpAq4zYjRrfAO/0vS4uHMGM92ok/PIypmmpVGJgvZ4H6Vwvh/KOLzDyK2i
	+RAOvbfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1xog-00EwEF-2I;
	Wed, 24 May 2023 23:22:50 +0000
Received: from mail-pf1-x466.google.com ([2607:f8b0:4864:20::466])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1xoc-00EwBM-11
	for linux-nvme@lists.infradead.org;
	Wed, 24 May 2023 23:22:48 +0000
Received: by mail-pf1-x466.google.com with SMTP id d2e1a72fcca58-64d2f99c8c3so1172700b3a.0
        for <linux-nvme@lists.infradead.org>; Wed, 24 May 2023 16:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684970564; x=1687562564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wCTcxCWoijw6Ro3pdugp95DOww3gmO9W49GhAWL5Sb4=;
        b=T4Yce5mliUV1mL9MlmQkjxI9yhVGo/k5DhOZTa/S/i4LDMdPgCFNBSKB8fbEsxHbPz
         m1Pj32m+e31LpLbAP/XEeCj89RF01ZGIurppS8PBmuCLmEl1X4ey42ZRmKP2bw1+WxIV
         ykycPL6YjN5a4k1WHI43ATbEN2+8QS6VNMnqVutLfIb39545uWTH8fHUVkPhJwTgPedS
         c5YLkFHBTaVfvepZ1nJQiW+0Xw4b20kZp8qTynaC/q/O34loWpPPF8PyKY6pW2wMvTDi
         /6WYPsGLGxZ8cA61Ha4woK4H5Zo2IbH5knHkSFHYmi4GB7dKJFbgu3Z1V7cz6dHO0XfS
         TnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684970564; x=1687562564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCTcxCWoijw6Ro3pdugp95DOww3gmO9W49GhAWL5Sb4=;
        b=NCEDexQbL7a5jARTKNQXN+KHOuRg6Nba0xSrw5S9477xsUNh4kpAYx8nbIY/9017/D
         qa30amqjnIGcMl0gFSvvjgb8bfzY6Ni0iyTj6D8ZqDW0SLv9cNMyz5Ww8XYCmPq+Zw0e
         kErCIUmJxXJIQr7C1DUb2OJTeh+BallYclhHZd3jcxpf+3kl4EIgpeUKJwQ6JR3ipGcI
         RlIn2cZwUoq6tNyfKBpGrYUbK10DnEV0FAUjOUe66GTg73vhew0a3RWo+jd3fs2cKqzw
         rfGgKKn2NHWEEy50+Y6nN8trNo/0gtmJVpC2IScDOcCcQ6JKFjmFrX8mu/38efNVyavM
         dGaw==
X-Gm-Message-State: AC+VfDx5vBTK0D5L4vBe+5ebTLEswrB2pAIeVpZf5sbPUBsEuBRDJ38u
	N4W/yuv6aAIoO89vdiavTeRDmS61MFZ3TLU6ziTyIywbv8SHG3TzUUeagnurhCeg9w==
X-Google-Smtp-Source: ACHHUZ5MUCqPlCXUrlUvb9xR9fcOWHl+O5Cb7vPT516e+9kmty1Le7NviPzNQeqWb+f003cOFrrg31NttVBR
X-Received: by 2002:a05:6a00:1a13:b0:64f:52b1:a890 with SMTP id g19-20020a056a001a1300b0064f52b1a890mr5431698pfv.34.1684970563846;
        Wed, 24 May 2023 16:22:43 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id y82-20020a626455000000b0064d740b7455sm2789pfb.7.2023.05.24.16.22.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 May 2023 16:22:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id A342D2219E;
	Wed, 24 May 2023 17:22:42 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 9D8D5E432D3; Wed, 24 May 2023 17:22:42 -0600 (MDT)
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
Subject: [PATCH v5 0/3] keepalive bugfixes
Date: Wed, 24 May 2023 17:22:15 -0600
Message-Id: <20230524232218.1584605-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_162246_458672_5642745E 
X-CRM114-Status: GOOD (  11.19  )
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

Changes v4-v5 (https://lore.kernel.org/linux-nvme/20230524193809.1360269-1-ushankar@purestorage.com/):
- Patch 2: revert changes to start_time; use req->deadline -
	   req->timeout instead

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
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 44 insertions(+), 3 deletions(-)

-- 
2.25.1


