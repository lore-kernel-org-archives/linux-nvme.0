Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB5C433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 15:36:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E925023CD3
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 15:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rr1KG+LE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ab5r6LV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E925023CD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3vjZd9/dJg2t10YCDMqJbn2eQ/NBtvi6qMAm2A++2AM=; b=Rr1KG+LE1t5HU2Cc/2m1yVRw1
	n/mnGG197fbEDZiyWyvdkfEjzHivPOMXSo0CNrlEzgVODx+kFAYyHcIr86lP6Jo0uPccWPYlgXuSF
	USKwNL1PztxlKNCSk45NAsLEPAdc0A1D2AxBrMGeFFmE4e/AsTqABBiGy7Jh6dQz8RTpsiX9IEEfQ
	jeiLD8cyGCf8UeCfaROslOhApTF4IOwZCIhZ/CzbJ2wR1RISe0yLC9k8jHfOIj7xZBVRBlGTWoSNF
	VEsX8GfuMjUydLi6S2xAM22q7UyY7TTsLREPPdgfuBBVOTqBeLoCZZpqXa4/piZPVit8e9yfCtinN
	L4oVmh79g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFffn-0005j7-Tp; Tue, 08 Sep 2020 15:36:43 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFffk-0005i2-Hn
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 15:36:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FARC803Qd0ZrUNsG5FlgrEkbFdfmzp1eWKCImeASLfc=; b=ab5r6LV9nD0svBk3tDWL7Mj4k5
 q8M2FtyjrQzrSKPz7wvQpSHaqUI+Wvu65csTEeHDUlibZvd3aCvxW8eip5hMG7Ah4LsRWP8q8dCJz
 YgsnIx0+qfmQkobYuPiArmtAQWlOQoYpdGwyk2Hp4vR6GXN5S3Wxsd/aYQErJjQBClhBoq85cH3SS
 5uLh2jRuMzp+JshMot6a66F7mW5PvxCfqkt/Cpnxl+svjCAhBIUxjh6h7RTbOZ1bNzlCawQRIGDO6
 Qw1RUKT5DSOUzkCWgBBRPnpmx98QePKGnIJBApz/ATD3uPIRq1sn1Kd6I4ILFvJAUWIqoPj/4g1xF
 sLX47Fog==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kFffh-00086c-Tk; Tue, 08 Sep 2020 09:36:38 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
 <20200904023929.5320-2-chaitanya.kulkarni@wdc.com>
 <16dc2193-9830-6184-e7f6-ceaca5f0aaf0@deltatee.com>
 <20200905072018.GA13403@lst.de>
 <BYAPR04MB4965438594B46644D7A35AC3862A0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ee6ce260-86ed-8633-bbb5-46427bc2aa17@deltatee.com>
Date: Tue, 8 Sep 2020 09:36:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965438594B46644D7A35AC3862A0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sagi@grimberg.me, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, hch@lst.de, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/3] nvme: decouple nvme_ctrl_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_113641_196405_85162CA7 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-09-05 4:57 p.m., Chaitanya Kulkarni wrote:
> On 9/5/20 00:20, Christoph Hellwig wrote:
>>> I still don't really like this idea. No need to keep a reference to a
>>> whole other file.
> 
> File reference open/close is coupled with ctrl refcnt and module refcnt.
> What is a problem with keeping the file reference open ?

I find it a bit distasteful to keep an extra pointer and object around
when all we need is to add a module reference.

>> We could still lift the filp_open into the caller, but drop the file
>> reference right after we got the controller reference.

I'm not opposed to lifting the filp_open() into the caller if it makes
the code cleaner. I just think dropping the file reference should be kept.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
