Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3A8EE49A6
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Aug 2023 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FZS+wVTLxp+RpYFXYLNFX2QuW2J3IpieCLiToftOd0A=; b=e47viOjTd9YD8l1hjpf4KiGaA6
	WRRwf97lAgJXPyfrrbSIaLInWfkEScBdlysAoFEQeqWlxHBT9+eadG+KcJOXDoMq9CXQNQkbFa9ml
	dRJ4iFJhgHt5eRfloPlEZmqwW9Mvm0eu2diSI5qE6WS68QlDYy021a6mDDiei6VE9DC0o9XYWJK/b
	LoTPNzYWr9jVnlc57daUOyXLyBWzBGdk8gOEuTHnMjMSvhsEdslhj6tqrV4mNC2nD/OWEAzYkPSEi
	CdAAeHFeMQ82v5zj6Hrv+rKOblwHhmEI3uvHVXlC773FVxUWp8R+4kO5VJvJ/hA75YmTP4dW9jadv
	K+TTFcTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXg67-00BnCE-2S;
	Sun, 20 Aug 2023 10:55:55 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXg65-00Bn96-1B
	for linux-nvme@lists.infradead.org;
	Sun, 20 Aug 2023 10:55:54 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fe5c552dd0so3506935e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Aug 2023 03:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692528950; x=1693133750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZS+wVTLxp+RpYFXYLNFX2QuW2J3IpieCLiToftOd0A=;
        b=cWXk+897EL4iX2/fG7a5pNXm/CBCqjsrNr2aHIlQ1bJoroLSnm4QO4zk0vbNl+pb7h
         2ljNTfhQltPDdI+2xGbkgxNzMQlfZp7cilP1otX6JdLxplW/QYGj+6HEpPmjSylUVTQz
         Ygu5eEFe1x7xdmyZmn5i7x02uPUa7rniEp128D/nG7kEYjyc/LuDO6wssi4QmSi7hnaI
         YQxCxiJT62jer2rPYNUm9XI+Hp+Tyi+J5pAShtF4FnwtvxNDhIkYsBzWSv1fTmxUFx4D
         BOrQbejJtlhnfGY2XehYYZBRTIUGvngi8ft42IxA0lhYBWCZOTyfKgzcsr9yk6JT6m7h
         Fi+g==
X-Gm-Message-State: AOJu0YzvnAwRzheEILEvKd0J6eLlQjIeGeSh31Q8zEZzI9HSWyukY8kY
	qOnrX+Y2cBF2HFARc+aBQUU=
X-Google-Smtp-Source: AGHT+IEHdSsDdOcazi73JLKi8fF7MAOmil7dlT4m7uRsI8AjIMxyj8QJtiXtncrwGrbnF4vQCUIshQ==
X-Received: by 2002:a7b:c459:0:b0:3fe:5228:b78c with SMTP id l25-20020a7bc459000000b003fe5228b78cmr3281429wmi.1.1692528949568;
        Sun, 20 Aug 2023 03:55:49 -0700 (PDT)
Received: from [10.100.102.14] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id y24-20020aa7c258000000b0051e0be09297sm4058380edo.53.2023.08.20.03.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 03:55:48 -0700 (PDT)
Message-ID: <e797a124-ac6a-0205-65a5-9806c6955d4c@grimberg.me>
Date: Sun, 20 Aug 2023 13:55:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rfc 6/6] nvme-fabrics: expose support for traddr as dns
 names to userspace
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-7-sagi@grimberg.me>
 <7d60e267-be0a-41ff-8015-d3440b6eca2c@suse.de>
 <433182d8-c57e-2e51-2692-02ac8b474bf2@grimberg.me>
 <8e72f698-af99-c8a4-a672-d51d28ee7a36@grimberg.me>
 <cc448d32-f3f1-0929-18d4-15186adeac01@suse.de>
 <b4fe7c1f-1581-bad2-9203-6f4c87d6a599@grimberg.me>
 <69b5e07b-f16a-0a9e-bee2-28877dbecab3@suse.de>
 <0569a67e-1264-1dcc-d44a-23bf8256a9e9@grimberg.me>
 <3wmt5cd5yd5ru3uzp5grcspkvi27ijztnxwxhov7chmf6wicg5@6dj2qed6ulja>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3wmt5cd5yd5ru3uzp5grcspkvi27ijztnxwxhov7chmf6wicg5@6dj2qed6ulja>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230820_035553_409927_1547FCFC 
X-CRM114-Status: GOOD (  24.49  )
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


>> Where do you stand on the kernel exposing capabilities that do not
>> manifest in "valid tokens" when writing to /dev/nvme-fabrics ?
>>
>> today when we read /dev/nvme-fabrics we get a string with all
>> the valid tokens. that is useful for userspace to understand what
>> it can or cannot pass in a fabrics connection string.
>>
>> In the example here, we are trying to introduce a new format for
>> traddr argument that is now supported by the fabrics driver (tcp/rdma)
>> where traddr can now be ipv4, ipv6 or a dns name (where before this
>> patchset it could only be ipv4 or ipv6).
>>
>> The question is:
>> Do we enforce that every new capability must come with a matching valid
>> token? Or do we want to expose capabilities that are not necessarily
>> come with dedicated tokens (like in this example)?
>>
>> I think the latter is a be better approach. But could be convinced
>> otherwise...
> 
> My gut feeling tells me in the long run it's good to have some generic
> way to inform userspace of options format or feature changes. I am
> pondering if sysfs wouldn't be the better place for this.

You would need a global entry for that, its not controller/subsystem
specific. For that we have the misc device...

> But then we
> would need to gather this info from two places. Not nice.
> 
> Just to through in another idea, we could also introduce a version
> scheme, e.g.
> 
> ...,traddr=%s@v2,...
> 
> If I got this right, the current libnvme token parser would just ignore
> the versioning string.

I don't think that this is a elegant option, there would need for some
documentation entry for what is the versioning stuff. Plus, a
feature/capability may not even relate directly to an existing token
necessarily (if we generalize this).

> 
> Obviously, the simplest way is to introduce just a new token and be done
> with it. I somewhat don't like it. Maybe I am trying to over engineer
> this.

It could be a form of token that can emphasize its not a token like
",feat=<feat_name>" or "cap=<cap_name>"...

But this would definitely need to be done in a way that is compatible
with userspace moving forward.

