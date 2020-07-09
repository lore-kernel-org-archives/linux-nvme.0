Return-Path: <SRS0=NJ67=AU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC194C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2020 23:40:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DFC20672
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2020 23:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tBd0Ede9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UDjPXkCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DFC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/nmwFYGrJdnSdZse18AAfQIM+2MHhz/RvR+w9RbHXmA=; b=tBd0Ede9WBDnmfsW7/ivECYcGC
	sW8OWcwJr4kYMs7VHAyTTXGGanY6T4iv1+zHXiJq04QYVbyYbDYG0A//Y6UdKQ7CTPYjt/MoEg8tm
	UUSZ2STMI+HdKSkHc2BU7/TjTtIBis4Xu5iE0dFHNtirayL6sg+iVCaOGY/T6vPdEqym3pNgfHkK/
	9W6GYiPsgkiagURNE6PH8EUH6opbplP2caI6lVKRljWHQifrDquWmXykfat47/5hXjiOtTT1tGSnC
	xyqb44lyme1hTY+doXYOhOwwuYUGCrXRzteFLHtI2HUheMxvMyG0kniWf1IIKjZzfPYYaxYZHIV1Q
	Pkmxv11w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtg9Z-0003kt-3n; Thu, 09 Jul 2020 23:40:33 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtg9W-0003k7-GM
 for linux-nvme@lists.infradead.org; Thu, 09 Jul 2020 23:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594338039; x=1625874039;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3L2Q9u3U5vvKy7KE248Dtgf93Evml1Q3NecQ0pCc8mg=;
 b=UDjPXkCyoP3bCI3MfHG224ayLRk3KNmtX4lOSXrTg+Hm/AdrH/FWjwYD
 8HVF+4Wsf65v2loLTtwoRm87fyvAnRzYMtbGfWv8t60UMcCU4L2duvdGT
 F4IMZhlV128pVeEj6RNwpU9k70MishMhWJINbhOYBdpe2oqv1CNmCs+Ts
 uViBE/rB36j7J78oy+SQA1MFoCa9v0E8TVvntpAabnGiezepCMYMm+P6P
 EEaXyZXb4wkhd4DuiAluCdUSCHRIYJ5GH3oihqU5DG+xPWx9S2U1fcm0A
 F1cJ19KB2ixGEBblOMksZsNwwwOXMe1o5gCdJka/T+0XpTurMuetyyvi4 w==;
IronPort-SDR: HL5SjbGu7gOKWsw1VyBT73gdL1972xsPHZfsiSyqZ48ij6Myw6Y5qJTfQzwQLxHunSxYFhONGp
 /ONMMr+uFNT3flmYfxvklDRRBXYIKR9Q51E3KJ9d5JMxGYyhD386tCgMb0hKQuLgmy0qBUCRWM
 eI+APIza/cFNxTAY2mNV8yzr+tFWbL4Y7YHm06vs/na73NjT2mkIZCDQQwDoL3toE0NLH2KJ0y
 ja76O5dJvII7lpuyY/txs3qfXLhpyGcZyGXkgY2ovSK/zpdb5U0Qsm0CIVtjgzq6nEFOox6/oz
 nXE=
X-IronPort-AV: E=Sophos;i="5.75,332,1589212800"; d="scan'208";a="245096143"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2020 07:40:34 +0800
IronPort-SDR: a6B1p84sh+QbcIyQtbz0XHm80tX36um91J36gef2TyWsa4DC4+A0YMI/glPElxdFyhOteJspi8
 0b//8gHS9x4ZQQxYmF/DB0EydApmyPy8s=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 16:28:30 -0700
IronPort-SDR: mCnE0/X2MAAKzrM90xMIDKGCQUER1QNcBEQHdV5l+5ztvE1X7vYngLLRWMsljnSpxCRt/xgS/Z
 tMdJ9I6StH5A==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2020 16:40:28 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH V2 0/2] nvme: fix iod size calculation in nvme_probe()
Date: Thu,  9 Jul 2020 16:40:23 -0700
Message-Id: <20200709234025.10673-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200709_194030_758568_11454442 
X-CRM114-Status: UNSURE (   9.04  )
X-CRM114-Notice: Please train this message.
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This is a small patch series which fixes the IO size calulation in the
nvme_probe.

The first patch replaces the ctrl->page_size with a macro. The second
patch calculates the maximum value based on NVMe PRP and SGL size.

I've tested this patch with different block sizes 4k-128k on NVMe QEMU
and NVMe PCIe (non-SGL) controller.

Regards,
Chaitanya

* Changes from V1:-
-------------------

1. Remove the ctrl->page_size and use macro instead.
2. Get rid of the conditional operater and use max_t() for SGL vs PRP
   size calulation.

Chaitanya Kulkarni (2):
  nvme-core: replace ctrl page size with a macro
  nvme-pci: use max of PRP or SGL for iod size

 drivers/nvme/host/core.c | 19 +++++--------
 drivers/nvme/host/nvme.h |  9 ++++++-
 drivers/nvme/host/pci.c  | 58 +++++++++++++++++++---------------------
 3 files changed, 42 insertions(+), 44 deletions(-)

-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
