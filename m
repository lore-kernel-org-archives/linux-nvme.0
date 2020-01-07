Return-Path: <SRS0=77Bv=24=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC764C282DD
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 22:30:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9901D206DB
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 22:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VmsyT5ij";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BXVa3XP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9901D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+NDuwVHmsOVBdAwlxILZSfy5WtWw+yuTSUVfJymndZw=; b=VmsyT5ijl7J0Ph
	huNlo2yyDud8a6v7Bdmw5hUALSOyzGNn3riHry1zXJzyQdx3Wfg7VUckOL0Hb4DP2ugY0ERKmc9nO
	x43awe59MKvc5lk3K3ECkbDbMpvHtDYnsFJW3MjL18yVwvGJmuIeJzVBUFn+ihXqLgdXGI57wMju2
	e0QoEjGdbvq56K2BKIr1JhHu+zjPrHb0sLD9ZyMHrA4qt8Z5z+um9sE/RwG/KtCWCyFWq//YHkleZ
	pzDIp2A28cKc5+TPOoJiIWZSpDQU9E6uZNAZUiEn22jT1qkIYgEmOY/4yJEpZUvSvq6th++Kx3qXG
	lXRI5/5xD7qI3TxuTjXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ioxN9-0007eI-9Z; Tue, 07 Jan 2020 22:30:47 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ioxN6-0007dJ-LV
 for linux-nvme@lists.infradead.org; Tue, 07 Jan 2020 22:30:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1578436245; x=1609972245;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0yu/e1APmDyrOiyqfuBQvh2sEg4lzG89R8qZG0pTiHM=;
 b=BXVa3XP17kkurQnzQ/hSDTFJ2p9p3ClymM5hnmVnbXc5HnuMU1CG8CGN
 RZHCXOvgycRmP1v4vCesSbu3Fw82xPGcLO3drTPWtEzeo8jB5bRlodSzg
 UxVENbe0A5aPOwfjuNDsbL9Ek8YQwCB3h2fFOP3vkHx4XwBlj/mY/FLg/ 0=;
IronPort-SDR: 66EUQz2oAEeoZOeuh4f8ntEX+LesIbMW+YTYwydU/0vOpC8CDUarfk2n6Yy/a3UmN3AzAZwQ0C
 egJ7V36XHmpA==
X-IronPort-AV: E=Sophos;i="5.69,407,1571702400"; d="scan'208";a="18687284"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 07 Jan 2020 22:30:32 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS
 id 59101A20F3; Tue,  7 Jan 2020 22:30:31 +0000 (UTC)
Received: from EX13D11UWB003.ant.amazon.com (10.43.161.206) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 Jan 2020 22:30:30 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB003.ant.amazon.com (10.43.161.206) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 Jan 2020 22:30:30 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Tue, 7 Jan 2020 22:30:30 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
Thread-Topic: [resend v1 1/5] block/genhd: Notify udev about capacity change
Thread-Index: AQHVxQslydawp/BwQkuXvP0PUEOjWqffygqA
Date: Tue, 7 Jan 2020 22:30:30 +0000
Message-ID: <d1635bae908b59fb4fd7de7c90ffbd5b73de7542.camel@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-2-sblbir@amazon.com> <yq1ftgs2b6g.fsf@oracle.com>
In-Reply-To: <yq1ftgs2b6g.fsf@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.109]
Content-ID: <7A4476106396C040A8D83784CE3F10CD@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200107_143044_746611_226B9CED 
X-CRM114-Status: GOOD (  13.27  )
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
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "mst@redhat.com" <mst@redhat.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Sangaraju, 
 Someswarudu" <ssomesh@amazon.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2020-01-06 at 22:32 -0500, Martin K. Petersen wrote:
> Hi Balbir,
> 
> > Allow block/genhd to notify user space (via udev) about disk size
> > changes using a new helper disk_set_capacity(), which is a wrapper on
> > top of set_capacity(). disk_set_capacity() will only notify via udev
> > if the current capacity or the target capacity is not zero.
> 
> I know set_capacity() is called all over the place making it a bit of a
> pain to audit. Is that the reason you introduced a new function instead
> of just emitting the event in set_capacity()?
> 

I did this to avoid having to enforce that set_capacity() implied a
notification. Largely to control the impact of the change by default.

Balbir Singh.
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
