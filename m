Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C117C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oX5JfFJL+A7m7LKqWyhlfXH8WepKdRlPJl9oJx3KF1Q=; b=Spc9Xe0Z7VDoO1jzuHsqhBzoZD
	8PRSKDu/kgseaA8qLCCHDUm/PQwyWJRlDX7IoGc4ui6Lk+Md0fIjkgyTYZsVRRWbpM2vBCid8NP04
	A5EGojuutpPIv8EONVaMvb+/dnZjJ1n7gr3P79N4NEfC7abcXygauqy5Wc0G9ukvfD+AvSToCWXUr
	wRaWYPWHBbPiX9zPeoQcQ3Ry9+66hg4NZxIsAFz8Je/oXUhA95XAxxBBuP5v6MtrgFyA0PWQ2s/Jt
	23Z5KR2WolTDp737rvKgK0tml2VnIJh9dU4Oqj5/jhsP9bsJSt0fZUVT243LbsCpG8GsO7Qo3vtoB
	9hkYnHfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pebj6-00CStu-2B;
	Tue, 21 Mar 2023 13:08:32 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pebj3-00CSt7-01
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 13:08:30 +0000
Received: by mail-ed1-f54.google.com with SMTP id w9so59456730edc.3
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 06:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404105; x=1681996105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oX5JfFJL+A7m7LKqWyhlfXH8WepKdRlPJl9oJx3KF1Q=;
        b=4fYGmlO76watv3PGpSrokhH4TXV/A/aaQxDFwFgd2udDa+mBJwZZt8dt+DbmPzYcnF
         o8a4MBrOZ7zQeX5BE9130QvvAQoroybpd5tp5E6OwsXK61Duz2ndlo6wo8DdPvj+QBSj
         IDoInKj11vj4/Mq44SmUt/5/UkM45m6PqgJUFW6PN39ygxUHSYje3DAW06CyGDDCWTjK
         4ev+q+tRXsFDu88eRdJRDbicZT7t/TLbMY3UDVY0ojFmD97CLqfZBGEmlRxJ5bwm+kQ+
         2M9hLGgn0GBCND1MHuyApt44WW/eosdnB2Ry4hE+KJQIevKmFAWo9tJrR4cz7bQB5a6y
         Hgxw==
X-Gm-Message-State: AO0yUKWBM4WNLByaOT8NQR3ZQW4EMUoymcTHYeNHxkuxXWlzmCODJ65x
	6nOEzOFCVdhZW2IFbLsPOYo=
X-Google-Smtp-Source: AK7set8Etl6EhD3gTWFNJQHxMA/ZoW4l+TaatjwCxfF6IPiPYdL0j+VTTu5bnJYA0sBuFRV+4I1t9A==
X-Received: by 2002:a17:906:51d5:b0:929:b101:937d with SMTP id v21-20020a17090651d500b00929b101937dmr2353415ejk.1.1679404104876;
        Tue, 21 Mar 2023 06:08:24 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b00914001c91fcsm5784336ejc.86.2023.03.21.06.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 06:08:24 -0700 (PDT)
Message-ID: <d37f118e-b6c9-600d-5771-b850425cbe81@grimberg.me>
Date: Tue, 21 Mar 2023 15:08:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
 <20230321092556.7m3etb25jnd4sfj6@carbon>
 <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
 <20230321104009.nltadi6zs6iz66h4@carbon>
 <f2653732-5566-ba2c-1dc5-412b20879ef8@grimberg.me>
 <20230321110645.ruxzlw5egzikagnw@carbon>
 <b6b14ada-e004-8dec-5ed4-2c188ba7a9ad@grimberg.me>
 <20230321125842.b77iskzsq56lstpf@carbon>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321125842.b77iskzsq56lstpf@carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_060829_053912_243CD647 
X-CRM114-Status: GOOD (  15.25  )
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


>> Can you verify that you never see a bio-less requests is being polled?
> 
> As far I can tell this is not happening anymore. I could trigger just by
> doing a
> 
>     nvme connect-all -P 2
> 
> I've added my annotation again and don't see the combination of
> 
>    hxct type = 2 && bio == 0
> 
> anymore:

I think I understand what was happening. blk_execute_rq calls
blk_mq_sched_insert_request and then starts polling. But because
this is a connect, that is running from a single context, it is
not running on the same cpu as the io queue was mapped to, hence
it is async.

The bio->bi_cookie assignment happens only when the request is started
(blk_mq_start_request is called), that is where the assignment happens,
but given that this is async, it can and does occur after blk_execute_rq
starts polling, and dereferencing bio->bi_cookie.

So I think we need to both untangle the need for a bdev to poll, and
a need for a bio with a stable bi_cookie. And the latter patch does
both.

