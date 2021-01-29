Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401D4C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:21:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9198C64E00
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9198C64E00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hN3Gk75YSq+49hZ0LyfcXX2Vw7aIoeOspOFtODnvNEI=; b=HpUucDw8eM8ltR63KUf7mkaaY
	0OamdHVGOizZJ3XRGnxr98NmYyg6bjP7RImvqgokt9Oy331pRBg2+sjqPkxP73OcdN2VSGluiWlp4
	+lufa52V1SC0ma7Q+ehEA4OfYyaLr01lD/n/vb8mr96ji6bN12D+cmokfLTiz9c22wTJBcpy50VdV
	nkmU5S3zD/e2/aN74+hoDeJ8yulahTtWagzOj3MPfqM77Ndmx8wajejUGCCIPxOaVpY4dO7FxvFwU
	EI6Vem22POs6pldtNadyWA/HeIIQqbHa30TuuISBFcimuQ/6cMokJc7WVK+cUhMYkHzjbbz/J+QZP
	GKm4evhpg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5bCs-00077O-Ke; Fri, 29 Jan 2021 21:21:30 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5bCp-00076U-Dv
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 21:21:28 +0000
Received: by mail-wm1-f54.google.com with SMTP id j18so7856361wmi.3
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 13:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g9aASbVtO3kirRVW8wwjA/ipbkGa0/JCkGxzb7a17hI=;
 b=smu9kKLRtUTNBdCKLhGBvvdoPpCJT22ZqBh1VNsSxsgQjyxR+Ge48m/OwXLGpwK8ou
 3BaZ3R0rrlJDo9kwhO88H4d9UMRhwuFHkndbE+qPST9d7EvlRybaePq82JeN/oAwQJF4
 wc1aWnPOwUpmqvigDBCr+SFAupOus3GvGr9MYI7DZzHKGuWe/z/W+ZxeJ0h5/01AQtsP
 eL8cM6jiWh3wfLP0o2usiXJj8SMwIfpT8AMCystBUE5BjACy3+plQvq5modWE0Bf8/zk
 MmswfQuBErVGjabrfyRuquGiwQqDt05laiX+YV7ZSO1A5OG+e1wwz5pVA+equT76E4jC
 CXZg==
X-Gm-Message-State: AOAM533LoW88gjiK2Lqre+XaoNBX9Zexsw2LxpsetD9BrKitKqMdwKLR
 EE9XkJYgXKtWvceyi9QJiuscP9kBpMc=
X-Google-Smtp-Source: ABdhPJzgotjUbt6roB0pQuhkEVPHQEJXpFbD5g2b1brF0w6yQmnEwaebsKVEQcv4N3Xk/qgK0FRnjA==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr5521919wmc.162.1611955285900; 
 Fri, 29 Jan 2021 13:21:25 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id e4sm14572038wrw.96.2021.01.29.13.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 13:21:25 -0800 (PST)
Subject: Re: [PATCH 35/35] monitor: add option --keep/-K
To: Martin Wilck <mwilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-36-mwilck@suse.com>
 <90145500-c2c5-023c-6d69-27db6ee600a7@grimberg.me>
 <12827c5f748bd2eff31450c47bbef1cfc7b73459.camel@suse.com>
 <400d4f5e-a578-e89f-ae45-7ed15d089a8d@grimberg.me>
 <b4b9a52011d17ef16cbc86d81ef3d19f7a517d93.camel@suse.com>
 <c127bde8-7cae-677c-4b8d-44cf757d05eb@grimberg.me>
 <2394e23e80f2bdcf0a95eb39e5eefcb00237d52f.camel@suse.com>
 <8cb1830e-b7f3-48ef-1190-0d917aa200bb@grimberg.me>
 <5623aeee6a57889123b8a3441ee6df7b97f76451.camel@suse.com>
 <552cb65a-8f1b-e414-4de8-f53ff469e8a1@grimberg.me>
 <c00de29ef02bf39ae231a2816f03c8e920ebdc29.camel@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <01314926-1d33-53e1-165d-346290101ba7@grimberg.me>
Date: Fri, 29 Jan 2021 13:21:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c00de29ef02bf39ae231a2816f03c8e920ebdc29.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_162127_489299_92E736C1 
X-CRM114-Status: GOOD (  11.50  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> I don't even see how does this help in early boot anyways, how
>> do the existing controllers get connected?
> 
> For FC, it works today. You can start the monitor in the initrd, it
> will receive the fc_udev_device events, and autoconnect (just like
> traditional udev/systemd based discovery). For other transports, it'd
> be more work, as we'd need to do mDNS discovery from an initrd
> environment. I wouldn't say it's impossible though.

I was referring to the nvme controller walk and connect a discovery
controller to that endpoint. I thought you meant that this helps
you at early boot time.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
