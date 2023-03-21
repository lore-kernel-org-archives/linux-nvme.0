Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465D1C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 09:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eu6PEf+UMxXJD4Ey7ObLWaybfWsJe6KZJZLKCDvMwlA=; b=FDNIEJVRDLgCIKd/z8ig0qElfT
	a7qIQIL9vGdsOYmYKwFEri0MNp2u8Axuc3r127Wr/9AYgNyWkMP/wX/zd1Plb2z3kL2dP1tXu7B3T
	X8VHBBygTyUT0EqwUSExhtKNGn0gnu33gGCx5xHGpFvDUhI1O6Bsr5oaOHW8x5ap6V4dkKFLoTTJ+
	BGAfjKK6t0hwRtAv6VIQGvu5UA7pqBOfydX5Ffd5FriYQMQ0QCBygpsN7XKLGQQnj9u5UuvnNzU9f
	2LtXocaUWJnbyfU0Acruoc4ooDqC6imUQevVQhVa0MVmSMFGCQJglwG/Z4BVQ37YUEZ+SfFVsING0
	I72HGPBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peYQb-00Btvl-2q;
	Tue, 21 Mar 2023 09:37:13 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peYQZ-00Btub-0E
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 09:37:12 +0000
Received: by mail-ed1-f53.google.com with SMTP id x3so57051487edb.10
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 02:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679391427; x=1681983427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eu6PEf+UMxXJD4Ey7ObLWaybfWsJe6KZJZLKCDvMwlA=;
        b=xCchAz8v5qwM0VO7b2B2tKsyz3F63sF7Fsou8iztE6D+ebK+hssGcuU0hW2TTl5ouj
         g20ybZBIJgo3Nccok0JdPPgT/wvEoCRItH8W8lds2PUvyyFrmxbXJ6YiT17UG2zlDTd2
         TYqM+CpavzlBR7yVll3o250OqOcnJLqh/Z7oSRvFo3IFuu8mfJay3417hLKayOGESF/u
         14Xn2IAd6oMLCSwMXVwAu55Tid4N4UawLvqU5CAglhQHzg7+cbK1ylNsN18AZrJwLdO5
         KitTofaNzDoi6mam8rl8ZzQvnx1n3PJBwwG6Pl55dOS+sLty28p/cwD4uJqQHABemXZB
         GPcQ==
X-Gm-Message-State: AO0yUKV6FJbK+lttSYDqpmX5L161PAyWPfpPE13BmUZWOr8sgN74jpV1
	lB5u6VgsDQJtXn/pu1IsKMM=
X-Google-Smtp-Source: AK7set/Ni6XyM09a/yeJtSdJwMvLZ/U1M8VzZNqeg1l7Ff+L9fCDObG1NZsIEVE01B6RZAG4CfPppQ==
X-Received: by 2002:a17:906:224f:b0:92e:f520:7762 with SMTP id 15-20020a170906224f00b0092ef5207762mr2084051ejr.6.1679391426721;
        Tue, 21 Mar 2023 02:37:06 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090668cc00b008d044ede804sm3507311ejr.163.2023.03.21.02.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 02:37:06 -0700 (PDT)
Message-ID: <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
Date: Tue, 21 Mar 2023 11:37:05 +0200
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
References: <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
 <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
 <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
 <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
 <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
 <20230321092556.7m3etb25jnd4sfj6@carbon>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321092556.7m3etb25jnd4sfj6@carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_023711_105663_0CA314F5 
X-CRM114-Status: UNSURE (   8.58  )
X-CRM114-Notice: Please train this message.
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


>> The admin tagset does not have a polled hctxs map to begin with,
>> so I'm unclear how any fabrics or admin requests end up polled...
> 
> Hmm, if no map_queues() callback is provided for the admin tag set, isn't the
> default mapping function used and this would add the poll hctxs map? Let me add
> a map_queues() callback and see what happens :)

admin_tagset.nr_maps = 1 (only the default map, no read, no poll)

