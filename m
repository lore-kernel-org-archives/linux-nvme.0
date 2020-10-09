Return-Path: <SRS0=D38N=DQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1EAC433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 07:58:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF3822269
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 07:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vtVZOIcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF3822269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UoMa/5RajbrXXoE/FPaxgazMjCD7UGDQxzzJkY8D7SA=; b=vtVZOIcfK50HtEt7y6aaqRSam
	QrjQGkAyQN5MVFXUqYz0K39N+E10H9EEvjmy+pXriYi1RpGSY6lRRv3rHttIvpIGEUhz8eNvby76W
	Wuax1TrObPNuWwen8adhlrRDhZobdevceWlP5duxQQYF/gsUQWxppl6R2MtsK5T8D0POR88aCgXU/
	ksAl8QR1U7/dsamgFAr+OYfDtjwWLKoFnTNDmDoFHQSHddJlKXQHWr+r1Bun5Sf2NnZHwioTOhk+M
	Uwn2lfV+IQy4kjS8S1tKyNis4EzkZwmWSvkYbPcXrF+ykvjSZnbm4uumy7gto6xn1KWnrxzE9VQZV
	Oq/oeGiFw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQnHy-0001Zq-OB; Fri, 09 Oct 2020 07:58:06 +0000
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQnHv-0001YX-JF
 for linux-nvme@lists.infradead.org; Fri, 09 Oct 2020 07:58:04 +0000
Received: by mail-pf1-f175.google.com with SMTP id w21so6177622pfc.7
 for <linux-nvme@lists.infradead.org>; Fri, 09 Oct 2020 00:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D79IJ36UudbRHG2m3Y2id3UXozcwn7gUBePp1MIHIBM=;
 b=Z98Toqspzl/B0h/BjInXaOpbmvmPUApDMw23F9GpYlXlNAN9Yw+vjZraK3AQWktPhu
 dxyROn1Px9WVoGolePLgvSWxdexQ2yA04a0E4dF5mDE/cxau3u/VeCXmk1zp/XTVg8ZT
 t0pC8bYD2NNJynfHqf4DoKhebyTo/T0UGF81FZSGNtXSouhyA/cGoA8792nB9MWVFTRu
 6PVXoy0P6UjI7ahKD7jW5RcYb6KqHjmK7uhsk0MFXFpF3yBkPVOZIADvFFIBZJacG5mA
 6MBUlyT/EKFdIprAD6nlWvB4emI8e9IZL6E8MUGpmffs2q/yAi+v4fsHB4plmju3LOfh
 N2KA==
X-Gm-Message-State: AOAM533gZC28Dhfubm8moWEVo2gjDInwNhcE15yRFxUYUoaMhwPBDZHz
 P9hpzfdQNoUeAG6UEp6UnzSu+kDC7FI=
X-Google-Smtp-Source: ABdhPJy8QkFmccEgwrQ3HJNNh2K2rXqp0gannngRcnmPA2j6e30u18GwwHU5Q8OZPcM63uYENVa7UQ==
X-Received: by 2002:a62:92ca:0:b029:13e:d13d:a07e with SMTP id
 o193-20020a6292ca0000b029013ed13da07emr11038495pfd.21.1602230282112; 
 Fri, 09 Oct 2020 00:58:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e430:c9cb:46e0:d242?
 ([2601:647:4802:9070:e430:c9cb:46e0:d242])
 by smtp.gmail.com with ESMTPSA id t6sm9850428pfl.50.2020.10.09.00.58.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 00:58:01 -0700 (PDT)
Subject: Re: Exporting NVMe-oF devices read-only enforced on export from the
 NVMe-oF target.
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Mark Ruijter <mruijter@primelogic.nl>
References: <BBC87AAC-A523-41F0-8CDE-38757C407C7F@primelogic.nl>
 <BYAPR04MB4965DEBF8F5F06FC026B502786330@BYAPR04MB4965.namprd04.prod.outlook.com>
 <f4445536-ed3b-203c-95ee-bac737e5574c@grimberg.me>
 <BYAPR04MB496559D7BD43F180E366D91A86080@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <759e98a7-5609-bc5b-7d90-8e64ffe085d0@grimberg.me>
Date: Fri, 9 Oct 2020 00:57:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496559D7BD43F180E366D91A86080@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201009_035803_679608_C40FD1ED 
X-CRM114-Status: GOOD (  12.57  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> btw, I just noticed that 1293477f4f32 ("nvme: set gendisk read only
>> based on nsattr") breaks BLKROSET ioctls.
>>
>> If I now do:
>> blockdev --setro /dev/nvme0n1
>> and then I will write to it, it will override the disk ro as
>> invalidate kicks in when the write fails.
>>
>> I think we need to start by reverting this patch, and then
>> add it back in a way that doesn't break BLKROSET...
> 
> Thanks for reporting this, let me add this fix in the V3
> 
> [PATCH V2 0/4] nvmet: allow target to export readonly ns.

To be clear,

I'm talking about commit 1293477f4f32.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
