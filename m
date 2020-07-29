Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184C5C433E3
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 00:43:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0922076E
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 00:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WGgu7ERg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0922076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pBc/YM6eCFK+9LoRZI+T8SSNFt4Po0yGJDB53f3eiTQ=; b=WGgu7ERgtaUFAH4sAYlYfmqfo
	cpSouMrLgNIGkzVwXNZgHsyhEo6gnpReQtKxiWfWrGyINgElcdumkihriEjVAI3npkq4rDtx2dllf
	eqTS1yXfJPlwMN1LHv0m4HG8Fsw2FRdMQIQAjaMfo5pI4ML02wiWBIS8/N18ps1jupGy8XhdxeMs+
	E3azG+GocSIX6vWbxZohwWWVT5Y1DsjRIuY3qCMwOJgMPgulkzAGgTDx73SXFe9+KJFV+OZpJYSeH
	U6cRHqdzbOJld+i0bndHlyyYoGF7QlehBpXS/lQ5WemMYdz4FK09a00Y/9kKmaIPfkE6Ez6pmcxOl
	2El9o8qYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0aBY-0004i1-0y; Wed, 29 Jul 2020 00:43:08 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0aBV-0004hZ-Sv
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 00:43:06 +0000
Received: by mail-pg1-f193.google.com with SMTP id l63so13294262pge.12
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 17:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q621nujP6PGe0N0JjbEojimC1WUZHW4/irnI2wZeTfk=;
 b=bAGnkUxVxS8eMc4USuD/BT4msggUfJEL0ID4YB6bs1IkI3sJdNAJw/2DFG+Z6hS9zr
 BDEINhyuzAH3eCdD4K1tsKRfYwpJXOl7z5Ytevlk+bJe+dkqgXQfigLh7X6uJXZMEpOC
 9SCp7L13Rd/6csXOErfGMXX7dNtujife8lcsXAk3QX2ty9eeS7Rzab3MPqRhlwblijmd
 uNh9HVhTLUB4VLO+8RU7ayrtArxwcZinOFK9K7ZB8xLKqfeDP8+RJTUWhB1oacd73Wcn
 +UOhQDFFIE/2klsSc7Eofmg3iLsJfNl3/WIFciYdlNijDOJkylVBy0DYiVcyNgZ2oVNF
 GFAQ==
X-Gm-Message-State: AOAM53179bXpZ+HWZRCrNq5ZzHSLIQbm6zllPE4FWC1goegvHQrasM2v
 p80YmXNMgn4J0LwjiB1mBCQ=
X-Google-Smtp-Source: ABdhPJxQODq0xK6fvW2V3KNlqM/yc77wLReKq8n97sRZZjRInGdpD0ykPKVa1bZJXKGHsK7q7hfsmw==
X-Received: by 2002:a62:77d2:: with SMTP id s201mr9201832pfc.213.1595983384823; 
 Tue, 28 Jul 2020 17:43:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fcc5:69d8:6e20:4fd1?
 ([2601:647:4802:9070:fcc5:69d8:6e20:4fd1])
 by smtp.gmail.com with ESMTPSA id a16sm229980pgj.27.2020.07.28.17.43.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 17:43:04 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: paulmck@kernel.org
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
Date: Tue, 28 Jul 2020 17:43:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729003124.GT9247@paulmck-ThinkPad-P72>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_204305_964138_45822E51 
X-CRM114-Status: GOOD (  16.75  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Dynamically allocating each one is possible but not very scalable.
>>
>> The question is if there is some way, we can do this with on-stack
>> or a single on-heap rcu_head or equivalent that can achieve the same
>> effect.
> 
> If the hctx structures are guaranteed to stay put, you could count
> them and then do a single allocation of an array of rcu_head structures
> (or some larger structure containing an rcu_head structure, if needed).
> You could then sequence through this array, consuming one rcu_head per
> hctx as you processed it.  Once all the callbacks had been invoked,
> it would be safe to free the array.
> 
> Sounds too simple, though.  So what am I missing?

We don't want higher-order allocations...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
