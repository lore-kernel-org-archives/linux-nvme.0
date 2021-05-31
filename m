Return-Path: <SRS0=adoP=K2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0820DC47082
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 06:53:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1B861186
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 06:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1B861186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QhLsLxnvc0j93I7F/JI0h1r7BfIS1lZxOJFnRVQ63Wk=; b=KiEp1hkZzhL6SC
	8RM2E+3rkTG6UuQsibwqrk/+EExJU0MdJJcbp0dTFHQxnlQP9DrAN1qI8sXlxznHvUNVFU4uIAM22
	GLOAJZv3d8MaENQxIKXuNA676bJo/WfXazKXGMGy81ctq5nOvRGBY/BsM6akLfiH9A8NF2XlicEEe
	S1BWfdSB1Khc8uj0OeaVboCgDKUJW3QXS1xoB8hiZPwx6YWKJfAi++ldHn/GCGimAwodDSdV8rS4p
	4xk1BA5ogTKMCgs65oGQ3DyGZ1idJN9o5CcUILgF3Ew6exbgMBRa4lTgUq8/E3wKCJ+6uOf2ffBvC
	m/PrfE+g0E/XcAt8CgeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnbnS-00B0MK-8q; Mon, 31 May 2021 06:53:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnbnP-00B0Lf-GC
 for linux-nvme@lists.infradead.org; Mon, 31 May 2021 06:53:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4F8F067373; Mon, 31 May 2021 08:53:04 +0200 (CEST)
Date: Mon, 31 May 2021 08:53:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Alexander.Deucher@amd.com, prike.liang@amd.com
Subject: Re: [PATCH v3 2/2] acpi: Move check for _DSD StorageD3Enable
 property to acpi
Message-ID: <20210531065304.GB1417@lst.de>
References: <20210528160253.9492-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210528160253.9492-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210530_235307_703853_E3140D21 
X-CRM114-Status: GOOD (  18.51  )
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

On Fri, May 28, 2021 at 11:02:53AM -0500, Mario Limonciello wrote:
> Although first implemented for NVME, this check may be usable by
> other drivers as well.

I think we want to expand this a little more, mentioning that the
Microsoft spec for it also explicitly mentions SATA/AHCI, that Google
has a local tree where this applied to SDHCI and that even if a slot
is intended for storage a user can plug any card into it.

> +/**
> + * acpi_storage_d3 - Check if a storage device should use D3.
> + * @dev: Device to check
> + *
> + * Look for a _DSD property specifying that the storage device
> + * should use D3 to support deep platform power savings during
> + * suspend-to-idle.
> + *
> + */

Maybe something like:

/**
 * acpi_storage_d3 - check if a device must use D3 for suspend
 * @dev: Device to check
 *
 * Returns %true if @pdev should be put into D3 when the ->suspend method is
 * called, else %false.  The name of this function is somewhat misleading
 * as it has nothing to do with storage except for the name of the ACPI
 * property.  On some platforms resume will not work if this hint is ignored.
 */

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
