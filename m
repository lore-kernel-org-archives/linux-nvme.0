Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D68C4741F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 10:36:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4162C20679
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 10:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ww5cHgoI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UEZMVw/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4162C20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O6luMQWaf0M/aPQiKDCLeKU5a3I3OaImlXKLeT4g3/k=; b=Ww5cHgoIno1aNmyz+oEGWT4tBA
	FUAPpadYmDzyGcJ0mhiyA64I/28x5PS4ZHRx1GrBXHsstxuXcpT6nFKhI+7/XCgJSmKlgU+5fu8Jr
	v3OSPWOwLMVrzg08WcAi6lXAZ89Wj+qsoS4BdCvJQpV1ka99/u+CKDj4uX8ScmlmBItzEEE2wRQOe
	5rg6NewfWiV92kdmKzl/iqZ85dcV6kCySuAI7Y3nvliUnI/cbEzEkw9Bm3NREQ8BvN9B1digT0Z1Y
	+hQdq7KbzYQRRCCoGJPUhtnHnkMBNwFyQoGAYR/pbzlIp+C3j0Docr77jXsbhPd56Uzt4TDAxXXJe
	ZBofqf4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcR0i-0005GZ-Lw; Tue, 10 Nov 2020 10:36:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcR0g-0005G7-Ay
 for linux-nvme@merlin.infradead.org; Tue, 10 Nov 2020 10:36:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=qibVoX6IULdWdPkI08Qmvy4hrCZ2mnIgyB5imAKkBcw=; b=UEZMVw/892HnI3xkni8Ccd4diF
 qRgZGa9eN8Xm7GqFqftAdHOdcx8XCoNLr8aN5XxWkmNP/s2Bw1jLEHXEFwr0DeaBtR+9juPkAOgoM
 0OfhW6QB8gTmeL+tEYePxKjZLxHAoPyuMnqUyz1Ln62yN04/iICR6/CzJ579MAaEBiLdwVkslZTbF
 hWWbMuCCinVjxjyiJThzTD1qkao+Wqs39fYxIA2O7nHzXIkaQEkTCM1CrwInFjGa79hFP+BN9CpT3
 ijK7WtlU2Dqf9ab3aZJrSTKk9x2kejNRPTVapfzm+lhKlY8CTpVrO/C5oBGXQQ0E96MBmrq0L4zQg
 rpxuc6Bw==;
Received: from [2001:4bb8:180:6600:1e3a:5cde:56c5:2738] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcR0d-0006HB-W3; Tue, 10 Nov 2020 10:36:20 +0000
Date: Tue, 10 Nov 2020 11:36:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fix for 5.10
Message-ID: <20201110103620.GA3200092@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit e1777d099728a76a8f8090f89649aac961e7e530:

  null_blk: Fix scheduling in atomic with zoned mode (2020-11-06 09:36:42 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-11-10

for you to fetch changes up to 65c5a055b0d567b7e7639d942c0605da9cc54c5e:

  nvme: fix incorrect behavior when BLKROSET is called by the user (2020-11-09 17:39:15 +0100)

----------------------------------------------------------------
nvme fixes for 5.10:

 - don't clear the read-only bit on a revalidate (Sagi Grimberg)

----------------------------------------------------------------
Sagi Grimberg (1):
      nvme: fix incorrect behavior when BLKROSET is called by the user

 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
