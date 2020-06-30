Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F209C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 14:04:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3018206BE
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 14:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ry0BcMlJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="XkHHnKwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3018206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=phbt4zFRH4pp0XzUN8f9FHBdgR4eW/fT3InX0Fsxps8=; b=Ry0BcMlJOdik3oCyOFkvjH79r
	gFNp4obJo6uNRWoifprAfvhUD3mpa0jWpUZfckr6qfYF33LtyZCSkJrLA5d1SGfaJ3HR8Hp8K57up
	FeIBkVmmjTgA25WJaMXd25iv5dmir4jDVnsF+DWX8kjHXfJvZunEsK3e/EnZNMmAuyVAZYuDzUVQe
	rHEovFiYS/swCXJqywFCshMScB72soR8jndLqwl5OK8xyGR2+EFmWDzszkgMbyYaLhJclDoiCrwF3
	B+vy6NIjYblOof7kwCoaMD0xSurMuXAd6jLtIqz7hzTKytkVjgL3Dw4lIr78n7mJRVHquXABGNjsP
	yKHl/g1ww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqGrp-0007st-PW; Tue, 30 Jun 2020 14:04:09 +0000
Received: from smtp-fw-9101.amazon.com ([207.171.184.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqGpn-0006rj-6o
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 14:02:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1593525724; x=1625061724;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=5cqbwaFqSkabewkIE0PH8u9d3WrDYtEIAmtYZ+31MBM=;
 b=XkHHnKwNJehz/jjDqL6acSCYWsYwZ6Y7NWFEJuC1RVZ1seepHTAsEToU
 LBYiPu4+rxptObiB5X0m5D/Zko8kb5Sia3r9Rq5eN6K6a+qplC94LFX1o
 CzFkiYXUfi4PKgzCeE5J+Z1YYwtw4ylIlaDA7NCM1D4k85WE+wL/9I/JX 8=;
IronPort-SDR: wcfL+7NxfY4PeRhWkaHXuaQ8Ft+JFHZsqJMKprw6Tld+8s54LXls7GQjlpHHqrFInsVpEnOuIV
 Icon7/Pwa00w==
X-IronPort-AV: E=Sophos;i="5.75,297,1589241600"; d="scan'208";a="48066445"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP;
 30 Jun 2020 14:01:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS
 id B25A3A1A3F; Tue, 30 Jun 2020 14:01:54 +0000 (UTC)
Received: from EX13D08EUC004.ant.amazon.com (10.43.164.176) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Jun 2020 14:01:54 +0000
Received: from [10.28.84.91] (10.43.162.109) by EX13D08EUC004.ant.amazon.com
 (10.43.164.176) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Jun
 2020 14:01:50 +0000
Subject: Re: [PATCH] nvme: validate cntlid's only for nvme >= 1.1.0
To: Christoph Hellwig <hch@lst.de>
References: <20200630122923.70282-1-mheyne@amazon.de>
 <20200630133358.GA20602@lst.de> <20200630133609.GA20809@lst.de>
From: Maximilian Heyne <mheyne@amazon.de>
Message-ID: <b3b621d9-b653-45c4-4164-f5a492cabd6a@amazon.de>
Date: Tue, 30 Jun 2020 16:01:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630133609.GA20809@lst.de>
Content-Language: en-US
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13D44UWC001.ant.amazon.com (10.43.162.26) To
 EX13D08EUC004.ant.amazon.com (10.43.164.176)
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Amit Shah <aams@amazon.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 6/30/20 3:36 PM, Christoph Hellwig wrote:
> On Tue, Jun 30, 2020 at 03:33:58PM +0200, Christoph Hellwig wrote:
>> On Tue, Jun 30, 2020 at 12:29:23PM +0000, Maximilian Heyne wrote:
>>> Controller ID's (cntlid) for NVMe devices were introduced in version
>>> 1.1.0 of the specification. Controllers that follow the older 1.0.0 spec
>>> don't set this field so it doesn't make sense to validate it. On the
>>> contrary, when using SR-IOV this check breaks VFs as they are all part
>>> of the same NVMe subsystem.
>>>
>>> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
>>> Cc: <stable@vger.kernel.org> # 5.4+
>>
>> The first hunk looks ok, the second doesn't make sense as fabrics
>> was only added with NVMe 1.2.2.  I can fix it up when applying if you
>> are ok with that.

I'd be totally ok with that.

>>
>> But you guys really shouldn't be doing SR-IOV with 1.0 controllers
>> independent of this..

So far it worked...

> 
> And actually - 1.0 did not have the concept of a subsystem.  So having
> a duplicate serial number for a 1.0 controller actually is a pretty
> nasty bug.  Can you point me to this broken controller?  Do you think
> the OEM could fix it up to report a proper version number and controller
> ID?
> 

I meant that the VF NVMe controllers will all land in the same subsystem from
the kernel's point of view, because, as you said, there was no idea of different
subsystems in the 1.0 spec.
It's an older in-house controller. Seems to set the same serial number for all
VF's. Should the firmware set unique serials for the VF's instead?

Thanks
Max



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
