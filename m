Return-Path: <SRS0=XVsr=XL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A00C49ED7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 21:05:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E5B206C2
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 21:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SHoxOHPw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OQk8YkFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E5B206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mcjfKxYMSo93leXix4DVBQE5eK8BHC1wwgM00u7RZko=; b=SHoxOHPwMNdEyH
	2fZ8YND937Q+Erd7L+waLy+v9eIJT7YSc29qoozGU7dwhF6mWE4cL0nI4QwYTxQBJeOAyHdRlvZay
	J/NGPbVpmdBdY3ksvKYoD1vsYmVEuIV9n2IPBsMwwKho9oMLsFa+SgIwEk8S54cmcv4HDP6oKIowE
	o+cS1L1/iqyOav7xg3WWKAxtPA1jXwgb0ucuZ2N8N/LV5xJQnLMHELCZTXmTDCX9OwNGV8l+STHyR
	v22UQYb/X0WwBOyLdymyqA2GzvB08iqt7xMAi/cabfUIekYbfLbRq/K/ud0wbgvb+P2a7v/Pi1qYI
	ms79+Za23oECJhCjVPQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i9yBA-0002kN-SI; Mon, 16 Sep 2019 21:05:00 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9yB7-0002jz-VE
 for linux-nvme@lists.infradead.org; Mon, 16 Sep 2019 21:04:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1568667897; x=1600203897;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VfLReCTc77xcw6BdxYkMQCwAbe94XdXtSULpMv2w5Fw=;
 b=OQk8YkFTj58wKc8XOYNWGYPMad5r5MPLgNtDm12HokIz9PGjguIdoUcA
 shCjGmMNmnLGlRlOWqfBmR2QvIjCLgQKUMnRW6xFm2Zkmpe0xAMcUPD8U
 OgcMK/HzjIi//JD/+O4uH9bGJ2fbaNkBTSpdvKp/7qzfONb9nLHgwNlAv I=;
X-IronPort-AV: E=Sophos;i="5.64,514,1559520000"; d="scan'208";a="702727060"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO
 email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.22.38])
 by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
 16 Sep 2019 21:04:36 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS
 id 4D5AEA2696; Mon, 16 Sep 2019 21:04:31 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Sep 2019 21:04:31 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Sep 2019 21:04:30 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Mon, 16 Sep 2019 21:04:31 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v2 2/2] nvme/host/core: Allow overriding of wait_ready
 timeout
Thread-Topic: [PATCH v2 2/2] nvme/host/core: Allow overriding of wait_ready
 timeout
Thread-Index: AQHVaowZshcyWEmjyEelOxdztN14/6ct71GAgABReYCAADoPgIAAVLeA
Date: Mon, 16 Sep 2019 21:04:31 +0000
Message-ID: <b9eb8038c04e3ae87d4f55ea228f8d12ef1ed42a.camel@amazon.com>
References: <20190913233631.15352-1-sblbir@amzn.com>
 <20190913233631.15352-2-sblbir@amzn.com> <20190916074153.GA25606@lst.de>
 <c51a4ac0b974e6efbd4f9d67adc8a70ae94ac325.camel@amazon.com>
 <20190916160117.GB1455@lst.de>
In-Reply-To: <20190916160117.GB1455@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.189]
Content-ID: <7AEB250C6960084582ABA8A199B936DE@amazon.com>
MIME-Version: 1.0
Precedence: Bulk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_140458_053982_525B19CC 
X-CRM114-Status: GOOD (  19.47  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sblbir@amzn.com" <sblbir@amzn.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2019-09-16 at 18:01 +0200, hch@lst.de wrote:
> On Mon, Sep 16, 2019 at 12:33:31PM +0000, Singh, Balbir wrote:
> > > Then again I'm not even sure we really want this.  The debugging use
> > > case is somethign where you can easily hack a line in the driver, and
> > > we really don't want normal users to mess with a random parameter
> > > like
> > > this one.
> > 
> > The reason I sent this out is that I've seen some controllers setting
> > this to max value. I suspect there is no good way for the controller
> > to set wait ready values either. In any case 128 seconds for a failure
> > seems a bit too much, specially if the controller does not respond on
> > boot and hence the debug option. I don't expect it to be used by normal
> > users on most of their systems
> 
> The problem with these tweaks is that people will touch them for
> weird reasons.  Another one is that a module parameter is global,
> while many settings should be per-controller (although that would
> add even more boilerplate code).

I do understand the concerns, may be a sysfs file would be better for
per controller tweaks, but that means it is hard to apply on boot.

I wonder if I should just call it debug_wait_ready_timeout and in the
comments about the help/description call out that this is a debug
feature.

What do you suggest?

Cheers,
Balbir Singh.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
