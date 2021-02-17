Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2102BC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 07:27:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9564614A5
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 07:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9564614A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1qg/Q52LTl9uy6MU5xL0RTukpizBe98YDfk/L1LJelA=; b=hKYOiJAH6S/soHdE4IqAfRgkp
	PpPhNDjWH3fAtk8I3rSwLKGTefYVvcWqVh0JB4LXDju8yKiplhGMqvf7HjLQO5JRgGeP2f7D0GUPl
	MXoz2J7MwMlcT1MOQaJPSdKJsa+IOTVnZxNpa1P1g2P6PHutUiJhTULbGwTaRxxWZKEKMh667G/82
	CQF9cA/5CQ6CJS6+qL2/Rv8yQXVvkElYK9ZBxCZirhVOeE0TUdW4bpA8afcja8VrsPrdjGHhh8CgO
	QgIIY5oiFv2rexuy33mwPF2gi17sCJvzPRgXiOUcvIgkogMiwelY+FK49eGiUNXohiihf0Vh1NywY
	f5INLtsqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCHEb-0004Tm-Dn; Wed, 17 Feb 2021 07:26:53 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCHEY-0004TK-I8
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 07:26:51 +0000
Received: by mail-wm1-x334.google.com with SMTP id a207so2075408wmd.1
 for <linux-nvme@lists.infradead.org>; Tue, 16 Feb 2021 23:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:references:from:subject:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M286kpP6If7Ljdfnmmm32v1M5kCkE/wuTFA9DNAFpmk=;
 b=Z4Po4XsUt425RC5dPKAg7MSXeJiQF4rg6cIsQop0sekd9CioiOe02Iwj2tHEthHqO1
 bssFd2eKONpc52cUVob72S7DBjwd17FIjpRDz4tasNZ9NBWlJ6+Nx3xvzVtaIAALJg6g
 BCdfa2k45SPTAoPY9Amdz1PpGqySD+wTQByh2AjQRcitIrhkkXulHocO0EsIAjgG1s8V
 6BURF1kQ5m919h++03JXJPgrx92Qa6aZ1o3BjcUYJTCUSGlyb3sunAXkKJKTgqcTbCvl
 /l4WEHKRhDkcPsPHAUDD41dkTX4++2OXfpIzaQJbipAXZK2xA+IJbGvL+QLSjS7RiTYP
 j5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M286kpP6If7Ljdfnmmm32v1M5kCkE/wuTFA9DNAFpmk=;
 b=pNNyh4kp8+lwyIAvEeXvD3dh8QKA37lWCWH9rU+ds/31wEVMXMMrwBxwCiHWp+2kP4
 i/UF31LeO1+aYXX9+TEO5Po6lysft7pe2gjDyc4eYy5d3lOYYGLAxUWrFD0vpNwQv4i9
 V/mNPhFTiYSorfhh/MwyseITAT/BRvFOJF0RoNaw74fltc9TjgnhLx24yY94FFba/j1G
 x3sjatSz+fWNjdZ9Fg4V6YiCcEvtfjV/ckeOHRQ/k1M+4HaRpCFTZ6Jgw4VxVS34uPxa
 3gqrGWTpcxfLXKE1g0vOQnhtUeLuC4wcQFF8bjmOjf/mhgCiTHeuARuhakijCD61W/4r
 3jZg==
X-Gm-Message-State: AOAM531HVk8OCG5yDNR37/SXpQte6DtDg3qXRpmG37fIYWWrFUFeAkLY
 Vc777eaN780nqd5hw5+3GBiJ/rspZMAAiw==
X-Google-Smtp-Source: ABdhPJzmteLt6ny0c+xECCWXCsLGzDAdt2Eue6MYXR5E4bADOwBUKUCpoFkl8RH8ln3FGoEn3e5YeQ==
X-Received: by 2002:a1c:7409:: with SMTP id p9mr5894662wmc.95.1613546806028;
 Tue, 16 Feb 2021 23:26:46 -0800 (PST)
Received: from ?IPv6:2003:ea:8f39:5b00:18f2:c6f5:8692:46a1?
 ([2003:ea:8f39:5b00:18f2:c6f5:8692:46a1])
 by smtp.googlemail.com with ESMTPSA id 2sm2646765wre.24.2021.02.16.23.26.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Feb 2021 23:26:45 -0800 (PST)
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <1c90fd6a-d991-b347-479c-2c8ae5a4c51f@gmail.com>
 <BYAPR04MB4965D222B05866D93852835F86879@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] nvme: use lighter smp barriers in nvme_irq
Message-ID: <be263cdf-19a2-05d6-1023-7d935d526663@gmail.com>
Date: Wed, 17 Feb 2021 08:26:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965D222B05866D93852835F86879@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210217_022650_648186_2131828E 
X-CRM114-Status: GOOD (  13.94  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 17.02.2021 00:59, Chaitanya Kulkarni wrote:
> On 2/14/21 08:30, Heiner Kallweit wrote:
>> Based on the description we should be fine using the less heavy-weight
>> smp barriers here. On x86 this would be compiler barriers only.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Can you share performance numbers ?
> 

I stumbled across this code piece by chance and don't have hw to test it.
Having said that the change is based on code inspection only.
Unfortunately the barrier comment is very generic and doesn't mention
a problematic scenario. Also the commit message of 3a7afd8ee42a doesn't
mention a potential race. Most likely the barrier can be removed
completely. Helpful would be if someone could explain the potential race
in detail, means which reordering / variable accesses could be racy.
Then we would have a basis to talk about READ_ONCE/WRITE_ONCE vs.
smp barrier vs. dma barrier vs. full barrier.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
