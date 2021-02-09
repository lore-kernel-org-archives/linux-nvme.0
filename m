Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50A7C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 15:53:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E6C64E70
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 15:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E6C64E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=REkOsex4Ubnudogt8mRKnNGOFkFm4kBz/16uiuB12pY=; b=UxuibVxoh9ALumMpX5xXrQkPw
	lWCORtp6YI1+51dzpLqbz1WU94yr3GIbiUTjFy8d0wfwKGxhgfg5cIQD1PN8EEUUrMFWb0U8ufO2E
	NQX28nAZ30Rah7dPekUt1fF9s0trCNwNFC4SjrqgaLzv3jVxccSYgtxik3efBMq7dm+AUrUKa9rDu
	5Vp7cu0JbcMcWydLoZFEeFSojCjZCIatzdqZprs1yMJ1/C/cScJDgrlqZjKqfrNP8qWZUzf3eSml5
	jrWddtBFuuAhspo8PbD6r5Tl3YQbartSztE5hQz5TyPM9jmXOd/2X3jBHuKGoDZpz4UhAvzUjd9yg
	aOuQSyeoA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9VKi-00036T-1W; Tue, 09 Feb 2021 15:53:44 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9VKe-000365-Dj
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 15:53:42 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 9 Feb 2021 07:53:38 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::98fb:6d15:be65:b22d]) by
 SJSMAIL01.us.kioxia.com ([fe80::98fb:6d15:be65:b22d%3]) with mapi id
 15.01.1779.007; Tue, 9 Feb 2021 07:53:38 -0800
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Thread-Topic: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Thread-Index: AQHW81Uk6e6cbZGyEU2+tznAk87Vf6o6RTXQgBS+TpCAAQ2LAP//+/uw
Date: Tue, 9 Feb 2021 15:53:38 +0000
Message-ID: <94d6c39917d04b88ae0099473df9f4d0@kioxia.com>
References: <20210105224939.1336-2-clay.mayers@kioxia.com>
 <20210125195844.1390581-1-clay.mayers@kioxia.com>
 <BYAPR04MB49650B6342C736B5268F833686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b5c179e3eb904800931712d6b92cfbeb@kioxia.com>
 <BYAPR04MB49652EA8F4CF06D41C708E2386BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b2a0593cd1fc4f239bbd44f3f43d4bcd@kioxia.com> <20210209075434.GA31373@lst.de>
In-Reply-To: <20210209075434.GA31373@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.90.53.138]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_105340_492315_5350AEF1 
X-CRM114-Status: GOOD (  15.88  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, February 8, 2021 11:55 PM
> To: Clay Mayers <Clay.Mayers@kioxia.com>
> Cc: linux-nvme@lists.infradead.org; Keith Busch <kbusch@kernel.org>; Jens
> Axboe <axboe@fb.com>; Chaitanya Kulkarni
> <Chaitanya.Kulkarni@wdc.com>; Christoph Hellwig <hch@lst.de>; Sagi
> Grimberg <sagi@grimberg.me>
> Subject: Re: [PATCH V2 0/2] nvme: Support for fused
> NVME_IOCTL_SUBMIT_IO
> 
> On Tue, Feb 09, 2021 at 12:53:17AM +0000, Clay Mayers wrote:
> > > From: Clay Mayers
> > > Sent: Tuesday, January 26, 2021 1:14 PM
> > > To: linux-nvme@lists.infradead.org
> > > Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>;
> > > 'Chaitanya Kulkarni' <Chaitanya.Kulkarni@wdc.com>; Christoph Hellwig
> > > <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>
> > > Subject: RE: [PATCH V2 0/2] nvme: Support for fused
> > > NVME_IOCTL_SUBMIT_IO
> > >
> > Is there any other feedback on V2?
> 
> My feedback is that we should not add code to the kernel driver and our fast
> path for fused command unless we have a mainstream in-kernel users, that
> is not at all for the foreseeable future.

Thanks - that makes sense.  I know the patch isn't enough to be very useful on
its own.  I shared it at this stage because of my concern over the implementation.
Thanks to the feedback from the list, it is better than it was.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
