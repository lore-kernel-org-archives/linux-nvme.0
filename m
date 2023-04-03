Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE97C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FeBep77DrjGUpmokRYQ7dhCDeDDySE9+TQjeaBuBkxw=; b=BqsAbry95KArNlJq33oACZKroF
	9SFlW+NrK15TX/5BokHl/ZUpm/8du5y26PioWXhuc03bN8FAGY4riUwbSap4X6p1K+XzgIooe4A45
	i3MQS53FSv9LTNK7IRa3Yt4CA/u9iAdkO+fU1SD81WJfnczcD896xsDWiHSeb6IHA5LSdp3iut6j+
	THiE9HebgRa5Qb1cgzw0WD3aukhZu5f2c6STXq3zb5RqlsT5mrs16KRiUXsb4DNPzr+5XlDV3UzPi
	GSrPmbh2TOBb1tZA8PsaVM3iYbmwqp/hjYudWBJIj3a2fsjE9WdyZi+MiY2URuIbzttEkAH8dTsV3
	3OnQKzrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjMoV-00FvYA-2q;
	Mon, 03 Apr 2023 16:13:47 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjMoS-00FvXV-2y
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 16:13:46 +0000
Received: by mail-wm1-f44.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso18462888wmo.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 09:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680538420; x=1683130420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeBep77DrjGUpmokRYQ7dhCDeDDySE9+TQjeaBuBkxw=;
        b=2ikFpa6/HTyL7qpNR9kUK/FJr9orCeAonW2E/JU9ikcsZU/ubwhN8Cgmu6NnRcuWn7
         1y+5V5Lv1D7RJqhGCzrRR8AxsrhWJqa3kE2ABzfNj055CoK9P5sHhqmcPyCP/5d3HET0
         eMJ+5tBwSBvTRBkPPKx1jqbLWboXoqfayQQGWcELDvlZK42zKhoBpR7nMEaJnpGckWls
         p7GqJlxoSiYNttTCPrlKA6MlXV9HXgf7mGluf0kJ4pPDbMOGdxglMKz4LjcBJ99zidpl
         ZrY8o3hjUyrIAfUpxaQGp1MVqMnR3qdqj3HVKmOkuEUcNBmNfW8cztBTBnU+ERpFiJgr
         Pabw==
X-Gm-Message-State: AAQBX9f+OuOdTO3fbHNXwysadkIIr2D2UahRBFaSBOo4jx/1+i+DMNwu
	cSdeYARchdpAHSAWWT6+knc=
X-Google-Smtp-Source: AKy350bQ6o8QlReTv05o8RCHu/tuH+y9+1PJGi+S4jdqiRhnA4MrEOz08syRp5I8Z5QCs7FLin6BFQ==
X-Received: by 2002:a05:600c:5399:b0:3ee:da0:cb85 with SMTP id hg25-20020a05600c539900b003ee0da0cb85mr61777wmb.1.1680538420020;
        Mon, 03 Apr 2023 09:13:40 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b003ef36ef3833sm19541576wmb.8.2023.04.03.09.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 09:13:39 -0700 (PDT)
Message-ID: <7e7c3787-1772-c719-9765-7d271100dffe@grimberg.me>
Date: Mon, 3 Apr 2023 19:13:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 12/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-13-hare@suse.de>
 <677f3f9a-872d-27fe-9a21-b41bbe1c44ff@grimberg.me>
 <daf1e19e-119b-3ceb-7808-b74d8b113e05@suse.de>
 <f1bfbb7c-d8df-0386-1048-f141cb6e22bc@grimberg.me>
 <d67d9932-96eb-3548-cf40-b48a6db95739@suse.de>
 <a22946d2-e22d-a361-8768-8b34cbec1b03@grimberg.me>
 <32a81d27-2c16-b71b-e9da-d704acda93f6@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <32a81d27-2c16-b71b-e9da-d704acda93f6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_091344_982799_445BF631 
X-CRM114-Status: GOOD (  25.86  )
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



On 4/3/23 17:11, Hannes Reinecke wrote:
> On 4/3/23 15:07, Sagi Grimberg wrote:
>>
>>>>>>> Parse the fabrics options 'keyring' and 'tls_key' and store the
>>>>>>> referenced keys in the options structure.
>>>>>>
>>>>>> Can you explain the reasoning to why a user need to pass a keyring
>>>>>> given that we already set up one?
>>>>>>
>>>>> Choice.
>>>>> With a single keyring we can only have a single identity.
>>>>> But there might be configurations where we want to have different PSKs
>>>>> for the same identity (eg for key rotation).
>>>>
>>>> How do you expect that rotation would work with this?
>>>>
>>> The user creates a new keyring, adds the necessary keys to it, and then
>>> either
>>> - updates the keyring for nvmet (via configfs)
>>> or
>>> - reconnects using the new keyring
>>
>> And the user cannot update the nvme keyring?
>>
> Sure, he can. All I'm saying is that he might choose to create a 
> different one (Different tenants, setups, what do I know).
> 
>>>> How does nvmet handle a non-nvme keyring?
>>>>
>>> There is a configfs attribute 'param_keyring', allowing you to use a 
>>> different keyring (the nvme one is just the default).
>>
>> OK.
>>
>>>>> With this option we can prepare a new keyring, and use that instead 
>>>>> of the old one.
>>>>
>>>> On an existing controller?
>>>>
>>> Sure; when we are updating the keyring and the key id the controller 
>>> will use that after the next reset.
>>> Much like we do for DH-CHAP nowadays.
>>>
>>>>> (And it really doesn't add much complexity...)
>>>>
>>>> I know, it just adds one more argument, and I want to understand if it
>>>> is really needed.
>>>
>>> I do agree that the keyring argument would not necessarily required 
>>> if we pass in the key id, but I'll be needing the keyring for secure 
>>> concatenation. And plan is to move DH-HMAC-CHAP over to keyrings, too.
>>
>> I'm not sure I understand why authentication move to keyrings requires
>> that the user is able to bring its own keyring.
>>
>>> So I'd prefer to keep it.
>>
>> I'm not against it, but I failing to understand in what situation a user
>> _must_ send a different keyring to the driver (and not use the nvme
>> keyring).
> 
> Oh, there is no 'must'. He _can_. And under certain circumstances
> (in a multi-tenant environment, say) there are reasons to keep the keys 
> separate into several keyrings.
> Bit like the '--key' parameter; the code will try to select the 
> 'default' key, but if the user wants to use a different one by all 
> means, do.
> Same for the keyring; we do have the default keyring, but if the user 
> for whatever reason doesn't want to use it we're giving him the 
> possibility for that.

I'm not overly keen to overload the argument space without proper
real-life justification. But maybe it does make sense to allow users
to store their secrets in separate keyrings...

So I'm not really opposed to this one.


