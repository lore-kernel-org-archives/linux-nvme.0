Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FE0C433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:13:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6C064EFC
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6C064EFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d+IA96IXMy+kfgiQfI3sIe2oUP26g0fSocg7z3mjnnM=; b=FtA2cruBLE3EIy0ZgiisvyYoU
	rPdo+DIFmAdr85kYCCARc9Uph6VQJj1BA9ji/ufL54jX33aJMboTtZx0srESkS41GLzB7IcDLGWL/
	1WuxbyjMiK4ccLr57cwzdk8DEXj8YUDQAf3JCPTlvtadbzsYL+HAFHVWa2lG4fOIinqxDwZ6jEX1T
	C191QK2l4V4itHM+UX3pfhNiRTs+vrQ1ROCveDtTz1s+FesWYPJR7A4qPlStTHEQXRAYY5J/+yMTR
	Skmv5SKVdYQAlOPDC97bCGPYDNk3P54uiPLDw5jYaVhRLbrmklTFuEYb4ZrfCc4qwtZhdcv5AxrxV
	AEYpYrzSQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLqlz-00GTbD-Kf; Mon, 15 Mar 2021 17:12:55 +0000
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLqls-00GTZy-Js
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:12:51 +0000
Received: by mail-pl1-f182.google.com with SMTP id f8so2114648plg.10
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/GighVHM49Oh1wFW8uS7jwqHvVtGoYTqq1XAK/LLxAg=;
 b=HOGehJMtlxzA4fHEZuM2TY2lQPNGoNuyp4YVhOPM2Q9EUFeYmGZ3c4E1eAjSsIAFPf
 1dEzCW71hitOkqBuDcXXPC9I61LUMXwn16ZJRzvQjC4ErKzT9pD0CmhSkKYoT80tAltF
 qnJksJ6NFG7pFBXAZNghndqXzqg56k6e9BObjS3M3Hj4wGarCU+wY1+01nNNRPa/Pgg+
 Aujh0gaaGXzi0u6O3+xQfN/a/fGE7uQjHaTMVGgu6ECaXVnqefOKpNnHW+qgDb5TAtcA
 K+nqWQVc9lg3Wxs0VGoWIiO8dBsBYRFxeRyloIUtLv3jaurM9UCfvfq2dl05LTz0t6z+
 HLWg==
X-Gm-Message-State: AOAM532pbF6ywaorIR6jgjEvyfzZGSyqWeq2d5Aa2Yw17iycBtvQCdkP
 l66ifoR800Gj5BcRiYaPEw76i04CZzQ=
X-Google-Smtp-Source: ABdhPJyMq/laC6HaWcs9AibY7XH4RyhgXWZdnuygVcpn5/erCxRbWkbZwi3Rf96qttCj3UhrZ8OffQ==
X-Received: by 2002:a17:90a:68cf:: with SMTP id
 q15mr36146pjj.231.1615828365226; 
 Mon, 15 Mar 2021 10:12:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id fa21sm201188pjb.25.2021.03.15.10.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:12:44 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme-fabrics: only reserve a single tag
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
References: <20210303125304.1200789-1-hch@lst.de>
 <20210303125304.1200789-2-hch@lst.de>
 <49d65274-002c-237b-163e-c3d482644a80@grimberg.me>
 <20210306070944.GA28323@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fc357ebb-f1a9-f927-1cf3-838330f57770@grimberg.me>
Date: Mon, 15 Mar 2021 10:12:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210306070944.GA28323@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_171249_023597_37FE0C8D 
X-CRM114-Status: GOOD (  16.44  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Fabrics drivers currently reserve two tags on the admin queue.  But
>>> given that the connect command is only run on a freshly created queue
>>> or after all commands have been force aborted we only need to reserve
>>> a single tag.
>>
>> Umm, I think this would be an issue for non-mpath fabrics devices...
>>
>> When we teardown the controller, we iterate over all tags
>> and cancel them, however for non-mpath devices these actually
>> stick around until they exhaust the retrys counter (with the
>> hope that the controller will reconnect again) unlike the mpath
>> case where the requests are failed-over.
>>
>> Now if the admin queue is absolutely full during a reset, we won't
>> have a keep-alive command.
>>
>> One possible solution is to make sure that
>> nvme_decide_disposition to complete a request for admin
>> commands. However note that this means that admin commands
>> would fail immediately when the controller resets, which is
>> a regression from the existing behavior and we may piss off
>> users with that...
> 
> We never retry admin commands!  And the reserved tags are set aside
> and not relevant to the "normal" commands.

You're right, admin commands will be noretry commands. this looks
good to me.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
