Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C0AC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 00:17:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D665323120
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 00:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D665323120
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SW6EYBxyHEX3zcBePp/Lu3kyXLVFQ0m0Br2fDW/gVLU=; b=B97AiYWL5m1DTYSUdMAoteGi4
	ZnlaJ6SOzuIXxNgo3nj8v/Cp9yj3VpDmGhp+A9BQ5EJHYOAU4ywAibzGTSVEVkg2GzVVbU9wxrAsl
	ButzwwYJc4AtDxFHKtukPl8cTs/n4TBNcxmZXJu94c5SoHhgMDFVbRwHAIMFL+GQ9DqWsRznnVug2
	Mq4pvxfAyhpFWtieBxf5UOBR4IO+EK4ZCJQML9tWuGOvMxccdP8r/xnSWfuiPIilw6Sz3UaXlUUVE
	HJjAD6jqnWn+Ad0Pn++6djZge1WnCUm5mLeTtyh8GhvFmK9ugWAK5U1TlLCPmIMuYqgVm4OyeTzaV
	o9uGVvNOg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzqK4-0006AF-Cr; Thu, 14 Jan 2021 00:17:08 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzqK1-00069q-MB
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 00:17:06 +0000
Received: by mail-wm1-f42.google.com with SMTP id y23so3189822wmi.1
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 16:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u4TOR+Z08uLcRAZJfpRYbgyzml2ie4yUyY/TC14bY2U=;
 b=jqUAFVbUnHbX2hYUXhmRarmH002LgNRBtmdofJOZmbaJE0T8GkPNXoBwL1DLe4Ofwn
 fKrCH+5f0Zfn5lgJibct90foDDYPp6JrxAfK5vGJOehRNX3tMmag1o9mNZIPI1/D3tSI
 1nH4VblPjZnlsMr6jOqZnH702gR73n8/KrlIp+WuEAQhLNv7s1YnaPMK4Msk+fkky1WJ
 atzCAvR1S6Mqx74QIR9gkZwo7wZl7zSphgpwPvgEd6mkJO0Z2zu2U9FoEtJbukaX82G5
 EF0tc3oU84wAq/sUjSAKciNbWf2/9twbhr3lteDtaZMvE/gla80vJi/G5YIWFbuszktk
 rltw==
X-Gm-Message-State: AOAM531JpTI3Vp7MY6niJXnIDSvWfOGHvJ6QMgg5MFGy/BJVu99YOUOT
 f9na5sLSi8IgtGBJ3M8DnCI=
X-Google-Smtp-Source: ABdhPJxKZ46vRCf7ePCzpIQJqDcUjRUds5ij5UAtWD2jYp1vwONlB6ECSXQU0jYmN6WEY2r6/YnC9Q==
X-Received: by 2002:a1c:5644:: with SMTP id k65mr1421494wmb.62.1610583424695; 
 Wed, 13 Jan 2021 16:17:04 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id 94sm6742258wrq.22.2021.01.13.16.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 16:17:04 -0800 (PST)
Subject: Re: [PATCH v2 1/6] blk-mq: introduce blk_mq_set_request_complete
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-2-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6ce3e173-4ac3-e84d-88ca-76057a8d8e1e@grimberg.me>
Date: Wed, 13 Jan 2021 16:17:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107033149.15701-2-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_191705_786759_B0F6D2DC 
X-CRM114-Status: GOOD (  10.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> In some scenarios, nvme need setting the state of request to
> MQ_RQ_COMPLETE. So add an inline function blk_mq_set_request_complete.
> For details, see the subsequent patches.

Its kinda difficult to understand the meaning of all of this...
the cover letter tells us nothing, and patches 1/2 also tells us
to see subsequent patches.

This is saved in the git change log history, so please try
describe what it is you are going with this, even if there are
overlaps between patches.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
