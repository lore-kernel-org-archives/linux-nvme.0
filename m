Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315EDC02181
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jan 2025 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fm7J0Eiz1lA6DmnH9CSQJAH3EDgNRFhpL6R7paSGNfE=; b=FxOm2w+eTF1mFFr6lGAbTSTsZK
	GCIQe2A+lGWDTTgpKbcqJiEzxtdJ/o9YJxg8/maDo7qtM4ll4o0j9iz3qm5VF60FH2iIsmYeCOsAJ
	AqsKtzhNGNeqRc6BtC3nG0yjphrChcGldzM9uwZIgsLDrjTVP82yp0B7V7cHCSvev+p7xqbj6OMnc
	hXBlsEKvHzxSiEi/LifiXJ4XeRjHgdsYgJa20JVJvKL7tdv1EIHg8yS2nI5hEvk7LcPtU/p5473qe
	kp3xM89BrGUUbTPtE3p4+FFjV1FIXO4I1CMxm5EG2PU7Je0YxGbPCkCMuXhwooVc08RWGqd83UYuV
	qlnK0Lzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbxcw-0000000HEfp-1LTk;
	Sun, 26 Jan 2025 08:04:18 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbxct-0000000HEfV-1rR5
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jan 2025 08:04:16 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436202dd730so23806625e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jan 2025 00:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737878654; x=1738483454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm7J0Eiz1lA6DmnH9CSQJAH3EDgNRFhpL6R7paSGNfE=;
        b=XGBgBAzZ6x4mDslg5+Zdvf+ewL7Hwv8g4sr3WlaZZ5M/jNz8eofgvrGUC9LPnow8Zi
         qsb2blkmnm+6yZaQYVvxKPflFtmHjKzBHafT9a+ah2WREjGtMwSCKaidgOxel6rZaw6u
         VxBd2WJEFi8PWZ26c2PwqhYP/4QE8+vTx2NnfwTB6Ok8622z0Y9avBgHvZEft6K8By0a
         Tg/tGjvWRIn8xx+uvHsITVdZQ1MTx0FL9l3nSByEdEZVoMhiFaSIx+tRLXN5fya59PND
         qCbAZbviam3y7QzwYXr3Pv0/6Jnin/5NpaIMpbeS3FownNsxXCf1SCHa+RRni9h9BLmo
         MDrA==
X-Forwarded-Encrypted: i=1; AJvYcCUvz6N7GjCEXTN+b//E17j1EFJTzypQ0eUlq26ypY470MoYMSAqomHm/HI3O6nmwxO0cjdQN1BDwhx6@lists.infradead.org
X-Gm-Message-State: AOJu0Yywdj0+37dnjNpT7W6HLiM150IRKRxB9Ze+SdxsE8srjA7wVG1q
	QBRavfUV68J/121idp0vn86w1lfwwrfdEKcRbJ2/stUMU5lWpJXO
X-Gm-Gg: ASbGnctexebJqlRxt7XBB+MFjQrbkED7gQUovTktzcRdnxIlLytL/FvkKZWtvnsxfKn
	oUvnBWyoT+sK35UncvzCd4348QCSuMr4GRTDx8Hm5dHP3/ME1scBrFdX7yd3q4l7KnuhUEDSwRY
	oGolOo+bmYWUuwSdk2i2a22srhD0xk6DJDb9k24CO3IOwYb516/b0kKNrygowZ01r372u2hwOz+
	rfrvIfoFOcOBKGXnJPmtmLF5MfRMVSxwejiMWxu1PESnMK4fR2CKjoGp58N5DIqFfNBR1cZd9CI
	pDymoF3Ox4Wf2ZHya0ywriuw+CnXJHAmc2P4woLf3BdCo20=
X-Google-Smtp-Source: AGHT+IECjoHRoW8tcbEBIECay8QdYw2zrwLb1/BlC7Js9KWMJxGJ9556MUmDRpUDxKC3NmqP9P+5VA==
X-Received: by 2002:a05:600c:1907:b0:434:effb:9f8a with SMTP id 5b1f17b1804b1-438913ef2c5mr345023385e9.15.1737878653548;
        Sun, 26 Jan 2025 00:04:13 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b179315fsm82486075e9.2.2025.01.26.00.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 00:04:13 -0800 (PST)
Message-ID: <dd9927ef-8a95-4562-b789-a01fc0daec90@grimberg.me>
Date: Sun, 26 Jan 2025 10:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: move percpu handling into
 nvmet_ns_{enable,disable}
To: Hannes Reinecke <hare@suse.de>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250124082505.140258-1-hare@kernel.org>
 <afe8968e-ff56-4907-b3ec-a79ac75d5250@grimberg.me>
 <f2dc374b-0a08-48fa-bd9f-1cfccd34446d@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f2dc374b-0a08-48fa-bd9f-1cfccd34446d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250126_000415_484399_03CE5603 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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


>>
>> On 24/01/2025 10:25, hare@kernel.org wrote:
>>> From: Hannes Reinecke <hare@kernel.org>
>>>
>>> The namespace percpu counter protects pending I/O, and we can
>>> only safely diable the namespace once the counter drop to zero.
>>> So we need to init the percpu counter in nvmet_ns_enable(), and
>>> wait for it to drop to zero in nvmet_ns_disable() to avoid having
>>> I/O pending after the namespace has been disabled.
>>>
>>> Fixes: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
>>
>> Can you please describe the bug and scenario which you are hitting 
>> this bug?
>> It is also unclear how the above patch is causing this.
>>
>>  From quick look patch itself looks reasonable.
>
> Should've said: this is the fix to the reported blktest failure
> on nvme/058...

OK, then please resend this patch that explains the exact issues that it 
solves.
Also, please rephrase your patch title to describe that this is a bug 
fix. i.e.
"nvmet: fix ...."

