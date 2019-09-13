Return-Path: <SRS0=imtT=XI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCAFC49ED7
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 20:58:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B92520717
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 20:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qd6lRR7S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YMOWQVT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B92520717
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dsXBUzyzIv2iAe0VS2H0YxHbLs3DE+XHES6jg98gHVg=; b=qd6lRR7Shk9XR6
	BMLKI+tCzXYnZgJ7/BK7cezp+rGRpt8RTBD9mMnW8Gjq1X9yw3+LkUc+NUn6PeObs8ObrloiRhD5z
	ob5Rsf91lXDtbbLVxdOISKecExhkz2JChOJLAICNYjtTZ/trzpT6pasfEGOnKgyanCnMq7aihTWqm
	IhXOrCmeRc6/7boVgF1YO3XcnefugKgpSp/wkYiIhq48Wzr43F/rHGV/LQ6SASy4ZELfvA5CMUsZ2
	DpfDnzUphxPSdRrYvL+7b//kj9U/kPn3GdB5eDLOCydR9VSVcwQvzpIMydR1tvk61LXMqbnoFYQJy
	r+DFRful1h3Cb28k/IBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8seP-0004s1-IZ; Fri, 13 Sep 2019 20:58:41 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8seM-0004rC-QY
 for linux-nvme@lists.infradead.org; Fri, 13 Sep 2019 20:58:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1568408318; x=1599944318;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yMPKZ89+PxC8VbRnv30PTW9V62mtEgaA/7WoHDmgMoY=;
 b=YMOWQVT09nGh3t7rzm//D1JS6V4j1bHSOhY17ESHYeNZJUnRgkdq+fgJ
 SNkHR3gLlMxBtDnqbe286mi2sk4kT0a0/DOBQwbxUbBtGruwn5H3LWoI+
 JffCWs+lWLZMXFQqoKWPyptDP5LWNKTh8pOXUU5i6euC7KDGuuMlF+rzk s=;
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; d="scan'208";a="421079619"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 13 Sep 2019 20:58:36 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS
 id F39CBA22E3; Fri, 13 Sep 2019 20:58:35 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 20:58:35 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 20:58:35 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Fri, 13 Sep 2019 20:58:35 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "sblbir@amzn.com"
 <sblbir@amzn.com>
Subject: Re: [PATCH 1/2] nvme/host/pci: Fix a race in controller removal
Thread-Topic: [PATCH 1/2] nvme/host/pci: Fix a race in controller removal
Thread-Index: AQHVad0weaqtoCO2e0WbgGM6z7w9W6cptIiAgABjv4A=
Date: Fri, 13 Sep 2019 20:58:35 +0000
Message-ID: <3cf02675ea58f3e3b91f23f63e53f1d2010fadf9.camel@amazon.com>
References: <20190913024432.7705-1-sblbir@amzn.com>
 <20190913150132.GB17139@keith-busch>
In-Reply-To: <20190913150132.GB17139@keith-busch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.147]
Content-ID: <D3BDB48F77EFDF4A87C2513BE83F22D5@amazon.com>
MIME-Version: 1.0
Precedence: Bulk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190913_135838_988393_A88D4CE3 
X-CRM114-Status: GOOD (  11.22  )
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

On Fri, 2019-09-13 at 09:01 -0600, Keith Busch wrote:
> On Fri, Sep 13, 2019 at 02:44:31AM +0000, Balbir Singh wrote:
> > Allow the hung tasks a chance by unfreezing the queues after
> > setting dying bits on the queue, then call revalidate_disk()
> > to update the disk size.
> 
> Isn't it enough to just set the queue to dying? That should unblock
> everything calling blk_queue_enter().

The real issue is that by then udevd has already called into blk_queue_enter()
and is waiting on wait_event(q->mq_freeze_wq,...), so we do need to unfreeze
and wake_all waiting on the event.

Balbir Singh.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
