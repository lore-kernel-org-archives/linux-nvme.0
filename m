Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7656BC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 00:53:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1292061606
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 00:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1292061606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=vk9m2umcD9HtFkQAYKxFT351QaCMqEShMY4zjBFwnZY=; b=q7pL9SLJ75F6HNN8BDUvoN+/X
	LzXlc/Kni+MaeJs1Gw4XkFXCFY828JLPxgiveWXqwXpdDjeCBkdd0SZa/1yJePzhi1XqRGAkkTbxO
	Z1zOugXaQgCNuVPtYl+J5Cv0VAlj9yepXd5WN8O3LMT+T+ijVYaT6SxrUleWPOPJ91kByUdFqmQ3i
	9xvqRaDr9unCBybkKBOgrTLyD033lDaL+3g0zS7vb7IElTwLrxwuZt6vERq5sUmLXG33LreFh+5Km
	t86Ct6dyN7DdEh1ZUbMoGTr+MksqHClQCQu+9GZllv752ujqG8iShPlECrpVZIIWYxkUq48gP5S+5
	cIjaq8VGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9HHU-0002C9-1C; Tue, 09 Feb 2021 00:53:28 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9HHO-0002Av-UW
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 00:53:26 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 8 Feb 2021 16:53:17 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::98fb:6d15:be65:b22d]) by
 SJSMAIL01.us.kioxia.com ([fe80::98fb:6d15:be65:b22d%3]) with mapi id
 15.01.1779.007; Mon, 8 Feb 2021 16:53:17 -0800
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Thread-Topic: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Thread-Index: AQHW81Uk6e6cbZGyEU2+tznAk87Vf6o6RTXQgBS+TpA=
Date: Tue, 9 Feb 2021 00:53:17 +0000
Message-ID: <b2a0593cd1fc4f239bbd44f3f43d4bcd@kioxia.com>
References: <20210105224939.1336-2-clay.mayers@kioxia.com>
 <20210125195844.1390581-1-clay.mayers@kioxia.com>
 <BYAPR04MB49650B6342C736B5268F833686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b5c179e3eb904800931712d6b92cfbeb@kioxia.com>
 <BYAPR04MB49652EA8F4CF06D41C708E2386BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.90.53.138]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_195323_028012_31E2543C 
X-CRM114-Status: GOOD (  11.18  )
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
 Christoph Hellwig <hch@lst.de>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> From: Clay Mayers
> Sent: Tuesday, January 26, 2021 1:14 PM
> To: linux-nvme@lists.infradead.org
> Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>;
> 'Chaitanya Kulkarni' <Chaitanya.Kulkarni@wdc.com>;
> Christoph Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>
> Subject: RE: [PATCH V2 0/2] nvme: Support for fused
> NVME_IOCTL_SUBMIT_IO
>
Is there any other feedback on V2?

My main concern I have about my implementation is how fused requests
are tunneled through the mq request layer.  The 1st request is marked as
started but it won't be in the device until the 2nd command is queued.  As
Keith pointed out, a device reset can split the two so care must be taken to
correctly handle this case.  Despite this, I thought this was a better approach
than modifying mq requests to be fused.  Especially given Christoph's 
concern of cost vs value.  This is the lightest touch I could come up with.

Further consideration of this patch may need a more compelling use case.
I've worked on a proprietary storage systems that relied on fused NVMeOF
support so it seems compelling to me.  There's a comment in target/core.c
that there is "no support for fused commands yet" implying it's been
considered.  Is pci only support for fused too soon or too little?  What would
make it more compelling?






_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
