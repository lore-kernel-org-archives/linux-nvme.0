Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D63C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 23:26:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE3E20748
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 23:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q/gD53Pr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE3E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8UDm7698tOEDUaIDXfJoqXm4t3pfhS6UCj7ybCIOKZ4=; b=Q/gD53Prq4etzziuCV6TjlMkhN
	bUDvCfVQfFQI05gGw+L45hPYiYPBTzrkZTR1tbW/CjO0qqhSrvNh/2WgdZCvocTdyRztIzw+sVXom
	B0RiD3fls7JecoVJIABq0JQIc++BQe7xtdhBMmEgj+1BTKy1aWvj3vIvZkgeYuTX7bR5UtNelz6yL
	h8rWugmBsmR8QCuibhPUbv6W9ubTADyHm1oasUfnSnl7YRwY+oLUTtzgq0VCwbOi2eMYYCSaEzfC1
	VAdqCBzO7qQi1JX++yWzIJQREr1xRl+e+mYfDqJiwcMUygAXIl71fdu682ElQT842+khQhV5geNKO
	/udH43LQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8txE-0002Z5-Ew; Thu, 20 Aug 2020 23:26:44 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8txB-0002YS-2l
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 23:26:42 +0000
IronPort-SDR: LOGbB0YLCHraJ69YSSHrzEy6waR5DctCFE+EsZiXH4to2oqdlyVdKEtaSMe/Uvm3LlyXWb4Gxf
 ZCOl3EwYrVdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="216962892"
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; d="scan'208";a="216962892"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2020 16:26:37 -0700
IronPort-SDR: 9Ky8mvGz0EN6h1i76ZR7v1lvNDl6DrRr3zpNs9V+NYGDw4SEgSPFiy5VWkb1qrPkhvjvx+kJ6N
 Hj1MJ1KtOSww==
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; d="scan'208";a="472830363"
Received: from unknown (HELO dwf-u18040) ([10.232.115.15])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2020 16:26:36 -0700
Message-ID: <0e911fce1c5c6f7dc01263ecdc280e76a0ea202f.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
From: David Fugate <david.fugate@linux.intel.com>
To: Keith Busch <kbusch@kernel.org>
Date: Thu, 20 Aug 2020 17:26:35 -0600
In-Reply-To: <20200820034539.GA12222@redsun51.ssa.fujisawa.hgst.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
 <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
 <20200819221054.GB26818@dhcp-10-100-145-180.wdl.wdc.com>
 <d9cc3ece0c70b51c2d40998081375ad3fa39ece2.camel@linux.intel.com>
 <20200820034539.GA12222@redsun51.ssa.fujisawa.hgst.com>
Organization: Intel
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_192641_262490_8CA14050 
X-CRM114-Status: GOOD (  16.34  )
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
Reply-To: david.fugate@linux.intel.com
Cc: Jens Axboe <axboe@kernel.dk>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, david.fugate@intel.com,
 Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2020-08-20 at 12:45 +0900, Keith Busch wrote:
> For the record, the suggestion provided, which you agreed to look
> into,
> most broadly enables your hardware on Linux and was entirely to your
> benefit. Not quite as dramatic as a political conspiracy.
> 
> You later responded with a technical argument against that
> suggestion;
> however, your reason didn't add up, and that's where you left the
> thread.

The suggestion to the rejected patch was passed onto the related FW
team, and the "technical argument" was our FW team's response to the
suggestion which I relayed to the list. At this point, there's no
closure on whether the device will get NOIOB.

My point in bringing up this example was a one-line, highly-
maintainable patch which improves the performance of Linux should not
have been immediatedly NAK'ed as it was. If you believe it should have,
we'll agree to disagree.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
