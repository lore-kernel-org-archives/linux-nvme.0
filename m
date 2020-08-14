Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DA3C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 18:30:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B8E20774
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 18:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="esFgbVkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B8E20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iRC9M37RUg7OI57CcGDJ1LQPetz4wBr/t/QygrqVGtg=; b=esFgbVkrMjdlmWKDzFFN7WMSx
	3hOna/azDShBLsGRdcP/IznkvrGPuhzP4AgANcBX8BH4kg8delwZN+GC9rRbm6yldrt1auxH/iMx5
	RXTe1IRNQxlm0vPl+20ww6BmFFGWgG4evU/Ov4nP3vmfWHvrIZcLcqQKtYitTkVmRvo432jXo3T2A
	ZBJFmeX6ndYBQhgWFF+AKtXpQztqQL1/BkDJoU9csTOBVMWS3FXnazQbGT+z3UkYYtYlEU4wi3Gv4
	hZ6V6ZVgnM9GpkWgQ0JT8aW+x+zkn1MqW9mLVqlYUMR8A48zYNBaYnf+NTftZi2TEQtWPTFlgPwzk
	FylzEr1qQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6eSr-0006Ve-7y; Fri, 14 Aug 2020 18:30:05 +0000
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6eSn-0006Ub-Je
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 18:30:02 +0000
Received: by mail-pl1-f177.google.com with SMTP id k13so4534594plk.13
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 11:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T20vVKu9NhCPVSwt/eq8ykWpCuaQ4mr8VHy6NKr+M3g=;
 b=VwmtoF6ZuHSOOWsv7YxPgThTYTLelphiYAUoSSyHYPlqnFs+cDPCRguGi2be9XjhEl
 L01n+HAorYjk8PAn1+q8iONToWyzm40uDPZriL4co/z/P4BrOJvkHpYeG93n+kj4JQPE
 +jGOZZZinVL8xGOlroqaUjimU8MC7Oc1FN6hmU7MpLK6UxkZ8Ej01/cJiIMzUDtdfQnm
 HC7UYYkFu2NuRliG1OLGIfImOiDeFZ3X3PBGsZ2r1HVYGIkRwggyevCoestwrb2SoFgM
 xoIvIr5T/2b7Gwt5AcbLo+fixLNWAiN0EE/pA1n4Ra4RCht8LR3Lb7PUWpIoJGkTs7Gr
 25gA==
X-Gm-Message-State: AOAM531A098irD3PgQ/quTTN1cxyzOqRgBHQcaLDxgGhT1UYqvMvZcQP
 mF9JSOtmbw9u10yoiH2EObw=
X-Google-Smtp-Source: ABdhPJxKwGABItY2Im8E72ZoA6RWYWZUPI9xv9dYdmFTQ/zRqM26eU7d7uTHQTe601xQ+91iUdsLFg==
X-Received: by 2002:a17:902:c40d:: with SMTP id
 k13mr2912812plk.220.1597429799654; 
 Fri, 14 Aug 2020 11:29:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id y79sm9765962pfb.65.2020.08.14.11.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:29:58 -0700 (PDT)
Subject: Re: nvme reservation commands during controller reset
To: Christoph Hellwig <hch@infradead.org>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200809161016.GA63121@C02WT3WMHTD6> <20200810124036.GA25070@infradead.org>
 <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
 <20200814082015.GB18371@infradead.org> <20200814100911.GA9975@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <83dbae6f-01a0-a9a4-9271-de8c1cf06c66@grimberg.me>
Date: Fri, 14 Aug 2020 11:29:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814100911.GA9975@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_143001_700867_5E35790B 
X-CRM114-Status: GOOD (  14.28  )
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
Cc: Keith Busch <kbusch@kernel.org>, "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Engel,
 Amit" <Amit.Engel@dell.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Amit,
> 
> can you try the branch below?  Pretty much hot off the press, but I
> think this should address your problem:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-pr-fix

I like the approach, but I think we'll need a bit more path awareness
like we check for available paths if we requeue or fail..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
