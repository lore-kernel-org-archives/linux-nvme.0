Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B44EC27C40
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Aug 2023 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EtlLPQ4XkMFpJySjQ9OXycirNX1t9e/eOV9xbgj8ih0=; b=UG4e8XQ9a4Kr3qXv26g6Res/WI
	OnBlq1vUxjHpsgDr2gjetOFHI9bAb0MM8FBL3dyOaW2CpPWzmvpKMxyIG45QgJyWemiLqZ2d/aX6e
	to27cEoAnC2ZLGXowkM1buh89eH7r5zAs04koc7w0UR3hjjX0T0Rp/olkBo8Ro4F6EOSOOYl7+evV
	rk041/P8045dcviZOtZNsSrKPJC5aqkf+vxHegrDStrSZBEA9d6eRzv9YexzAsoZ7ZXy02/8q7CnW
	iVJQ5LwffWpZ5M/4EYORfdCJqLoWZT9W8IFsTef5HvX132NOUobNEf6XLSHUfZ/ZHoRT5UbG9VtJE
	nK3U+9Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBRd-003EpA-1t;
	Thu, 24 Aug 2023 14:36:21 +0000
Received: from mail-pf1-f173.google.com ([209.85.210.173])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBRa-003Eod-2t
	for linux-nvme@lists.infradead.org;
	Thu, 24 Aug 2023 14:36:20 +0000
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-68bed28cb22so741619b3a.2
        for <linux-nvme@lists.infradead.org>; Thu, 24 Aug 2023 07:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887777; x=1693492577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtlLPQ4XkMFpJySjQ9OXycirNX1t9e/eOV9xbgj8ih0=;
        b=N/eGz1rm8PJjoNtAiYNbat2nWK6EgbRtavLnhp8t2E4FBYJ3ZwTZbTyqBWg4af9iVe
         tKUZyUd5RmWY9bqivLeKsw00AXlbAQblA0bFi7jz6jIFVwZNZBA1+dhPjeD1ChpiCKR+
         gqCgd/+pqNk4V+5+mPtEdYrHWEd91tde+/mbGLmJDEzmf7YmkJe4J/gsn+/hX60ZH8c7
         KwcVL1aNEIfzIgSxXicYe0HbI41jNUAzMlu+q/OhskrLMntP7TrTI+OIYaErExi2iAn2
         shqK9Pw6oxIbLYiIaq6U3lVe3O/2q/q2lzhkfthww4VrikG5lMgaGQECXrapt2ltnT4q
         6NXw==
X-Gm-Message-State: AOJu0YwYQfyv+bsrR6Wf/HaVdnMCrrLNYnFYpPiOQeOnFOX/0/WWT9jO
	P38JqHpfoZowQ33igZhO1qc=
X-Google-Smtp-Source: AGHT+IFhh/yEEq8jK9/1mUwkjtgL9PDsZzGFDBhhP31JIt8DlZgc7qS60r6ZxJZj+KRAPFQGufVKHQ==
X-Received: by 2002:a05:6a00:1406:b0:682:4ef7:9b17 with SMTP id l6-20020a056a00140600b006824ef79b17mr15252022pfu.32.1692887776574;
        Thu, 24 Aug 2023 07:36:16 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e6ec:4683:972:2d78? ([2620:15c:211:201:e6ec:4683:972:2d78])
        by smtp.gmail.com with ESMTPSA id z12-20020aa791cc000000b00682c864f35bsm11533887pfa.140.2023.08.24.07.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:36:16 -0700 (PDT)
Message-ID: <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
Date: Thu, 24 Aug 2023 07:36:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_073618_935614_A72F428B 
X-CRM114-Status: GOOD (  11.75  )
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

On 8/23/23 20:09, Shinichiro Kawasaki wrote:
> CC+: Bart,
> 
> This patch makes shellcheck unhappy:
> 
> tests/nvme/003:26:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/004:26:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/005:26:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/006:24:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/008:25:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/010:25:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/012:29:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/014:28:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/018:26:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/019:27:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/023:25:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> 
> But I think the warn SC2119 is false-positive and we should suppress it. In the
> past, blktests had suppressed it until the recent commit 26664dff17b6 ("Do not
> suppress any shellcheck warnings"). I think this commit should be reverted
> together with this series.
Please do not revert commit 26664dff17b6 because it produces useful
warnings. Do you agree that the above warnings are easy to suppress,
e.g. by changing "_nvmet_target_setup" into
"_nvmet_target_setup ignored_argument"?

Thanks,

Bart.

