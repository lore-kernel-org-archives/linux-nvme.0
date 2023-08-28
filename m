Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BDFC83F11
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Aug 2023 18:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=umflnyFqBYkm4MgelOGwx19oN9oBe5SP3i3J2ZxPkxQ=; b=4YN2JufTNjLwO9s3190hKTAwrb
	FblHz8ciQW6MRIGsx9/5i9dEhpmnvxsdRZpWp+lhFlQ2Go22PEEkTJY6MMjSRfJNASRBzF65+wHkO
	EAYtnlCVQIyLMI2dmdI8ZAJVC/4j6Ae5wvPX7wnY2Nv1a/IY+UlKx+oUhJqISG3/U1gaLpaBaKink
	1SulAUGUfFPqVVwXt5CpLc05hBW/9ORZ76ztqbSh0IMltFOZ0n9sOLbkUfVtB8sLL/ZXFzzb9Lac+
	b6SLbGCzG4BCNI0MtCA4nt9oHS00U+7po5vYdFj0+/sLIqig3or2m6JF2wjw9m7U9prkOvQZK4Ued
	NtL4cDDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qahOJ-00A6YG-32;
	Mon, 28 Aug 2023 18:55:11 +0000
Received: from mail-pl1-f177.google.com ([209.85.214.177])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qahOG-00A6Xh-2z
	for linux-nvme@lists.infradead.org;
	Mon, 28 Aug 2023 18:55:10 +0000
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso3532985ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 28 Aug 2023 11:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248907; x=1693853707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umflnyFqBYkm4MgelOGwx19oN9oBe5SP3i3J2ZxPkxQ=;
        b=E4JnM3T4snb1ftSJ/B5NcsSDat8r0fFGbYAq9a3C0zz+tr8YJhrZgA1ycepil49Wj6
         hPybNtUREn2RJoBkakMwk2+M0E/mTqYgu0nXJ9tJ6wj8Wd4bTNRHdHvyF1Je1Hj9Ew+R
         RM+1uqEADOyPDK/yEkocOWX5CFpfkdi+x0CwbqBL46yPkyGDztGimsifjvnrU0APLFhv
         uxS2a6hvad7JDDk1q/hLxGsvMJHSRR7Q9L0XxSJoHEA2Mxl75pjmNZ9XqLPL7WdGH3YD
         ByttbFGE9nVkX7e9aYXG5gUtBomFEH6uhhNlUKmWGn+hVaLtLBUOeAu6qeysERwyzPbn
         6AZA==
X-Gm-Message-State: AOJu0Yyn7z4sKpiSdRs/aH8LEBQPszYfiQqdggh6f+BKcpE4qlALbXF6
	dDgoihHS/wiXVTpOTS9BWdM=
X-Google-Smtp-Source: AGHT+IG5OnTzChA0NWY4c4vTbc4cYX/NBVucFHt1B0vYzAE05QFD8WTqXl+BXzYAGg4hw/79RtJ9YA==
X-Received: by 2002:a17:902:f94e:b0:1c0:e014:90c1 with SMTP id kx14-20020a170902f94e00b001c0e01490c1mr8249817plb.48.1693248906633;
        Mon, 28 Aug 2023 11:55:06 -0700 (PDT)
Received: from [192.168.165.167] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c14d00b001b8a3e2c241sm7745382plj.14.2023.08.28.11.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 11:55:06 -0700 (PDT)
Message-ID: <ed518b56-a579-49bb-b2bb-220214ef6e2e@acm.org>
Date: Mon, 28 Aug 2023 11:55:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
To: Daniel Wagner <dwagner@suse.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>
References: <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
 <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
 <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
 <8ffb6c2f-0836-4302-82b9-902e092e537c@acm.org>
 <txsyjpcxb3baog5fgqdnm5hh765nt5qcbcmllsto7uulyzr5kn@zirmqldhosbi>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <txsyjpcxb3baog5fgqdnm5hh765nt5qcbcmllsto7uulyzr5kn@zirmqldhosbi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_115508_967262_142CCD46 
X-CRM114-Status: GOOD (  11.67  )
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

On 8/28/23 10:02, Daniel Wagner wrote:
> I am against adding code just to make ShellCheck happy.
Hi Daniel,

That's not what my concern is about. My concern is about keeping
the blktests source code maintainable and easy to read. My opinion
is that the ability of bash to pass arguments from caller to callee
implicitly (a) hurts readability, (b) is error prone and (c) hurts
maintainability. This is why I think that this feature should not
be used and hence that disabling SC2119 would be really wrong.

Regarding (a), I think this long e-mail thread is more than enough
evidence that it is not clear what the intention is of the
_nvmet_target_setup calls without arguments - not pass any arguments
or pass the argument list of the caller. Regarding (c): if any
_nvmet_target_setup calls would be added in a function that accepts
arguments, how is _nvmet_target_setup() expected to process arguments
of which it doesn't know how to interpret these?

Hence my proposal to change the _nvmet_target_setup calls with no
arguments into "_nvmet_target_setup --" and also to ignore the double
hyphen argument inside _nvmet_target_setup().

Thanks,

Bart.

