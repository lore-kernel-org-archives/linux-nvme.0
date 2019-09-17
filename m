Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E5EC49ED7
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 02:57:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3EC20650
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 02:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uxe5j7X8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oeyU4d/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3EC20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=emgin1ebQaOiyvBE5Tg8EcgfQfvK+9Q9MIxHhKzS2WE=; b=uxe5j7X8Wof3Qs
	hb5QmmTnbGz6AhI69jsOwYV/AcryVLXqvcsACIeWqGM6vPciFlIZbPV82paDcZXFRonk752V/oqaH
	Z1pwvmA8qtt6xMDk2dB1M+umNo6Vyfzc1yBdtX5I07CwO4GyonknV5dQNlFDkRjL3Rb613J5qoDku
	eYRBk+J2l6drWTSWphxroncNZ9jyEWrIBDcAKYqUHAfcIWJeaIW1PFsMueuOQrZkBJiB0NuhRdSpr
	J11S5DKDnYNVGoVxEukPIwi+nzecMWwhgEvyRdm7o0UPKrtbnUbz4W5V7v5okXZ/kKv4jU4/L563w
	rIl2d1pMp0VVeSgiIAVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iA3fi-00083I-QS; Tue, 17 Sep 2019 02:56:55 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iA3fg-00082v-M3
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 02:56:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1568689012; x=1600225012;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=87S4RqFez4Eb+YGUqpFU80cmQxszfkg2ib3FHHiNPhA=;
 b=oeyU4d/14PtRqvjJq1+bYZq4Fve6y/YyIqiJgX/+vI/ij8VoekQeEEHw
 Ej9TzuklPRuYup2N/OYsPGF2H2CR6ub6ZBxGP4r56x5KifC3TIQGHe5bH
 oghwMMYyyTwYYooIC7Sab6bbOzl2PyOKsplRuqJYdqmGK9KtGXTMJPm3a M=;
X-IronPort-AV: E=Sophos;i="5.64,515,1559520000"; d="scan'208";a="421504725"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 17 Sep 2019 02:56:46 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS
 id 6F345A23B2; Tue, 17 Sep 2019 02:56:45 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Sep 2019 02:56:44 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Sep 2019 02:56:44 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Tue, 17 Sep 2019 02:56:44 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH v2 2/2] nvme/host/core: Allow overriding of wait_ready
 timeout
Thread-Topic: [PATCH v2 2/2] nvme/host/core: Allow overriding of wait_ready
 timeout
Thread-Index: AQHVaowZshcyWEmjyEelOxdztN14/6ct71GAgABReYCAADoPgIAAVLeAgABF6ICAAByAAA==
Date: Tue, 17 Sep 2019 02:56:44 +0000
Message-ID: <9612b87ed79704b89da559f42e3051ecb171a2ce.camel@amazon.com>
References: <20190913233631.15352-1-sblbir@amzn.com>
 <20190913233631.15352-2-sblbir@amzn.com> <20190916074153.GA25606@lst.de>
 <c51a4ac0b974e6efbd4f9d67adc8a70ae94ac325.camel@amazon.com>
 <20190916160117.GB1455@lst.de>
 <b9eb8038c04e3ae87d4f55ea228f8d12ef1ed42a.camel@amazon.com>
 <20190917011441.GA31163@C02WT3WMHTD6>
In-Reply-To: <20190917011441.GA31163@C02WT3WMHTD6>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.153]
Content-ID: <30F5BEE2D6797F4FA1EB924AC3EF0C28@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_195652_857110_3712A04E 
X-CRM114-Status: GOOD (  17.17  )
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
Cc: "axboe@fb.com" <axboe@fb.com>, "sblbir@amzn.com" <sblbir@amzn.com>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2019-09-16 at 19:14 -0600, Keith Busch wrote:
> On Mon, Sep 16, 2019 at 09:04:31PM +0000, Singh, Balbir wrote:
> > I wonder if I should just call it debug_wait_ready_timeout and in the
> > comments about the help/description call out that this is a debug
> > feature.
> > 
> > What do you suggest?
> 
> I recommend going to the vendors that report incorrect timeout values, and
> apparently broken controllers that can't initialize, to have them fix
> both. If it doesn't initialize in 128 seconds, your only debugging
> recourse is to report to the vendor anyway; overriding the timeout to
> something under what the device reports it requires doesn't exactly
> provide you any additional debugging information.
> 

In my case I was doing a simple mirror (using madadm across two nvme
devices) and when I get timeouts on one, I need to wait up to 128 seconds
before switching over. Ideally I want this to be really fast and drop
the slow broken controller.

> If you really need the driver to do spec non-compliant behavior, we have
> quirks for that.

I like the quirks approach, but it assumes the timeout value is not
variable, but rather fixed by the quirk. I was attempting to really have
mirrored IO timeout quickly on a bad device.

Balbir Singh.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
