Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088D4C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mRImVUXizjXFbyDIshaydV7yCJAO62vsecbpn87GvaY=; b=pBJGTMaOVL3xiLZPhucaGUqUhF
	qhEsmwYuBdgHhIfy+uhv1SH28TN8qSJ9pBHbW0agujdzyEx09aBS6WsqK5NZd8BHDRiAwW4mPdXRW
	Tod8TF9LiQcY+F9Y7E0XfzgUq4Nyg5lR1UeU3nkS5osKdea2gXLojoX/ogd7Y9nLg3rMp0/o54aow
	oGlB4eU/O0dJVxcULvPMj67nBl4K8RyTqfOKqqquF0mfcjQJ7Y1oRApvYpJ4RGXi0h3FDn+b46q/L
	x0KC9dqHrT8u81gaIDWOpu+b66+avTRaFrNoXLo+8gnP0PhcR7G5BV8ebD3AU1KoVu/sSveRzY90E
	sn1fkFVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwlvV-009tOv-33; Mon, 13 Dec 2021 14:03:37 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwlm1-009p3l-6j
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 13:53:51 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 p3-20020a05600c1d8300b003334fab53afso14056913wms.3
 for <linux-nvme@lists.infradead.org>; Mon, 13 Dec 2021 05:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mRImVUXizjXFbyDIshaydV7yCJAO62vsecbpn87GvaY=;
 b=IfUi93ZlAOMzMhpC8j3P3v3bXeoyCvgwK/tMTbUngIr11HpCNRCbROCqDdQYBDyj4M
 1tzKMVtWP8EX23eXjx1E2M+unVIWa/t6vkfY+cY7loNbrRIufcu7OIF9cmiNWtTx/Z6l
 NdmC7UprIpCbh9wNuVWJd4ygVUkjfbe/pbKsbmF9z+3skyqUy840XMpc8Ogosru4GbXg
 DhX4vZZVUKpOKACt5LtijnbdNUTfqr4dC4uMQgXYcS4/YbNEEO9n9s0kgPS7EPMazW+m
 8ogJlN0TxHXUt5njISoik3ae/7+tWJvZ8ld0cZ+rKs7OcN3vj4w39HLQaPoMWMktkBLD
 Llww==
X-Gm-Message-State: AOAM5311J/n3SRNqtWvCq6dJgDeonZoj6W3q4eXOnYIqeaZTwpKfX4qB
 AoehZ9LG5gH8AaaJgAQV4qGXOgHcRjY=
X-Google-Smtp-Source: ABdhPJyQ7p8lmXTzWOLLv4vijJl5l30p84V8FIxcXpLNzmS+IaE7MpNxHgfNAptzXLqvQipW7KalWQ==
X-Received: by 2002:a05:600c:4e45:: with SMTP id
 e5mr37587819wmq.43.1639403617712; 
 Mon, 13 Dec 2021 05:53:37 -0800 (PST)
Received: from [10.100.102.14] (85-250-228-224.bb.netvision.net.il.
 [85.250.228.224])
 by smtp.gmail.com with ESMTPSA id e7sm13951741wrg.31.2021.12.13.05.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Dec 2021 05:53:37 -0800 (PST)
Subject: Re: [PATCHv8 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20211202152358.60116-1-hare@suse.de>
 <20211213080853.GA21223@lst.de>
 <9853d36a-036c-7f2b-5fb4-b3fb4bae473f@suse.de>
 <4328e4f0-9674-9362-4ed5-89ec7edba4a2@grimberg.me>
 <56f1ce1c-2272-bed2-fd6b-642854b612bb@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <483836f5-f850-6eac-8c38-3f03db3189ab@grimberg.me>
Date: Mon, 13 Dec 2021 15:53:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <56f1ce1c-2272-bed2-fd6b-642854b612bb@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_055349_290021_20C6FA51 
X-CRM114-Status: GOOD (  20.87  )
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


>>>> So if we want to make progress on this we need the first 3 patches
>>>> rewviewed by the crypto maintainers.  In fact I'd prefer to get them
>>>> merged through the crypto tree as well, and would make sure we have
>>>> a branch that pulls them in for the nvme changes.  I'll try to find
>>>> some time to review the nvme bits as well.
>>>>
>>> That is _actually_ being addressed already.
>>> Nicolai Stange send a patchset for ephemeral keys, FFDHE support, and
>>> FIPS-related thingies for the in-kernel DH crypto implementation
>>> (https://lore.kernel.org/linux-crypto/20211209090358.28231-1-nstange@suse.de/).
>>>
>>> This obsoletes my preliminary patches, and I have ported my patchset
>>> to run on top of those.
>>>
>>> Question is how to continue from here; I can easily rebase my patchset
>>> and send it relative to Nicolais patches. But then we'll be bound to
>>> the acceptance of those patches, so I'm not quite sure if that's the
>>> best way to proceed.
>>
>> Don't know if we have a choice here... What is the alternative you are
>> proposing?
> 
> That's the thing, I don't really have a good alternative, either.
> It's just that I have so no idea about the crypto subsystem, and
> consequently wouldn't know how long we need to wait...
> 
> But yeah, Nicolais patchset is far superior to my attempts, so I'd be
> happy to ditch my preliminary attempts there.

Can we get a sense from the crypto folks to the state of Nicolais
patchset?

