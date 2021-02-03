Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD83C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 11:13:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4EC64F5D
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 11:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4EC64F5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PEEn9QHvYRvQYzLrXi9cou+o/wTcOebbHL6JhAGUicE=; b=nGnrFocfcR0CasaH6Gl02OTyu
	+g7YgtRK2ipNw4b630O3wyVnobfnXfDI2qE3ryzvteNsKdtyfS4iE46RQ5z3bXeDm8UqMxwmjl51o
	fQ1+HUYdCmRyM/XsnveliPusaa1+m6ImW3TiBuPWyLHM56rnKAYeqrSf0Dc7E8p1+4aHwFbhPDwmn
	Sd2Y/NvgHGDK2j3NH4JfUAYC7PDkj1gNteG+VlxxmLgSPs3Q1OFP5sRUD7rgn2kAJMEaT8jxseUx2
	QGfYXYIVVP5RDEf8D87FQVr7iKbQu5+2PIXDyrlIToA7UvLz9NGg9I14Ca1WtOLEqOhV6Y8r1XSmG
	Oye2jl2Xg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7G5d-0000Wi-Tz; Wed, 03 Feb 2021 11:12:53 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7G5b-0000W0-NK
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 11:12:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1612350772; x=1643886772;
 h=to:cc:references:from:message-id:date:mime-version:
 in-reply-to:content-transfer-encoding:subject;
 bh=BafQidahkXiub3U6Y+3Z6cbkXATtE2p3Hlpl71TTN7Q=;
 b=HbEG2c2U3j085xaNQp1LUvkSrMlLaFih6JGQgTAyB87Yq5lNFev/ATem
 1M/T2wB78na7KdbfFylHjEj9RRZ3weiENtCIfKx91Iw/Iw6ZMYoN0MnS3
 LZ14DmyQKnpA5k0hMQE8blP8nhr4L/eDkDraatEk54+d7q0ZfZpNqysS9 I=;
X-IronPort-AV: E=Sophos;i="5.79,398,1602547200"; d="scan'208";a="79396584"
Subject: Re: [PATCH] nvme: Add 48-bit DMA address quirk
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 03 Feb 2021 11:12:38 +0000
Received: from EX13MTAUEE001.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
 by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS
 id A1913A1ECB; Wed,  3 Feb 2021 11:12:36 +0000 (UTC)
Received: from EX13D08UEE004.ant.amazon.com (10.43.62.182) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.226) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 11:12:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEE004.ant.amazon.com (10.43.62.182) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 11:12:35 +0000
Received: from u2196cf9297dc59.ant.amazon.com (10.1.212.5) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 11:12:33 +0000
To: Christoph Hellwig <hch@lst.de>
References: <20210203094338.19473-1-sironi@amazon.de>
 <20210203095148.GA8897@lst.de>
From: Filippo Sironi <sironi@amazon.de>
Message-ID: <0c38f5eb-41ef-7934-940b-77b6e73c5239@amazon.de>
Date: Wed, 3 Feb 2021 12:12:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210203095148.GA8897@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_061251_836245_61B7A5F2 
X-CRM114-Status: GOOD (  15.29  )
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
Cc: sagi@grimberg.me, serebrin@amazon.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org,
 dwmw@amazon.co.uk
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2/3/21 10:51 AM, Christoph Hellwig wrote:
> 
> On Wed, Feb 03, 2021 at 10:43:38AM +0100, Filippo Sironi wrote:
>> Certain NVMe controllers don't support 64-bit DMA addresses.  Instead,
>> they are limited to 48-bit DMA addresses.  Let's add a quirk to use them
>> properly.
> 
> WTF?  This is such a grave NVMe spec compiance bug that I do not think
> we should support this buggy mess in Linux.
> 

I don't disagree on the first part of your sentence, this is a big 
oversight.

On the other hand, those controllers are out there and are in use by a 
lot of customers.  We can keep relying on luck, hoping that customers 
don't run into troubles or we can merge a few lines of code :)



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
