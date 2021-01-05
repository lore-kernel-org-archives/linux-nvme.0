Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF223C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 22:50:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867C522EBE
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 22:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867C522EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r2rgXPrL9VaDNpY0tp0nZh2ECzIeAUr79Hhtq0jWISY=; b=xv+Ze3nN8Zf7wH/+76xaSJ30Ch
	rv3/wJ9Q1FOlxHDyiYvAQ+EBt6i3RETlt5/lwILL7xcm5RAei6Fsf/W/HdtDQPlP66vd4yVus1607
	FYqip2TNKGQXG6RzXwFwtjOXPw86Pb859KtgS8oFXZq1VZTBTgmVaf4vs+TUZpj1M21VGjLsUUw67
	R1x6ws8b6EwQuTLQYy02PDoDqVL9GiVwWGodgKj1VhKEY1VGROyoScthGAfKS6kVeuVKFCSK7v7py
	hw+5iuYKp/0tam7GR2Z09YaDaDzNvlYNASM1jANSsJi21RPyzA7ZGbob73hgnXsyVjL2rZqH9IkGp
	ftvZ8b5A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwv9H-0002BU-Ri; Tue, 05 Jan 2021 22:49:55 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwv9E-0002AJ-7c
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 22:49:53 +0000
Received: by mail-pg1-x533.google.com with SMTP id n7so879880pgg.2
 for <linux-nvme@lists.infradead.org>; Tue, 05 Jan 2021 14:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kRwO1zIIdPn+KZmxzpiR6felY2gILKRF55gzBIatEU4=;
 b=t4j3HQC9KlAFRus9bHiwk+gJelfHw5rzCTq97MNe19QXnpqFCSyGhKjZezeidE+p4n
 LuF9XxPK4NWmRI/+eDlUASaXeZFZmmduA4WGwyYtLwHTiW78jEp/rFYNtGnUZrY+uhbY
 Ti/gf31hXZMvhwgHL1appeXXyoZizgmA2axqlHhti5GSyXrlNHQWqJiTIji33y7XDhj2
 E3jzgvIap5mpOnT+F1etnbCMcl/GfpKW5gv+Jww+Dk04R4qUTYni78ykCQH5ZOTtU7Hx
 zfAJGSR7mngdXeHSUNP8/2I/w8XpJytTwB0G/ZeMy+i2jtAf7tcts3mOJoF2IqL0i2+/
 YkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kRwO1zIIdPn+KZmxzpiR6felY2gILKRF55gzBIatEU4=;
 b=XJHXzvaP2vfNgwRZxTYUXzOAFNZBJUZtAuvF+pkafSz0TmP5z8nMy7gnOTm4T/acTb
 TbCl5diPaRHRLjP/vUMUlKvgTO07PNsjmFdbnMFIpciOoVokrN80WFJQDJM/v4ZAzJi+
 vlJ9GB/ptTs+q0u4PT/rP3/4/cc4CpbEJiC63Ry6VkV9Z6S11e0p1rRektB7fWzQ7KiU
 c4Z54zKDc0NJ0+dOY5yOl3TQZbDCndb4uwVSt9IuBj3q1l7jOmEf+hWRwoGgwgobHvbz
 Ugev4zKL1hKvukRjzSJXnsj5gawIETEuiz8BmmZnKQ/RjxQWj5QGzJcSj7wQt8mREU9h
 Ybzw==
X-Gm-Message-State: AOAM5327CKXHo3FCTYlVdJzOWIbvHOE/GWZj6MzOBM3E8tHvu6bHZH4a
 hXHuJiP9b5hzPXAyjnkKYlO1HzKGFUNQm6nL2fI=
X-Google-Smtp-Source: ABdhPJwHiYnlctxR7oKOrK4jfSQjxUdMWKiuw8DCU5vqxBtIuDUa+rKUqmPSmcJ1WskVEhVMduo/Kw==
X-Received: by 2002:a62:ac09:0:b029:1a9:dd65:2f46 with SMTP id
 v9-20020a62ac090000b02901a9dd652f46mr1343111pfe.15.1609886988154; 
 Tue, 05 Jan 2021 14:49:48 -0800 (PST)
Received: from kai-mayerc-x40e.us.kioxia.com ([12.201.142.42])
 by smtp.gmail.com with ESMTPSA id 6sm351516pfj.216.2021.01.05.14.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 14:49:47 -0800 (PST)
From: klayph@gmail.com
X-Google-Original-From: clay.mayers@kioxia.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Date: Tue,  5 Jan 2021 14:49:37 -0800
Message-Id: <20210105224939.1336-1-clay.mayers@kioxia.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_174952_317260_995DF3B4 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Clay Mayers <clay.mayers@kioxia.com>

Enables fused compare/write to be issued from user mode.

The first patch allows a pair of pass through requests
to be linked and submitted as a fused pair to the nvme
device queue.  The second patch exposes it through an
nvme ioctl so a cmp/write can be issued from user mode.

There was a question regarding Linux support for this
functionality in nvme-cli.  With these patches, that
would be possible.

https://github.com/linux-nvme/nvme-cli/issues/318

Clay Mayers (2):
  nvme: support fused nvme requests
  nvme: support fused NVME_IOCTL_SUBMIT_IO

 drivers/nvme/host/core.c | 261 ++++++++++++++++++++++++++++++---------
 drivers/nvme/host/nvme.h |   2 +
 drivers/nvme/host/pci.c  |  32 ++++-
 3 files changed, 234 insertions(+), 61 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
