Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F168FC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 00:16:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8183123122
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 00:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8183123122
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6lKrpdFS2oqu9SvBYCmTjytaLSCU2WhYEJM9C4Y+D4w=; b=AEUtepEYjRHyOER6eTuwnm6Eb
	5WDXkEII//aWrugvHkFrMbU1lkGzbvZKOvDQdpOVBwGyzpEVQWN7z87yuPYrXlcc5izgCe/K/S6pg
	aAstCdL1QaDErta3X3128XY8SSFdINgbKWBVh54+fix+adW8Z2B6nJYY6//u0nlcE5tVB7qCAk6gH
	zCRwbseBk4jTdTUxei19GyTP23TCOXqom1VnCRdYs4O3zo9Oo/R3ktkSDYIE9AmYuzdDFDs8UBY1X
	xyjlUn/WVQqZFfkgkqGRzZkbmyxxnW2hz0adgQdoeDA/mK+Ej7Bw1ds2WsCsAidBuPonCwxfsIrUA
	AjcTx03AQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzqIy-00060X-L3; Thu, 14 Jan 2021 00:16:00 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzqIv-000600-7m
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 00:15:57 +0000
Received: by mail-wm1-f48.google.com with SMTP id r4so3172727wmh.5
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 16:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CjOYVZEsf2FiLNXwyV5fZxp1Cug1pJCM1gzhjiP5Ln4=;
 b=a5wzrurk0dBEEX0YLzNgy0L8DKezY2qcQ+DtMvIzok7MAoNGIWc18YQ/sdFS2J1KDy
 ZQk6fUFbYXhs9dXssGMwoireVTploJaJ6YLSYOhshpapF+wK3GFY38tICsuT8hglTTh2
 Bd+k1rXBuGpxmTldRQ7m5c8QZO8cOxAWCydEiPs5r9Vs7laq/gfD7EKJ2ETvCMr8MxnG
 EfQEbBC5TaxrLYzBeuV2gfK0iIZqo7bLDhWFDqnGaiV4K3kV9sFoa0pVaqZIxx8Kj21F
 Bvqp2UyH40fC0+fZYFyjEwGqJQo2hq2kWJVHcA5ktUf7+3TDP38ukjqHcKRAwBYlN988
 vMjA==
X-Gm-Message-State: AOAM533SUZB4yEt7EYx/ExwWHnJBwdLteMdrItGWZPuvVk50U28wMXem
 HycMKiTxcJUDa8C4phxWoeg=
X-Google-Smtp-Source: ABdhPJxnDgb+WIYycc3ID2vAo2/XWBQDZ6Nm9gUBvvvpApZYDr5WBKf2Vu5qmI2AgxtIO2IiTyQeQg==
X-Received: by 2002:a05:600c:2905:: with SMTP id
 i5mr1407139wmd.28.1610583355938; 
 Wed, 13 Jan 2021 16:15:55 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id c2sm705931wrt.87.2021.01.13.16.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 16:15:55 -0800 (PST)
Subject: Re: [PATCH v2 0/6] avoid repeated request completion and IO error
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210107033149.15701-1-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <879d04a5-c52e-4d21-5003-d369ab5cdaee@grimberg.me>
Date: Wed, 13 Jan 2021 16:15:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107033149.15701-1-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_191557_310769_844391C4 
X-CRM114-Status: GOOD (  10.39  )
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
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> First avoid repeated request completion for nvmf_fail_nonready_command.
> Second avoid IO error and repeated request completion for queue_rq.

Maybe this is me chiming in v2, but what is this fixing? what
is the bug you are seeing?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
