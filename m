Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21164C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UNEeljzIhK5W/IZgGt7gmKHGzaAkqCUHyoA8WnkK7is=; b=cvPAgKN/i0AUjlKVBEUxDH9lat
	atIeyDMninmaiiAbX/OPSnLOYN1fMAYg1FQ2lK3QOHQ0OXta6HRiKS/zCBQXzGeYXMQ+63strLYwY
	BjPbftspzne1PhzLu+2nEzgOsQUaa/Tu+hOAjJ0VwX5u5nTyDS0jf5sC0kGnv/pEAc3BF9eVV2sTB
	zGOSVybTIQD8RymCiiGKk2mWN+HuoAmkz3s2O7IE1NhrszJS/PFfeqYc4tc0SXZAQkcpp+64GbjN4
	up8laHdE/I/JJqSugx5sVekxSPakUJQHKInw+mmRuWCFr6R7iiPhazfUUSzG4UpciPoflH7FVhi4W
	HgZH1Elw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJZxu-00EyQB-UG; Mon, 14 Feb 2022 11:56:23 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJZ4f-00Ef3Q-RR
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 10:59:19 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 d14-20020a05600c34ce00b0037bf4d14dc7so9907930wmq.3
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 02:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=UNEeljzIhK5W/IZgGt7gmKHGzaAkqCUHyoA8WnkK7is=;
 b=AR7iJOj4vNqEGRveFd2nWUimZ722oR+7SETDOtm+NckakqA06ZmjRPOAbXsQh9Zwmm
 b5Y6fpDvWs4dUB7xiEKHBecJZx6Lz4DbYpeFIY6a+5Jw+Ejen8n0DiebrZ/KlsQiU3k2
 N4yLgYLqFtV5JW+mpny8PZvkgTPAaVo1L8wdAhuNtUmKacldIuR8YxQ9zs03DIVYrAdg
 R+ciXXhVBnZ7U2QuRlo5itCLd81rytgxo03sdrPFxC2CJnRIr7HrJX6v2YpMaNry79Im
 am2sCKW8LFO/lJUNUSK1fbcn2NssKWbs8ruph9s65D/w1whd6A36ZQngC1UC64PxgdXI
 PQzQ==
X-Gm-Message-State: AOAM533IY9nARur3op7DFFuUf7okch4K8/WavFiyGXpfTYPDfn0uAF8C
 t/J6bmqYrOCYxlVuN+JMMFQ=
X-Google-Smtp-Source: ABdhPJzhDQ873ljjkoF0rKqjkrDM/ahfTUjIWs0oZp3FuPWdwN8go9NhZM1fb6CIJq/EezlTp1npPQ==
X-Received: by 2002:a05:600c:2d4b:: with SMTP id
 a11mr10553578wmg.44.1644836356195; 
 Mon, 14 Feb 2022 02:59:16 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id z17sm11689729wmf.11.2022.02.14.02.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Feb 2022 02:59:15 -0800 (PST)
Message-ID: <083bf233-5258-ae35-9d3f-727ebd3ded07@grimberg.me>
Date: Mon, 14 Feb 2022 12:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/7] nvme-tcp: fix bogus request completion when failing
 to send AER
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20220214090732.479193-1-sagi@grimberg.me>
 <20220214090732.479193-2-sagi@grimberg.me>
 <6d0d9d72-40d0-46e0-87af-524f49e966a3@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6d0d9d72-40d0-46e0-87af-524f49e966a3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_025917_977797_912C2E50 
X-CRM114-Status: GOOD (  10.13  )
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


>> AER is not backed by a real request, hence we should not incorrectly
>> assume that when failing to send a nvme command, it is a normal request
>> but rather check if this is an aer and if so complete the aer (similar
>> to the normal completion path).
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> 
> 
> I think same patch is already present in the nvme-5.17 see [1]:-

Needs to be disregard, it sneaked in as it existed on the same branch...

