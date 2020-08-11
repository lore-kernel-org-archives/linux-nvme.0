Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4840DC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 20:53:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF882076C
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 20:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VCFpAtgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF882076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AHxy/RBVjdjDmBGSQ+jliAxpxayQMAS862wZMTvtVwc=; b=VCFpAtgOsywZziTOgmhIhCx6n
	4YeGfat8naVwdFTbBflX7qdT4g6P+hIwoBW8G8m6yQNeyycF99SFuCj1ac2Dfc459pePLywOlx2pP
	EnjN9IZFXbWRuBF7XuwbLzU3wKOKENawrx+FgdOOi4KiYqfTdfsAp2wnh8HRmgVfVkrFARtz4JOJa
	3ik8gtennSNuHf2QG9TH9IlGr2b7iOWmI7YZ9McVP+gzbEcZD6ikrzIC79D10/yjoXNP0HmkIuJXq
	feQwpEATOqCIwrncFEKjrccH7SF/K6V8diOOWbNdQlKwmbQ0p1LUWfb+TXv6WrYB37jq3pvMtFHJF
	fkfA8dnLQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5bGi-0004ev-3V; Tue, 11 Aug 2020 20:53:12 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5bGf-0004eR-It
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 20:53:10 +0000
Received: by mail-pl1-f195.google.com with SMTP id o1so114797plk.1
 for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2020 13:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gd7T+8eJ8mVx/b7wAbA1Z3nYKYy/7EXK0qxlAlojUJg=;
 b=FjR14SmHioynpfAxv+Oz+cIDDkevTYi5TktN9TcCi4aK6WAnOL3N2FVqh1+J+gjTLG
 XPP74L9A+qDII347H3wpvW4aHdUdUcRwIMGYlQzuUA5xLNqwyaPvcr7UUXnf1H0Olm2f
 cuBY1pg2TPXvJBDR1DAMIg7NjJNvkhOci4NO5s6BFgb2Ezpn8GY+b79hBiUgPlOw8/ej
 RLtbq5i5fgb6ULOwxXHn45hn/IGZUwB2h0VvCk2QMqEVnwKsvxNx+8/HJl8czqIwJhod
 WjNV6DWrg5XQ42GA68csvGp30z8dkcxcL/eoFVt8jaX/JQvbDF8CfcPnfybBhpFdxvTS
 opGQ==
X-Gm-Message-State: AOAM532/y6ZNHzv6AGmTpV0Y6fwTa7/4Z1CSp/rktRXHn1RDb82RHeL3
 cGE/aNxWmA/dWokprgzIx4I=
X-Google-Smtp-Source: ABdhPJxqu6C83I6tgr9J5Y+0EmFaUkC7oAfIdfeP6WTob9YDLecZlvnzH/njyR0r/y1VDIAB/jqm0A==
X-Received: by 2002:a17:902:7781:: with SMTP id
 o1mr2481936pll.149.1597179186842; 
 Tue, 11 Aug 2020 13:53:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b58b:5460:6ed2:8ff9?
 ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
 by smtp.gmail.com with ESMTPSA id in12sm3573550pjb.29.2020.08.11.13.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 13:53:06 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
To: Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>
References: <20200807090559.29582-1-lengchao@huawei.com>
 <20200807134932.GA2122627@T590>
 <61a78a78-73aa-1c67-1e8c-eae8f7c3a4e0@huawei.com>
 <20200810031547.GB2202641@T590>
 <6dc6bb01-5bfd-bf13-f53a-1bc75a6b3991@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4dbd5fe2-b3df-dec5-81f2-6ff97472f62a@grimberg.me>
Date: Tue, 11 Aug 2020 13:53:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6dc6bb01-5bfd-bf13-f53a-1bc75a6b3991@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_165309_636908_01E4BD31 
X-CRM114-Status: GOOD (  14.50  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> About using per_cpu to replace SRCU, I suggest separate discussion.
>>> Can you show the patch? This will make it easier to discuss.
>> https://lore.kernel.org/linux-block/20200728134938.1505467-1-ming.lei@redhat.com/ 
>>
> Directly replace SRCU with percpu_ref, is not safe.
> This may make quiesce queue wait extra time, in extreme scenario,
> maybe wait for ever.

Agree with Ming that this is not necessarily pressing as this issue
existed in nvme for a long time.

I don't resist to change the locking mechanism, but Ming needs to
provide evidence that this change does not degrade reliability nor
performance. Personally I'd like to see this specific issue solved
first and then do a an infrastructure change.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
