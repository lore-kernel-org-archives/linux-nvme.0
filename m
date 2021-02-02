Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CBDC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 11:21:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3068764E06
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 11:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3068764E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O55EmrgSIFgB16CRmm+cdBhaRzqxdI/G5JuRDQszG4U=; b=wTR8Yt+DGmTybDqY4cuImoF6y
	gpwnIeoSUED4Al+zGmCcO5nCmGEfiUzuHefPXrb8vNIqFmMnqX2nO0b9BDRR017Rsy4ciyQmt7j+Y
	NYe3PHkuE4memlWc0kXqet5hnlW0H5yPae5vOQR6bumWiBerppXmqSy57nLfpoSISmYBexm19g6J5
	YyJuRlyILNd58DxH5A1Y5IS1vJSpD+svyAvi5ay8AigNS/gyQ8iHuk9ivh5QzE5cXD7p6hoCifxfe
	NwMkeGRaSvRzqVO4XzC/M15LLISUkYa+7dBkb3q6NSPDv9A3oAM+9iss9VO04e+iSMa6CXGdCySmQ
	27LIZVltg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6tkL-00049D-BP; Tue, 02 Feb 2021 11:21:25 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6tkI-00048k-Ck
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 11:21:23 +0000
IronPort-SDR: vI6shjrm/1RvEYyBPZJHHDw7dGDOjI6jlM8ELAY/D6CDKH73oRGcT28FyPoF/qOY5EjRsk86QW
 8DHbyvDcL6zA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="178277567"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; d="scan'208";a="178277567"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2021 03:21:18 -0800
IronPort-SDR: arxa1CnexkB+IedD8L6vPTrDVN5f4z/C8a5pzT/twDzjV3GGUUsXy2Tf3v1Tqzazeo+z2FX1Hd
 8pL4xV87qATw==
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; d="scan'208";a="359007943"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2021 03:21:13 -0800
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1l6tk5-001NHP-Ui; Tue, 02 Feb 2021 13:21:09 +0200
Date: Tue, 2 Feb 2021 13:21:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH V2 3/3] Adding
 device_dma_parameters->offset_preserve_mask to NVMe driver.
Message-ID: <YBk1pUbQ/JZQ7WZe@smile.fi.intel.com>
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
 <CAMGD6P0uwVxKuG503ahGTbPcwb+y2wRXSiE_gvzfdUrMfZ5YbA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMGD6P0uwVxKuG503ahGTbPcwb+y2wRXSiE_gvzfdUrMfZ5YbA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_062122_608046_3BF4A1FA 
X-CRM114-Status: UNSURE (   8.52  )
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
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>, bgolaszewski@baylibre.com,
 Marc Orr <marcorr@google.com>, gregkh@linuxfoundation.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 axboe@fb.com, Erdem Aktas <erdemaktas@google.com>,
 iommu@lists.linux-foundation.org, jroedel@suse.de,
 Keith Busch <kbusch@kernel.org>, dan.j.williams@intel.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 01, 2021 at 04:25:55PM -0800, Jianxiong Gao wrote:

> +       if (dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))

Side note: we have DMA_BIT_MASK(), please use it.

> +               dev_warn(dev->dev, "dma_set_min_align_mask failed to
> set offset\n");

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
