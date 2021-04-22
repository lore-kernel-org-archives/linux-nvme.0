Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0D7C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 07:08:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C99613CB
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 07:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C99613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wLHywfSZzZ/TSITjeJBZgArc1Fpe/9MwAxWaDzYjY1g=; b=Sfp7B0ssbKQVS0Jh62/7WGv7OZ
	NC6pTGeDnvLTqdOmpzLSekoaq7d9kDQFzDTwS4sVvxhC1Ex86z4DQM1gAdhphqa4L1BL4sYqJKjDW
	zgJl99DZ/maymkXqDID1Qej/OdbdPrUA0M6zC/9GotvC7hqTYEwTwbfr/683f9qFuXCBDGio9ITE4
	qzVxoDhwtKQIcO0OL2ue7W1XO4ZxDqpopmI9Qv4lk18MHFZwRq8wqGaNLbeaGMZ183AEz5DL4VqKC
	dK1ioo7/S9fE3rESGfTLF2n5ypkMUvEoVHr5+upScLqMXF9net+29BbAlbpNr0fFC6iwbaVBlKDdj
	kZ71zx1w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZTRE-00G6MU-Px; Thu, 22 Apr 2021 07:07:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZTRB-00G6M4-RG
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 07:07:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=mpDyeS655fsYnTxsXCfjWFLGSwI0nGPOMF9FGc+WyvI=; b=jKeNq6oL9MEr01u+O92X5n2OC4
 TdWpdaB4D30qCOXLojdajch+3ccLCHouHsdHldnvhEpP33znQZhRJYf1K2aM/FX86C8lARs7NvKMX
 abAF2KTMoyhHhpqTp7d24ci7rjyfI272lMwmefJD55QzTo2TwU9Z9h27Gquu3bZ+LmjFM0HXg4cR5
 uFxinRl2XuKL+EGwMd008zU7OFpyvu1vRUE7WS6P75ZB/W0sYlCLnbCpGFPt4d9bJXtQJh1wrLDgx
 058V8l/n492JpfuPWpZnWD1D5pLN82jckigbmVwYnZTsaPGPT1sRdlPa/EUW6nPNLxq8KI/mLArZa
 vuWp1jNg==;
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZTR9-00DRBK-E5
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 07:07:44 +0000
Received: by mail-pf1-x432.google.com with SMTP id a12so31031275pfc.7
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 00:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mpDyeS655fsYnTxsXCfjWFLGSwI0nGPOMF9FGc+WyvI=;
 b=enrLRwwyXnNDr4EmUArclwWwKVeNmcPqzZIWrQ/p30Cv4L/M5az/yG6LB5uDIgLIZ4
 6fQVDDKB1FRxy1AhjjYIp6tgsTh9wLxmHRzLs52IaOydKDzP/HWFucxeSkvi/qwOoEfO
 DGxdRH38ntSKlqdl3VI3OksyE4SODfdr3Piw+FHHkIiz8DGCI6XlNslQzeWMxQS8gi/q
 G/qpwZdSGS2XJZ4HEWLxy4DEjgDFirw3M20MCom0HH1YLCVM7RkotWWrP9hK/MU6g/qO
 JbPqEkcNGHPfraLcRIHTgQ5J1QlKEAKANmHcgsPr7Z9bQMCoouvE/XDqKY5yrmwYkeBd
 vEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mpDyeS655fsYnTxsXCfjWFLGSwI0nGPOMF9FGc+WyvI=;
 b=XP4fYMdBkpEWIWNbe3VAIDfN7P223Oxevazr0c58Y94DaDj3Gdml5tbSOaZoeojynm
 B9vBBU5/UoYNrD/IF/eoO+XCQygC+xfKBGwYCvle6LdqHgEV0XiyjaARYSQRs4PJ0aft
 YbR9hDBG2P9p0BlgiZAH+d6TZ08OjLFXx1opCUH9p704RXIOUZNQRUCX9qMwLOFoPuhT
 R4r+BTtLZjHlD1X5D11xnWbe9iDQl3y8inr9ERWGiV+OhTJTCO7wHtEiT4xtHlm0QYRo
 QRpa4MAmiXKUX7ArqX8uT0w69z5iKbLI7j8FRWrAJWAOSqMK6vgzLfO6P7upWqxHtWkJ
 XoFw==
X-Gm-Message-State: AOAM530hdIOhzxxY/tdrRsrBT4yTBmft15nGu8F1j1Ts1Jp/CCz/MDJf
 PB7l3G7XSUDxPKHjCqy+1OM+hP1ihQ1lNg==
X-Google-Smtp-Source: ABdhPJxdHOB/GIqadN0vW2QYhJk/R0CyuNWnjJVngw8VaQMpmb1MYyBtsYyU2Mb+iKaOAPdfODPq3w==
X-Received: by 2002:a63:3c1a:: with SMTP id j26mr2179999pga.292.1619075262448; 
 Thu, 22 Apr 2021 00:07:42 -0700 (PDT)
Received: from localhost.localdomain ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id u17sm1174914pfm.113.2021.04.22.00.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 00:07:41 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH 0/1] nvme: fix controller ioctl through ns_head
Date: Thu, 22 Apr 2021 16:07:34 +0900
Message-Id: <20210422070735.25855-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_000743_494479_58622D23 
X-CRM114-Status: UNSURE (   9.13  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

This series is to fix controller ioctl though block device in the
multipath case.  This series simply reverts the commit 3557a4409701
("nvme: don't bother to look up a namespace for controller ioctls") to
make it consider the namespace attachment with controllers in the
subsystem.

Minwoo Im (1):
  Revert "nvme: don't bother to look up a namespace for controller
    ioctls"

 drivers/nvme/host/ioctl.c | 47 +++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
