Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAEEC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 19:39:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E86B64FB8
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 19:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E86B64FB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vAwvowfEaDM3I/AIZeFcbDoPvMLux0pdOYXFIWjpAYE=; b=mTMkFm4HDnZsoaJSjT2MRPr0c
	VReG8LrhjFrr6sKgElmf/gVd3UnRXyQE/XFtX7Eh4LQl9yTnFRQ+kx7jsdqOtVq3kHlzja8dG/TK1
	CC1RNs13umGZtFg3amhiWfYEY9TNOMgK6Ilb2GJhKgBCjo01Qzknok19BHRcg2KRB4m+2rWp9yppc
	AqXoex2l6C437Smp//szo+xKHrxTF+qOMsiKAJrsh7HS5EI6xvqhdx22+lhWs7GaQ5LCsBGH0n2+0
	4Mr0f2LG+c/mD+9qRTw0szzt6qEPsVsWaisQaHY7iQ5Zdu4dloYJeMGcWBoVJc1WcUfriCyJAfEg5
	oUkNL3/tg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l86wb-0003R9-H6; Fri, 05 Feb 2021 19:39:05 +0000
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l86wZ-0003Qa-34
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 19:39:03 +0000
Received: by mail-pj1-f47.google.com with SMTP id cl8so4201415pjb.0
 for <linux-nvme@lists.infradead.org>; Fri, 05 Feb 2021 11:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qT8bzq68P4LXsXBTB1t8W3GcMqMLq5lJk+M1gQSfwLw=;
 b=q/JGwsrl2uXQTRMdhVwZFpuIKma3wnbCzZ34gB9aFcBu9tObyIQqvj9e45HmlmXuur
 ytXyerhUyJEg/uKHo8HfltgzerNPOZ+bJ8HSo6OfHwX72gfp7Yisymk9YsAD9+S5N0C0
 OGpDTdD/DvRuVbj7wPjEFDOTUeBHOlVjN46t7l08cU5T24PBmlDg4ZXQwVNhD+DPKjzR
 sSRihwF23St/11S6jjQnRulY8in9Q9kBZZOfgTrTwg/MHSQF7+wZui+i7T7+ifV0CFA3
 pF5HXwc/gm2iX9eU/RsjJANUyWW/4g7Me6yNUmQH89eDV0MhJ+LITY+FjJL/VV0ZdWsz
 7EMg==
X-Gm-Message-State: AOAM533PagESMJvvi0uQ05dNBrXBihLgZWtwUt6CasL+xwnyz1QZDMSb
 YLfRQXTL+4fcpnHvI21GzX3USvpfyRw=
X-Google-Smtp-Source: ABdhPJy2sCnq0CGQtxZkr1lHSR1LgAX0c4ZWGHsRSP/M5h2e/xzUvjIY7R9yv1ftRDD/qrLEIUTJ/Q==
X-Received: by 2002:a17:903:22cc:b029:de:191c:1bdb with SMTP id
 y12-20020a17090322ccb02900de191c1bdbmr5618998plg.14.1612553941345; 
 Fri, 05 Feb 2021 11:39:01 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e569:9026:928e:73dc?
 ([2601:647:4802:9070:e569:9026:928e:73dc])
 by smtp.gmail.com with ESMTPSA id b65sm10825692pfg.3.2021.02.05.11.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Feb 2021 11:39:00 -0800 (PST)
Subject: Re: nvme-tcp bricks my computer
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB45443358535A404035588EC5F2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <42f94a06-cc66-87dd-3a92-de793a228d22@grimberg.me>
 <SJ0PR19MB4544B86790800C6371E7F96AF2B49@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ccb20293-efdf-ee96-d97f-405ced9b67a5@grimberg.me>
 <69e0073c-35cd-552d-eccd-2092ab49c38d@grimberg.me>
 <SJ0PR19MB4544A3DF2B1B2A1EEB8D1B41F2B39@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <43ca75a5-e751-6b9b-2a0d-336dbbc207a1@grimberg.me>
 <2251aa94-0d6c-1405-b1d8-185bcd714d8c@grimberg.me>
 <SJ0PR19MB45442A0B8E171B55A8AACACEF2B29@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8937148e-f667-9a05-3828-58114dca6da3@grimberg.me>
Date: Fri, 5 Feb 2021 11:38:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB45442A0B8E171B55A8AACACEF2B29@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_143903_167374_301F1343 
X-CRM114-Status: GOOD (  12.21  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi,
> 
> I tried with nvmet-tcp and, just like you, I don't see a problem. So now 
> I'm doing packet captures and comparing the differences between nvmet 
> and the new cdc we're working on. I'm also asking the cdc developers for 
> their help. I will let you know when I can clearlyidentify which 
> packets/bytes/bits are causing nvme-tcp to crash.

Thanks Martin, obviously we have an issue because no matter what the
target does, it should not trigger a host crash.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
