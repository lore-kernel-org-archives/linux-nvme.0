Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A06C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 19:44:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B33464DAD
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 19:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B33464DAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yO2l3AIpbBneSn1RkAC1WnGv0N+//GqeljDV8GvBddE=; b=jEsbcalPi5HYR64R90E52w6xJ
	cVjSEdclJQqgwfVmGGW1h4N0E1ss7nRZwJfafdjnJ94052WVaTQ56Sl4U82n31LQTh2WHXAtG5vNp
	MlDyxNSQa5boiPWdtqGPLlsMU8jrI72P52lxrflKalzUIx93+RNx+fIccghYiym2YamegUwJMoC+t
	pDRTUGyfJpTCkoFigX84J0ixWFdxxAp666805x3jLdO1enhi5Za++GTRN6/y3ek35VVWFC+aGSdMR
	i9h/l15RQ1cnSSUc8z2EZfr2Q111AtEZ2CK5T1UisdpgXKCKYY9wzspqXwP2oct1880A1nH0yKOnv
	FIb2RiOtA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAHtS-00043l-Ff; Thu, 11 Feb 2021 19:44:50 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAHtP-00042t-IC
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 19:44:48 +0000
Received: by mail-pj1-f46.google.com with SMTP id cv23so4007829pjb.5
 for <linux-nvme@lists.infradead.org>; Thu, 11 Feb 2021 11:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+px3AlhCcKNWwW22WADelZhiN+SnFE93DAyp8iEoiKQ=;
 b=geg4fMY8xVi1aUld7NX+pGTFYI8o80PEo4J50BVwvGVVWFzKwHRJ+fZz9CZx4NCbQD
 QOYcBEFvN/bc44AWZfOP5kSOvM5qqU5zk+zxAjn+4KzuyFkhtFfQJlNxKdUA38nkhKCk
 VwrBEBR5rnAepLvvaDNKgNKuqCduPSTbwh1m6tLWVLAZMESVtuKsThenUy0HpTDvKPQq
 goovcUDAdOBJh1oh/EmB0vTdehsbrlgFGFINta0tGjv15sRB/ri00PfPiBkllmXyyNMF
 Qu0/xM8Y+bOKR/BmNISZWVH0fFHGKe9uByeYlh/bnCC58jGPeayrSh6g7epVKbxi5q29
 7ogQ==
X-Gm-Message-State: AOAM530drHi29KFzKznrayqsxyfw6U2w29u+KwnOZylxxTnl0/orDFtJ
 m4flUr7raEAxGHxhKZApKEM7viz7mG0=
X-Google-Smtp-Source: ABdhPJwNDNhTfdv1BWFmps0n7SUuUvImFnjg5flAeCX3EvWXjVee7cMATll5Wrq6pqcjJg2YcGinBw==
X-Received: by 2002:a17:90a:f302:: with SMTP id
 ca2mr5413224pjb.233.1613072686258; 
 Thu, 11 Feb 2021 11:44:46 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:1fa1:4e73:e82c:40f2?
 ([2601:647:4802:9070:1fa1:4e73:e82c:40f2])
 by smtp.gmail.com with ESMTPSA id f8sm6409782pfa.207.2021.02.11.11.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Feb 2021 11:44:45 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme: don't set iosqes,iocqes for discovery
 controllers
To: Christoph Hellwig <hch@lst.de>
References: <20210209101235.1539917-1-sagi@grimberg.me>
 <20210209101235.1539917-2-sagi@grimberg.me> <20210210101126.GA26624@lst.de>
 <3702938a-cfd5-b725-bb75-7c9072a42fde@grimberg.me>
 <20210211070250.GA13708@lst.de>
 <f279bd6a-d4e3-52b6-740b-66f90434cf69@grimberg.me>
 <20210211183124.GA26045@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a5ea738a-44c4-e953-3271-a0b97668000e@grimberg.me>
Date: Thu, 11 Feb 2021 11:44:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210211183124.GA26045@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_144447_645322_E7F20EB3 
X-CRM114-Status: GOOD (  21.43  )
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
Cc: Keith Busch <kbusch@kernel.org>, Martin.Belanger@dell.com,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> The annoying thing here is that this issue will manifest in the host
>> waiting on nvme_wait_ready for a long 7.5 seconds to understand that
>> its maybe incompatible and re-attempt (nvme_enable_ctrl writes to cap
>> and then polls CSTS)...
>>
>> What I have now looks like:
> 
> In terms of what to do about the retry this is what we'll have to
> do.  That being said I think for existing controllers we should just
> stick to the existing wrong value, and only set the correct one
> for versions > 1.3.  This isn't exactly correct, but probably causes
> the least harm.  It will need an extensive comment, and maybe we need
> to add an option to override it if controllers show up that do not
> like the wrong value.
So you suggest that we keep the retry w.a. but continue to send the
wrong value in 1.3 or lower?

I personally think that this would be extremely confusing to users, if
they do trip on this, but I agree that they are less likely to hit
it because existing controllers obviously accept wrong values...

As for option to override. I really hate it.. What is the least exposure
we can get for this but still allow the user to control this?

Wish we had a good and reliable quirk mechanism for fabrics...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
