Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D62C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 14:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RJKnfzyzyEQaXBcdN+jnFLQABa9yl2KfuisahfbwSlU=; b=mWXIZYL/mN2ozUNpYUcKxdc023
	r9YG9aEJlvm+ExkmEy0cKWWEb2Pri8okrjKnuJ3SpkyxZC4k2qpN7Fn0xH4t7jwQJt0tyizPO0xRy
	3urPXHQ9+S54Trs5LPAKohWjqD9V6QRafP47p96r2P839DtaTjLPH9aLhxY51VoRTPMKP1jZcogp0
	H7p/4U/xKvK0EiZ7a4APmQFH18Ecwe9m3BFJkFcF1xNJnm99yCVN0yDd/heYglSH/sDAPm6hseItC
	eswvIc8lDH50U+eOJ75XUcnCUEIRsMrsfp4iwqTobDSikdlTNQry4J1unE1hzuJ7sRTPZ8g2JWKrC
	W2bANE7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDQVI-00F5SW-2v;
	Wed, 13 Dec 2023 14:46:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPTq-00Er4f-1D
	for linux-nvme@bombadil.infradead.org;
	Wed, 13 Dec 2023 13:40:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=RJKnfzyzyEQaXBcdN+jnFLQABa9yl2KfuisahfbwSlU=; b=T1qYm0sUZBu9UdYtH4dKKyGkmw
	pOww2bay6TtVY+nYOlyfczZqywu9Nco5fWg56KQMuhAvYysJQJG7B4DuvTclS/E98eEnx+0ET0jk7
	jMJ5HRhpGARzMJ0BC9dSEHOFjj4zB8MN7s3DkAof4gbANWa+G4DaaLlSa9uK0Zt5lt1U4+9exYuoE
	FfaAk2v1nkEoMlwDAm6fNX09kpv9kybvLba4D/FduB1fctfhTo48XcnY61INXYaxt39IX6gyyp2mD
	uJBiFAsI8hVdlYpLDrLlhprTXyRuIL1eDyrw6KNgEe5pvf2oH0PrACeCkNVvs0NRn8PED8IlW4XyG
	Guaa8Tgw==;
Received: from mail-ej1-f51.google.com ([209.85.218.51])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPTl-0096j3-1t
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:40:52 +0000
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a1cc518c5bbso219981966b.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 05:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474847; x=1703079647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJKnfzyzyEQaXBcdN+jnFLQABa9yl2KfuisahfbwSlU=;
        b=NRwZGiY1r1B8iArB+UgUD4MhrX00UmX4vsB4I9xLT31gZvXBwi05Re/gYkHgQtSsfv
         c7Yu43rKybVpWWhO3wEcYwWbGTMFmwOeegqcxfjBgcIXMr9Lly6k/90JQSHGx/E2L6kw
         1k2RMiu0tx/yT5USU0BpF8JXJsSr2WjA5zoTugZkamoGIKm84NJqpCthKeBQGqzlUjet
         pBqbwJURbo+/MwZqwKltmSnBja4tD/Z9EUDYe43ya5qMUktfNyhrA+uTTVheqh9AYI1o
         tfrmr5dkXZssHdpTznrHO4bLXa3fiqbKsoQadqwaMm5PW9iokt4qdXxHauwB+GkSzoJ8
         vvxg==
X-Gm-Message-State: AOJu0YzopMH3RMBfa8pAwH1LzPCoxn8bpN2+4iy4/gQ1Ko2vHRcWRv6G
	lBKmFG2j1idjgLbyfk9u+9QlNThTmzw=
X-Google-Smtp-Source: AGHT+IHSIG2JrGvEU8taQncs/5kxJkoD0Nrw5y01/fbw6hnXBdaviPPdh3h5/riPgMszYtWJGWWMGQ==
X-Received: by 2002:a17:907:c317:b0:a1d:5c72:3be2 with SMTP id tl23-20020a170907c31700b00a1d5c723be2mr8370959ejc.7.1702474846772;
        Wed, 13 Dec 2023 05:40:46 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id vw12-20020a170907a70c00b00a1c904675cfsm7740917ejc.29.2023.12.13.05.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:40:46 -0800 (PST)
Message-ID: <b6169317-4714-4240-87ab-3e80b2aac2c4@grimberg.me>
Date: Wed, 13 Dec 2023 15:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] nvmet: configfs: use ctrl->instance to track passthru
 subsystems
Content-Language: en-US
To: Evan Burgess <evan.burgess@seagate.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SN7PR20MB6609903F74075383EC400BFC808FA@SN7PR20MB6609.namprd20.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <SN7PR20MB6609903F74075383EC400BFC808FA@SN7PR20MB6609.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_134049_937607_0774BBDD 
X-CRM114-Status: GOOD (  13.79  )
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


> To prevent enabling more than one passthrough subsystem per NVMe
> controller, passthru.c maintains an xarray indexed by cntlid values.
> An nvmet subsystem cannot enable passthrough via configfs if its
> passthru_ctrl->cntlid value is already accounted for by the xarray.
> 
> However, according to the NVMe base spec (rev 2.0c, p.145), "The
> Controller ID (CNTLID) value returned in the Identify Controller data
> structure may be used to uniquely identify a controller within an NVM
> subsystem," meaning that cntlid values are not guaranteed to be
> globally unique across multiple subsystems. Instead, the cntlid only
> uniquely identifies multiple controllers _within_ a subsystem.
> 
> As a result, multiple unique & valid NVMe targets can be blocked from
> enabling passthrough at the same time if their controllers share cntlid
> values, a behavior (seemingly) allowed by the spec. This could be
> remedied by indexing the xarray with passthru_ctrl->instance values,
> which are allocated per controller by IDA and thus should act as truly
> unique controller identifiers.
> 
> I have seen this issue in practice, but have found a suspicious lack of
> corroboration across this ML and elsewhere (so far). So, I am not
> discounting a possible misunderstanding of the spec and/or code here.

You are correct AFAICT.
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

