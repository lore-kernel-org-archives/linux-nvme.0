Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15202C433E6
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 08:05:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27A064F4E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 08:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27A064F4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qGv66Wy7HkDGTMnt1gLDgMG/yo3m6750Z617hGqVd1c=; b=yb2keUGgRd1RxB116AgqXnirq
	VLCAFEC9ANdjEx2rXTkdjXOfTQ4SNItSRKE30rZJL10ttkHTMOJ1o84WdxPdtGp6BHbizMaoipF75
	WmIcdVoqxW8m2MsJkZ/iPM4ghsEORXa4Ih6UccFAhO7RNfWQJwlhcT0mHwBwXDw3HmX5cbNciDYxe
	0HFe1/9Xa8aJo7vbuBAkcIrJrO8wx0XzoZdxnFKkS2IiZf5y+iDkkvJ+jHEidLg78oqqd090szTvl
	Nqy7ehJHw2fl9qEDUlVb3GKj8emtmuZpgrgE78ZvsxUTLs//VUm3usExDP2/WGOm6lQViN3tP7UjN
	pFBD/34+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7DAO-0003LO-8I; Wed, 03 Feb 2021 08:05:36 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7DAL-0003Jx-DM
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 08:05:34 +0000
Received: by mail-wr1-f49.google.com with SMTP id q7so23050200wre.13
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 00:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QyymkxOQIiK+/1MbPLuZFWzMKXwNrvTuYOPMQ1co1yY=;
 b=YUWydfr9uwcZpZhiXh7+4kcOFWtSMxIYEoAHnnPFXylb9h8Tw6/+eebmfJNskyzpDH
 qGIBbAWHKgtFRy/7tIW9byXjKRrTHpBN/oT44bib61bjOz70ufsj1gY9k1+2VnlXaLXs
 F/kyLsyT7qpJmiAxpgT00BUSWtq+5ib+UFlt16P9VE4rvmyrn7Q/d5Z5cYmDXesfDzBs
 bSlscBLENsvmysUDTbpyq/HEMjY0z23s+cG8kBeEogIlL+RlBBeUo2rA1xOBGQlOKHZn
 PocVB4i90r6cSfBgB8wIvT71tvhQUOZf9rfgOYcwj+2oJnYGmDdbEK7dTLWBA+hGfobX
 0ooQ==
X-Gm-Message-State: AOAM530dykIWoiHaUTpNgRLvBPQj8k9ALeBzF4MMW1sm0pXBQexXpiBV
 td+dBECgA7jCoBLNwdDYhIY2LkETUEI=
X-Google-Smtp-Source: ABdhPJxTh6QDfE7WHZhwOfORG+j7NjEoZ+EHZHjrIOGnVBVuAzXtKUue3r9hg1iaHYRVxAMdStFnNw==
X-Received: by 2002:a05:6000:11c5:: with SMTP id
 i5mr2062961wrx.302.1612339530830; 
 Wed, 03 Feb 2021 00:05:30 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:819b:e1e8:19a6:9008?
 ([2601:647:4802:9070:819b:e1e8:19a6:9008])
 by smtp.gmail.com with ESMTPSA id l10sm2246104wro.4.2021.02.03.00.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 00:05:30 -0800 (PST)
Subject: Re: nvme-tcp bricks my computer
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB45443358535A404035588EC5F2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <42f94a06-cc66-87dd-3a92-de793a228d22@grimberg.me>
Date: Wed, 3 Feb 2021 00:05:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB45443358535A404035588EC5F2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_030533_494961_8D5A7A4E 
X-CRM114-Status: GOOD (  12.39  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> I'm running "nvme discover" over a TCP connection. The nvme-tcp module freezes completely and bricks my computer.
> 
> Steps:
> $ sudo modprobe nvme-tcp
> $ sudo nvme discover -t tcp -a [IP address] -s 8009
> <System Bricked!>
> Only a reboot (Alt-SysRq-B) can recover the system.

Do you have a stack trace to share?

> Conditions to reproduce the problem:
> The Discovery Controller must support sending Discovery Log Change Notifications. That is, bit 31 of the Identity's OAES field returned by the discovery controller must be set to 1. If OAES[31]=0, then everything is OK.

What is the discovery log page returned by the nvme discovery 
controller? Does it include referrals? There was an issue fixed
in nvme-cli with respect to referrals (although nothing that is
related to any oaes changes).

> Systems tested:
> 1) Ubuntu 20.04, Linux 5.8, nvme 1.13.21
> 2) Fedora 33, Linux 5.10, nvme 1.11.1

Are these the default kernels that come with the distribution?
Does this happen with the latest upstream?

I know people are doing this for a long time now and no reports
came in on this phenomenon.. I'm assuming this is not Linux nvmet
target correct?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
