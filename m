Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FACC001DB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 09:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Onp9ZJptHL07n4NPSiYwM0vGxLeou7U0Var2bjtzuBA=; b=Om4jXFEJKvAYAUfZT8VCLARcpo
	kE896HBt6v/K3sK0vA5dnvGAQ7vAQEnpbJWmBR817auruAfoGcBTM9FuPntSPocedm2Lp2ZAoiLSg
	3lOovToDhCtxuBOGmkMCmb+mL9ucI+vZPVXIa4ajty2/H2hNG6R2e/8P2146LyEtJCdt2rv68XExy
	JI5Hd9PlwzTCyM/NxcLWAiVucc4DTq/iEflRXo57Nh/WkU5dmB2JNUQFXvoVvO69qaviv4p187LmA
	P9Xae2tfT5NANIbnpYUT8IKZ4iGOAUcKi/Suqn+sLjRgzl0+2QaZ/pcMs6t1dZFdwqF2YKbKxXEWq
	xtHLm18A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIfF-0026NX-1k;
	Tue, 08 Aug 2023 09:06:05 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIfC-0026M2-37
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 09:06:04 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5230f92b303so1608594a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 08 Aug 2023 02:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691485561; x=1692090361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Onp9ZJptHL07n4NPSiYwM0vGxLeou7U0Var2bjtzuBA=;
        b=GifLU4r4kT5xGFVDx8KBsTIyPG+I76WRY0tmCeHevafzXb39LDgWqpZVHj4WOqb79j
         VSZPkCjuCimh4CuGGiemsCPnfBGbA0GS+q/zcxB4H6YRJXHf0BJwUbAjB/qNfSw1M4XS
         NoAKd4+KRWogq/JtSQ62p1czfCABLy6OhvektkZmXfX9S7AouG/0w7fhYpHfd+eAdWqd
         33n+O2655i/kWgf9SudzPLJCa+jodsNscRIMoFrr3dSK2/K797s3ShACQvAqNQvB67K6
         4RHPQxIqpdWYoCDbKWHQXRr0dnnQztXaks3EVxJkAZQscMesmCNv2KerTAnelc08/cqm
         JXzQ==
X-Gm-Message-State: ABy/qLa59/OTweD7rXn8SaTlfsCWXnnPGfSEx3qqhkYEN3KGdIn6kVAQ
	TLZLUr5iDw0g9TdwCj5uiHM=
X-Google-Smtp-Source: APBJJlHF8TXi/8mhTibvbISi4+q3a9AbHk+Qg2wqNdgfronmhkxpnBwEuDphRCYf8Clkbq+mp86oKw==
X-Received: by 2002:a05:6402:5110:b0:51d:cfeb:fc3b with SMTP id m16-20020a056402511000b0051dcfebfc3bmr26859483edd.1.1691485561321;
        Tue, 08 Aug 2023 02:06:01 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7d51a000000b005232ddd0151sm3837267edq.52.2023.08.08.02.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 02:06:00 -0700 (PDT)
Message-ID: <0c927b66-94cf-e2e1-ae7f-0c5dc4391c72@grimberg.me>
Date: Tue, 8 Aug 2023 12:05:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/14] nvme-tcp: control message handling for recvmsg()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-10-hare@suse.de>
 <5c12f391-c5cb-2d1a-40b3-b93f45292c6c@grimberg.me>
 <5127f18a-7a15-71d0-4ae3-b7caa62e5d80@suse.de>
 <41f9e217-374e-2cfa-b912-147686fe7ee6@grimberg.me>
 <e297b28a-dd74-7fe2-ad63-6f3b103b50b7@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e297b28a-dd74-7fe2-ad63-6f3b103b50b7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_020603_000277_2FC60F6D 
X-CRM114-Status: GOOD (  14.13  )
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


>>>> Is the cmsg passed unconditionally? meaning this does not
>>>> impact non-tls?
>>>>
>>>> If so, why is the ifdef needed?
>>>>
>>> Passing in a cmsg (and a controllen) always enables the use of
>>> control messages, irrespective of the type.
>>> As we never enabled control messages prior to this we would
>>> change the implementation when TLS is not enabled; who knows,
>>> someone might have been sending us control messages all along,
>>> but we never checked. So I thought it prudent to only enable
>>> it for TLS where we know that we might be getting control messages.
>>
>> But you are doing this only based on the compile-time config option, not
>> based on a runtime setting. I am not sure I follow your logic.
> 
> For TLS I actually check the cmsg type, so even if we were to receive 
> other control messages they would be caught.
> If I were to enable control messages in general I would need to check 
> for control messages on every packet, which may well impact performance.
> Do we want that?

Hannes, still not following.

Lets assume that CONFIG_NVME_TCP_TLS=y, like it will usually be
by default for most server systems on the planet (where nvmet is
expected to run).

Please explain how you do not affect non-tls workloads? Or what is
the difference? I am not following your logic here.

