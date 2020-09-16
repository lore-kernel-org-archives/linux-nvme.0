Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94304C43461
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 17:00:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133DF223BE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 17:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WNRC8yia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133DF223BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PuGvfG74feo/+T9Lmcj1vOHaT1K54qcUZnTnqy8S6Lc=; b=WNRC8yia8heksUg4wLz0JuHGM
	GyYKHOY181//wrcy09Jh1QdowG1sVzOK6vy+I/MUKDrYct3ayWDibDHtqYHqPC2cTZPgVr9IuPP8Q
	nSYWZRm532RJT1S+iPKHeE73FinJU04SQ/wgmwwsnwP2t5xYCjUd5JmZiL1yfiFgH7MuhhrsUNMbG
	X6dnm3eWQ4CheUePBWFL0Xaw1xpcP68LxpR5mC03wDZGHGuzEB6ceFxgcbIVVjCuSi7vFel2T001b
	NOj3fGqzjtlxvgnlQPC/q0rCxaWU6TtV2aFKNiFH+YpDbkZ/TuZl/cZWeLbZ+ri7aKKbwtqK38Qpd
	ThuFxhuaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIanf-0003t0-U3; Wed, 16 Sep 2020 17:00:55 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIand-0003ry-10
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 17:00:53 +0000
Received: by mail-pl1-f196.google.com with SMTP id u9so3515585plk.4
 for <linux-nvme@lists.infradead.org>; Wed, 16 Sep 2020 10:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QP7ckIOqaocnWJA2GJRU52viETpUtfNQoigRsVwQe98=;
 b=UsjOz/VxOsus3vLMV+5Yi6AkU0CGozeOVx3VbyKD8uYH6OwHJeaVhPDPzATdHX04d2
 41uQ0Yb4p3eXUEhEFfeKNtTTvdww7rlbhaBKDcCcDrcI3mdI5EtxNx5c7avcSa6lyRoo
 6FScI1jR135+ie2C09fjG2AZhYlmCuT241PV2elP3Lk/66VeXmxAYRtG+NJR6IOXUZED
 e7NASF+ida7FZvKYBTPtFTKMlWE5TSATy94oLptbE8ruJGwTOPs7OxKY1elSiQA11cXf
 kzNLjlTvrskFHVmtmdXhTDRG3ZMmUqu/0C7NCgwpFc/8Xm7UgSNsFi8Og2nOeKOiInsJ
 lPxg==
X-Gm-Message-State: AOAM533A63evXmxUSrSjH9JAj0zl6d2fujV+Yx9t+gBApiOeuejsqGHh
 zmBE5SAEt1Tqs5rhr/oG7us=
X-Google-Smtp-Source: ABdhPJyMsG4CGHt6ZaCUWV93LdncEyqBOcTBNacLzqIs6OgJYfngzY2tN81njOJIl2C8Yi4n6pvxrQ==
X-Received: by 2002:a17:90a:8d05:: with SMTP id
 c5mr4672527pjo.222.1600275651733; 
 Wed, 16 Sep 2020 10:00:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5b8f:1046:c134:e3e4?
 ([2601:647:4802:9070:5b8f:1046:c134:e3e4])
 by smtp.gmail.com with ESMTPSA id a2sm17280713pfr.104.2020.09.16.10.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 10:00:51 -0700 (PDT)
Subject: Re: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200915230456.13159-1-chaitanya.kulkarni@wdc.com>
 <9aaecc8f-7eda-b792-2e5f-a8cc8f8178f2@grimberg.me>
 <BYAPR04MB49658A3CB5BA3AB70434551E86210@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9ae2644e-73e4-768f-965e-ff1d41c19c6c@grimberg.me>
Date: Wed, 16 Sep 2020 10:00:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49658A3CB5BA3AB70434551E86210@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_130053_310013_1822B137 
X-CRM114-Status: GOOD (  13.12  )
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


>>> Update nvme-loop transport with NVMF_OPT_CTRL_LOSS_TMO in allowed ops.
>>> Without this patch following command fails on my setup :-
>>>
>>> nvme_fabrics: invalid parameter 'ctrl_loss_tmo=%d'
>>
>> But loop doesn't do anything with this param, why should it
>> accept it?
>>
> 
> With latest nvme-cli all the testcases are failing [1] with this patch
> they pass [2]. We can ignore this param in the nvme-loop unless there is
> a need for implementing the behavior.

I'd say we need to fix nvme-cli not passing optional parameters by
default...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
