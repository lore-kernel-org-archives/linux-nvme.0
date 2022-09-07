Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A047DC6FA86
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vxUxC22ur5fJgbptGRFgrug3/HToGITj+3oiBa0Uwws=; b=whildud/hKGwihFrgmtIl9LYXv
	eXpToGpAS26jF+MeHN6RZAdDec70ZABa45i18knbeCzih9glikGYzbrfcC3avUrd0j7fkPjGO88ZT
	9pscOhUlZ9ek6E/PDAVSurMaWIEZvct1Jc9jfxCxsC09MDyKkhn6dESUcNqnvMUf4j3Ofay4aYAta
	NjE+YRbEf1eEF4T16tAEzMM5daJh3p4RZWQc2pTLG3BBCDqY8MgWDHnixVNkdJZ2FOeFulHPefBuf
	tuGE+19RVa1uhaRXLjNxaKY7TkVxYSjKxuzBzrZnkkcclnE0KGysIrMryn84BEMuAOVAIFPspZdWn
	cufUDlow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVw2O-006snz-59; Wed, 07 Sep 2022 14:28:20 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVvyV-006pw4-TX
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 14:24:22 +0000
Received: by mail-wr1-f46.google.com with SMTP id t7so15637599wrm.10
        for <linux-nvme@lists.infradead.org>; Wed, 07 Sep 2022 07:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vxUxC22ur5fJgbptGRFgrug3/HToGITj+3oiBa0Uwws=;
        b=36ruE95T2oKxjhu0HETtlw8T7dliuP9/WQODlNb0d1XSdQUdSliN8ZY1afPCCGcLy+
         Il0SGphdlFaXXdEqtILR2ZDlDFFziVfI8lPz82uTJJVDPXGZCVqYM27lTv4MYtgK+Mka
         Za+WmVA7K2nlfrCODlGRRgN5LBeyVEyNUOAsjt9p+l9BmBCmXJ3+45NDlNfdEorYVxk1
         lOQNHU6BfQRvbVOcPr7QhSRScorGJU/OLDEG3C4qMqkKMvA6OYkwYjlOu1iViScXOz3L
         SNpn8Ovm4ppPmP8azDhXfbl79WllBvpUzJp20238UJPw7ZZ2bqFUKBQVfLE9G5aPmh0p
         +kVg==
X-Gm-Message-State: ACgBeo3Nn9i642MVQxTSrxFJIjXpm3G33sync3bFU63eTQmBfNI9Nvgy
	s7GLt5rPSDcCWPkXjg3sVGzyONWC0cY=
X-Google-Smtp-Source: AA6agR6Lm3+ccFV5NmXjyIXaSEQUm5emL88Bwc3o2I46vGcOVCAOtszF9/VbzCytRCuyDcPf2+RiUQ==
X-Received: by 2002:a05:6000:1549:b0:225:64d0:a5c2 with SMTP id 9-20020a056000154900b0022564d0a5c2mr2188174wry.87.1662560653770;
        Wed, 07 Sep 2022 07:24:13 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d504d000000b00228dbaea941sm6552486wrt.26.2022.09.07.07.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:24:13 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Martin Belanger <nitram_67@hotmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc 0/1] Fix missing AENs when discovery controllers are disconnected
Date: Wed,  7 Sep 2022 17:24:07 +0300
Message-Id: <20220907142411.101950-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_072420_004925_EEB1BFA7 
X-CRM114-Status: GOOD (  11.73  )
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

When a discovery controller is disconnected, no AENs will
arrive to notify the host about discovery log-page changes.

This attempts to fix it with a new connection parameter asking
the kernel to send a dedicated udev event for this case. Prior
attempt tried to use "connected" event already sent by the kernel
however this also applied on the first connected, causing undesired
side-effects when issuing a simple 'discover' command.

The patchset includes the nvme-cli/libnvme counter-parts as well.

Sagi Grimberg (1):
  fabrics: support notify_rediscover connect parameter

 drivers/nvme/host/core.c    | 4 ++++
 drivers/nvme/host/fabrics.c | 6 +++++-
 drivers/nvme/host/fabrics.h | 4 ++++
 drivers/nvme/host/fc.c      | 5 ++---
 4 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.34.1


