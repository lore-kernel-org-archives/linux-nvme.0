Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD02EC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:45:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84243206DA
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MIdQujCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84243206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KNSucOKuOmoJljW/n4lPHwYJn3ZISFp2QCox0szHG4k=; b=MIdQujCinAlIJi/mNJ0l1EV2l
	GYTyygypELCgxgKYZyrXZoHzchhzDcrEyNnjsyCn+c6Lb3EaU9ck/WlbM/QApAazqx3O73UYjtaH7
	ha3eWy2tJrHI3Q7eciLRMfFR1eXbzSWvW6JU0ER3r0CvGzQNUuRzuRiZkopPj0lMvM4NYLWYfMXxi
	9dHp32mmYiCDlN7EMijE1RQ9SVTQVVYdgskeBrVNNgkxAI6Y2uTGsPCBxoaAfTTkoqDyJa4UMxxMm
	1KijFjDiAMweIBodjX/Dvkc94KZ6rLK8ycZJXMZ4OMJLHcJL3ZWyJhceESQbk6ogyTP8jZPLvAevs
	UzB0i48tg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5c5A-0000u2-6y; Tue, 11 Aug 2020 21:45:20 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5c58-0000t4-9O
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 21:45:18 +0000
Received: by mail-pj1-f66.google.com with SMTP id e4so106198pjd.0
 for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2020 14:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aG2TZSuxwKetVw9WAETDbHNqIj8OwXsHuETcwl47mxg=;
 b=JdloBV+qLKD/af77RuGxy33/tXPByn5rjTDwE+qHXagSFflPEKCCYMXKMkcaoM3OHp
 43xVhvtlm0LXB/PEWhSugizV57WEsTBBWOAv6zSUruAgGGbYAsBgq5lm/tnHXiebM+4c
 3HbRVNoxXupNgNqZQAqAbdxDT/dhaTJ4UlTDmQdAgkAWYH3RDrzGNlsa/pGHV+5fXQ9r
 U9CoYOyQPLFz3msmWxFzuZwVOEbebj6H0h3EVROzyeST30o26ovC+sSs76TDFH4CQfTQ
 GQNMrPzPZh/umpjeMoEUG3vciPiQPFIlPbLtl0ZZwaX8UDWwVcI/4aUVbuX1rbKVm4Rd
 hLQg==
X-Gm-Message-State: AOAM5314fFabCwIE79RlEORLLlfyRI3qN0V0bE4GUtazTBLW0NQGeYh2
 JmfcIY9RriLkTPsOFFXkqqk=
X-Google-Smtp-Source: ABdhPJw8LIt2gQ6FOkVrUrZ12i+84Mc/CAKsk88WGSaz14Ggq/82u+hhNv2YtYs7btuxoPB1heQPsg==
X-Received: by 2002:a17:90a:6f85:: with SMTP id
 e5mr3077388pjk.128.1597182315339; 
 Tue, 11 Aug 2020 14:45:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b58b:5460:6ed2:8ff9?
 ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
 by smtp.gmail.com with ESMTPSA id o16sm32849pfu.188.2020.08.11.14.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 14:45:14 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] common: move module_unload to common
To: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200811210102.194287-1-sagi@grimberg.me>
 <20200811210102.194287-7-sagi@grimberg.me>
 <47900df7-e3be-c200-67ff-c9e099cb8aee@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <19e536ca-cb18-68ac-7688-d5c9b788ee99@grimberg.me>
Date: Tue, 11 Aug 2020 14:45:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <47900df7-e3be-c200-67ff-c9e099cb8aee@acm.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_174518_348994_A5C216AD 
X-CRM114-Status: GOOD (  15.20  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi,
> 
> I think there is another copy of unload_module() in tests/srp/rc. How about
> also removing that copy?

Yes, this is minor enough to remove when applying, Or I can respin the
patch set again if Omar prefers it that way.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
