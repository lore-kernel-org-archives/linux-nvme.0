Return-Path: <SRS0=n1R8=2N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789D3C2D0C8
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2019 01:53:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501DC206CB
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2019 01:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J9X7p2+B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uynViSAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501DC206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UQKDjON53EluCxCECFayOEfY65WHAfshOdoqjVEypyE=; b=J9X7p2+BMfA5Wm
	ZfavziL0bISf0RVznH3KzqFiGxDHAxqn3K9BPxhOhrAJXGNgY4IvUfrSIwjDBdqg5dGibz/lCX3uv
	dU43InVXnm0YqX9rnLC/nE8ill9tt8iwj1VDHIGzFlw64cXMFGC0Xn6RFfuqGfjy0D89TQpLR6J4t
	g0wPGsYNVH58O69R5kVN1mcsuMX1EL+Jc5zluAKGN3BLo8ssJNn706pEUlJnFcyt7ZMbJJglW0dbD
	VWHMjZbwCwl9Jw/P3MFJKM9vaLwL9H9+N5FfN+k5igWpVZ/KTEygqPP5mFwNzBCPH29QBAr/hvIKj
	XDg1pW8SPOVTY7/e2PrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ijCup-00064Y-OG; Mon, 23 Dec 2019 01:53:47 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ijCum-000649-DF
 for linux-nvme@lists.infradead.org; Mon, 23 Dec 2019 01:53:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1577066024; x=1608602024;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+wko5RT25RxW2zeycjxSO5Xakzc/zM0/ZUap54jab14=;
 b=uynViSAktnp2WPcHnZCDRveb7lE3Si6+CLRmTGzYuTs9kgNzePsZKR9V
 /ANwZmXjJfIyOziJ+NDN3fdZouLKHgpT1OeyfyeBrjIRRb/3a8OzztcMH
 OJsE7p6yV/PCyvEtz7G21QRJ9sLM7g7m1ihxLf4jlCO+g5oyxd0hwAB+2 A=;
IronPort-SDR: 7ryDAeCaJipu6dr1NaTh+ZQLiiweTV1ev5z/mCxhwEP8xXivmZ2jz53XmcMjjVnp4eJofiUsxM
 2R2IthzTw2WQ==
X-IronPort-AV: E=Sophos;i="5.69,346,1571702400"; 
   d="scan'208";a="9713435"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.43.8.2])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 23 Dec 2019 01:53:42 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS
 id A8E2CA23BF; Mon, 23 Dec 2019 01:53:41 +0000 (UTC)
Received: from EX13D11UWB003.ant.amazon.com (10.43.161.206) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:53:41 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB003.ant.amazon.com (10.43.161.206) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:53:40 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Mon, 23 Dec 2019 01:53:40 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "=linux-block@vger.kernel.org" <=linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Thread-Topic: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Thread-Index: AQHVuTIQS2D+6UASEUSut4lHWyy8r6fG9TQA
Date: Mon, 23 Dec 2019 01:53:40 +0000
Message-ID: <e452f6a638fe09f065b9e4cd1c25d5d3a2f29e5a.camel@amazon.com>
References: <20191223014056.17318-1-sblbir@amazon.com>
In-Reply-To: <20191223014056.17318-1-sblbir@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.78]
Content-ID: <B7D314F84E432C468D7F28186EDB3776@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191222_175344_578291_DC54E07C 
X-CRM114-Status: GOOD (  12.53  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "Sangaraju,
 Someswarudu" <ssomesh@amazon.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "hch@lst.de" <hch@lst.de>, "mst@redhat.com" <mst@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2019-12-23 at 01:40 +0000, Balbir Singh wrote:
> Allow block/genhd to notify user space (via udev) about disk size changes
> using a new helper disk_set_capacity(), which is a wrapper on top
> of set_capacity(). disk_set_capacity() will only notify via udev if
> the current capacity or the target capacity is not zero.
> 
> Background:
> 
> As a part of a patch to allow sending the RESIZE event on disk capacity
> change, Christoph (hch@lst.de) requested that the patch be made generic
> and the hacks for virtio block and xen block devices be removed and
> merged via a generic helper.
> 
> 

I messed up with linux-block ML address, I can resend with the right address
if needed. My apologies

Balbir Singh.
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
