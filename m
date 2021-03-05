Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBCCC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 21:13:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D2F6507A
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 21:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D2F6507A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZJhLZwUT3RSo/eWNbuSB0Vpo4dctWxcOnoJlh5XL2PU=; b=mMCZ2jNPG85VmRhk2gkbffbh3
	Nti6JyG74pZGFBG+kpUN8nqpSgomtgKHPQVD/ahBeiNo65usDSD02BUkISbABtiI9h37kJ9sHfE9F
	1U1TvgVaeFbNhAnmUEeMziJ9k1oHs/I8bEmL3sZeQX9q5WOyqMbibl+5QkGdWeWWujuXlQgQcemFq
	LsofNRxqXCQ5Vyqd8nOywT5UYmF61v4sjJySdZUbpqlStKwYcU/YBUA5iQ0Op2xwwqimAbqS9jlFk
	xoFtAvSSBpUZuRng8bwbJfb66mh6QNPTTClLE13zyQjH6jjzM8dKTsNmbL3+2gxHqodG/dmM78/8R
	9iMsje13Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIHkZ-00GX2G-KQ; Fri, 05 Mar 2021 21:12:43 +0000
Received: from mail-ot1-f45.google.com ([209.85.210.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIHkR-00GWz1-69
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 21:12:38 +0000
Received: by mail-ot1-f45.google.com with SMTP id d9so3127930ote.12
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 13:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XxvGnWRwM1FN/0ayIoux3WGYS2/8AYSzwubzX8ci9BY=;
 b=HRmzyoxY7sfSs9L439FGCqjWlWkU34FLZMrKBAx2nFcrcgDq/KvrYvDSH6K60mCiZm
 ncO455UsUbRuAbOh1YxiHPtStB1miTb4pr2QXznCA7PORmAr5WtUin9xqOwCrNTAlSRQ
 bU7wozaNBnzAZTQjFi39gAk0y39lt4SHsHdph8EHM6TyseV4vTPxkICnnvybQl4fGqsP
 coyvcAxoYxptj3QH3p9JckogB685MxfYzkT5MDyMwyEVYNmQKGQ8cHHxD/z8kBzkoRR0
 9yyRhqLJeXGpVrwJrzxNyBuwziuHLwaXiWU1dt+JxRmO5zTuEVmhjFV68t+C/ZTvbno7
 jJhg==
X-Gm-Message-State: AOAM531Ma9pZKxrLuTBN7uQmH8nf4vseshR3pk/O3nwJJE0Wt9iZDsTA
 dt/68YkLYP8/xKEBwVQvcLH6H1Vabps=
X-Google-Smtp-Source: ABdhPJyxJARnjUtFga9YR7LK9ldpdDpIDSNazvJ2CsR9KOceZn3UcOCRdCwYoSHUqxhFWnama6jpUA==
X-Received: by 2002:a9d:6b99:: with SMTP id b25mr9808097otq.30.1614978753716; 
 Fri, 05 Mar 2021 13:12:33 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id h11sm753491ooj.36.2021.03.05.13.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 13:12:33 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme: delete disk when last path is gone
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210225110534.75710-1-hare@suse.de>
 <20210225110534.75710-3-hare@suse.de>
 <20210225165944.GF31593@redsun51.ssa.fujisawa.hgst.com>
 <176fe48f-090f-0365-ef8f-d650b803f053@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <96afcec1-92c5-6837-5853-9b180e881375@grimberg.me>
Date: Fri, 5 Mar 2021 13:12:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <176fe48f-090f-0365-ef8f-d650b803f053@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_211236_882405_A66672D2 
X-CRM114-Status: GOOD (  22.63  )
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


>>> The multipath code currently deletes the disk only after all references
>>> to it are dropped rather than when the last path to that disk is lost.
>>> This differs from the behaviour in the non-multipathed case where the
>>> disk is deleted once the controller is removed.
>>> This has been reported to cause problems with some use cases like MD 
>>> RAID.
>>>
>>> This patch implements an alternative behaviour of deleting the disk when
>>> the last path is gone, ie the same behaviour as non-multipathed nvme
>>> devices. The alternative behaviour can be enabled with the new sysfs
>>> attribute 'no_path_detach'.
>>
>> This looks ok to me. I have heard from a few people that they expected
>> it to work this way with the option enabled, but I suppose we do need to
>> retain the old behavior as default.
>>
>> Reviewed-by: Keith Busch <kbusch@kernel.org>
>>
> Oh, I would _love_ to kill the old behaviour.
> Especially as we now have fast_io_fail_tmo and ctrl_loss_tmo, which 
> gives us enough control on how the controller and the remaining paths 
> should behave (and which weren't present when fabrics got implemented).
> 
> We can make this behaviour the default, and kill the old approach next 
> year if there are no complaints :-)

If this is broken, and this behavior doesn't break anything else then I
don't see why we shouldn't do that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
