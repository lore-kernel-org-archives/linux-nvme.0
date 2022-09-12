Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8014BECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Sep 2022 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IuAzgFvQjMqRKpiTBPtvylAOjlVD/gpAhNOiw+EY0sg=; b=z0NIG1nkzLLhN7m1nc3F7XLsPk
	LyMpglpDJ2HMtINHeESaQJA124U0E2mIGiLU31V/4fskoy3LJe9osWuV6Ztwa3MpkZm75gAQuAviX
	G3Lcky4tMtpE5XkAn+XO7sC+wAbnJl5286rWGzbkSzs16ghjBgBqkkvhNlNIhpQTud/llEihVgidB
	P7ntRkdD58ts4gcTiImMr0liPxujn+VQO96B+7jtrAIfsoPMkl/x3fO7JVHHXqzv/7JXthxEKnZvB
	bhCB5hIhAtTrhU/hTAOBfIm2G2QKGr+bzxbeZ3Tl+cURctGt5+4p1+Cz9/jIl+cd2rUnBm+3UX7IG
	7maYywlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXicq-009mmM-BF; Mon, 12 Sep 2022 12:33:20 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXico-009mkE-BL
	for linux-nvme@lists.infradead.org; Mon, 12 Sep 2022 12:33:19 +0000
Received: by mail-wm1-f44.google.com with SMTP id z14-20020a05600c0a0e00b003b486df42a3so1990980wmp.2
        for <linux-nvme@lists.infradead.org>; Mon, 12 Sep 2022 05:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IuAzgFvQjMqRKpiTBPtvylAOjlVD/gpAhNOiw+EY0sg=;
        b=dcv9ioRLXD8h2Y13ujRGGjKrD0QLUtWdq1wp8uKswguRETscSCJMPC1jc4+E/KaPqW
         7AYDWy3uGnXV2f7R5s9jBRI4l2Ib1BRLuXTPM2A0VCW0mQtvX2u7c3d3KdO8jNww14mS
         g0WVrg53ncuquRBGmJ4SPQymR4f/UEDUrWlh+2IpagPnz5X6bB+BP5YMRwMm0rb7L8ve
         ScN0rBiNfO1C/oMtRa8/QSa7eCXihyvuu+QHwoKvw3FAAbnBOR4kTZIJzB+Zw6s9N2MA
         uxgQskKRezoYJA7a4zn6+I0B+iYk1UHQuXk2emQuYYp5HFxJVqMeifbvQXk4lDMiLw+L
         6NSA==
X-Gm-Message-State: ACgBeo11DRLFQJKcEgrKDXra/c9mtwd1IdL2MAxji0b/kMpxyc1l7EwT
	8a6n/dWhY4TqiKPgGr4BRL8EMQtk/eA=
X-Google-Smtp-Source: AA6agR4QsFCFYs9BiYm3M3qvY5TcC+k/ZpRlWUW2TS8So+UHy5Ef90Ig6P5iaM9CB4TnoEtXG/n6hQ==
X-Received: by 2002:a05:600c:1f1b:b0:3a5:f4f4:f599 with SMTP id bd27-20020a05600c1f1b00b003a5f4f4f599mr13971374wmb.39.1662985996918;
        Mon, 12 Sep 2022 05:33:16 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n42-20020a05600c502a00b003b31c560a0csm10036176wmr.12.2022.09.12.05.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 05:33:16 -0700 (PDT)
Message-ID: <51243855-b026-3dd5-163f-572d2ba43543@grimberg.me>
Date: Mon, 12 Sep 2022 15:33:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH libnvme 3/1] fabrics: add notify_rediscover parameter
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Belanger <nitram_67@hotmail.com>, Hannes Reinecke <hare@suse.de>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <20220907142411.101950-4-sagi@grimberg.me>
 <20220909065846.b7fu53pvyvp6qtpp@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220909065846.b7fu53pvyvp6qtpp@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_053318_426056_BDBEFB37 
X-CRM114-Status: GOOD (  12.83  )
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


>> @@ -481,6 +482,8 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
>>   	    (hostid && add_argument(argstr, "hostid", hostid)) ||
>>   	    (discover && !discovery_nqn &&
>>   	     add_bool_argument(argstr, "discovery", true)) ||
>> +	     add_bool_argument(argstr, "notify_rediscover",
>> +			       cfg->notify_rediscover) ||
> 
> If notify_rediscover is not supported by the kernel, wouldn't this end
> up with an EINVAL when we try to connect? I thought we need to make this
> conditional.

The check is done by the callers, which check support for it. If it
is not supported and still passed, its a bug in the caller.

