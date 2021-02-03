Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF3C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 11:22:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A23C64F67
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 11:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A23C64F67
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XlsXpyxjqMeN/flTTHiJZBlZw2xDWxcwUNRBaAbkBoI=; b=LylpZIQuKMaIep1JDwCPCvbeV
	P44oFrUDQJ1I+O3tv+uiUWqiN9WlYq5LQ9pDhGierYtxbOIhp9lJ0fHIJNlroQv6EcYokeSzM3mAX
	6cg8bmjLw/bcXKkFGJdzuvc9eQCU0De6Jm+yP93jI7cJtYMeJdla89yRA8hk+w1RitknYuhqJNfkI
	mZWxEirDSaXzjOR1pibj9Z5Am6m/EN5Yq+LXJ05HIZHpP6fBfSlCQFtYbrCWftFFi80e9xJiyHICc
	pMHAoYi7lVv6fzyv4AiKdrXCyvLh4YtifvDTMXxUYp9catlZvfbF5uIDuKdtkMpnN0KTf8PWZ5ir7
	djcSAjNeA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7GFJ-0001Wr-0q; Wed, 03 Feb 2021 11:22:53 +0000
Received: from smtp-fw-9103.amazon.com ([207.171.188.200])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7GFF-0001WC-TS
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 11:22:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1612351369; x=1643887369;
 h=to:cc:references:from:message-id:date:mime-version:
 in-reply-to:content-transfer-encoding:subject;
 bh=18cLPBSgASmoHqw1uCd93wj7L5Z/l3QTe+arYV9VCPw=;
 b=ngknBz5YG9tnMhU43qlGg9Vsltl7/VxjBpFvcrtMKY7shQSVz9yX7jaL
 Tlsrc+JlTaHhTlgPm3Fwtu/fhInQMDXQtqyYM2aqG+awpWOT/7wPnsItR
 YeYrcnTJ3CX68YdKZyXXQbRR4+Fd1Da1teWIMD684wpvotulM6OSk7gI9 E=;
X-IronPort-AV: E=Sophos;i="5.79,398,1602547200"; d="scan'208";a="915302612"
Subject: Re: [PATCH] nvme: Add 48-bit DMA address quirk
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP;
 03 Feb 2021 11:22:36 +0000
Received: from EX13MTAUEE002.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS
 id CDCC91AADE7; Wed,  3 Feb 2021 11:22:35 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 11:22:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 11:22:35 +0000
Received: from u2196cf9297dc59.ant.amazon.com (10.1.212.5) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 11:22:33 +0000
To: Christoph Hellwig <hch@lst.de>
References: <20210203094338.19473-1-sironi@amazon.de>
 <20210203095148.GA8897@lst.de>
 <0c38f5eb-41ef-7934-940b-77b6e73c5239@amazon.de>
 <20210203111548.GA11075@lst.de>
From: Filippo Sironi <sironi@amazon.de>
Message-ID: <396b45d5-3dd5-8159-34c2-5668510d1d68@amazon.de>
Date: Wed, 3 Feb 2021 12:22:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210203111548.GA11075@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_062250_084170_3C317C75 
X-CRM114-Status: GOOD (  18.76  )
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


On 2/3/21 12:15 PM, Christoph Hellwig wrote:
> 
> On Wed, Feb 03, 2021 at 12:12:31PM +0100, Filippo Sironi wrote:
>> I don't disagree on the first part of your sentence, this is a big
>> oversight.
> 
> But it is not what your commit log suggests.

I can definitely rephrase the commit.

>> On the other hand, those controllers are out there and are in use by a lot
>> of customers.  We can keep relying on luck, hoping that customers don't run
>> into troubles or we can merge a few lines of code :)
> 
> Your patch does not just quirk a few controllers out there, but all
> current and future controllers with an Amazon vendor ID.  We could
> probably talk about quirking an existing vendor ID or two as long as
> this doesn't happen for future hardware.

I know that the hardware team is working on this but I don't know the 
timelines and there are a few upcoming controllers - of which I don't 
know the device ids yet - that have the same issue.

To avoid issues, it is easier to apply the quirk to all Amazon NVMe 
controllers for now till the new lines of controllers with the fix comes 
out.  At that point, we'll be able to restrict the application to the 
known bad controllers.



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
