Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82850C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 20:01:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47FCD6024A
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 20:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FCD6024A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AROargXbXpQ4M/U5K/l5ybYSC6BEioFTJxI/DT6BtF4=; b=uIg2HDyFrnubgW
	jcEq665E5L/OA8DY8BV4iGWy7/pNER5nUuCUc1XA6sAf6zqDgs3nfNjeNFwa+fN4nDl6v/SX7Q5fS
	CS5JOcQG/3zqi1DT4/KmHUdd/V9909x0UYeyOd1nFImvNrIbdVW3nLl7Oqwti0mhv6l8dWd8+3cIs
	2vX3/rhVf7FqHGFMb4Ww75QPtcnquczfox4WcwplZUd3vei7kTbmMM8+PePBrFmd9/3M5Xy4JLE+j
	kzM6hfR8vZOT6ZBLtdzxrNYTGB3iqjwqtDjrYJLNlh3kCqwkQfM6cMcl/EMJFIwWN9vougGEV9pQ8
	70bSEoNS0yOiM7/h3jSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqhuS-00AMNo-DK; Tue, 08 Jun 2021 20:01:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqhuL-00AMKy-9j
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 20:01:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5943361375;
 Tue,  8 Jun 2021 20:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623182464;
 bh=F2Y55vEIvmldRRvnuJh//gyZ7g+GCfz2XlFDoM/UTpE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F8U9MCxcaCa/qPwqeDahooVTEXTjWTkNUiKl1E+J45jVnXVBJPI/Tp166PNQhFLs1
 3STrTaJVFjLj6aO7aL/zMjcAwYpWZKs4g3j6T33AC4NkhFMDGAJbwlGyDiVsSB7g6t
 0FPcmOMt7RMexMjNHnqDD6w5o8g2c4F+Qon2JQ/udWC9sNqErLwQKAxaxyBbaxBj3M
 0g6MLp4tweY3Kcbxwq8zOJA80qU1CHnM8Kic55g4Qpy/81/uH8DngQteapAbGEw7bp
 LSXrbHqIOsmeIqA64fRseYyLIk01XzMA2tJGs3WEMPIImKmT8ivETOKfeb/+k9Q1Id
 HEqvScXEmMnUQ==
Date: Tue, 8 Jun 2021 13:01:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
 prike.liang@amd.com, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v6 1/2] ACPI: Move check for _DSD StorageD3Enable
 property to acpi
Message-ID: <20210608200101.GB339628@dhcp-10-100-145-180.wdc.com>
References: <20210607173156.5548-1-mario.limonciello@amd.com>
 <20210608053546.GA14116@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210608053546.GA14116@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_130105_417106_BB6A289A 
X-CRM114-Status: GOOD (  18.38  )
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

On Tue, Jun 08, 2021 at 07:35:46AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 07, 2021 at 12:31:55PM -0500, Mario Limonciello wrote:
> > +/**
> > + * acpi_storage_d3 - Check if a storage device should use D3.
> > + * @dev: Device to check
> > + *
> > + * Returns %true if @dev should be put into D3 when the ->suspend method is
> > + * called, else %false.  The name of this function is somewhat misleading
> > + * as it has nothing to do with storage except for the name of the ACPI
> > + * property.  On some platforms resume will not work if this hint is ignored.
> > + *
> > + */
> 
> I still do not like this comment.  There is nothing about only using this
> for storage devices.  It is specific to a PCIe slot, and if I plug
> something that is not a storage device into it the same restrictions
> still apply.

Hm, I thought this comment was good. Despite the dupious connection to
storage, the function name matches the ACPI property, so an explanation
for this misnomer seems appropriate.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
