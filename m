Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3304AC64EC4
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Mar 2023 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lLGiNavGwCzxUVL+snPo8/qrtYV5Iz99KwVyTM8K7EU=; b=pq3btO6Geq41HbZwEFU4wsjC+Q
	M+edOumOfKOanzkTLY0HxjRVt6khdeUw2ryrNG1fhLsMmrnsbpIiNRtdY7SR3IeEUi+8k2v8wG8kl
	5COhN6sUz7aF67XBh4op5ELphvZr0ADgu8aQjliEJY1jVWTkDySGJZsQIdW9kBwKGyWs/z54Cv2Ye
	/oacI5khyKz9wt2v9HlPmgSLtr33a7AVYWR7UXwmqE6zNv2wAimcw9KmT5WbvWrvz8mLKmN3bKczW
	Nog/8/Cklu5+DWncTnu65QR8xePNuO56lQWO+mSxbz6UCjne7kJDdngSwXmV7SNk9wDbxTaWbL2sS
	jTqJ0LVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZs7n-004e0P-SR; Wed, 08 Mar 2023 11:38:27 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZs7k-004dyb-N0
	for linux-nvme@lists.infradead.org; Wed, 08 Mar 2023 11:38:26 +0000
Received: by mail-wr1-f52.google.com with SMTP id bx12so15028165wrb.11
        for <linux-nvme@lists.infradead.org>; Wed, 08 Mar 2023 03:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678275500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLGiNavGwCzxUVL+snPo8/qrtYV5Iz99KwVyTM8K7EU=;
        b=yS42lMFyKe1afc8Ayz5wo2WujcvuXImXb423G4/enGMpaqnXOj3n3DxPrr501VDpat
         /wkT8GW+ADTmXfASZAvYvCB70H7wSDus6ThVfFzQSJ11NXdyFBsTnrNv15uE2hwQlJ/B
         tAbcNutLeMmz2wvK8YCl/k4xVJgguYkxDHMxS0Zg1IdQ6WLXP3J7YvuytgvbYvwBox7L
         9kW3HoVolm0vXNUdvu4BAd2Z3dQ/EPF723SZxcqPqgnM1PLB1uyuVBRf0+7nTNIk7KS2
         xYDosAk5zsrrZS3R+JQHLBIgEYu49MU/igDnT14z7dp81g3Fm/iDT5FvvWtDLmvxQFZW
         BujQ==
X-Gm-Message-State: AO0yUKUMuaKsV/ZnJCzKp8ehwhLJYM0cqMUvXwBOwwyEhF6BKdrniO9C
	IRfVB746nLTdTN6V2GpY0Jo=
X-Google-Smtp-Source: AK7set+S01iTXbDSS5aqr+S6sEWoPi3+v6B8QralJpnCI6IK+aJhcEV+RlKu2lJYsWqbwwY0uSSP2Q==
X-Received: by 2002:adf:e60b:0:b0:2c7:1c72:699f with SMTP id p11-20020adfe60b000000b002c71c72699fmr11361912wrm.4.1678275499727;
        Wed, 08 Mar 2023 03:38:19 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d670d000000b002c8476dde7asm15061712wru.114.2023.03.08.03.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:38:19 -0800 (PST)
Message-ID: <c2d61f14-e505-5e71-ca46-63b318095d23@grimberg.me>
Date: Wed, 8 Mar 2023 13:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Content-Language: en-US
To: James Smart <jsmart2021@gmail.com>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20230301082737.10021-1-dwagner@suse.de>
 <a73ea22a-9871-d152-080e-49c0904dbe94@grimberg.me>
 <20230307122849.3oc66ojdsgvvj77h@carbon.lan>
 <ce404c97-2716-9572-22de-3935c23757dc@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ce404c97-2716-9572-22de-3935c23757dc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_033824_771089_4339495E 
X-CRM114-Status: GOOD (  20.40  )
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



On 3/8/23 00:09, James Smart wrote:
> On 3/7/2023 4:28 AM, Daniel Wagner wrote:
>> On Tue, Mar 07, 2023 at 11:26:12AM +0200, Sagi Grimberg wrote:
>>> I think we should make all transports to unify setup/teardown sequences
>>> (i.e. including pcie and fc). Otherwise we are not gaining much.
>>
>> Not sure about pcie but I haven't really looked at it. The state 
>> machine is
>> really handling all the fabrics specific queue handling.
>>
>> Ideally, fc would use the same state machine. Though the current code 
>> base is
>> differs quiet significantly but I can try to convert it too.
> 
> I'll certainly help for FC.
> 
> The 2 main hurdles are our differences around:
> a) the new flag - which I replaced in the fc calling setup and a state 
> flag. Shouldn't be much of an issue. We just need to look at when/where 
> the tagsets are allocated (and embedding into admin queue setup isn't 
> necessarily best).

Does fc create an I/O tagset on every reconnect? Doesn't appear
that it is removed on every disconnect... I'm a bit confused.

> b) the init_ctrl - I don't have the initial connect inline to the 
> init_ctrl call - I push it out to the normal "reconnect" path so that 
> everything, initial connect and all reconnects, use the same 
> routine/work element. Also says the transport will retry the initial 
> connect if there's a failure on the initial attempt. To keep the app 
> happy, init_ctrl will wait for the 1st connect attempt to finish before 
> returning.   Don't know how rdma/tcp feels about it, but I found it a 
> much better solution and cleanup became cleaner.

Don't see a major difference, I personally find the initial setup
different than a reconnect so its simpler to do them separately.

Can these two differences change for unification of the transports?

I would also like to get rid of the new flag, and just break these
sequences to different routines.

