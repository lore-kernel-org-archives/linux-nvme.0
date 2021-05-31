Return-Path: <SRS0=adoP=K2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0219EC4708F
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 06:47:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D9B61186
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 06:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D9B61186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uNZmF0E6ANCLYc496VEt68SJs/hHtUaKvnKjiWF8yqs=; b=k9ETzP0IEY/u8U
	F/YqHtN3dzX5y0Rr2byeKSZO26bqnZ5q/lvlYxqg1vXDdV0o4zvX/OKvlT+hU4GhuYqMwUCgwUGp+
	rRkyCc5aqmTVcauWP+NxJpoYWeiY5i9Gg9YVSRN/g06lxFcHX7bw4cbg2BKljX+hGaxJzaAvBL+54
	aTdWNfV8A0zlOBIiZ8kdsKB/l2ifaic5AV8TMmUQ81T9qRi5i8c4rV4Nwth7trCZIuNV84ylvFIzk
	2VM/gtkdd5hrvw2Cx1n/L8RdeIkGe1oH0o5c8FXU1lIQdQESpQ8hEKADGvhy+rBel3XxFUKfuT+hr
	aJ4gTmT0psr/++1dwkZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnbhW-00Azbc-ER; Mon, 31 May 2021 06:47:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnbhT-00AzbH-Iz
 for linux-nvme@lists.infradead.org; Mon, 31 May 2021 06:47:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2A34F67373; Mon, 31 May 2021 08:46:56 +0200 (CEST)
Date: Mon, 31 May 2021 08:46:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Alexander.Deucher@amd.com, prike.liang@amd.com,
 Shyjumon N <shyjumon.n@intel.com>, Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH v3 1/2] nvme: Look for StorageD3Enable on companion
 ACPI device instead
Message-ID: <20210531064655.GA1417@lst.de>
References: <20210528160234.9402-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210528160234.9402-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210530_234659_799290_93E5CD0C 
X-CRM114-Status: GOOD (  17.11  )
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

On Fri, May 28, 2021 at 11:02:34AM -0500, Mario Limonciello wrote:
> The documentation around the StorageD3Enable property hints that it
> should be made on the PCI device.  This is where newer AMD systems set
> the property and it's required for S0i3 support.
> 
> So rather than look for nodes of the root port only present on Intel
> systems, switch to the companion ACPI device for all systems.
> David Box from Intel indicated this should work on Intel as well.

I think we need to wait for the confirmation from David.  This looks good,
but I'd like to see testing.  I also wonder how many of the simple suspend
quirks we can drop with this.

Shyjumon and Jon, can you retests the platforms quirked in
1fae37accfc5 ("nvme/pci: Add sleep quirk for Samsung and Toshiba drives")
with this fix?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
