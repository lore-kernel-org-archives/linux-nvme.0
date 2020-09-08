Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC54DC433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 15:34:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F47E21D94
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 15:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oPwG845S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="eY0exjP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F47E21D94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eUk69N4CfxHuNehauewlbORLEzOhKxljHtQzCBdkiRA=; b=oPwG845S13R5rQvSKazZdQu8m
	jgCX8lff5JWhsXcraYuxH8lLnBEla0Op3YeRtMle11zvrJzi2NMEkYPJExh8sDtfd6FgbjxxuaviQ
	gx4F82h0Uc7ilelY4RTIx4oPfWEH6X+3+/BDAsOWEdYA8mEIGmAStknyla0oSHZLqf7LU4L8UyIlN
	IgHaKrp3nOaz0mMwsIVnSBGFzFJdEja0QAawhqbYn/dQRoOp//cq2EiTw/aCXDWJqv6sDz7HISK5X
	sknuVAufz47DNXuvq/rRzRjsRmrlg5pmJB9SkZbPdxWc93/TMISssqKAtsZ9TBpztP4Tm3G1/fQSS
	x/cbxtK0g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFfdL-0005FG-0h; Tue, 08 Sep 2020 15:34:11 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFfdG-0005E5-8Q
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 15:34:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TbLs2YIUdz1II0wViWwQ9BZBsNQlOLA4q4a196iXocM=; b=eY0exjP+ntL7IuDaHH9molw4RS
 qJBztFrfLVrRAbQnjmZqt5gOJWmRKpYP59Ele2QXnfrqBYj/NaXiFSDCM/vhK8e0U1VCoxwDKgFfy
 PfSm8rwOQdWYu6YYWVDvt/IBv1KFRf3JWnbb9ouQGlza0IYJ3dZgecBIKPl5uAR/b1GPq1LPnvnsl
 zLaly/PSx/K+42pevlS2UGkIvMRcUvt99R4Sh5cktjW4mTdHR4+BHCm8CY38dekAv8Uw4O2zDAguw
 c4p0pUFNbIVyhLYz/i0jaxhLyb70XGDvwOR5DWLtvg3/9dvVSuqKWo2bxRidOZyg5G32OAaqImKAQ
 7ABwb3yg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kFfd9-00082o-4S; Tue, 08 Sep 2020 09:34:00 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
 <20200904023929.5320-4-chaitanya.kulkarni@wdc.com>
 <8c075e3a-d461-7d58-7c02-5ce81cfff6b9@deltatee.com>
 <BYAPR04MB4965A6C54007234812735F52862A0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c8f40122-b868-6bca-f4c7-53a7f52a0788@deltatee.com>
Date: Tue, 8 Sep 2020 09:33:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965A6C54007234812735F52862A0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sagi@grimberg.me, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/3] nvme-core: fix nvme module ref count Oops
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_113406_355227_D20B0D0B 
X-CRM114-Status: GOOD (  13.58  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-09-05 4:03 p.m., Chaitanya Kulkarni wrote:
> On 9/4/20 08:57, Logan Gunthorpe wrote:
>> I'd probably just fold these changes into the previous patch. When we
>> get a reference to the controller we must also get a reference to the
>> transport module. So no sense getting the different references in
>> different patches.
>>
>> Logan
>>
> 
> That is a preparation needed to actually fix the bug.


Depends which bug you are talking about. I'd fix the bug with the char
dev file open which requires both taking a reference to the controller
and a reference to the transport module. Might as well do both in one patch.

Then I'd fix the bug with the passthru reference to the controller by
taking a reference to the module in that path somehow.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
