Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC95C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7BBaAJCFiRdGvin9xHY5uPPFBq08Ik7RitVkuTXaecQ=; b=DDPYVTt0s1+Qjo5iS2t7KW1zFc
	W1+0mNaxccU+IF70YiAoLRQIqfDxw5i3Lm4yLOzXmSvJebOodFOdLox73FZ2x5qbMfFzI7t56PmIl
	4oqoxoeExq7q/+W+rGpCWNlsSTJR4tAkjXJpUAY0Pc+BFlEHlDk/iD5cNhBPezx9DJnompweeOoD/
	+XpXwdhkbbsrZfS0ykV0ik9OLqazyMqrG2kXHxAI3pPLJBE5WWgE6bTxjQgPub/VYfGKaawFnXYIM
	K1Mw3V2eFrgQghMVG0iLBKnDRRErlt49esKcNg0GNhra4Ssq3kARkKR8JtJFan2I3pjo8CWTA1cX/
	7x1nqQHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbk5D-001R7z-67; Tue, 05 Apr 2022 14:22:59 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbk5A-001R6h-3M
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 14:22:57 +0000
Received: by mail-wr1-f46.google.com with SMTP id d29so13520465wra.10
 for <linux-nvme@lists.infradead.org>; Tue, 05 Apr 2022 07:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7BBaAJCFiRdGvin9xHY5uPPFBq08Ik7RitVkuTXaecQ=;
 b=Z245m3h83eqENgSVrCsjovLET7sLXctGMefUdx6y6RPphFhbC733/xRRVpTQiAy7Wt
 +fy0Qp3mr0s9VfgNbnyUL/6xsoqcmqI5SPnkLYpjR50gRZM5ElUkZLRCEjplZsKWY0ht
 9DAtvq/3ul81Hx+p0Oj5DWso0+BiCiV/OPc20LOxB2LUB09rhpR38oM6pQMcA8y5oKcZ
 Tq2Ex9kv9+1Ur8+ioS+/+QcJUw2AYigXUigqA5+Hd+VWGebAJ74haK3f8EZ1ZFdGrtlk
 QcONFGMsFkMvZNi3+l0rE3THptD5TTxykHpm1BvACxFVs+VyEManxHbB0clIRE5SzM3v
 gS2A==
X-Gm-Message-State: AOAM532szKdhnPMm3ZYI9QFyeiqwGa9LhCDytogPU3fudDXhK68/X/Po
 A0b06XD3fUhKYJVQWrMfS44=
X-Google-Smtp-Source: ABdhPJw994JlO1oq4YLURnxbvPfdF17RKBAXPTNaBNt9uUsPBaEPRvHSEqjibvV8YM+RXuUO5z/XaQ==
X-Received: by 2002:a5d:588d:0:b0:204:217a:d9ce with SMTP id
 n13-20020a5d588d000000b00204217ad9cemr2991472wrf.377.1649168573436; 
 Tue, 05 Apr 2022 07:22:53 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 r129-20020a1c2b87000000b0038e6a025d05sm2464688wmr.18.2022.04.05.07.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Apr 2022 07:22:52 -0700 (PDT)
Message-ID: <6bb6cd3a-cf20-da88-9aae-31d92358fe74@grimberg.me>
Date: Tue, 5 Apr 2022 17:22:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in discovery log
 page for unique discover controller
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-4-hare@suse.de> <20220405054601.GC23466@lst.de>
 <a129df40-6195-8b59-aa76-e3053e0960fd@suse.de>
 <20220405061941.GA24290@lst.de>
 <366e9acd-23c8-f8bf-2671-9187f3c0ce96@suse.de>
 <15910553-e0a6-3513-ae43-fc1cb634b1b0@grimberg.me>
 <4d4b58e1-f0db-aa55-78b4-a01df62c2a56@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4d4b58e1-f0db-aa55-78b4-a01df62c2a56@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_072256_188018_70147EC9 
X-CRM114-Status: GOOD (  12.07  )
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


>>>>> To make it configurable.
>>>>> Unique discovery controllers show up in configfs just like any other
>>>>> subsystems.
>>>>> And with that we need to clarify the relationship between the 
>>>>> discovery
>>>>> subsystem and the other subsystems, ie which subsystems should be 
>>>>> presented
>>>>> by this discovery subsystem.
>>>>>
>>>>> Linking the discovery subsystem into a given port makes it obvious 
>>>>> that
>>>>> a) this port will be presenting a discovery subsystem
>>>>> and
>>>>> b) that the discovery subsystem will be presenting all subsystems
>>>>> configured on that port.
>>>>>
>>>>> The built-in mechanism for discovery subsystems was okay as long as 
>>>>> the
>>>>> discovery subsystem was built-in, too.
>>>>> But with this patchset we're moving to an explicit configuration.
>>>>
>>>> Shouldn't we just require anything to be manually listed for this
>>>> case similar to how we configure referrals for the well known
>>>> discovery controller?
>>>
>>> Which is what I've tried with this attempt.
>>> I did _not_ want to create a new configuration mechanism, but rather 
>>> use the existing ones.
>>> And the existing mechanism we have is linking subsystems to ports.
>>>
>>> If we want to treat discovery subsystems differently (as you 
>>> proposed) we sure can have a different mechanism on how to configure it.
>>> But I wasn't sure if that's the direction we want to go.
>>
>> What is the concern here? that it will break existing users with
>> introducing an additional configuration step?
> 
> Yes. It would break backward compability.

So maybe hide it behind a modparam that we can deprecate in the future?

