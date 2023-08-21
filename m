Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE72EE4996
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Aug 2023 07:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6hlRFuEO18ewfLVhWL/VLpc0gMEa3vQtcpOVMBFDnE=; b=aphdQ/oLhYaBrssYcFiNSK903h
	Nu5SdGMOnI+JsWOdod6hdwTVJWP6Q2eYzT4XUhc/FSqImHS53zYfEme0e50QXM/uIvuj0OxbB1jxx
	qAbnG6u/kyAyA0Q2EAH2wSAP/KSz7tdw5uPEaWPJG+kCIqQnHI5i2k0Jk3IystJ4Hh85M50Tcd9Fr
	mf/fx8aNG6MAu8kh3m9HFCcekJ53AI4ceYcaMoZpWoVIZDjFVehKghsl/JWTR2atCwlHuvCcfD4do
	eaUKQYskQhgffzdKqA6j1pKGQLBU5y9rNrNG/WHEjFp8vSVSHjqwQLbrv5cWFL2abCImM3MXkovFX
	BGmMaEIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXzZL-00DNgc-15;
	Mon, 21 Aug 2023 07:43:23 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXzZI-00DNfk-39
	for linux-nvme@lists.infradead.org;
	Mon, 21 Aug 2023 07:43:22 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-31985ebed68so623532f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 21 Aug 2023 00:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692603798; x=1693208598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6hlRFuEO18ewfLVhWL/VLpc0gMEa3vQtcpOVMBFDnE=;
        b=eoJvkBtjbIn7CBBn4TSWtTyPvA+6+z82Uzb0c4zA41QJQNDcBdCcXp0B9+J++TcbVA
         g+tklMwTOja29lIEDTrPnAC9EyxY+NW7HpyeeSITABd8Onf8yUQVWeibF///cKf5vJds
         zHJTbvIuThQae3vF3AILFCW+O6I/cYzzkfQp+PTGSTUj5Kejv3RDIr37Za+bDDo0TZPv
         9L/SHiRk3iWZATK4t3FlSjkWt+faldnUvIX6fTn9Fe3OhBJ/LdEK8tMI2V3CATVGHBMZ
         c/yOPyMbkwzPxfRcGOQuyghxMLSkMsDce7EMwjyFfTD02r7crtJL4r0JYLLzvh6XvpUc
         oOmQ==
X-Gm-Message-State: AOJu0Yz3sFRvXsMP4AO/tsGcuWqOEdW+eCXvbqXycZ6YHscRuFkz0WoE
	XPc9jaMg1IVzX2q8GUrhr94=
X-Google-Smtp-Source: AGHT+IHDt7naLH0gcQQARK8rQAsDXjJZrHcQgGMzMpPBtCojQBs1ERrRjAWBRx5UUBj9r+yPoyICZw==
X-Received: by 2002:adf:f4ce:0:b0:317:f1d6:997c with SMTP id h14-20020adff4ce000000b00317f1d6997cmr4443599wrp.0.1692603798154;
        Mon, 21 Aug 2023 00:43:18 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b0031416362e23sm11696178wrw.3.2023.08.21.00.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 00:43:17 -0700 (PDT)
Message-ID: <fc4d55db-dbd3-d2e5-ab2a-3eed07b30676@grimberg.me>
Date: Mon, 21 Aug 2023 10:43:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v2 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230818141537.22332-1-dwagner@suse.de>
 <20230818141537.22332-4-dwagner@suse.de>
 <3713297b-a5fb-b027-c34b-d56526155c4c@grimberg.me>
 <u2esnihohobu5jaxgz3xdfpjfvfrnmkklzajjrckdnr6g3i54b@qofopy4bhhlp>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <u2esnihohobu5jaxgz3xdfpjfvfrnmkklzajjrckdnr6g3i54b@qofopy4bhhlp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230821_004321_012651_39B7C5A5 
X-CRM114-Status: GOOD (  10.51  )
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


>>> diff --git a/tests/nvme/003 b/tests/nvme/003
>>> index 71b82ce758a3..eed1f549866a 100755
>>> --- a/tests/nvme/003
>>> +++ b/tests/nvme/003
>>> @@ -22,15 +22,8 @@ test() {
>>>    	_setup_nvmet
>>> -	local loop_dev
>>> -	local port
>>> -	port="$(_create_nvmet_port "${nvme_trtype}")"
>>> -
>>> -	loop_dev="$(losetup -f)"
>>> -
>>> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
>>> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
>>> +	_nvmet_target_setup --blkdev=device
>>
>> --blkdev=device by default no?
> 
> Yes. I thought it is better to be explicit in the tests. I don't mind
> dropping --blkdev=device if you think we should use the defaults.

Just wondering why it is different than all the rest of the defaults?
It probably can be omitted from the callers.

