Return-Path: <SRS0=imtT=XI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0343AC49ED7
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 22:01:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8345206A5
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 22:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iW0y3ov9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T+iGB3kf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8345206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Yl0Xu5zpFGyNAnlxRypmAyO5DYyihujTV9+9oatdVg=; b=iW0y3ov9Khtu/D
	MxSAhr8R9RLN7UzpZjeTbQmQmfQwasQfT4CFnwtbAzH4O1OFEgViru0ckrQM9ZA45/b04ulXF3Kb5
	w34fds7Qs6vZ/rQFVfXXqyaVcfauFwzIAXt2VxAfGkOBxrknh5r9GaDsKmSJMDI6vCzJlZ/SNU43I
	/p3RUPQVO87UYzd7/oMdFn7uIuZgKX9xpa4oc02S41y34SbkL0IpqLro7oJ/ZhMbRAxeyXByY86WI
	PAUtZv2tQL9SprkXsqfZW0ZY6Kk/v31glQM+hFFOPhNYe183wkvI2cBuX9JC5dhVIQry2nAxpry4J
	d+ThVCF4UTyyN7O+PcdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8td5-0000Qr-3K; Fri, 13 Sep 2019 22:01:23 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8td2-0000QR-MH
 for linux-nvme@lists.infradead.org; Fri, 13 Sep 2019 22:01:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1568412080; x=1599948080;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VIJbkLDasyuo3oyhLpet7SHnzxc0w51audKlfg2+xYE=;
 b=T+iGB3kfoD7uQjE8KnDAbNkArg2dsuKmpqsnTn8eq2RZQmkzx935r2oe
 5BuFyVAf27BBe6/71+FxKTSppOfiEOZupvkm+oMpXfUNV/dM57n/BTbVj
 gmKbIMMx8bXAelTBBpFWrMD2sjH9Kcyym/a+Ke+TWtHyUyjXrpKO2w/Ce s=;
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; d="scan'208";a="831809672"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO
 email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.22.34])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 13 Sep 2019 22:01:15 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS
 id 36EC9A2819; Fri, 13 Sep 2019 22:01:15 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 22:01:14 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 22:01:14 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Fri, 13 Sep 2019 22:01:14 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "bvanassche@acm.org"
 <bvanassche@acm.org>, "sblbir@amzn.com" <sblbir@amzn.com>
Subject: Re: [PATCH 1/2] nvme/host/pci: Fix a race in controller removal
Thread-Topic: [PATCH 1/2] nvme/host/pci: Fix a race in controller removal
Thread-Index: AQHVad0weaqtoCO2e0WbgGM6z7w9W6cptIiAgABjv4CAAAuugIAABdUA
Date: Fri, 13 Sep 2019 22:01:14 +0000
Message-ID: <9feca2b1c52a960451b24c2f1d2239e7875101e3.camel@amazon.com>
References: <20190913024432.7705-1-sblbir@amzn.com>
 <20190913150132.GB17139@keith-busch>
 <3cf02675ea58f3e3b91f23f63e53f1d2010fadf9.camel@amazon.com>
 <ad85a4ac-7b88-a855-abe2-6fab85c703a8@acm.org>
In-Reply-To: <ad85a4ac-7b88-a855-abe2-6fab85c703a8@acm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.27]
Content-ID: <33675E8827D5F943AE9FF24DD004291B@amazon.com>
MIME-Version: 1.0
Precedence: Bulk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190913_150120_776721_6CFBBC06 
X-CRM114-Status: GOOD (  11.87  )
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

On Fri, 2019-09-13 at 14:40 -0700, Bart Van Assche wrote:
> On 9/13/19 1:58 PM, Singh, Balbir wrote:
> > The real issue is that by then udevd has already called into blk_queue_enter()
> > and is waiting on wait_event(q->mq_freeze_wq,...), so we do need to unfreeze
> > and wake_all waiting on the event.
> 
> I don't think that's correct. blk_set_queue_dying() wakes up 
> blk_queue_enter() and causes it to return -ENODEV.
> 

Fair enough.. I presume looking at the name, it was twiddling
bits. I am going to test with just the re-ordering and check.

> Bart.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
