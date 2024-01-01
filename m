Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32767C47074
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ch0XguHkGk0Ebeiz9l+P/+27AypLTPI8hdYry0pzjyY=; b=nlS6tdayo7jXEnGC44SJi9LRDW
	P0irDrAm0FpElIf94E/tGX5nFK4Dl0YN0m9B2J1schaHktKgcaZ9PzvLl3BaLsy0h7mQvOO8R3EV/
	yNNVmrlk/roGBz7IJVhPrRu7Ak0LyDGixNOYFwjNPdtDkSYkNMYG90vAKKiiYCp6+1y6Iy8i9djYm
	VzDfxKHjBpmhBuOAM0SmSl6L3RZKAM49813klmk9MESnRxifNeHrcUKm/F9rP2TBge3FhRp7yKwxw
	YmLn/Ib+IseHe25pW8XIgSHabJBAkJb2DcZciRlNyNiLaNVmw7Ptt6qx3NaiFLNji4W8tY30pPCDU
	s+l3uCfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEVu-005of1-22;
	Mon, 01 Jan 2024 09:23:14 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEVq-005oeV-0f
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:23:12 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d5a733823so2485875e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704100988; x=1704705788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ch0XguHkGk0Ebeiz9l+P/+27AypLTPI8hdYry0pzjyY=;
        b=Ee0fEXFoi7Tazaz5Qq4KKsn92FiKAAG2605bGlAt6dNF5sz11YTyGth3dKcGySohZC
         mIDMKAetbe6Wh+j+g4UtnkmdFXJzVJyc+LtqyGQlkQ1IcI7eKk67Squ7UG0qApjHYJs3
         mDT4d03PGq3cWglIbNozcatNqQvifgkLaqa5HGKA4igwzVeLSjiblA/2zkY2f7IlFz02
         NahMTDd9ehtPC3FIbUUh2b5HCWRsjVfplfP6fGZ87Dk1BWKCxRj93LQhAOQQ4gNukL22
         SFeXjsiWj7kkshQLSRBVPqdbRmeUmc3BnIFl3iUd45m9rpQze5MjpMym/4JydAKQReZU
         jHoQ==
X-Gm-Message-State: AOJu0Yw28mj0UIV13XP9Y/8SVZ57Kg4oGshClTxraHqh8zCzrDXwaWf9
	xQ+5SAuCk02ayew0zhMOoMA=
X-Google-Smtp-Source: AGHT+IGcH+nhiAiCT73jz1AbrNj5kZ82nIeLDK4BMl/IPypOdlcKOWk9BrhsjrUpB/YS9lxfzzzRhA==
X-Received: by 2002:adf:e382:0:b0:337:2a0b:a7f3 with SMTP id e2-20020adfe382000000b003372a0ba7f3mr4664942wrm.2.1704100988118;
        Mon, 01 Jan 2024 01:23:08 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m17-20020adffe51000000b003364a0e6983sm25316648wrs.62.2024.01.01.01.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:23:07 -0800 (PST)
Message-ID: <1f55f4a5-24d4-437d-b2d7-5caecce3959f@grimberg.me>
Date: Mon, 1 Jan 2024 11:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] driver core: Support two-pass driver shutdown
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 linux-nvme@lists.infradead.org
References: <20231227203337.GA1509884@bhelgaas>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231227203337.GA1509884@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_012310_246078_67F7B9FE 
X-CRM114-Status: GOOD (  17.17  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> From: Tanjore Suresh <tansuresh@google.com>
>>
>> This changes the bus driver interface with an additional entry point
>> to enable devices to implement two-pass shutdown. The existing
>> synchronous interface to shutdown is called, and if a shutdown_wait
>> method is defined the device is moved to an alternate list.
>>
>> Once the shutdown method is called for all devices, the
>> shutdown_wait method is then called synchronously for
>> all devices on the alternate list.
> 
> Christoph and Sagi noted that the objective is similar to "fire now
> and wait for completion later."
> 
> Would it be practical to actually *do* that, e.g., add a global
> shutdown workqueue, have the .shutdown() method of nvme and similar
> drivers add items to it, and have the driver core wait until
> everything on that workqueue has completed?
> 
> But I'm not a workqueue expert and I do see the scary warning at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/workqueue.h?id=v6.6#n619,
> about not flushing system-wide workqueues, so maybe this wouldn't be
> workable.

I don't think that a workqueue is necessary. What I do think that we
should document somewhere that .shutdown() can be synchronous or
asynchronous when paired with .shutdown_wait().

