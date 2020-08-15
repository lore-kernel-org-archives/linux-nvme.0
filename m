Return-Path: <SRS0=fF/j=BZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74AEC433DF
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 07:00:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8BD22DCC
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 07:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="y74axZhx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j3vHvjAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8BD22DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aBVtIQyhDemkau/XMluIk8QgzdW7jTGi7ZQoRoyhDQo=; b=y74axZhxNoNtft6SsaJZhlRh8
	lkgmot9G9ua+cgOgQWAMpxo8pITCJhlulvTqK/xdZlTkORgHcchystkmbPXU4DgYrIbYDBO2wG2Ah
	YCzqTxhq0vQtKxQsH7zTEeMJXUcuaGYa+Yc8gto/HobGTh84cud6hrebe0bNdEXZbvW7SflbFvaWY
	DE+cdnHXktIuR3LaCSpL7xAq/ec6ZnNqQ4J0XsDP4vZfGwbbTlxsDUhqJKFrYRHBDWHgt2JRBbmw6
	6dwoT22rmNmfvqEczJWmctM2AAE7qcA7gOMY3MiD0waAQ3Zo0OY+w1MqaGSieiIucxMOs5Hl8ksgY
	Xs01JMPnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6qAv-0005e6-7w; Sat, 15 Aug 2020 07:00:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6qAt-0005db-LB
 for linux-nvme@merlin.infradead.org; Sat, 15 Aug 2020 07:00:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=30xUChJQIa1Y11UtNxAuwM7rvyUI8emxUciP5Lh6amc=; b=j3vHvjAwXaoV4n4FX6ExFFfQ7g
 oJ0JdJ0MGEkuL3A77UhTHZ3nf8A8Wt2Rh07S5xV30XA+1yAMliT6Rf+7hSmsCBXMg68kdy+kgYvf7
 uuvWUMoXY6HpsaujQSy0Up7iv2/7kjggpar3P2GFiLuQEa5vfWE+L+KmIkhmlRV9fu8tkzL2ALdZr
 whHNvlsRJWJM7mqtkIbvhXL8f2xfjAWduN98vDrW429vW0Z8s8QvCOQe6jB+tiJExIIM/nulfRvkY
 jBqBnUHzuIIAeND2IgNsdfyCru9ILMite38g6tUuEIHUDIXUBarHy+UTZU3GgYt2Z6vrRu2uwJycO
 /rSJUwFA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k6qAq-0005SB-W8; Sat, 15 Aug 2020 07:00:17 +0000
Date: Sat, 15 Aug 2020 08:00:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: nvme reservation commands during controller reset
Message-ID: <20200815070016.GA20460@infradead.org>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200809161016.GA63121@C02WT3WMHTD6>
 <20200810124036.GA25070@infradead.org>
 <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
 <20200814082015.GB18371@infradead.org>
 <20200814100911.GA9975@infradead.org>
 <20200814160220.GC3772144@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814160220.GC3772144@dhcp-10-100-145-180.wdl.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Christoph Hellwig <hch@infradead.org>, "Anner, Ran" <Ran.Anner@dell.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Engel,
 Amit" <Amit.Engel@dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 14, 2020 at 09:02:20AM -0700, Keith Busch wrote:
> Couldn't you just clear the REQ_DRIVER_FAILFAST flag to get the existing
> retry mechanisms working in this path?

That would only retry locally and thus not really help.

> 
> And while it looks fine for fabrics, PCIe doesn't have the implied HOST
> ID connection that makes reservations do the right thing across
> different paths. Automatic path failover retries for PCIe may have the
> wrong result.

You need a host id for reservations to work properly, as without that
they won't actually be persistent.  Unfortunasly NVMe allows
reservations without a hostid with some rather broken semantics instead
of just failing them, so applications that do use reservations needs
to ensure a host id is set.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
