Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4127C4CECD
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 05:02:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F8921848
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 05:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gfqfb//G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lw4r+9TJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F8921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0g4eh6sCQp2JSjx834EZLGNM4cnw53/HRIELUY8vY38=; b=gfqfb//GsG4arU
	Ka0H3l4zrIE6frtVFvSOW99loSOoyd3aPHM02mSYi0RY8OFqWFp07ZinjZQcwCpWe1QptiyfAPZBD
	l3806HfJJj9pj3+6YPjufsibATJfMmtbaTzuaJEBOvkEpZ0Szybz40f4gMQDZz9sr0cFkZ900IOxP
	8f68wnlTZa4q9XaI9DGpv318AHGpe7Feu1i26d/adtFylELEsmLgceXgZzRnTx/gha6gaJackiQFh
	RSe0kfXC+RKQaEiVNzyiAyJo3TQ7hO4MMbUs+vXFJDod0xiKIL3J4QYGsRunuENdtWyNT1MgFqgvB
	lqdNK0hZwC0K1j+vKDVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iA5d4-00080j-Oc; Tue, 17 Sep 2019 05:02:18 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iA5d1-000803-J1
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 05:02:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1568696535; x=1600232535;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9sPDs/5SKG0PjmTC8BFddIgACr6kIadUsF2cKfp4oAc=;
 b=lw4r+9TJL4NIYFmkHE4Y/i9vdtjCcLdG9x0c4Xta4UWUJ3+eFOs3YHxE
 wlcL3F5FZAvcW5+vAhcOjlPjOWjdB1sUZut++FRxkQSIPvWXuj1OOH8MY
 yC0SYBHAtaSnKweR5cjtyfieYM0xujR686Djp6Srl6VXKG5BFpGAqnyPH U=;
X-IronPort-AV: E=Sophos;i="5.64,515,1559520000"; d="scan'208";a="421515603"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 17 Sep 2019 05:02:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS
 id A48691A0945; Tue, 17 Sep 2019 05:02:11 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Sep 2019 05:02:11 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Sep 2019 05:02:11 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Tue, 17 Sep 2019 05:02:10 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "bvanassche@acm.org"
 <bvanassche@acm.org>
Subject: Re: [PATCH v2 2/2] nvme/host/core: Allow overriding of wait_ready
 timeout
Thread-Topic: [PATCH v2 2/2] nvme/host/core: Allow overriding of wait_ready
 timeout
Thread-Index: AQHVaowZshcyWEmjyEelOxdztN14/6ct71GAgABReYCAADoPgIAAVLeAgABF6ICAAByAAIAABeuAgAAdIQA=
Date: Tue, 17 Sep 2019 05:02:10 +0000
Message-ID: <34b3e7e974346816f14eb30dc35fdcddde6e6867.camel@amazon.com>
References: <20190913233631.15352-1-sblbir@amzn.com>
 <20190913233631.15352-2-sblbir@amzn.com> <20190916074153.GA25606@lst.de>
 <c51a4ac0b974e6efbd4f9d67adc8a70ae94ac325.camel@amazon.com>
 <20190916160117.GB1455@lst.de>
 <b9eb8038c04e3ae87d4f55ea228f8d12ef1ed42a.camel@amazon.com>
 <20190917011441.GA31163@C02WT3WMHTD6>
 <9612b87ed79704b89da559f42e3051ecb171a2ce.camel@amazon.com>
 <ee9a3b5b-2572-5022-0322-e1e2ae38904b@acm.org>
In-Reply-To: <ee9a3b5b-2572-5022-0322-e1e2ae38904b@acm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.16]
Content-ID: <99AA01880FF7C7478EE7980F310F3CF5@amazon.com>
MIME-Version: 1.0
Precedence: Bulk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_220215_756973_204CC7F3 
X-CRM114-Status: GOOD (  19.08  )
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
Cc: "axboe@fb.com" <axboe@fb.com>, "sblbir@amzn.com" <sblbir@amzn.com>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2019-09-16 at 20:17 -0700, Bart Van Assche wrote:
> On 9/16/19 7:56 PM, Singh, Balbir wrote:
> > On Mon, 2019-09-16 at 19:14 -0600, Keith Busch wrote:
> > [ ... ]
> > In my case I was doing a simple mirror (using madadm across two nvme
> > devices) and when I get timeouts on one, I need to wait up to 128 seconds
> > before switching over. Ideally I want this to be really fast and drop
> > the slow broken controller.
> > 
> > > If you really need the driver to do spec non-compliant behavior, we have
> > > quirks for that.
> > 
> > I like the quirks approach, but it assumes the timeout value is not
> > variable, but rather fixed by the quirk. I was attempting to really have
> > mirrored IO timeout quickly on a bad device.
> 
> Other Linux kernel storage transports (FC, SRP) decouple the failover 
> timeout from the I/O timeout. See also the output of git grep -nH 
> fast_io_fail for the kernel source tree. See also the documentation of 
> fast_io_fail_tmo in https://linux.die.net/man/5/multipath.conf. Maybe we 
> need something similar for NVMe?
> 

Great suggestion!

I tried something similar with wait_ready, isolating it from io_timeout,
since it is sort of the bottleneck w.r.t. recovery in a mirrored
configuration (timeouts on one of the volumes)

In this case it needs to be system-wide to remove the non-responsive
controller within the speculated timeout, not everyone needs it, but
it sort of gives similar behaviour to (FC, SRP) failure in a multipath
setup. I am not too familiar with FC, SRP setup, but it seems like
we should provide an aggregated timeout for full reset work on failure/
timeouts. Would that make sense to try and build or did you have some
other design in mind?

> Bart.

Cheers,
Balbir Singh.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
