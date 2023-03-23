Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7610C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eJtS91X7wWZWsQs8IP0IX0aBUDgzNq7ouUFEylr/oRA=; b=gNUMgC3xbItrjtF4/lV5sSKCEj
	+5uDLs68i3Arf0kp+QHgadv9ylcobfCTuY3vuHtjRoCZ9YTFTwOiH3gFRibZQw9OoGf3O2KJ18ZOO
	LzmT9J0ylVru7zrkjmYq9MgoyvC/TzEC/PXA0r97IIPLI3S1gOeOUTwN/t2u8yNRt3NUbSGTkrKPP
	UOyfEoRITZP3Vzbwxhcant5u3YmFc0bgWoRvmHGD6LbVl9MVa3TvkhdinrlXBEdjxoMbavsz28pWB
	kukr7dKoZoyryD5qePrYB05q7vXBT0xyaLHVJv6cPEYsqsR4lfPiJUsBBHBCIyBV7izCD3QG+KbVM
	H9Yk0hZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfG7L-001ELc-2v;
	Thu, 23 Mar 2023 08:16:15 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfG7J-001EKq-2i
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 08:16:15 +0000
Received: by mail-wm1-f42.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so576558wmq.4
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 01:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679559367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJtS91X7wWZWsQs8IP0IX0aBUDgzNq7ouUFEylr/oRA=;
        b=RbhaQNNBhrFpNW3GKKlQXFhHwcZ3vUBoayQ04/kWl3TDsJQsusvAp4e+dBVFamle3U
         HpA43wYp/CUw5QdnEd4FF1a12CZ6fzVEOxW5EUER2u1/D8g192T8caAZHR2HKW7UF71b
         nDjrBRj/sQdMg3O5/L8Q3VLrrAU6ciDr137DocZO9QxLMTf+2Ev1BAvQb9oKc9z/1gSv
         CGSt3EluLTsUv+1kYXujaCnRURzZLNOWV5Pvlw0F/ckf0Vu1R9iCHdbWvm7uZnESEpvP
         IsWv8oekRIWaJRNY1cEeXV2dEYMcTt/kgAUFkfBUwf9SkDHDcRnIzGsAK3wfJsh/2HIj
         l1cg==
X-Gm-Message-State: AO0yUKUXWn5ZuX6TQrZGIJ8xIwnEXoO0dFLwVLObvV9na1SqGf66oScJ
	rVdAbjAppOes4xBYepHj/QY=
X-Google-Smtp-Source: AK7set9w/q9cfmoQHZk7ivoNDdyH77tTpE++gINHtljOvjP8zxWqfIGetMwk+EkcaQAmwfNhwgbcdA==
X-Received: by 2002:a05:600c:4515:b0:3ed:2eb5:c2e6 with SMTP id t21-20020a05600c451500b003ed2eb5c2e6mr8918312wmo.2.1679559366922;
        Thu, 23 Mar 2023 01:16:06 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t16-20020a7bc3d0000000b003ed1f6878a5sm1160883wmj.5.2023.03.23.01.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:16:06 -0700 (PDT)
Message-ID: <33627b01-b3e9-6200-51fe-baa9cd3ae30e@grimberg.me>
Date: Thu, 23 Mar 2023 10:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 9/9] nvme-core: fix nvme_submit_sync_cmd() args
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-10-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230323033636.812758-10-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_011613_882953_B0DE46CE 
X-CRM114-Status: GOOD (  14.65  )
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

> The __nvme_submit_sync_cmd() function currently has a long list of
> eight arguments, which can make it difficult to read and debug,
> particularly when the function is commonly used from different parts
> of the codebase. This complexity can also increase when extending the
> functionality of the function, resulting in more arguments being added.

I don't think that complexity/difficulty is the issue here, its just
ugly.

> 
> To address this issue, we can create a new structure called
> nvme_submit_cmd_data

Maybe call it nvme_sync_cmd_args.

> and move all the existing arguments into this
> structure. By doing this, we can pass the structure as a single argument
> to the __nvme_submit_sync_cmd() function. This approach simplifies the
> code and makes it more readable, and also provides a way to add future
> arguments to the structure without increasing the number of function
> arguments.

The potential gain here is that on-stack initialized structs you can
implcitly zero-out members so you don't need to explicitly set in all
the call sites. But that is a subjective gain because it can be counter
intuitive at times. Otherwise there is no real coding gain with this
specifically.

But regardless, this looks fine to me.

