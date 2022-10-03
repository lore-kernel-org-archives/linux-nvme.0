Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26832C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 08:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bI6E04hvQn6gIEf5lxXx79EdIOBf9BgYO41pl2Ql6nU=; b=1Gu1ewxsPv+GkLKDUmiIZNZcIb
	tUWhDygN/qZGqwjqVAFQiT2OlKLjvsBqvfUDGUNdX+beUXSpL9Iz3HlTsG+ETJ7almqYqHBKc/XvN
	+Xoybh/+KPe0/vkEzc35zF4ZxW44eaSY7u3ySI/EgRPnv1Bt0sYEOkQznhvRHrYymziHK5GbH/luJ
	uwo8A17K5+Q44saCiL1H6DpJPbx/VBac/jeuH2ptLOy/b1JaVTsNV7EKI3Ul7xJLhRQLWApZi9Uud
	fXx/D+X63jdRNROFooE7BzqnJvXn0QYyqpTUIsgw/x8m/KyzLvIlEF8D/9N4W2UleWQMJ5xKsF6Pb
	ZU49w88g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofGya-004jIs-Ta; Mon, 03 Oct 2022 08:39:00 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofGyW-004jFI-HV
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 08:39:00 +0000
Received: by mail-wm1-f45.google.com with SMTP id v128-20020a1cac86000000b003b7a6ad5ccdso2384032wme.3
        for <linux-nvme@lists.infradead.org>; Mon, 03 Oct 2022 01:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bI6E04hvQn6gIEf5lxXx79EdIOBf9BgYO41pl2Ql6nU=;
        b=d6WttvOzqVVoJGlUk4HZHvOjD2CVrS2+OcI9mDryykbIbF/20DYDdQ8xhvsm2WUo2N
         YhTDpbtNdRXcp7uRzYfhaWJGyfj4z0+45jGRBDsHlN4GlvfoOeAeHWaUfGUGbnXw41ib
         h3gXi6TghKnlGPntQSX2LIxxy1ZILE1aZ1gMGwgGH67V9KIQCn5d+unqUH2PO//q/p+Z
         STyVDGbJmVleubIN+x9onebFDxNIqCgp8v3105SBq1xt+vYMuB5vBjVYGJnYgMFLpu4L
         OT3S+y1oIscT8u0TCl3fS+fiaQwgWMEtTg91jK1luRU0YIlSl7GIsDsV3lP3ycmCO8Qa
         Zoow==
X-Gm-Message-State: ACrzQf2MT7dBTDdsyXNeVhI1MAk0mfJ/jw9HHLFdu7gp6RiPscHN8Tez
	l+MZzVVjWDIFBCu5Euka3ZY=
X-Google-Smtp-Source: AMsMyM7tUa5qQw15Ft7+AXJUL+6bKHQDW1aff0CYSAlzjYnomMj3mNVUrBDukUf9d81OTI8yY+uVyA==
X-Received: by 2002:a05:600c:4f89:b0:3b4:a6fc:89e5 with SMTP id n9-20020a05600c4f8900b003b4a6fc89e5mr5844437wmq.149.1664786334045;
        Mon, 03 Oct 2022 01:38:54 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b0022afbd02c69sm7071254wrp.56.2022.10.03.01.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 01:38:53 -0700 (PDT)
Message-ID: <d55d562c-e1ac-1dd8-c756-9b7da3425e98@grimberg.me>
Date: Mon, 3 Oct 2022 11:38:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <4588d1b8-c2e1-bebd-3aaf-29f94cff6adf@grimberg.me>
 <cfdf4e12-a855-49c1-2c65-7e49c24cd2c1@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cfdf4e12-a855-49c1-2c65-7e49c24cd2c1@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_013856_601328_1D18209E 
X-CRM114-Status: GOOD (  12.72  )
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


>> index 9bacfd014e3d..f42e6e40d84b 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -385,6 +385,8 @@ static inline void nvme_end_req(struct request *req)
>>> ????? nvme_end_req_zoned(req);
>>> ????? nvme_trace_bio_complete(req);
>>> ????? blk_mq_end_request(req, status);
>>> +??? if (req->cmd_flags & REQ_NVME_MPATH)
>>> +??????? nvme_mpath_end_request(req);
>>
>> I guess the order should probably be reversed, because after
>> blk_mq_end_request req may become invalid and create UAF?
> 
> Yes - blk_mq_end_request() will put the tag, it could be reused by the
> time you call nvme_mpath_end_request(). It won't be a UAF as the
> requests are allocated upfront and never freed, but the state will be
> uncertain at that point.

Will reverse that...

