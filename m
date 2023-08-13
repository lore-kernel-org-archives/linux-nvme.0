Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ACEEB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 13:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+WchHnxYDWvLtaJmVKpQlOl6TOdhyGhTmPbCyKoZbU=; b=1/3QmdoTMGv91XGKdqi9iK3kuP
	8IjPBYGcO8CBX4IJW7ssqBi/9rEd6Mj+8if0n/Cv45FI6fN9993rtkj2xGVHv79nccbW6LkZxTleF
	PrTpfaxoRGcNLL31XqfXOMNXOGeuUFxEmhAhY6Bvtoqm1tL3xNqcknBaDwXdgfSupvAcPVFLvXs7d
	1vWHvZx8qvH1yGqE8dmJRvNUkOkoSxBmW4btXag/J422hBbCK5cU6jw8f0QcenmFNAGd3T6beMP4Z
	GSQnZ3bPqd5ZUkVOWqFJDu5sy00bf6d46PKOMvT37nIvYChHYv+Z4o2dbrOFCdiyPV4W1iWEhT1TH
	vFgYpDAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVAob-00F8er-08;
	Sun, 13 Aug 2023 13:07:29 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVAoY-00F8e3-24
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 13:07:27 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fe5c552dd0so7079475e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 06:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691932039; x=1692536839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+WchHnxYDWvLtaJmVKpQlOl6TOdhyGhTmPbCyKoZbU=;
        b=ZXSa7drWzelleqIPHhYSiScjCKxbQb+OCINocChSU4yP94MfvoAoj8NULaLBjB2A15
         J+vLr7JunD7iZoQis6Ln8UEG7VeB9lfknCxYBq+30t4vohvRk458VBtCMm1GnP0BvkHL
         R3x/PkXftxDRyGL+/ZWe98I5821xr3ItwN6H9YOMZhPynBoq4uNaSlC5nRT7XDfu5rBe
         QXbqgmtJv9a89QKSpyJ5oApkcNUj6yGLe/vX8gCw0zenjSI71T5CCP11eCpWbaOwvq6V
         yNoqATr1xWek8op/K89dD45bIWnAl3mzPzbEyKPOsdbHxiTal5kRzsCOEH/fjYKA35xD
         2sww==
X-Gm-Message-State: AOJu0YwAh1K5MeF4PI5hEM45ZcMhUdoC04/pqHmC9IdpK2T4zWIGhrOQ
	Vo1BxGiS/mj98wwz2RAVVbpu/ayrHr0=
X-Google-Smtp-Source: AGHT+IERb3YH45rnMGurTErZBHlXauj+M7YCujyP22v/pwd7xp9KLd3gwzsXahLaUjGeL7yD9PuAzA==
X-Received: by 2002:a05:600c:354c:b0:3fb:a651:c153 with SMTP id i12-20020a05600c354c00b003fba651c153mr7019292wmq.2.1691932038912;
        Sun, 13 Aug 2023 06:07:18 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id c17-20020a170906695100b0099297782aa9sm4516214ejs.49.2023.08.13.06.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 06:07:18 -0700 (PDT)
Message-ID: <433182d8-c57e-2e51-2692-02ac8b474bf2@grimberg.me>
Date: Sun, 13 Aug 2023 16:07:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rfc 6/6] nvme-fabrics: expose support for traddr as dns
 names to userspace
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-7-sagi@grimberg.me>
 <7d60e267-be0a-41ff-8015-d3440b6eca2c@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7d60e267-be0a-41ff-8015-d3440b6eca2c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_060726_696798_02213204 
X-CRM114-Status: GOOD (  20.95  )
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


>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index fadd25538d1b..6a7e8cbdaf69 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -1331,6 +1331,7 @@ static void __nvmf_concat_opt_tokens(struct 
>> seq_file *seq_file)
>>           seq_puts(seq_file, ",");
>>           seq_puts(seq_file, tok->pattern);
>>       }
>> +    seq_puts(seq_file, ",dns_ip_traddr");
>>       seq_puts(seq_file, "\n");
>>   }
> 
> Don't we need to update the parser to accept this option, too?
> After all, the implication is that all tokens in the output can be used 
> as valid tokens for the connect string ...

I struggled with this bit here...

Today, we simply expose all valid tokens, but in this case
what we really need is a capability indicator (in this case
traddr can be a fqdn and not only an ip address).

So we could make this a parsed token, and make userspace
actually pass it in case traddr was passed as a fqdn, but
it is absolutely redundant to do so.

We could come up with a format that explicitly says this
is a capability instead of a valid token.
Like: "cap=dns_ip_traddr" or "format=traddr_as_dns_name" or
something...

What we just need, is for userspace to know if it is possible
to pass traddr in a specific format.

I tend to think that this is something that we will want for
other options that can have multiple formats.

Another option would be to make this a separate token and
call it ctrl_dns_name that would be separate from traddr, but:
- that will cause the changes a spray of changes that would accept
   an alternative to traddr, and validate that at least one exist, but
   fail if both are given
- bubble up the usage to userspace, leaving the admin with the
   exact format of the traddr
- keep track of this when doing reconnects and stuff.

So I figured that the current approach would be preferable if
we accept how to expose that for a given kernel/driver, we can
accept dns names, or we cannot.

What do others think? Christoph? Keith? Chaitanya?

