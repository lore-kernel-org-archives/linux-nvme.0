Return-Path: <SRS0=tL+/=A3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727AAC433E3
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 14:42:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E5F206F4
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 14:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AUAugYBU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JbisizTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E5F206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SDFkl0pmvzZXIamBWFh0vDoPjgLSguAd1hXoDHnZAwc=; b=AUAugYBUkvP8cHlmThN2CBMFdp
	ZPwkAHva9CZSxXxjaYiN/5510IE/FUPFN7SWHucBwENjqeb1P68wyv7nBatZVzakM7VjpLZIce4Vr
	Ydez9UwHHxFE3KqxeTDrqZg8sqMPypXNyiyKN8kBD/vLz4NGH/8v7mU7azWjVBHJPaJpy0zoVGBVm
	5ILDfaKvxj/kG1I9AZdEel340qAdSUMNAcha7SdYjfOGvMyIZ+gE3uYwgUTRnB4fuOhZbOEc4yIO/
	1K36B7lIUEbDLBIMwdheMf0s8T+zypUvVpzkYFf2oEdHryyKvofKXUDPa2wiRwxP3yfA/n+lueSfR
	ObvXWj9g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jw55P-0001Qu-60; Thu, 16 Jul 2020 14:42:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jw55M-0001QK-M5
 for linux-nvme@merlin.infradead.org; Thu, 16 Jul 2020 14:42:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=DYDmyYTH9KAmzY7DEUnovhADbtU1IOpaCstIMpojNGA=; b=JbisizTMiCzaYQQDjCpJkubB3x
 0VtjrpgnNqIW3EdUpJbyjIjxv0o3MwAR9tqTxSvcu5s/2O7CGqnWoQEMFIsP6Q1/7Asyfvd9FRw6w
 zAfzZt8Z29K2gGqO0SBl8XyKQLBawP2IPF44nA1rxsoZaR4r1JywMivdttA1mRvlTm0f/S6cPoaka
 xBpq4wv/nJaIvhVTlvyJTOQAewMyIBi8D2x6eR5uvo6Slh4nF6VN7BG8BUbcgL+N/TBgON3VRooG/
 KrGesm/Esdt2iUhUN7HXOmTaoY/xkstg2b7QRkKo8xDcwNrtZN8HiGgi7aghcujbrX2co5rM7mUPs
 EltmcGFw==;
Received: from [2001:4bb8:105:4a81:1bd9:4dba:216e:37b8] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jw55K-0000pH-8l; Thu, 16 Jul 2020 14:42:07 +0000
Date: Thu, 16 Jul 2020 16:42:05 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fix for 5.8
Message-ID: <20200716144205.GA475287@infradead.org>
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

The following changes since commit 579dd91ab3a5446b148e7f179b6596b270dace46:

  nbd: Fix memory leak in nbd_add_socket (2020-07-08 15:42:18 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 05b29021fba5e725dd385151ef00b6340229b500:

  nvme: explicitly update mpath disk capacity on revalidation (2020-07-16 16:40:27 +0200)

----------------------------------------------------------------
Anthony Iliopoulos (1):
      nvme: explicitly update mpath disk capacity on revalidation

 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/nvme.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
