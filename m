Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C229C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aW/p/gDFPpURkrS2LMNqwBCA5bDLb6i2HHaFzhXO5l4=; b=SjMkOURe7jBMnAvWYfdFaNgtBe
	K1p9uldMzhgeQgwKTgJTneChm16sH60se8W9+Q16FvZXBxmqGGFbxOLdiFLtCb+bRmfXPxLZFHbrE
	ZOsXVWaFp4Jzcz+h3zQWPNhcCU26KqZ3LaSGBO5LJhY0tDsk9izZ1qywGr+hvoZ4QWoDpllcgEPSL
	4SRagiBnJlE1e4TV6XaqxT1Ia2XJIGpWXg2fktzpfM41XtTD1q4uPlQYx+yrJolp3vrfJaV5O9UAk
	6ZcWjzVxn8LtNgZ+2ewRIlRyrSjbfijbAhy1hlDwhAiYdwfzrQ44JwzcdOJA99qJvkn1NShs2m2yK
	+XELTOGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwhiO-008f5V-4R; Mon, 13 Dec 2021 09:33:48 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwhgG-008eKb-0Q
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 09:31:37 +0000
Received: by mail-ed1-f52.google.com with SMTP id x10so32534132edd.5
 for <linux-nvme@lists.infradead.org>; Mon, 13 Dec 2021 01:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aW/p/gDFPpURkrS2LMNqwBCA5bDLb6i2HHaFzhXO5l4=;
 b=MqoqNY88wVHc3WzN+xM4CsMPO+ffJGElBw3Epko+0mbx6zwJvbPumjgB4V8WAtSXwX
 v9pCVE2oYw7bMMjRQNasdZfUQKmex/rk1fuJngoVdM345V6i9ROLY/m7ItkzUP57ujIZ
 oo4Q+YIANrcQPOC0fA9zoqk+AOYUDnqEDwKiT0Ir/zo2Q5rfkJozTg1Sa+w8Hr5eBT0I
 03AFnmh+0JlQSlanEOqWaDNthKpnLQ6axUtXvUK2oOqWF4wUrS/Pd8frYYDhiSMLkGU/
 hLvXFOmJ1udO+Lx2KKD+dBLmZsZR10wRa2iDYHK+MPIxwC4iLetiPG6cG075PomPL8v1
 yz6Q==
X-Gm-Message-State: AOAM531kDeletQENXPm755csdcgLOxk2zY+k1R4N/m7LBqEof5QgnjNj
 swTASHioDA2rEiuzOVT9oZs=
X-Google-Smtp-Source: ABdhPJz1k2cOyY/Xc1RNwZ3z0Z7xKi4ESdWgN8mng3uSUXWKEEgb7a0afr8+9egYrqQbSamfg9j2Kw==
X-Received: by 2002:a05:6402:3550:: with SMTP id
 f16mr60728870edd.377.1639387894089; 
 Mon, 13 Dec 2021 01:31:34 -0800 (PST)
Received: from [10.100.102.14] (85-250-228-224.bb.netvision.net.il.
 [85.250.228.224])
 by smtp.gmail.com with ESMTPSA id d19sm6016366edt.34.2021.12.13.01.31.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Dec 2021 01:31:33 -0800 (PST)
Subject: Re: [PATCHv8 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20211202152358.60116-1-hare@suse.de>
 <20211213080853.GA21223@lst.de>
 <9853d36a-036c-7f2b-5fb4-b3fb4bae473f@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4328e4f0-9674-9362-4ed5-89ec7edba4a2@grimberg.me>
Date: Mon, 13 Dec 2021 11:31:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9853d36a-036c-7f2b-5fb4-b3fb4bae473f@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_013136_086482_F5759853 
X-CRM114-Status: GOOD (  19.09  )
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


>> So if we want to make progress on this we need the first 3 patches
>> rewviewed by the crypto maintainers.  In fact I'd prefer to get them
>> merged through the crypto tree as well, and would make sure we have
>> a branch that pulls them in for the nvme changes.  I'll try to find
>> some time to review the nvme bits as well.
>>
> That is _actually_ being addressed already.
> Nicolai Stange send a patchset for ephemeral keys, FFDHE support, and 
> FIPS-related thingies for the in-kernel DH crypto implementation 
> (https://lore.kernel.org/linux-crypto/20211209090358.28231-1-nstange@suse.de/). 
> 
> This obsoletes my preliminary patches, and I have ported my patchset to 
> run on top of those.
> 
> Question is how to continue from here; I can easily rebase my patchset 
> and send it relative to Nicolais patches. But then we'll be bound to the 
> acceptance of those patches, so I'm not quite sure if that's the best 
> way to proceed.

Don't know if we have a choice here... What is the alternative you are
proposing?

