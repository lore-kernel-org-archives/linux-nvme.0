Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6DEC4727D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 15:29:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E4523A79
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 15:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OXY14oVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E4523A79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3XMGHpmFP7DWARnvBppBlfLKddt4U7TUNjWODk4nC5s=; b=OXY14oVsxjcowk2EDEhXSnqzM
	gUsUbeUzvkhO/yTaUp1j4Gc/hye3qXaKtxSII4krsPqV9SNHgolUqPOgb1SoZEY8S91MXb4itVMs9
	h61AnGZJiXygHo5TrBkKDjYRO8MRBCRHyzEvCsDR3F4DLefDGMWE4JzTTwM8a2YMbtCfyTBPvR6Ev
	0KP2kVQ/7+lf43YcUVJJG7adWzFHtaZhM7tCPr5xew6SzZhnu+IIbl3htUm3UCP42DRmaRm2h5S7q
	YDtz9kvzXg0hwu1WhItDRg+Dob1oaDVzSdyD+W7XtION07O8yU+w0M78Rtrc0fGDvA8kfKSlRmFPr
	+SKw72Htw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKkDu-0003eK-HZ; Tue, 22 Sep 2020 15:28:54 +0000
Received: from smtp.h3c.com ([60.191.123.56] helo=h3cspam01-ex.h3c.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKkDm-0003bx-L0
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 15:28:49 +0000
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([10.8.0.73])
 by h3cspam01-ex.h3c.com with ESMTPS id 08MFRMLE067100
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Sep 2020 23:27:22 +0800 (GMT-8)
 (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 23:27:27 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.1713.004; Tue, 22 Sep 2020 23:27:27 +0800
From: Tianxianting <tian.xianting@h3c.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
Thread-Topic: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
Thread-Index: AQHWkKof6KH2tOMk4EuCjM46q9dNfal0OdSAgAAAdACAAI18gA==
Date: Tue, 22 Sep 2020 15:27:27 +0000
Message-ID: <5099986543624f9fbbeb26c2173934ba@h3c.com>
References: <20200922062517.30031-1-tian.xianting@h3c.com>
 <20200922145705.GA4035426@dhcp-10-100-145-180.wdl.wdc.com>
 <20200922145842.GB28420@lst.de>
In-Reply-To: <20200922145842.GB28420@lst.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 08MFRMLE067100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_112847_273021_73C17D53 
X-CRM114-Status: GOOD (  10.63  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you Keith, Christoph,
So I don't need to send v3 patch? 

-----Original Message-----
From: Christoph Hellwig [mailto:hch@lst.de] 
Sent: Tuesday, September 22, 2020 10:59 PM
To: Keith Busch <kbusch@kernel.org>
Cc: tianxianting (RD) <tian.xianting@h3c.com>; axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] nvme: replace meaningless judgement by checking whether req is null

On Tue, Sep 22, 2020 at 07:57:05AM -0700, Keith Busch wrote:
> The commit subject is a too long. We should really try to keep these 
> to
> 50 characters or less.
> 
>   nvme-pci: fix NULL req in completion handler
> 
> Otherwise, looks fine.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Yes.  I was about to apply it with a similar edit, but I'll take yours happily.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
