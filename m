Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC151C77B7A
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eCRtXNEV9j+vElLusKZZ0YjTgxXI02P/HBwFwL73M70=; b=MzVEKH0yg7X9tWSyFm3mPIIg3E
	LlLEZ84iIx+NR/3VNTx6s5D+i+D9K1OB0EBQF9CmBItpSbqbirEghrqhHVrRHhLyTcCdOFj+7aSFF
	iHxpnKkv7qfD3O4mhNxBei6oSuosv+/Svs3N3d8NnV1fwdz7EfhLJid2oNt1kk1OY8iWf4L4YmNKE
	8wvm6liLjRuqp5cuEBQvN17GohITc/So85dUriywJEUjqDoMHxSE7vfQAqdf6obwIB09TYmk0ZKv2
	yPw2GFpmtymmL1iHoTg+oZ6W5dSaCXklDIL5nmOgCU6mL5HlPHfeGqrqLMuncRInRuSXYm1BN66bw
	vllISUuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FbT-00HNSY-1Z;
	Thu, 25 May 2023 18:22:23 +0000
Received: from mail-io1-xd68.google.com ([2607:f8b0:4864:20::d68])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FbP-00HNQf-03
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:22:21 +0000
Received: by mail-io1-xd68.google.com with SMTP id ca18e2360f4ac-774942ddfe0so169828039f.2
        for <linux-nvme@lists.infradead.org>; Thu, 25 May 2023 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1685038937; x=1687630937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCRtXNEV9j+vElLusKZZ0YjTgxXI02P/HBwFwL73M70=;
        b=CKVmLEPWGTYzDpWfWIPRYLpSntbxUS6bV+a7L6IX/4LylrV2ZTGFCSYfqILzK9Hg4i
         HOLWJhh1/eGoI1oyV6qSDe5Nbt6vYg8FeriLtZ7NB+aDfYo7vUqD4vLSmkzhcYqDC7g7
         kHWRjvp18Cn7V/BwkyVErfx5t9I/bqAy5Zv6GPtMNE5KobWHIjX4JsjqMFHwGhdKQApq
         2NQIL3Oz9Tf8/eqHApxFvqberEM1gW1iUMngsxIVk71iJCB3RfFxRMj8kNCHBghS/Tw0
         QluFnGlCuZ448JwYtU9PUR8eCIDXGRP1/46y/enXaAr/d059ePBbSORm9Cmj9HwabkoL
         IkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038937; x=1687630937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCRtXNEV9j+vElLusKZZ0YjTgxXI02P/HBwFwL73M70=;
        b=Vanao5aZopHep31bWv66Un+S5lD2jlvE7WPsXJO1DU2DFBJSMVSDDCztTqREWdvfEM
         xNfppvWs7qVqwO1CsBti9wdgmER0y1+wNxuN0bTsGXasPV412yTAVkRPDWO40GJcdR7d
         lXWcZcb6o5/m0fJPCv4+VvNN8xo31jKGAx7AT6tC8FL2d5030mkjJHW+yUTXjBhBKHx+
         qYxgrxnSKKiY488zXeapk0/OyqsWbc82tbnunJdr99qbc/uAGZyD2erCZjiFVF/SePY9
         iznUfZltgF8Jrxb0A+nCcLHXTcrTvw6JGGSHltpZvfgybOYaUnJ7GT7xvU8uo/tA1/aF
         7rWA==
X-Gm-Message-State: AC+VfDw4Sjb4z3iJsgwg3Kk8ZWMEltW3vX/wZdOdBUOUgkLkmK1uxr2X
	EY2NFA/DcguSOYSHfm6JZPKiKhc+ho6QdgG7lbgQyM3DPAddt3Uz6+ZAChOb+DufSQ==
X-Google-Smtp-Source: ACHHUZ7x2SCN6gR9S1pVSmqlk4qow9BWq16akDLCEYFgI+mcy1ffbI6YeVjMvpnXlczU6CEvTQxS0BPg03BJ
X-Received: by 2002:a92:dc48:0:b0:338:a359:e5b2 with SMTP id x8-20020a92dc48000000b00338a359e5b2mr14418224ilq.22.1685038937187;
        Thu, 25 May 2023 11:22:17 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id a12-20020a92c70c000000b00330bc5b6451sm99170ilp.10.2023.05.25.11.22.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2023 11:22:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id CAE16220D6;
	Thu, 25 May 2023 12:22:15 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id C6205E432C1; Thu, 25 May 2023 12:22:15 -0600 (MDT)
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
Subject: [PATCH v6 0/3] keepalive bugfixes
Date: Thu, 25 May 2023 12:22:01 -0600
Message-Id: <20230525182204.1954429-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_112219_276307_B3FDC9F4 
X-CRM114-Status: GOOD (  11.68  )
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

Changes v5-v6 (https://lore.kernel.org/linux-nvme/20230524232218.1584605-1-ushankar@purestorage.com/):
- Patch 2: fix line length and extra empty line, add comment about
  	   req->deadline - req->timeout

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

 drivers/nvme/host/core.c | 48 +++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 46 insertions(+), 3 deletions(-)

-- 
2.25.1


