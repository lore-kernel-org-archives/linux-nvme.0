Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B896C47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 14:18:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254CD6109F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 14:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254CD6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vN+8ua6rkrByUPFZcBgsYj2dvF6dd5EtOp/mbTOBwDA=; b=TR/FKtbAVqy8+L
	KzjEyHh33eghhaKyFF8NXYCVa+9hvkb3RPMUoRwlD2E+4xriA/bD49soax6BzJjrafn9wHmJ3JBbu
	EExBDfygpPXMTOm5wB6mLa5Fi1rnnGInRpi1Cj9evZ6O77PceuKDNaLFaLzCQzG+v9pB5D/Tw9wXo
	eE1H3dTJ8GGT/XEGfgNUAv3l0aaqB0zPB3p/wea7XupqG0uH2Rqptfe0NtNYNqdGUDKB8SQ/Hz03D
	onq3uM8BZlA199oTrTqbr4FFa/gKubKHSQtkFkWsMqUCvrNxgA1DHU+PYnRTqP8zhHKKnJKbCwHxe
	X16tuYRLDn4QNJJaMuug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqG4k-0041iA-TZ; Mon, 07 Jun 2021 14:17:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqG4g-0041hI-M1
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 14:17:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A24C761130;
 Mon,  7 Jun 2021 14:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623075473;
 bh=L/IcAmlfla3G6jqxEY2OT9sBai4M7rEkPnSNSRR930Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pp0Mmj/UapJ4mrUgFZgd3pKjSq1mLFQzXvDWyCijXdrHgS7IrfkUVLtxTuyXRcfvR
 YLe+/lfEOpkQzMIm0B1iw2A7uj9CEnpr3CTp5Cx5DFy8sGCOEP/jVE775bEQxZd9kg
 E4nxsZkBVTB0KF3k76q+Jg2CvjEu0CmLfdlpCIaqbb0qUbXFr+zLV4tmaf6474wTpm
 2mWCpDLPMnO1VcCC4t4a68gZnUMisbV/vQvLRf/Ln+tBgZLao1zMR9TrkPy+m8UAJ9
 qdf+pj5emT3NafmqdeYnAZGKw8vNdETJnq0X4iDVsqWtVAtfrQL7Eao1mNMd9h3Ebu
 700rTX7AbRZ7g==
Date: Mon, 7 Jun 2021 23:17:47 +0900
From: Keith Busch <kbusch@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Alexander.Deucher@amd.com, prike.liang@amd.com
Subject: Re: [PATCH v4] acpi: Move check for _DSD StorageD3Enable property to
 acpi
Message-ID: <20210607141747.GA21631@redsun51.ssa.fujisawa.hgst.com>
References: <20210603190753.5084-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210603190753.5084-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_071754_758766_8B7D4A51 
X-CRM114-Status: GOOD (  10.30  )
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

On Thu, Jun 03, 2021 at 02:07:53PM -0500, Mario Limonciello wrote:
> Although first implemented for NVME, this check may be usable by
> other drivers as well. Microsoft's specification explicitly mentions
> that is may be usable by SATA and AHCI devices.  Google also indicates
> that they have used this with SDHCI in a downstream kernel tree that
> a user can plug a storage device into.
> 
> Link: Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Suggested-by: Keith Busch <kbusch@kernel.org>
> CC: rrangel@chromium.org
> CC: david.e.box@linux.intel.com
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
