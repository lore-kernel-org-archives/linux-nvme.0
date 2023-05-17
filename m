Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33D9C77B7F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 10:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AlAqK8FcIZGK9cue8gGgv49lvpfMD2NVj3FP5krvXww=; b=pHmoGXAb7MXOCfvK9U5O5aS8cR
	lxqmMn7r4wZQfZ3TBaqX8wiECdtgWsD8XBJu3hMMJCHAjhUT4TlFj0Rht80e9sWGLyeW1ceXDL0qk
	9uTyIvpLUG5M51Prk/sE9B4zEC4fu14M0spq96Hv7bZMmTceD8QSI1LLaKyMHssDaQyS+PYTRM/BJ
	E3RAT0mSDhjZOJXPnvWawbVzpA/srqMa/TzMPXcbIi1jqpm7KcEVLMM9+uCFQThglRwpw6CdnmEUQ
	Quhi4XAlzxJ0KGp7wCPxFwwN7OB+ioEJYAdj4MGa8EcwmLckdFgsAWm9y/aJeWbasQgkAMEZfUBVn
	UJxLELNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzEfB-009TBq-1t;
	Wed, 17 May 2023 10:45:45 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzEf8-009TAb-0k
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 10:45:43 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-30945099087so3859f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 03:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684320338; x=1686912338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlAqK8FcIZGK9cue8gGgv49lvpfMD2NVj3FP5krvXww=;
        b=U9Wimg+11Q3rSb09dCHpZmatdGd1G40Zlr9sOlX7rfJMRSEvabV7CYf0a9+sUO05aS
         JzupslWULURvbICisXjhNXLO0YWYouQhTijM0O+KnjdW4JVUG0/AY67PtGngum6+St8r
         XLy4Pw8B+Tu/TUdznvJqYiKlq9eqJYljRzLFHQ3FVuZokdmXgvbaaiBeh0IISamxHUTi
         lQZfnMvLx/2AdpdbMjOzJau0ko8Ph8JqfD1ggZNHx4NOC/5s82bVNK4pqaKJI04QDVOF
         u+wsD3ISEHwD/xV2tV+6Y5CXiTI38o5puquDm8YTRLs5rCpChjIOfNlz28aKOvMgBzFp
         F5zw==
X-Gm-Message-State: AC+VfDxp1HkigjV360DmP/CO1Z+oezC8q2ySChjvmvPwaaqN5+jH4pTB
	l2NAd7O36T+u378kpN78LNI=
X-Google-Smtp-Source: ACHHUZ7retFBeF9juN86hZFupUlnfL3LLcm7gRfgBu8IZmkAIa1IOWE2PkDdPSD+SZ78/m2nBH9ZTA==
X-Received: by 2002:adf:dd50:0:b0:2cf:df6d:6063 with SMTP id u16-20020adfdd50000000b002cfdf6d6063mr1579941wrm.2.1684320337917;
        Wed, 17 May 2023 03:45:37 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j11-20020adff54b000000b003062c609115sm2417664wrp.21.2023.05.17.03.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 03:45:37 -0700 (PDT)
Message-ID: <cbac5de1-05d8-dd6a-f494-fb8db642e236@grimberg.me>
Date: Wed, 17 May 2023 13:45:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] nvme-core: add helper to get nvme_ctrl from device
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
 <axboe@kernel.dk>, "ch@lst.de" <ch@lst.de>
References: <20230512082206.4788-1-kch@nvidia.com>
 <0b182e1b-e267-81da-dbda-95ea04ade338@grimberg.me>
 <4c52ac51-73fd-97c5-4bfc-7e897dc9e73a@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4c52ac51-73fd-97c5-4bfc-7e897dc9e73a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_034542_270674_9BC2E119 
X-CRM114-Status: GOOD (  17.70  )
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

> Hi Sagi,
> 
> On 5/17/23 00:12, Sagi Grimberg wrote:
>>
>>> Just like we have other helpers to_nvmet_port(), to_nvmet_ns(),
>>> ana_groups_to_port() and to_nvmet_ns(), add a helper to get nvme_ctr
>>> from struct device.
>>
>> I don't think this is very useful.
> 
> it's the same pattern we have used everywhere in the nvme code,
> I did not invent anything new here ...

Still I don't find it very useful. get drvdata from a device is probably
the most common helper in device-driver territory, not sure why we want
to add a helper on top of it.

>>> Note that this removes the bunch of nvme_ctrl declaration code that is
>>> needed to get the nvme_ctrl from struct device in the host/core.c.
>>> Followwing is the diff :-
>>
>> It doesn't make it easier on my eyes...
>>
> 
> I failed to understand how this is different from examples mentioned above
> which are part of existing code reducing ~20 lines in current code and
> future code for a variable declaration that is only accessed once ?

It adds an accessor on top of an accessor. The reduction of declaration
code does not by definition make the code simpler. and personally I
don't think that making bar->x->y foo_to_bar(foo)->x->y is necessarily
an improvement.

If others think its worth while to change, I won't object, I just said
that I don't think its very useful.

