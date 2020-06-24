Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8AEC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:57:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9EE42072E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NssERRKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EE42072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wAiyc/rdSv/2HqTi/3RLb7uK7yr4w5Gj+qblMGWB0Xk=; b=NssERRKAT0/Ni/svMWmdzQbpN
	dJ6jpowxLVDdOE8kMilNwv22AHyP690cUOY2ZcdetK6AR2skzLWm+Ixu+d4ozIGZEvyvNg6H7mCrq
	G8zl0+BbBpr35YWDq2qxROxTAGFXWnY0sLi+DFX3bfhMeL+1o1ApT6tymM23lev/rA8T82xJYAj5l
	i9KUj7WkC846SHf4ZXRYxD+B50rnLVQSZo8nzSLzb+qt6tyIOJDzZXPIOzbCRrD6Rsg90PKwF/CIC
	9NBSLXeNMCMmRtK6xxS2jKXT/jg2gCG4b0nDCobG6g8au0UJwDEtqSp/5BJYGXfNBhA9cTOyri9Jn
	6JCrlVvCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnzLW-0001Of-Nw; Wed, 24 Jun 2020 06:57:22 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnzLA-0001Mx-74
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:57:00 +0000
Received: by mail-pj1-f41.google.com with SMTP id ne5so770282pjb.5
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 23:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lzmImX3KflYmfbSSkHMb/3SuAZQ0FoQJw6O1QJxWzjg=;
 b=AuFsUbcw9mUfPGCuNTWJIfGG12GAyxIl/U9YGir6WfTKVzntT3xt4TrRIHikxSJapg
 gCYdF0samTotNpvMokww7Kw6pRrvyiZtHCHbuHHpNG0HBBVDMr/FQO1pyG+I8VlP35ae
 x4UN6Odvk6JBPvE9hQ+h+51EZVMrFfdg1CaPaXH+4PPAJE0n4rVS8fZCR9NBVDQyU2Ik
 JRa6PcWzjFHxGQhwprmYB8AnlMuTUm7LA3fpQ35ZGG+us+4LSilngwrJr5Ejqyk46e4s
 FvTXozGM7pYUC/h9WyjM8GEV3b47Hb2VbZo9qziClYrtnu8FQQ+aBesCCem72anr2cRP
 Cdcw==
X-Gm-Message-State: AOAM532nf6p9wNkRNUlFo/Qh91ddOMg7EZqeNm3qKj9m7+tMKkt4dVcM
 D0Si2mrOE9wauhf5Q4z1N0/ytxXf
X-Google-Smtp-Source: ABdhPJyRBMVsaE2zEaOmU7MmVwMlPZ7zKwm+4VZWsjqI+TTfFpYwLnT49MVfvhgMaEXF2Y7bE7Nl2g==
X-Received: by 2002:a17:902:b204:: with SMTP id
 t4mr28004454plr.132.1592981819133; 
 Tue, 23 Jun 2020 23:56:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9915:87a9:9728:63e?
 ([2601:647:4802:9070:9915:87a9:9728:63e])
 by smtp.gmail.com with ESMTPSA id t9sm4145437pjs.16.2020.06.23.23.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 23:56:58 -0700 (PDT)
Subject: Re: [PATCH v2 for-5.8-rc 2/6] nvme-multipath: fix deadlock between
 ana_work and scan_work
To: Christoph Hellwig <hch@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-3-sagi@grimberg.me> <20200624063413.GB17594@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <60e27a64-461a-c0fd-98b0-342d92042bed@grimberg.me>
Date: Tue, 23 Jun 2020 23:56:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624063413.GB17594@lst.de>
Content-Language: en-US
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> -static int nvme_set_ns_ana_state(struct nvme_ctrl *ctrl,
>> +static int nvme_get_ns_ana_state(struct nvme_ctrl *ctrl,
>>   		struct nvme_ana_group_desc *desc, void *data)
> 
> Maybe this should be called nvme_lookup_ana_group_desc or so given that
> it doesn't actually do anything about the state?

Agree, reads much better.

> 
>>   {
>> -	struct nvme_ns *ns = data;
>> +	struct nvme_ana_group_desc *dst = data;
>>   
>> -	if (ns->ana_grpid == le32_to_cpu(desc->grpid)) {
>> -		nvme_update_ns_ana_state(desc, ns);
>> +	if (desc->grpid == dst->grpid) {
>> +		*dst = *desc;
>>   		return -ENXIO; /* just break out of the loop */
>>   	}
> 
> Any maybe doing the early return here would also clarify things:
> 
> 	if (desc->grpid != dst->grpid)
> 		return 0;
> 	*dst = *desc;
> 	return -ENXIO; /* just break out of the loop */
> 
> Otherwise this looks good.

Will fix.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
