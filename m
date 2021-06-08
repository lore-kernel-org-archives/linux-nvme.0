Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D539C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:36:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5AC61263
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5AC61263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J/mwR6WBCJTPaYiitoakRTnlNhIQBfH3Nd4HgVlWV04=; b=B1r78xPpkUwUs/
	DObPQdn2RthjzcxFXfuV0A/GDMLKCZYkJ/xQcl1KQt72xr3fbuplaIH2EtX+r2g8VY/piZvpyiiXT
	n1ogeJ/n/zzVh5Gosi+0ZmsYclCTfMTjCr/Px1gOyrkBuG89UOjJ5tmTVkAJw0ee2lA3rYcRnhe06
	1FI1Z3oXEIMBmpq6ee8c1kKtlaDgqYUF7rnbPtWt37I3DJz/QPz8Rj1ehyn6KJY3zwFasxCmN1Wqy
	HhbprQZffTOIEjUtEsscNOHnyoMPU5Qq/n7xM2jsggzjypSrcXpJcYoAvwViPPb2u58XsC0LpdRGw
	PvAWQHMVczMqBofzGVaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqUP3-006Z0G-DR; Tue, 08 Jun 2021 05:35:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqUP0-006YzV-KT
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 05:35:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2E0A967373; Tue,  8 Jun 2021 07:35:47 +0200 (CEST)
Date: Tue, 8 Jun 2021 07:35:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
 prike.liang@amd.com, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v6 1/2] ACPI: Move check for _DSD StorageD3Enable
 property to acpi
Message-ID: <20210608053546.GA14116@lst.de>
References: <20210607173156.5548-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210607173156.5548-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_223550_844206_79025E0F 
X-CRM114-Status: GOOD (  17.07  )
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

On Mon, Jun 07, 2021 at 12:31:55PM -0500, Mario Limonciello wrote:
> +/**
> + * acpi_storage_d3 - Check if a storage device should use D3.
> + * @dev: Device to check
> + *
> + * Returns %true if @dev should be put into D3 when the ->suspend method is
> + * called, else %false.  The name of this function is somewhat misleading
> + * as it has nothing to do with storage except for the name of the ACPI
> + * property.  On some platforms resume will not work if this hint is ignored.
> + *
> + */

I still do not like this comment.  There is nothing about only using this
for storage devices.  It is specific to a PCIe slot, and if I plug
something that is not a storage device into it the same restrictions
still apply.

Also no need for the empty-ish line at the end.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
