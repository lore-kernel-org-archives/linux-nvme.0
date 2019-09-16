Return-Path: <SRS0=XVsr=XL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC232C49ED7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 12:33:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F005214D9
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 12:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AOmAQr+g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WZdXbDFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F005214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JUHMrkFnUGDwatnP+yrcq/JnAJykFoMKOkmfr/+KpZk=; b=AOmAQr+gPpqr9y
	u41EzwCpr7hO6cx3Dow88+4I78QQdJU9SM767EFoOPNTCe1Po5DT0AysdWmxJSxBgq1doo5/TmaH1
	Sy6k7epZBCTjp3ZbLDt3KyH+kYsUIxOHTm1ostWLebZsyb1jzA/cwRyrByOzHZ5TLHQbOIQ3BiRl+
	W7gdYxExxhhymv4zTZnwpgdp7/7Q1ayTGZHd4deL21LyrqFkLJULY49tOcvhb9gHUH286MtVGkSSQ
	n4V8zYoM5pUvi0LrRb+aMClQtc3HEAWQbIK096gKX/JzKFUnP2i/n3clTdlbVM0WuS6AEjx7K8PF0
	Aaoha5A1gGvFdwtmqxgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i9qCL-0002Sf-FB; Mon, 16 Sep 2019 12:33:42 +0000
Received: from smtp-fw-4101.amazon.com ([72.21.198.25])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9qCH-0002QS-95
 for linux-nvme@lists.infradead.org; Mon, 16 Sep 2019 12:33:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1568637217; x=1600173217;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KQ0Bjw7bVhOSA82rZrJQ8sm1nzylNxLZrs4T1Jdm6Gg=;
 b=WZdXbDFHhNO+mNO4alXdDf1nNBehKlg6DMVv1Uk7qpz0hUcQlBlmfDF9
 mQ0CUNLOprilDWSK+xO+JKQ6iOb7yaAHuG2ElT5ZPd2OH6urRh6aMAZUn
 Z+e9fRHW/e1EOg0mZii/HDlZ1zD/gGQdQfp2lHlg9khzWjOKtmuH3Km4Y E=;
X-IronPort-AV: E=Sophos;i="5.64,512,1559520000"; d="scan'208";a="785151080"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP;
 16 Sep 2019 12:33:33 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS
 id 9C4F9A2382; Mon, 16 Sep 2019 12:33:32 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Sep 2019 12:33:32 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Sep 2019 12:33:31 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Mon, 16 Sep 2019 12:33:31 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "hch@lst.de" <hch@lst.de>, "sblbir@amzn.com" <sblbir@amzn.com>
Subject: Re: [PATCH v2 2/2] nvme/host/core: Allow overriding of wait_ready
 timeout
Thread-Topic: [PATCH v2 2/2] nvme/host/core: Allow overriding of wait_ready
 timeout
Thread-Index: AQHVaowZshcyWEmjyEelOxdztN14/6ct71GAgABReYA=
Date: Mon, 16 Sep 2019 12:33:31 +0000
Message-ID: <c51a4ac0b974e6efbd4f9d67adc8a70ae94ac325.camel@amazon.com>
References: <20190913233631.15352-1-sblbir@amzn.com>
 <20190913233631.15352-2-sblbir@amzn.com> <20190916074153.GA25606@lst.de>
In-Reply-To: <20190916074153.GA25606@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.189]
Content-ID: <B32C49F70F1DA64CA9444D2427E65087@amazon.com>
MIME-Version: 1.0
Precedence: Bulk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_053337_666258_4F6BB9F3 
X-CRM114-Status: GOOD (  20.09  )
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
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2019-09-16 at 09:41 +0200, Christoph Hellwig wrote:
> On Fri, Sep 13, 2019 at 11:36:31PM +0000, Balbir Singh wrote:
> > +unsigned int nvme_wait_ready_timeout = 0;
> > +module_param_named(wait_ready_timeout, nvme_wait_ready_timeout,
> > uint, 0644);
> > +MODULE_PARM_DESC(wait_ready_timeout, "timeout in seconds for wait
> > ready on reset");
> 
> This is only used in core.c, so it can be marked static.
> 
> Also it introduces a > 80 char line.

I'll fix that, I must revisit my checkpatch results.

> 
> > +
> >  static unsigned char shutdown_timeout = 5;
> >  module_param(shutdown_timeout, byte, 0644);
> >  MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for
> > controller shutdown");
> > @@ -1938,6 +1942,9 @@ static int nvme_wait_ready(struct nvme_ctrl
> > *ctrl, u64 cap, bool enabled)
> >  	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
> >  	int ret;
> >  
> > +	if (nvme_wait_ready_timeout)
> > +		timeout = NVME_WAIT_READY_TIMEOUT + jiffies;
> 
> I'm not sure the NVME_WAIT_READY_TIMEOUT #define really helps much
> here.
> Also the code is a little confusing as as, why not and if / else with
> the normal timeout definition?

I could refactor the patch

> 
> Then again I'm not even sure we really want this.  The debugging use
> case is somethign where you can easily hack a line in the driver, and
> we really don't want normal users to mess with a random parameter
> like
> this one.

The reason I sent this out is that I've seen some controllers setting
this to max value. I suspect there is no good way for the controller
to set wait ready values either. In any case 128 seconds for a failure
seems a bit too much, specially if the controller does not respond on
boot and hence the debug option. I don't expect it to be used by normal
users on most of their systems

Balbir Singh.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
