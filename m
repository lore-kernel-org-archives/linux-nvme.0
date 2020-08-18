Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C91C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 17:18:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62E920658
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KbHalHrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62E920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0AIfCl33e8iySiIjCd7nfWp82JztQT2+dbX4EJ+6qPQ=; b=KbHalHrKHH4lXIdXXUpA6VsFK
	T9YU2r8px+BMNnJ33NtE5vXm23Y6Thwp7B9jEwLgja7HzJHnuzIfCrHSeGBIuSGHSWkjoEASL8pry
	bgdgdQU2X2uc0m2mwUmPFYTrEE/s2D/Dsm7dyNVzN2LajqYz89mdd/tW6jAVebaIjKYDdPlc8xS6G
	EgfK5bVksFef/IwG5BtIUIL0V70KhTKMTseYI91K58nW/DTbioYGR/cEyItR89bDUgsFCwI3UcvVx
	KurkUmcjFU418w6ZlYtreA/laQ2Jg5K0KFynH0ZMhV1oGqYmI2H9guXU1TYch96JbDfib7G6Jzg/m
	fy4bMg0Kw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k85Ft-000742-Kz; Tue, 18 Aug 2020 17:18:37 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k85Fq-00073C-UP
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 17:18:35 +0000
Received: by mail-wm1-f51.google.com with SMTP id 9so16936563wmj.5
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 10:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iUrwSVL0O1InvwGm4rIx94WIoSvs5TPYcB5lrfnt9Jw=;
 b=YH+vJ3k74sBlZ9z8DsfePxccrwsmVENc2ClNBQ2nKPL/cX1xvcMhfSu1nnv77a/bUD
 HdS+aPhzWUVcZvP1M2B0ujdWfOgYx8RSMDcJ4c8XSuG0Ige83WxQX+jwuEJI19n6O3qq
 RO4v1qESk+slCMeOyFSHDw2CTO8wTQT/yiRTk85bwpme/WKspPgOXh5mCEmN3alTIzik
 nw4F81LHWHoTuQPJ4QfhojH+H91hbp6VvLoH9c6yz+z3ljL4/oWIJDNe80y6/qCS0mHW
 luMEB8tg9g74+SIMqidECNorL5igngVxZfrvgBtYxc8QqlIGvGimO2gpqk3QfVcOi62l
 Vo7w==
X-Gm-Message-State: AOAM532fiRveA27Np72BZKUK43SYTCeXBp+i1+pGsDrHMhgAI2FtdIWF
 yLM43+7TvOAZi9dOLtzy9z45yqBsdaF0Vw==
X-Google-Smtp-Source: ABdhPJyNEQp04IXY2pUo+83iYTjo46Mfzdp7D3EmS+3dWXD3px4sgy+pjbUxL0PeXGi6Ar1F3gQi9A==
X-Received: by 2002:a05:600c:230e:: with SMTP id 14mr834248wmo.3.1597771113748; 
 Tue, 18 Aug 2020 10:18:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dce:63f2:5e83:391e?
 ([2601:647:4802:9070:3dce:63f2:5e83:391e])
 by smtp.gmail.com with ESMTPSA id f124sm777237wmf.7.2020.08.18.10.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 10:18:33 -0700 (PDT)
Subject: Re: nvme reservation commands during controller reset
To: Christoph Hellwig <hch@infradead.org>
References: <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
 <20200814082015.GB18371@infradead.org> <20200814100911.GA9975@infradead.org>
 <83dbae6f-01a0-a9a4-9271-de8c1cf06c66@grimberg.me>
 <20200815070134.GB20460@infradead.org>
 <e312ae98-5b40-d0ee-c13e-b65db1f3acd7@grimberg.me>
 <20200817081227.GA12680@infradead.org>
 <29359e09-f386-8004-7369-c8fc055e2c38@grimberg.me>
 <20200818063625.GA9206@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e11f2af3-96eb-2869-3919-b07e1a8fa625@grimberg.me>
Date: Tue, 18 Aug 2020 10:18:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818063625.GA9206@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_131835_041078_671E9555 
X-CRM114-Status: GOOD (  15.63  )
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


>> So what is the semantics we want to provide? a best-effort one? not very
>> different than what we have today. We could, if we choose to, have the
>> pr context to wait for a path_map_changed completion and have
>> nvme_mpath_set_live and nvme_mpath_check_last_path do complete_all on
>> this completion.
>>
>> But the question is what the semantics we want to provide...
> 
> But it might never change..  We could give it the default max_retries
> based retries for any reasons if we want to be fancy.

Is there a difference between sync read and pr ioctl on the mpath device 
node?

Currently the read will block until it absolutely cannot issue the
request, but the ioctl will block until there is no available path.

I think we should have the same semantics for both. Unless convinced
otherwise..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
