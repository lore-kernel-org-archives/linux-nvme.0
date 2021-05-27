Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0185C47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 18:48:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EED7613D1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 18:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EED7613D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3GrIFYJpou9UlDRQXrRy1HjQI9lIJdxmL5PI8y5N3wg=; b=UrILg+j82GXQOK
	547ZOKhqwp9ZtXAUzkNpIFq8o3sg/AH5kIhBaK2N5tBFoUX/wim48L4ZK4LsQMQgljQLppOOyOKex
	7+gyA4Qv/pYkNgIxNcZLELbn2zJ2pDFh+vZv1EKmOPnPFxV1eJ4lRIcggT2/IbDGLWjc16X4uPXmx
	8H6Uwb7Fmm9k1pZoxqeU62yvgGv1HcE1uCm1r+nWJPmDnL4D+W3cXyPSudkLOj84eoIvKoa0IKRen
	5FeAj7zXemNC7Ji4i2CEG6HtmK/mY/nzqXbn5XI/nvuBCXq/RJQdIWmz26i3QwtPgak0L/sX3R1xn
	TVtM0xNQqUxJ+aLmhcVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmL34-008euW-CB; Thu, 27 May 2021 18:48:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmJom-0085s9-UX
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 17:29:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 584AA68BEB; Thu, 27 May 2021 19:29:01 +0200 (CEST)
Date: Thu, 27 May 2021 19:28:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Prike Liang <Prike.Liang@amd.com>, rrangel@chromium.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
Message-ID: <20210527172857.GA7426@lst.de>
References: <20210527135941.7634-1-mario.limonciello@amd.com>
 <20210527143548.GA32170@lst.de>
 <c911ed05-071f-ddcd-7f76-9cb7535dd01b@amd.com>
 <CAErSpo5za0x1fXm18YNzdNRFdaucVs=9Hhh2kqRS_baWos5Vgg@mail.gmail.com>
 <20210527165844.GC3706388@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210527165844.GC3706388@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_102913_175748_34775F56 
X-CRM114-Status: GOOD (  16.17  )
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

[adding Rafael]

On Thu, May 27, 2021 at 09:58:44AM -0700, Keith Busch wrote:
>  EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
> +
> +bool acpi_storage_d3(struct device *dev)

This need a really good kerneldoc comment.  Not like pci_pr3_present
which somehow made it into the PCI core, but has not explanation
whatsoever..

> +{
> +	struct acpi_device *adev;
> +	u8 val;
> +
> +	/*
> +	 * Look for _DSD property specifying that the storage device on the port
> +	 * must use D3 to support deep platform power savings during
> +	 * suspend-to-idle.
> +	 */

This is part of what should got into the kerneldoc

> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
> +		return false;
> +	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> +			&val))
> +		return false;
> +	return val == 1;
> +}

adev could be initialized at declaration time.

Also any chance we could have acpi_fwnode_property_read_* helpers
that include the NULL check and the acpi_fwnode_handle conversion which
seems to be boilerplated all over?

Also I wonder if having this only in ACPI is a good idea.  What when
we get the same thing in OF?  Isn't this something that the PM layer
should tell the device when calling ->suspend?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
