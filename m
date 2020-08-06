Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48316C433E1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 01:15:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C46F2173E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 01:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CK1YEEJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C46F2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=woqKD5bnSDNC+5dMrYb4yNrbjdyZ3qGeS1jyKtqxY9k=; b=CK1YEEJUXGGHplKBcsQY8u//t
	oqPtWpCJ4GzdTr0jfvOJxfMQvsmGV/4gnbiKok0laRspqCL8ePeuzgP3HrVoGIOASdWR6hfDQvI57
	v6OuJpugkppT33OTepdgY9tsu+Cp6wQUozpPyEnJULVcnhVD0MWGCNVLZbYlqS2O1lpacBKjUDm2w
	cmrEx82bhgL+oGflK3wbwUEvcbJhqXeclpWUv5hKJMkdnS1fe7XzTg5iLvZQpIVOifEvlScxbcyLy
	7O29LU8YVDOJSalPuns1CONpSmrrzt7G4LrdJ5P4E+3iuQnx88ewQVSatezfAnKPU9kDZmICyvGcx
	lKvq9sKVg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3UUo-0002ot-2D; Thu, 06 Aug 2020 01:15:02 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3UUl-0002oK-7D
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 01:15:00 +0000
Received: by mail-wr1-f68.google.com with SMTP id p20so7471527wrf.0
 for <linux-nvme@lists.infradead.org>; Wed, 05 Aug 2020 18:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IMwzmeUWlIUMBkzoWUqLg8C7tOu2SeHgF4lmZs2oBQs=;
 b=mvBUwgMyF7LVTfP+cgjUCJJChieRMwOlEqvkuHx6WUPXXfIKuODGCheRM2rzVCYQYg
 uMqebuGTs8ITn15JeDbmd1D27gzM5x/2UQbT/w5Zc8c3KYty51S0EpRdLSAcGLm8rMxa
 ykIi1ivStx5uZ1mEDhcBMEYARy9bFa649ZMGtkiV9OaBeP6qiNJZB/GYPsG8fu/wxCJ0
 rewuioO6FUzAO/qJTiDbtoz+sMZivpLKL6dOGVjzRC0pOci2FLXa7M4Uqj2o2XrUBTPL
 q95GmUJn3Ejnvk+ZKXnoCv9rPX2+RtrnQeYe6/Q2NORilCfX0aoWrtf7Ig7qCro+ls+I
 ldVw==
X-Gm-Message-State: AOAM532xlRS4qoXmUGCayciSAp8G4dtg5I0UecNXuUgn+bC6D9wO5ODO
 YuM2wekSP7WtbzjRaQU5Z1o=
X-Google-Smtp-Source: ABdhPJwdbef6jXmE+jN4Pl9BBz1qDXxUWRKEm8jm+fUg0/0xhV9D/uT919vQNvtPF63Psh/G8aDoWg==
X-Received: by 2002:a5d:4144:: with SMTP id c4mr4940678wrq.200.1596676497600; 
 Wed, 05 Aug 2020 18:14:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2803:3684:5e52:5417?
 ([2601:647:4802:9070:2803:3684:5e52:5417])
 by smtp.gmail.com with ESMTPSA id 111sm4632767wrc.53.2020.08.05.18.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 18:14:57 -0700 (PDT)
Subject: Re: [PATCH] nvmet: fix opps in nvmet_execute_passthru_cmd()
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200806000804.6345-1-chaitanya.kulkarni@wdc.com>
 <4c0eab62-d29a-f1d9-7856-78af8d6fcf48@grimberg.me>
 <BYAPR04MB4965F41CEFC7DAE474CD3D1586480@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c31c1600-7b9c-f2cc-57fe-e8c16d857d2c@grimberg.me>
Date: Wed, 5 Aug 2020 18:14:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965F41CEFC7DAE474CD3D1586480@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_211459_314065_5AC7B681 
X-CRM114-Status: GOOD (  12.05  )
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


>>> This patch adds a check in nvmet_execute_passthru_cmd() to prevent the
>>> following oops :-
>>
>> Why LKML and not linux-nvme?
>>
> 
> My bad (+linux-nvme).

It doesn't have the patch. can you resend?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
