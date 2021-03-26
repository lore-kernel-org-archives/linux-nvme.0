Return-Path: <SRS0=jxE6=IY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B4CC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 21:01:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA8D61A24
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 21:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA8D61A24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6JI3IItFzPl4NReMALmWxGTU5/7XkpRHF1EMADgzAXY=; b=KBWJ9vuTvplE1BdA5RpZifdSy
	YhL+NdhiVVnwlrk3m8LW7qtflLrKs9sVQgYcC7KSbstQStUY3ehTdgVhyYUrpYdRN3zbOkQlc2hqp
	U7hvKGoPkJ2mBtNbSZo6oIjbRFwYrtv5X7U8m0R1rCCdeQexNKYr9SPFWHOQxwxk2u0v+Sr9Rm8pI
	pBOeumcZb4wZO/737bY8YdigQFtOgSEroSY7qE8i6stILyXB7r8+oQuDgp4R/y1iq7eB2z26Bmz1L
	ZyoK7j1AlKqEdHkHpHl0yaVKY0xrwpRIhhCrctw5I94bMsaXcCyn3H1D4SPTYWbJQO+1TYRfftT72
	7Gr1aJ9tw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPtZd-004LLS-BR; Fri, 26 Mar 2021 21:00:53 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPtZY-004LKs-S9
 for linux-nvme@lists.infradead.org; Fri, 26 Mar 2021 21:00:50 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 j6-20020a17090adc86b02900cbfe6f2c96so3061293pjv.1
 for <linux-nvme@lists.infradead.org>; Fri, 26 Mar 2021 14:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aCTZsmFlbQvaEIYdcL/1NQFSMIybYMfuAGTKpbzYzGM=;
 b=hplMs1mKPaTIYIB0ARKNQMNoFSvB/p6k7RUoQSAUsmL+N0ihKA5XCgRGqRVl3YbpH9
 sBfB3LBwXg7iiM8aQiICndcoD0CkYgjys2mIeJ1ktRTg03/u8SSSgNEsfPllljT+vAWc
 BEpemAGglfusxNDN4E4yrSCHiFqRVuX0zJmq0I7igBS9nNwlc1fh6iMUFvrOxnBM5SEd
 ohkS0kFifgoxTJcSb8GOdG7IZjYjiOn5cbHx5fMppT37O2P4LWYHh/ajMLvzD40cuSeA
 B/sLKSh9eXlCT5ESnkRNY5/CxwWlS52w4TYbxx9j5xrJB7MxUQ9MaTfUKoOg687IrRmZ
 JZcQ==
X-Gm-Message-State: AOAM532Ykfm0ZSi/5PE8uwBfplrpF59kOqrTUt7GxpKupd8el8ttbRAq
 wObEIdFIbyGVM/LqqtDB7RqDreMVhv8=
X-Google-Smtp-Source: ABdhPJx69zGk/7QXEu7vqsaQpMgZ6UZNfqR54OFxrrragfM/9hwfCA7PuJYLGoOK0XTgbCeL3XZu2w==
X-Received: by 2002:a17:90a:a618:: with SMTP id
 c24mr15606438pjq.108.1616792447168; 
 Fri, 26 Mar 2021 14:00:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5512:a799:a5d1:66a3?
 ([2601:647:4802:9070:5512:a799:a5d1:66a3])
 by smtp.gmail.com with ESMTPSA id o76sm8603237pfg.217.2021.03.26.14.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Mar 2021 14:00:46 -0700 (PDT)
Subject: Re: [PATCH V4] nvmet-tcp: enable optional queue idle period tracking
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR11MB2869734125E692608AE1A4A5E5639@BYAPR11MB2869.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <83a47699-16d2-7842-c85d-4b81f7ab8b41@grimberg.me>
Date: Fri, 26 Mar 2021 14:00:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB2869734125E692608AE1A4A5E5639@BYAPR11MB2869.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210326_210049_034329_C1B40EB8 
X-CRM114-Status: GOOD (  10.40  )
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


> @@ -1525,6 +1558,8 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   	if (ret)
>   		goto out_destroy_sq;
>   
> +	if (idle_poll_period_usecs)
> +		nvmet_tcp_arm_queue_deadline(queue);
>   	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);

Patch looks good now Mark, can you please update it to apply cleanly on
the latest nvme tree head?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
