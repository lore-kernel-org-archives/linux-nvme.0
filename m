Return-Path: <SRS0=ocGt=GT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C923FC433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Jan 2021 01:19:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7830D23128
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Jan 2021 01:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7830D23128
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F8nZnxmyqM9AZJUzdzdMMn0WoAadtWuYXm8M8q6Shi0=; b=R8Ehpmz/TgBAEvaFYwjhQeZjl
	4c/frxk+dtoGziXEveyTvc2gl+/jo/mXlCXfLNcE2H2pGb2BJpucwU9HIEDshqiHlBc4VoF0Xdyvl
	mMajm1b4GebI7/6rHd+cE8/zNYgq3FJslU47WkrasUDTR7B3dsfniOF2lr0+YdmXIcdI3a3GDHMiL
	eGWBbfyl+bpGCAmUtSHbzxsFYxZejgXSx6eJESMMaIMtqf1IsJuQNrYq8FnBbRvTvAOvbkP6cV8l1
	vitAVYKupobZXyVg8aKeGW1uGHP/eQWxNZvskqZ64Srul7jp6gHsK/kvL2j6LORSmjreWs9FK79dD
	h+JwhBOsg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0aFW-0002cW-JK; Sat, 16 Jan 2021 01:19:30 +0000
Received: from mail-pf1-f180.google.com ([209.85.210.180])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0aFU-0002bx-30
 for linux-nvme@lists.infradead.org; Sat, 16 Jan 2021 01:19:29 +0000
Received: by mail-pf1-f180.google.com with SMTP id 11so6583451pfu.4
 for <linux-nvme@lists.infradead.org>; Fri, 15 Jan 2021 17:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zei8uHHWU9tMo8El5b6uSDfglPlVbZZ/bVQn5m9kLC8=;
 b=nXkq2Cgixy0TW0kAwAhy9rm3NEv+7TCJxkp73B5HV27O19xGe+Wi1fn5M+I8F9Ovne
 sVt6euFLBBGaPdS3Rhk9uRsko5R0UWOHec5Nd6VQYo31HIp7y1JniW5O6BIi+9WWGe4Q
 kz/J3W+rLiwRKwel7vCF5XvEeddosKSbMiEDq0RgDgJTKYWCpeP2DiNm5BpMsrY4fyh9
 BnF8LPuh5jO00T0FKIyehcDbCqamMXerT9W221P4TYsPtvz2GMnSHuJ3Kqxv9YhrX33w
 3ICBxW/G5serk15vtl4QRliGbeTuE9cggiFzNgW+oYo5UOrWE/RpCiT0E/g1R0B34wjm
 /jxQ==
X-Gm-Message-State: AOAM533Hed971+Qd2JDWkGZ3idYkKruAORJWt2HA+EGRG8wMzInpso9g
 K3PbrDZ1R6zCKdSCWufyJBg5l/gQlxs=
X-Google-Smtp-Source: ABdhPJyao/RMmIbrctbwBj9sFU99yMVGMGZO5URetsUXsAY4QnKbrUNGW5wAsNXnmpdDL14kNrzUIw==
X-Received: by 2002:a62:6047:0:b029:1ac:6091:cf50 with SMTP id
 u68-20020a6260470000b02901ac6091cf50mr15378152pfb.40.1610759965695; 
 Fri, 15 Jan 2021 17:19:25 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:5e2f:377f:716f:f0b9?
 ([2601:647:4802:9070:5e2f:377f:716f:f0b9])
 by smtp.gmail.com with ESMTPSA id n15sm522647pjk.57.2021.01.15.17.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Jan 2021 17:19:25 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
To: "Grupi, Elad" <Elad.Grupi@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210113115152.69692-1-elad.grupi@dell.com>
 <ad9f038b-9920-21da-755c-85f4e2228a22@grimberg.me>
 <DM6PR19MB401194016A086DDF8A82C554EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
 <f5b8dbc2-7960-894e-47ea-b18665536e70@grimberg.me>
 <DM6PR19MB4011A4116FAB37BEC28BBC91EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6459e22f-f2f2-9183-0862-654bcc5e90eb@grimberg.me>
Date: Fri, 15 Jan 2021 17:19:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB4011A4116FAB37BEC28BBC91EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210115_201928_189521_F37E7309 
X-CRM114-Status: GOOD (  10.62  )
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


>> This was a silly typo, did you check if it addressed your issue when you applied the needed change?
> 
> Yes. We applied the needed change before testing your patch, but still had kernel panic on recv flow when we had unread inline data on the socket.


Can you share the stack trace?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
