Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB4DC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 09:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MNr0rMQMz9zwkgx1o/kKG3az4M+iSYsqLlSaalfpRL8=; b=ebIBtFfH31lhRbUv51kTC7hlIJ
	T76yGYdqsfNpRdiWiW/EzclWWwr0Gxk9iyDCrZPMfRvZc1EB4qoW2G0CL2kfBYSDuAVcmqdOekXs5
	+udP6NaYg0YsrUZFxTijDqlDRxXrfwu7c3xhoYbtVydrY3+JpkMLZSM7vTvK1gfCQ3XZs5rGNervY
	hdsAY1s0wd5xTImM/+K8eD6GDcvLgUidxKrLxfRux0I8vJLmm0Tno7FXkth5BTTdZrmqaS3UgaMj/
	/2T//xNaJtJDHcx8uJaA7i1uZao6oSmhcRQKN+B95EFrPWgTy7zYoEn0n6x8XZEjrNzRMX08orIlI
	EhYMdFtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nE6Ol-006DEY-6J; Sun, 30 Jan 2022 09:21:27 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nE6Oh-006DCw-GY
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 09:21:24 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 bg21-20020a05600c3c9500b0035283e7a012so2304312wmb.0
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 01:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MNr0rMQMz9zwkgx1o/kKG3az4M+iSYsqLlSaalfpRL8=;
 b=nF6+WF7XeloIXqrVAfgoJARvqw/t+HkEqNTKPEBBhvW4odTdIJzgL4uoJCsu5hJ6v/
 JARK0VKmMetcXZkdaCiWQbfMpA+JCBAaS6SfSsZcpG0FhSqL6MqFH5LYWYhqSqW1KZgm
 noOMxLSC61DeGMJR4iyQl6AZfacvupUBT4nWHWRvXBnLFWn/Bx/JXoFThpnIN4x7p1qW
 +e4EE4XVcrdCHTL7ZnsLIk9tMr+ZbIQHmccuun/mszwfhxYFxQGLfJPr/qbsnQBgvsZg
 7R3sr1iYGabXk0uTkVrPrkyUnJST3HLRp92/T9F2Vea9KDNHLduX+wjpTIbbdaFCTLYW
 yuwA==
X-Gm-Message-State: AOAM531eF4IWaFjWEuc/4MXNjDZ+B/1FF3nM4aiaWr6JeyPHZp0gxgnw
 cQU42TUzLKrZTCnpUM/2dTthDK28JK4=
X-Google-Smtp-Source: ABdhPJxzwR1GwQXVv4hE5pr/48kAc7H4hb8CUygtE8C4faTR4zSJLWiiz/mwyNP3XdNzEwFtYx//tg==
X-Received: by 2002:a05:600c:2e02:: with SMTP id
 o2mr13733643wmf.34.1643534481561; 
 Sun, 30 Jan 2022 01:21:21 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o15sm6861452wms.9.2022.01.30.01.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jan 2022 01:21:21 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
Subject: [PATCH 0/4] nvme-[tcp|rdma] fix for possible use-after-free
Date: Sun, 30 Jan 2022 11:21:15 +0200
Message-Id: <20220130092119.595854-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_012123_578115_F6514AA1 
X-CRM114-Status: UNSURE (   9.14  )
X-CRM114-Notice: Please train this message.
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

A few use-after-free reports were seen in the wild with nvme-tcp when testing
ctrl reset and error recovery under load. Analysis shows that the exact same
use-after-free can happen with nvme-rdma as well. This patch series addresses
these issues for both.

Sagi Grimberg (4):
  nvme-tcp: fix a possible use-after-free in controller reset during
    load
  nvme-tcp: fix possible use-after-free in transport error_recovery work
  nvme-rdma: fix a possible use-after-free in controller reset during
    load
  nvme-rdma: fix possible use-after-free in transport error_recovery
    work

 drivers/nvme/host/rdma.c | 5 +++++
 drivers/nvme/host/tcp.c  | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.30.2


