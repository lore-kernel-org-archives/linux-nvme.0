Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4A5C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 20:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=peNfjyvSHuZS7d9Xq56OU5X9wJb2moCNRIFyWTeF44U=; b=WF6jq+Wqw1QL0JUmiGeV035bn7
	U/Cnv3JI4CGSmGV0b0yoagqqG+b2sDNCZD5VNwJ7RONzACouDOPROQYvJlS9oJ0FVOt67H+8aVzqy
	IfVsFL6gbhwtEcuVZ1ndWxjo32sziH3PNndgz8wKtqIfGqpXWehE3/Mlrz9b7+53lkoWWjIKMqGu6
	ihV5rcSnNGDlY2G4BBzDiseYpt9/J9zC3UkrFaphX/T8fw7pdGyT4sssPFn4pC0lR/NVJPqXSuxzY
	5P38Aij6jg+ViCffkKQwAaZ4QRaGzmwqRdHrezriquRPDL7lAGtcUfFkTQw7E3e3YgKGQmb3Ts14h
	GqoVk5Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzmAI-008VZY-E9; Tue, 21 Dec 2021 20:55:18 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzmAF-008VZ9-SV
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 20:55:17 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 bg2-20020a05600c3c8200b0034565c2be15so2578806wmb.0
 for <linux-nvme@lists.infradead.org>; Tue, 21 Dec 2021 12:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=peNfjyvSHuZS7d9Xq56OU5X9wJb2moCNRIFyWTeF44U=;
 b=J1MX+vbdDvW/tmlqQUlKpZ9VTUsrl8KbBPveCM64HsURD1UDN7CJjOc8vLjl1MMoKu
 PxxJzcWBmUvAmNmF6lNlT6jyIA5Br19fRr7AEgu9x8ZCCnix5QF752X5IAir3nL1mVZG
 Clnzbvlr4mxjUTusP3MBQbdowTTbxmUaIt5ilS2zkUnjv1uu2NRjuYQQi79pYbjfJEzQ
 dVUse7A3zsn48Q5V1fcJ5VJYfDFz6g83X+EL/BNwgX0V7mnidhhZ/0G77WlVnKuM4eBv
 NMCJvmZcKLiaJM7uo9YnWfDxCj6pdSxGjMjlbG1tjkhPC6UkS4mSJDuaujj6R+zJWTaB
 XGWA==
X-Gm-Message-State: AOAM531/k/3RXFmRZy7A/nFiP8rspd7uh8Kc9DA0iJdu+N9pgRt8Y0Pg
 Bqiyrjr8JQoMgT8jvdGOXjq9xKwEKYg=
X-Google-Smtp-Source: ABdhPJwz9LKtv8NBwwD/rXtvurbTPQSVP9FjBir9aEXo9I87yLgO2SWiIbCcuobvBlgBMPZqQA9TYg==
X-Received: by 2002:a05:600c:19cb:: with SMTP id
 u11mr181967wmq.142.1640120113292; 
 Tue, 21 Dec 2021 12:55:13 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h27sm3576587wmc.43.2021.12.21.12.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Dec 2021 12:55:12 -0800 (PST)
Subject: Re: [PATCHv8 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20211202152358.60116-1-hare@suse.de>
 <20211213080853.GA21223@lst.de>
 <9853d36a-036c-7f2b-5fb4-b3fb4bae473f@suse.de>
 <4328e4f0-9674-9362-4ed5-89ec7edba4a2@grimberg.me>
 <56f1ce1c-2272-bed2-fd6b-642854b612bb@suse.de>
 <483836f5-f850-6eac-8c38-3f03db3189ab@grimberg.me>
 <0c4613ff-ba30-c812-a6e9-1954d77b1d1b@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ad9af172-4b7b-4206-feab-8ab54ba7cfe5@grimberg.me>
Date: Tue, 21 Dec 2021 22:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0c4613ff-ba30-c812-a6e9-1954d77b1d1b@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_125515_980441_D1A341E8 
X-CRM114-Status: GOOD (  16.83  )
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


>>>>> Question is how to continue from here; I can easily rebase my patchset
>>>>> and send it relative to Nicolais patches. But then we'll be bound to
>>>>> the acceptance of those patches, so I'm not quite sure if that's the
>>>>> best way to proceed.
>>>>
>>>> Don't know if we have a choice here... What is the alternative you are
>>>> proposing?
>>>
>>> That's the thing, I don't really have a good alternative, either.
>>> It's just that I have so no idea about the crypto subsystem, and
>>> consequently wouldn't know how long we need to wait...
>>>
>>> But yeah, Nicolais patchset is far superior to my attempts, so I'd be
>>> happy to ditch my preliminary attempts there.
>>
>> Can we get a sense from the crypto folks to the state of Nicolais
>> patchset?
> 
> According to Nicolai things look good, rules seem to be that it'll be
> accepted if it has positive reviews (which it has) and no-one objected
> (which no-one did).
> Other than that one would have to ask the maintainer.
> Herbert?

Any updates on this?

