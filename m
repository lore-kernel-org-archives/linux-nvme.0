Return-Path: <SRS0=7ucB=3X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A0CC35249
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2020 16:19:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEEF20838
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2020 16:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t4AIpjlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEEF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zxXcVQJ6nNtqUhIvFBg0M9c+LiqANJb4D8m5wY58ezE=; b=t4AIpjlbBwKmEu
	D/TboqcFhI3McBcPOO0F0I5ZcoBKldaCmMt+vx0F1Vhhjuz3iqV0XMmDLSy5EY3KCRVAFDg3bDhD3
	A+Fvt/5W+652E0jNxmUezmEp8faJ0eBcNExDgxwBaAPF++gSKcbJkuZNbno0i2xY1VwgizniIWJz3
	1GnnEtkimF2bcH+8rtKQplsIfBRF7Yxmrxls2TEEisn8jreOQY+vNJxXX9/9agoZIjaNpAOjGhQ+j
	XOpvKkILcBlRjn3+SO0pFmCEey4m88PDrPKZKhw5Om9pkePcvoek9sFCPIqibySHpcz76I5lwws5I
	99WkSuhjmNhvw5EUaucw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iyeRg-0005wv-K7; Mon, 03 Feb 2020 16:19:32 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iyeRe-0005vs-4z
 for linux-nvme@lists.infradead.org; Mon, 03 Feb 2020 16:19:31 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Feb 2020 08:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; d="scan'208";a="234727756"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by orsmga006.jf.intel.com with ESMTP; 03 Feb 2020 08:19:25 -0800
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 3 Feb 2020 08:19:25 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.100]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.4]) with mapi id 14.03.0439.000;
 Mon, 3 Feb 2020 08:19:25 -0800
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] nvme/pci: Add sleep quirk for Samsung and Toshiba drives
Thread-Topic: [PATCH] nvme/pci: Add sleep quirk for Samsung and Toshiba drives
Thread-Index: AQHV0JE8PJxAY0HnKU6GNvS3A/cVVaf3dteAgAxo5oCABmCbAA==
Date: Mon, 3 Feb 2020 16:19:24 +0000
Message-ID: <8b14347f1a778ae324eb5d950d93fb66a95ab620.camel@intel.com>
References: <20200121193012.29360-1-jonathan.derrick@intel.com>
 <d74ae02c0a560973fda9b35acc5e5f16e1438fac.camel@intel.com>
 <20200130145559.GB8412@infradead.org>
In-Reply-To: <20200130145559.GB8412@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.0.177]
Content-ID: <259D168E44022F42949FEAE14850ED71@intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200203_081930_207161_ECC5549D 
X-CRM114-Status: GOOD (  12.63  )
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
Cc: "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "N, 
 Shyjumon" <shyjumon.n@intel.com>, "Nadolski,
 Edmund" <edmund.nadolski@intel.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2020-01-30 at 06:55 -0800, Christoph Hellwig wrote:
> On Wed, Jan 22, 2020 at 05:25:26PM +0000, Derrick, Jonathan wrote:
> > That being said, I wonder if there's something else the driver should
> > be doing for the whole range of devices and platform combos that seem
> > to require similar pm quirks.
> 
> Well, any idea of what we could do?  We're trying to follow the spec
> here, but apparently drivers only get tested with one or two windows
> drivers.  We could try to reverse engineer what they do, and given that
> the only one with autonomous is the Intel one, maybe someone from Intel
> could help?

Actually I was simply thinking of code organization. Right now some PM
quirks exist in pci.c and some in core.c. I can't comment on what other
vendors do and we're simply reactive to these issues in the platform.
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
