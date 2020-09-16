Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C42FC433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 23:31:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F4522207
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 23:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xmFdKiSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F4522207
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CQVF68tn4B7NHubPcgIw4XvvWl02MCSLw6NJNp3JYk0=; b=xmFdKiShRSWailiv/qmIIpJ9k
	N8rPsZc2cHckrVDZXgUEuD/4f9yHFMlS9lHB9MdU+fhI25/46XH3UJG2C2gJHD2wZYe4AlzR8O63h
	XuTA5X5p2iks90Y92a0zaNBJOpkzbFHSfSNVpJdol33opRKIfUlSSq1RxazbA8uzFoT0byYCGiopv
	JDd7eNDYqsgbambyjmuoVWL2/RkO/LdLbFNhmL3gCseESkwkCexS5OoY50lrygblqo/9jFTza7ox5
	iWzg3WUAPHcvJn97322FprdAXXJjrg6G4v3v2jpXy7Dr7LidRZg1YX7+e7+aCfGtBRVEhBMlhmOei
	YBZI2VRBg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIgt4-0004kp-L1; Wed, 16 Sep 2020 23:30:54 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIgt2-0004kT-Ak
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 23:30:53 +0000
Received: by mail-pg1-f196.google.com with SMTP id 67so230340pgd.12
 for <linux-nvme@lists.infradead.org>; Wed, 16 Sep 2020 16:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fRN0jVAfso+Vtm2ch6wQowsNGV/ye+t3fxiFV666Rr8=;
 b=ncGBOPKYiiQpThdmXkvUihLI7QwiycsPF+WxqWDiaYFjVT6HytpKc7KuqbkmCRw3Cc
 PSyXWItAWvrXNkO8460Jdcy4UKnyFobrWTMpy7YlEwszoG82J7oiqwrt98Oz4ge3zcwD
 QQ6rDjk6iulOMxDITwfnJ4ENJ5dHlj1sTq8F037MCFTNJCT9PsU1ahP0MmOlyg9GbF23
 zV4KWB8LBOfy/iEiDxVmQQxot5oC8T8fAuS4RzyvgYA5TFOwsbA6EKa4EgAqZFOKtlpS
 46eQ0cSsUto4KhqlFPstrcDm1jqYtN6UsM9EalUu9Qv1P1pqjH/Yb0/AeTBEbqYvWKTz
 7cnQ==
X-Gm-Message-State: AOAM530Xp9gkTQxGBHPJyqJOxQ4boDiaxfCsUb8U9DTZrxHSvd5NBH5N
 QDgklMLoLTspZzZVG3gkhdY=
X-Google-Smtp-Source: ABdhPJwAqvW7gdHskYVHzi85KLJ18riQFYb8+wrlpPZL/q5na9DSLvMt+BtXl5luy8j9syhEYVuSVA==
X-Received: by 2002:a62:6dc3:0:b029:13c:1611:658d with SMTP id
 i186-20020a626dc30000b029013c1611658dmr24966752pfc.10.1600299049260; 
 Wed, 16 Sep 2020 16:30:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5b8f:1046:c134:e3e4?
 ([2601:647:4802:9070:5b8f:1046:c134:e3e4])
 by smtp.gmail.com with ESMTPSA id y3sm19121734pfb.18.2020.09.16.16.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 16:30:48 -0700 (PDT)
Subject: Re: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200915230456.13159-1-chaitanya.kulkarni@wdc.com>
 <9aaecc8f-7eda-b792-2e5f-a8cc8f8178f2@grimberg.me>
 <BYAPR04MB49658A3CB5BA3AB70434551E86210@BYAPR04MB4965.namprd04.prod.outlook.com>
 <9ae2644e-73e4-768f-965e-ff1d41c19c6c@grimberg.me>
 <BYAPR04MB49655525AAD3191DF31E2B9286210@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b9851360-0087-adb0-a355-62700d4fe047@grimberg.me>
Date: Wed, 16 Sep 2020 16:30:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49655525AAD3191DF31E2B9286210@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_193052_390687_32CC6205 
X-CRM114-Status: GOOD (  17.36  )
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
Cc: "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> I'd say we need to fix nvme-cli not passing optional parameters by
>> default...
> 
> I assume that we changed the nvme-cli to fix the issue and default
> behavior (i.e. expecting and setting the ctrl_loss_tmo).
> 
> Changing now again will break the fix in nvme-cli which requires this
> default behavior ?
> 
> I think it is easier fix with right comment documentation so we don't
> have to rely on the tools, plus it is only for nvme-loop which we use
> for development and testing but not in production.

Its going to keep breaking if nvme-cli keeps sending optional params
by default.

Don't care all that much, but it just seems backwards to me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
