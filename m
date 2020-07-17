Return-Path: <SRS0=QPGu=A4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F54C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 00:51:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F3020787
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 00:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vyzu4oHH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="avom7G9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F3020787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Der9SCLmRm/6u2ubFgXigF5rmcP46mykEs7J3sx4An0=; b=vyzu4oHHPcW8Wn7p9kA8W+JQ3a
	QcWMWiNo5zs08X8c8ERJ1mFVhNej/YT7eBrnm62rwvdEMxLDx0PQAk9QZeKrAGrCmUSh9XnbnVgd8
	5OHPMnyYFaB3nGu9WsB27Tl8Nxb3Bqjwmwk7NQfXjKQ/v/zuQPIPpoV3Y2PQPqnjuhPRP7FkmBXdF
	+CVrtU3e1ivRCbnYoxZaXg5Yt0ZktHNAaddIBgwFMdVOyrNjt8jyqsyH+hleb2BAVYCMWXN7AvQGG
	T06vC0OceSFmXmH5jYd7C4pXBZSMyAvopHhNR4XBzYXSEnU67xnz/Hmti7txxmYtXo0TnPt7zWCOM
	iyDnaoCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwEbO-0008Co-Fl; Fri, 17 Jul 2020 00:51:50 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwEbL-0008CV-0s
 for linux-nvme@lists.infradead.org; Fri, 17 Jul 2020 00:51:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594947108; x=1626483108;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hWTOKWBFM7goWtZtqelHtfpgK1ct42hT8L4fA1SBAi4=;
 b=avom7G9KtT5BkUo3lJlhQuiFEw/2gS+eXgl1WcQh1QqkyV1t8UL1ndnG
 BLoRruQJEn+1zrIOvgbtEh0MTswxM46XoPTMslpa9PNFHQ6WNbTAUP6qx
 p9KkTjzLcnIskZo5k/rhAXdfUaiwGg4qJ8+A1zisdhITSMZ9g+EzWWoFT
 7PhGy94IlSQbPmbUVPY4R6CC7G9w/ktB61WyK/mvdIvgtKV3+kXA9Owak
 StB97db/xGmfC0DsmN3MYjZp5bpZaq8mG37C/6t+mXD6s7t/fVcbzqNZC
 5ccqaq+hhONZ7kJfZGkbjZ7o77DHs0azFxB3V0q4f45ZtXhuHhlxzCHyT Q==;
IronPort-SDR: JafTrEXCP1EosGHvWLfI00xzwucGh1S4PS4iUNvnNJEupdhsxorkAYJ+mJA022i49kpDWecDGo
 QqOkSZINgLwmkJa1DTBdE0W1sVK7ZBfy49hGiipccwTOT0W21bGYB/tEhm8C+WNdWkknC5PjSW
 rMJq1O+8sBOOSEyN6SyhMqxM5VwJasQq/XNZOXW2lsvg67MbOgTev+yDjH57NuUo2GwPYYmS3u
 +H8UYrYAqaflN0Ztt1ZeJ6EdJSN/+BGPIW0yP6z9nTNmb5xN30wI14pANZypBAWVcHdtJEAIpR
 CY0=
X-IronPort-AV: E=Sophos;i="5.75,361,1589212800"; d="scan'208";a="245699426"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 08:51:44 +0800
IronPort-SDR: bvCUQ5Ai4Yk2VyMvIOLLvr17R/3eef7LsvYGcqV66aZC428Qzokbg4ow7njYfxAvYZpBJDMP2e
 dL+PUlweWmfjGll/UovJnNMPyaNHR0LLI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2020 17:39:32 -0700
IronPort-SDR: WTeyln2N6SXZbk2JeKBPMMJ0tfAUBuctq80O/OOCpubIViPYkpOLsnScYCUULQ7gPqP6qlefw3
 bufU4SGIg4dw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 17:51:42 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V4 0/3] nvme: fix iod size calculation in nvme_probe()
Date: Thu, 16 Jul 2020 17:51:36 -0700
Message-Id: <20200717005139.18923-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_205147_278258_193512B2 
X-CRM114-Status: UNSURE (   9.56  )
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

In this version I've also added 3rd patch to get rid of the division in
nvme_unmap_data() since we've hardcoded the value of the ctrl page size
in the macro.

Regards,
Chaitanya

* Chagnes from V3:-
-------------------

1. Use (1 << NVME_CTRL_PAGE_SHIF)T for NVME_CTRL_PAGE_SIZE value.
2. Remove size and nseg parameters for the nvme_pci_iod_alloc_size() and
   hardcode them in the code.   
3. Added 3rd patch to get rid of the division in nvme_unmap_data().

* Changes from V2:-
-------------------

1. Modify commit log for patch 1.
2. Repalace ilog2(NVME_CTRL_PAGE_SIZE) ->  NVME_CTRL_PAGE_SHIFT.

* Changes from V1:-
-------------------

1. Remove the ctrl->page_size and use macro instead.
2. Get rid of the conditional operater and use max_t() for SGL vs PRP
   size calulation.

Chaitanya Kulkarni (3):
  nvme-core: replace ctrl page size with a macro
  nvme-pci: use max of PRP or SGL for iod size
  nvme-pci: get rid of the division in the fast path

 drivers/nvme/host/core.c | 19 ++++--------
 drivers/nvme/host/nvme.h |  9 +++++-
 drivers/nvme/host/pci.c  | 65 +++++++++++++++++++---------------------
 3 files changed, 45 insertions(+), 48 deletions(-)

-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
