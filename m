Return-Path: <SRS0=Pbb9=2X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EA9C2D0DD
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jan 2020 07:36:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843E121655
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jan 2020 07:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FEyDWQLK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uxkTL+mD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843E121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9fyFkSjMHzV0XnaDUHj+UBc6ByXVjdSINvUqZsQU5w8=; b=FEyDWQLKAO+JW0
	c7NPOXuBFsXrnIGoB28jVL1NYHZtQioYP73gc3Fo1pMNp6Q3KqSo13EFGGq2/f5Wmj5Ddb9RMeE9J
	qE3prCfu/y16Y6aYrHBb/QgMkvv3hvSi6iKX1oadN4ZU0ofYgKQhW/Q8A99ak9OnwydWaxrAagyJI
	XDxjcvQODhmA0qfivC/y6YJOPDK0sBlafO5VeF6p6IjuX/60Ki/IpO/yEoonJaOx/j1Tl1bnC+Tyf
	4nVgVfzIICcNQao+jGfkfy6dWZtElTRDbF0r6semohtFZzMBqLJnxD7SoTCIKFU9l+VThE5uHSoCQ
	E+UhhF1OiniCAqHDSLAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1imv1z-000559-St; Thu, 02 Jan 2020 07:36:31 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1imv1v-00054P-6k
 for linux-nvme@lists.infradead.org; Thu, 02 Jan 2020 07:36:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1577950587; x=1609486587;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=k1Nzb8bZaT4m/b1dU7SsCqlqfBlTEdEx32bcxwJJuB0=;
 b=uxkTL+mD++d2zuluturDtnUd4fG15w4zThknB78bNX1RK5WCm9/AnmfC
 jFCfszBoKD0B1y54Pn7gZL/CEpAUIjRQdZzkBO9C4bCcXUqbU/8RDf/sR
 8bRzJMk4XUwMAhdTsUHogSOGlTaPLuSd5d8ummAue0KhR4zhlBMViDBby Y=;
IronPort-SDR: B7ksXLAadvey2WJTLpGdmppAdnrvityxtYbn3quHgmH0v4XzNhIkGz4jcZGHQWSNKWMeLazSrc
 hktCfvc8MsAw==
X-IronPort-AV: E=Sophos;i="5.69,385,1571702400"; 
   d="scan'208";a="9796547"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 02 Jan 2020 07:36:22 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS
 id 03347A2296; Thu,  2 Jan 2020 07:36:19 +0000 (UTC)
Received: from EX13D11UWB001.ant.amazon.com (10.43.161.53) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:36:19 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB001.ant.amazon.com (10.43.161.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:36:19 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Thu, 2 Jan 2020 07:36:18 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "=linux-block@vger.kernel.org" <=linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Thread-Topic: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Thread-Index: AQHVuTIQS2D+6UASEUSut4lHWyy8r6fXDD6A
Date: Thu, 2 Jan 2020 07:36:18 +0000
Message-ID: <507d6d24a15b76c9887b1746db37f4dc970e7800.camel@amazon.com>
References: <20191223014056.17318-1-sblbir@amazon.com>
 <e452f6a638fe09f065b9e4cd1c25d5d3a2f29e5a.camel@amazon.com>
 <BYAPR04MB5749C2F13BD6F6C15509FE8586210@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5749C2F13BD6F6C15509FE8586210@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.109]
Content-ID: <8BEEDDC95109554EBF79E5898A7A2D17@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200101_233627_372825_75DD2BA8 
X-CRM114-Status: GOOD (  11.33  )
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

On Wed, 2020-01-01 at 03:26 +0000, Chaitanya Kulkarni wrote:
> On 12/22/19 5:53 PM, Singh, Balbir wrote:
> > I messed up with linux-block ML address, I can resend with the right
> > address
> > if needed. My apologies
> > 
> > Balbir Singh.
> 
> 
> Unless you have sent it already and I totally missed it,
> if you are planning to resend can you please also add a cover-letter ?

I did not resend it, I'll resend and add a cover letter.

Balbir Singh.
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
