Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4388C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 19:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxXAtsm8WfSGYQvRdY3AIGGyAZybptGkBG5uun0fVrs=; b=kGU7uo/jyUswNbzEDdYAwAxMYR
	x0k+fNsGlealhqquKMx/Y4m8bLvDITmkhliNL2A50GWn0RU7jA82gJKuyvXuK/ZAat+mT/uia1h9s
	QNmnlgd4uY5k8aWSD9/9tEEc+aJ1Bx6IIx0V/7kVjQVsJkKcIBt/5gsd6w4tgi4pjzdx5xxqgkMfi
	R262kPERShblXftKZxpsR7YFi2XKbou6TF5NZNYgWwCNElhTdEogJoqADswHy8sEc4TPzGG+l3X6W
	nu32lWrPWX2EI70PPZeSGFiWeb93q7DQeq63d7FJl8NnUVaq3wa4nXkni/wElS4NyN9XVI0nENh0k
	Edngp/jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFi42-002dG5-65; Thu, 03 Feb 2022 19:46:42 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFi40-002dFc-1i
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 19:46:41 +0000
Received: by mail-wr1-f41.google.com with SMTP id v13so7049761wrv.10
 for <linux-nvme@lists.infradead.org>; Thu, 03 Feb 2022 11:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=NxXAtsm8WfSGYQvRdY3AIGGyAZybptGkBG5uun0fVrs=;
 b=kT0r9xCnp+zArBxW/o4VoFYdoxOKAYLUGZDEjFjQCbM8fc+Y41zFkYeoYMOTFgHlzt
 cdkzyP7gTDWq+GRF8Kx0JhvtgJL3Bu2BReisp87XHz1F9EyPC6vxkUQAjbVtxNRsW8hH
 R91YXeuHPA3rLJcvqq6HCPdJfISFeiV6SKhx3SYkvCYByZmsB0uvdsukG9HNTsHJ1YkY
 9q88/jkyVZ0K5wp3KE6R7GE8MAyjDw7Yb8Nda6CWOu3Lsb1/Q33bsUZSab9vUy6BZuK9
 axQ4S0HRnvuzRQdhOfmCWo8VugKSQk7tecvUNGtKDQVLx1JwNcy/raOgN1nbSazEsMyo
 1CHA==
X-Gm-Message-State: AOAM533t35FVSet8p3YNVaCFFCNqQ9yisUzWKvCkbQKRGNazitpkJVyo
 d8MJP4l+BkywPBrlChnurGY=
X-Google-Smtp-Source: ABdhPJz7yGofDtBOD4VZkGloxj/KdbRFfPCfrsyTUAWOKonLQJk20F5jHq42AwP9f2i5LESDGIlabw==
X-Received: by 2002:a5d:59a3:: with SMTP id p3mr31518470wrr.378.1643917598248; 
 Thu, 03 Feb 2022 11:46:38 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id v8sm7550647wmd.44.2022.02.03.11.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Feb 2022 11:46:37 -0800 (PST)
Message-ID: <d312d330-e273-fef1-abf4-371a6f224487@grimberg.me>
Date: Thu, 3 Feb 2022 21:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Content-Language: en-US
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Rose, Charles" <Charles.Rose@dell.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
 <49b2d58e-80b4-94f2-77ef-c2d1ec19e581@suse.de>
 <BLAPR19MB45318B8797176BF97BAB0A30F2289@BLAPR19MB4531.namprd19.prod.outlook.com>
 <68451fbe-ff4c-a89c-36d7-1b5829fab825@suse.de>
 <SJ0PR19MB4544B435D22B0F19E2B7CEBAF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ea56c568-9cbe-3087-21b0-81023ead927f@grimberg.me>
 <SJ0PR19MB4544CF86ADD8F3771CA9E4BEF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <d0fb3f06-a35e-c8f1-ae5d-b6871c913bcd@grimberg.me>
 <SJ0PR19MB45447A22F305FFD65477164CF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <SJ0PR19MB45447A22F305FFD65477164CF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_114640_127155_2CF1D595 
X-CRM114-Status: GOOD (  15.30  )
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


>>> Sagi, would you add this function to drivers/base/core.c?
>>> Martin
>>
>> Yes. This would need some more eyeballs though, maybe this should be
>> extended to device_update_attrs?
> 
> Is the linux-nvme repo even the right place to submit this change?
> This is a core kernel file and not just the nvme module.
> 
> Submitting this change will probably delay what I'm trying
> to release by weeks. Is it OK if I just submit the small change
> and leave this bigger change to someone that has more
> experience with the kernel?

I don't think it will take a long time we still have time for 5.18 which
is where this is headed anyways.

I suggest to send a new patchset, make sure to cc Greg-kh and rafael
(see MAINTAINERS file) and let's see what feedback comes.

