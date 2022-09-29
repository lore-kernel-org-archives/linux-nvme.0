Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15B7C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36OTTwRy+5c5M7fe2EXmhqbct4GRhvZJ9FMcrAFKht0=; b=vaWWNFQzVYDFccBl60iey3fRYm
	l5sWguxGNbxDScu05Ai+okywiufLwe+T7VNoIcHQxN91CC7ch9I4bpJa/ZXnzgG4T18JMoyCjWSns
	hFBPY7LH4dGElF+iaNheE3vQwQZFJ36rVhdqgIag4qr1+sJm2fGVNap3OQ02+cWl3NqUQqj9HWRFx
	WNoM74u02ohUO7mDTrbDP1o8Mm/J0d12UayHnsMp/NjIvuaCukVDvqh0Tcwm9nVHbpYrvSs0Nm4vH
	ylkVXmt46Ws1eY5H3jZjXaDWKqX8XemgzGvqVbcEndfe6L3CtBo+4F5BocWsqAapJF98N9+9EkJoD
	H+MW8Jug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odv8g-003lq9-Lp; Thu, 29 Sep 2022 15:07:50 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odv8d-003lmH-Oy
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 15:07:49 +0000
Received: by mail-pj1-x102a.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1584114pjh.3
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=36OTTwRy+5c5M7fe2EXmhqbct4GRhvZJ9FMcrAFKht0=;
        b=SNoe1BDPa3AgjVgbKlJugpoKUqqiu+dfjZfcp2/52Nhd/QSECre+9KJQjNO3a+TCEm
         PtuIoIG+9DRAv7E6dW9scD+uJMQyErVAXdxPSSXAhbdqZ/PPrh3ncSHSlpUpWxdJdY59
         hhwqj+vfDZnhefJmbNAFrc8G4AXNyJcNnWlvK5bdQFhiWcMaO5Ss0O2OF/fRrNuthYE0
         Qk6DTWQLcDrDoVhZLXn/HEdTfsYbUD+TPH3XsVu4/TmrOe7mGT8uFozka0wGasyi/7rT
         hlzIo+XofpEipzrY9bvCg6SoP6bXNR/S4AqXZbUuPNimauUCkBHw3mWZNuHFteflqIyw
         koZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=36OTTwRy+5c5M7fe2EXmhqbct4GRhvZJ9FMcrAFKht0=;
        b=zhXleKx5EUm0WRvoN8d45ehyB3bVY0iSHnr2FmRVWnizlmaI65/0dxlupwMaDXi6FZ
         EI4NykNspawiqnNN99QL2KU5oy4NjHybXnAnDy799mWoCl8CKjUQ7TNvqFsUqoZ9qKWQ
         o5L9YB44DpLS8/c852JrQk+VUZjOVB/6KJgymdnUFpVp+qO+2UikuP5qlV6FSa4qPDuT
         KxyrQstKeHlhuTYNyYnyUUyThCIqqX11HbsDVu0Jw830W1lJpRAMo9qZrB73EsDQKGmy
         pMHGbGaE3xgSCvlrMZZbJHmAc/uXMoARrH0WRN7JKv5gwMLc//tE51fyvrjilRjejNw1
         dxEw==
X-Gm-Message-State: ACrzQf1pItBx5tVvYvqZEJpRSMJc/RXZ+f7ZKM4OCqRPN3rme1NIg5gv
	R4dr/KkWhjMzIlhoWBH7K/bDhdJY9qy49Q==
X-Google-Smtp-Source: AMsMyM5x+qK0MT841AFb/0462HlriETBk438rHme2KGFcNnIBwf6hCVBnBgtLQeLsm+vStdYi/DAiw==
X-Received: by 2002:a17:902:a50d:b0:178:9701:c02c with SMTP id s13-20020a170902a50d00b001789701c02cmr3848250plq.145.1664464057409;
        Thu, 29 Sep 2022 08:07:37 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b0016d5b7fb02esm3315601plk.60.2022.09.29.08.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:07:36 -0700 (PDT)
Message-ID: <cfdf4e12-a855-49c1-2c65-7e49c24cd2c1@kernel.dk>
Date: Thu, 29 Sep 2022 09:07:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <4588d1b8-c2e1-bebd-3aaf-29f94cff6adf@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4588d1b8-c2e1-bebd-3aaf-29f94cff6adf@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_080747_841778_025BEE7D 
X-CRM114-Status: GOOD (  12.85  )
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

On 9/29/22 4:04 AM, Sagi Grimberg wrote:
> index 9bacfd014e3d..f42e6e40d84b 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -385,6 +385,8 @@ static inline void nvme_end_req(struct request *req)
>> ????? nvme_end_req_zoned(req);
>> ????? nvme_trace_bio_complete(req);
>> ????? blk_mq_end_request(req, status);
>> +??? if (req->cmd_flags & REQ_NVME_MPATH)
>> +??????? nvme_mpath_end_request(req);
> 
> I guess the order should probably be reversed, because after
> blk_mq_end_request req may become invalid and create UAF?

Yes - blk_mq_end_request() will put the tag, it could be reused by the
time you call nvme_mpath_end_request(). It won't be a UAF as the
requests are allocated upfront and never freed, but the state will be
uncertain at that point.

-- 
Jens Axboe

