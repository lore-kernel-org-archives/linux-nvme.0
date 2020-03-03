Return-Path: <SRS0=oVUq=4U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E33C3F2C6
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2020 04:04:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C112465D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2020 04:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HyhnQs0S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="i7b0Ffb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C112465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=co9nZPl0XxJ3jtsllgsUGCTPYPTyZTH3PuZqfYX2Thw=; b=HyhnQs0S6bFtNr
	GXGx82RF/0r4zWnWaIsvkBhbRQ56m9jkPeDXNG5ni7zx5PXAbarz+ZfhAt1/wN60epot7/7bhNOZN
	0Nc+5ye6z9Pj+0x/TKqBfEam0XDdDMAbyY5N7aM4LLSwg1JX7gdV2qrhqQAkUGihYIwBsXUnK9MBQ
	DZM6aykspsfkq4NCT+clg6AYU501bfEQyAsq5KxEfFM6Njn4A3lnsDX6WtW2Y7PPt0DI822ogwm/t
	eaq/Mk2EAOFLFd3cccVHgrq+SpqDfNr95UQN66K3vQveX4g1aYLW019IKo+VLXB4zwEVuecTXvdQR
	9AA/p8G/nObHz9RHfCWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8ymu-0001zq-FN; Tue, 03 Mar 2020 04:04:08 +0000
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8ymr-0001yn-SC
 for linux-nvme@lists.infradead.org; Tue, 03 Mar 2020 04:04:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1583208246; x=1614744246;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=sXeS6p7Itr7djtUdtudVwXDeytGL1G/3avUXEanK1OY=;
 b=i7b0Ffb/yhxf3zXYToXuCfp/4SHPz9h10c/NBatRGFZbyvZ0B0zGza/t
 2sIwZWf4QFGu2YN8Xa4ntKKzcGB4Lv/cMagyTq8n9j/j8dIuyDGIQwoY+
 XVWRZG7UbZHjdSz/Iz6ZhcZlulCtg2g7HCdPPF5jFwBShNPY4sXf0RQun I=;
IronPort-SDR: 4NXr8SMbetEKaQTY4fdW/KXzww/XZW3aSn+bnL3yY+9egQoy1w6JqDjzftCPrM1Hnolsmw54mg
 Nkx4Xn7O58ew==
X-IronPort-AV: E=Sophos;i="5.70,509,1574121600"; d="scan'208";a="20649458"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP;
 03 Mar 2020 04:03:49 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS
 id D0089A2CB5; Tue,  3 Mar 2020 04:03:46 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Mar 2020 04:03:46 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 04:03:46 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Tue, 3 Mar 2020 04:03:45 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 0/5] Add support for block disk resize notification
Thread-Topic: [PATCH v2 0/5] Add support for block disk resize notification
Thread-Index: AQHV7BZlqlE0eKkI5kmZncB90XbQkKg2SUiA
Date: Tue, 3 Mar 2020 04:03:45 +0000
Message-ID: <f2b805c1a420a07aa9449ee0ef77766a10e9ff20.camel@amazon.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
In-Reply-To: <20200225200129.6687-1-sblbir@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.8]
Content-ID: <97EF196BA8BC864E90A3D2B135CE2ADB@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200302_200406_042039_6869CD5C 
X-CRM114-Status: GOOD (  18.03  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>, "hch@lst.de" <hch@lst.de>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "mst@redhat.com" <mst@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2020-02-25 at 20:01 +0000, Balbir Singh wrote:
> Allow block/genhd to notify user space about disk size changes using a
> new helper set_capacity_revalidate_and_notify(), which is a wrapper
> on top of set_capacity(). set_capacity_revalidate_and_notify() will only
> notify
> iff the current capacity or the target capacity is not zero and the
> capacity really changes.
> 
> Background:
> 
> As a part of a patch to allow sending the RESIZE event on disk capacity
> change, Christoph (hch@lst.de) requested that the patch be made generic
> and the hacks for virtio block and xen block devices be removed and
> merged via a generic helper.
> 
> This series consists of 5 changes. The first one adds the basic
> support for changing the size and notifying. The follow up patches
> are per block subsystem changes. Other block drivers can add their
> changes as necessary on top of this series. Since not all devices
> are resizable, the default was to add a new API and let users
> slowly convert over as needed.
> 
> Testing:
> 1. I did some basic testing with an NVME device, by resizing it in
> the backend and ensured that udevd received the event.
> 
> 
> Changelog v2:
> - Rename disk_set_capacity to set_capacity_revalidate_and_notify
> - set_capacity_revalidate_and_notify can call revalidate disk
>   if needed, a new bool parameter is passed (suggested by Bob Liu)
> 

Ping? It's not an urgent patchset, I am happy to wait if nothing else is
needed.

Balbir Singh
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
