Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7B8C4707F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 15:00:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E48261186
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 15:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E48261186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wfrPZICGJlwD2TOy2LV/37dALV5bFPClr7/cg33hSm4=; b=oi5K91TmBBg2be
	jrkRyLbG1F6v0a66sp3IBaBYUQHF/obzv201fPbiW0cFS7vuN5JnMRO0zWM6oZi50sxrSlHzTBWba
	u6Xk3nrAALG94yxcnJbXBmgnsSibk/CBjyo8GBkXraC4hOFx3HzrtpQAgO0IZDkjGZeuVvAagAcfy
	NkTfIn7+TAYQ3tqSYHaIMkQFu/wr8voitvCD81txjB0fC9RooivxaSuj5R3ywRaeJ9eb8wYnHSRJt
	ARJsvnpRa5FLtVBcUcmYIHfneXXEcY7L+GSU6pGHHMi4pGOukl+sIEckr6UT9WrMKGDQTk3hd6KR2
	RAeCoCJ8LSLG8OaA1tOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmHUn-006zTr-LE; Thu, 27 May 2021 15:00:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmH73-006paR-Dx
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 14:35:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6589E67373; Thu, 27 May 2021 16:35:48 +0200 (CEST)
Date: Thu, 27 May 2021 16:35:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Prike Liang <Prike.Liang@amd.com>, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
Message-ID: <20210527143548.GA32170@lst.de>
References: <20210527135941.7634-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210527135941.7634-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_073553_657817_A0280EB9 
X-CRM114-Status: GOOD (  11.17  )
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

Adding Raul who has been asking for something like this as well.

I'd also really like to move nvme_acpi_storage_d3 out of the NVMe
driver.  The Microsoft document that the original document references
makes it very clear that this is not NVMe specific, but also covers
at least AHCI.  On top of that the platform simply can't know what kind
of PCIe device is in any given slot.  Last but not least this will also
allow us to add quirks for devices that fail to properly mark this
misfeature in the ACPI tables.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
