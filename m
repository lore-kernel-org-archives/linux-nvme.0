Return-Path: <SRS0=imtT=XI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0C6C49ED7
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 22:46:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A462089F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 22:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JkqVyNu3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GaP0t8Wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A462089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qlBWGM30cBlLFWMIAbh7aJxX0HgQJB/BfEC0zj0m2mw=; b=JkqVyNu3dhnhKM
	jYC5pU1SRIbZxk7Scizf+sWI5MjGSNbFP6DI6oeklzlgAeG/CrZvDUqHsElEUtm7NByH8sHQdH4Zi
	RcfHRx45uP65dvzuZ9OYL0c/PvkxN2ImBjvNA+/0gBToRxDezKE56X6Bk4lv4zGeNcHF3eYhlkWw0
	pGZbDw2FFVkiFc7U9lQE2rMa1o2O4SRa1lgSo8IYc8sNVvWl6INs7YlzTKVOSTWgwJ64TqvO77poT
	3nJHMHgm7pd/cfECBhNEHwmX7p4OdQxDTwAfSQw53HbbnRIW51puOK9jMV9FXClDHtJF4w3bfq54e
	BzuQvyv1np1WuNI4FHhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8uL1-0007B2-Hf; Fri, 13 Sep 2019 22:46:47 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8uKy-0007Ad-Is
 for linux-nvme@lists.infradead.org; Fri, 13 Sep 2019 22:46:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1568414804; x=1599950804;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TVVtncXAMkBiOHFTqBwDUwqEj/jm5yAWGH6HuwhcjhQ=;
 b=GaP0t8WmrOvf9y2p33B1ruOCgoTgAhsQurol0cYuDJxXPvH2YeVkPb4k
 hrO1bmVf83FAI0wuhN/wG5Dz3H1Y5/FdR8+B5VCMFAw+Z45adI9mu8iNd
 C/4wH9uGugSB2ZIVqjacwoBFhiuduHk2oWqHCnFcS7+xS312XWBqOkvGY Q=;
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; d="scan'208";a="421091822"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 13 Sep 2019 22:46:41 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS
 id 5A921A230A; Fri, 13 Sep 2019 22:46:41 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 22:46:40 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 22:46:40 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Fri, 13 Sep 2019 22:46:40 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "bvanassche@acm.org"
 <bvanassche@acm.org>, "sblbir@amzn.com" <sblbir@amzn.com>
Subject: Re: [PATCH 1/2] nvme/host/pci: Fix a race in controller removal
Thread-Topic: [PATCH 1/2] nvme/host/pci: Fix a race in controller removal
Thread-Index: AQHVad0weaqtoCO2e0WbgGM6z7w9W6cptIiAgABjv4CAAAuugIAABdUAgAAMsAA=
Date: Fri, 13 Sep 2019 22:46:40 +0000
Message-ID: <082c6d54bfb05cab364821094a089d5f0f92f643.camel@amazon.com>
References: <20190913024432.7705-1-sblbir@amzn.com>
 <20190913150132.GB17139@keith-busch>
 <3cf02675ea58f3e3b91f23f63e53f1d2010fadf9.camel@amazon.com>
 <ad85a4ac-7b88-a855-abe2-6fab85c703a8@acm.org>
 <9feca2b1c52a960451b24c2f1d2239e7875101e3.camel@amazon.com>
In-Reply-To: <9feca2b1c52a960451b24c2f1d2239e7875101e3.camel@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.189]
Content-ID: <BE767E0EB80F914F8A0F0BA520C58443@amazon.com>
MIME-Version: 1.0
Precedence: Bulk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190913_154644_756439_F8498A73 
X-CRM114-Status: GOOD (  13.80  )
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
Cc: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, 2019-09-14 at 08:01 +1000, Balbir Singh wrote:
> On Fri, 2019-09-13 at 14:40 -0700, Bart Van Assche wrote:
> > On 9/13/19 1:58 PM, Singh, Balbir wrote:
> > > The real issue is that by then udevd has already called into
> > > blk_queue_enter()
> > > and is waiting on wait_event(q->mq_freeze_wq,...), so we do need
> > > to unfreeze
> > > and wake_all waiting on the event.
> > 
> > I don't think that's correct. blk_set_queue_dying() wakes up 
> > blk_queue_enter() and causes it to return -ENODEV.
> > 
> 
> Fair enough.. I presume looking at the name, it was twiddling
> bits. I am going to test with just the re-ordering and check.
> 

Upon further check, blk_set_queue_dying() tries to freeze the
queue again, but then it does do an unconditional wakeup.
I can confirm that just re-ordering seems to help and
blk_set_queue_dying() seems to have the right bits.

Respinning for comments, thanks for the reviews Bart
and Keith

Balbir Singh.

> > Bart.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
