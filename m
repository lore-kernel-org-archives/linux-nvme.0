Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5430C77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 15:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c6i2IHb1dRf7Rq/h4Um0rVFJJU1I8nzPe8J3nLS/Xqo=; b=Y/lknu+kRKvVJRUrDGEOhVA4W/
	4P0QS/lLfwH8/Wew0rk7BTeHOsa5EoP3sf7yjDF1+XBuJZ+NIVk68vi2vc0OHYO+p05Xu16iyJNYc
	Y9L+fD725PydQ1pGQj6fIHX+gyBGvCzEaV3jUT0cfjbUh7DHxcSXtJ1sG0v3AvisLQKJiY0oBk3k9
	SH4dArOdc4MwanQ8MwjgwcA6NB4jcHSh9/HfTTCdMHHH7o387Zt5VDEOJGbNaYuqlrg0cJ/zPPUnI
	VZnTgQZP2FJjpHSmT4CoWtJc9NLCYfKNLBgqWpm3lkV6ufCop2Rw3XrVg/3mHu2PeuG8tEQUuwrIQ
	eTwvL0MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poQWw-00GnKj-20;
	Mon, 17 Apr 2023 15:12:34 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poQWu-00GnIg-0b
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 15:12:33 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f0968734f6so10486395e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 08:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681744346; x=1684336346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6i2IHb1dRf7Rq/h4Um0rVFJJU1I8nzPe8J3nLS/Xqo=;
        b=kfPf1G19dPhjQ4xaTthgnPew0IkBz2bpKw/jbTEvmEfrHGOcnLhrm5aaZ14dr6rWmT
         00M8IaPRKr0k0KAGhvJn8Qp1IOamBC5jK5h2iXyg1AWuDFm/9A9PxjeJ7UiS6Q7LlXZd
         u946NF+XSO5Xh8Dk1CU13CINbmcbbarx014l+/uTnW2M/UY1FN0+leUKSSaej8WNfnlp
         5yp9zzyFP2zf00pKBDZail31FxGzO0mBfcTcvbHnleCzHCjG4gevfcubnY3uo7bpfUx4
         jEVyVBXwUGElNTJZnGX0NtJKPnj/kDa8IgljskTCOKIZzjXoiO77gTMky6uQFLEKymND
         uB/g==
X-Gm-Message-State: AAQBX9ee/pqiSgXQUJ+pivMN8iZ87umcDw8QbgisT/j2T9EMC34xcils
	edPf2ig+ZLu9G6z53DwukbmQx96UYOU=
X-Google-Smtp-Source: AKy350Zh1bNuv0vK8gv2VsVaUsWBFWmiIL8HeoDHI0un6BTqvMSvfIyTag7My8SmTYNkjxhPeQm16Q==
X-Received: by 2002:a5d:6281:0:b0:2ef:9699:f906 with SMTP id k1-20020a5d6281000000b002ef9699f906mr7272926wru.7.1681744345931;
        Mon, 17 Apr 2023 08:12:25 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q21-20020a05600c46d500b003f03d483966sm16158530wmo.44.2023.04.17.08.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:12:25 -0700 (PDT)
Message-ID: <57d53899-8695-2bf2-b6aa-0389ad82c7ea@grimberg.me>
Date: Mon, 17 Apr 2023 18:12:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 18/18] nvmet-tcp: add configfs attribute 'param_keyring'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-19-hare@suse.de>
 <60ff89b4-5d63-a6db-18b1-e0f28055c5d9@grimberg.me>
 <c7e895f1-1c95-f658-f7a1-c4cee5cf8c91@suse.de>
 <1b018791-9aa3-b988-7045-40b46bc50989@grimberg.me>
 <02e4f6eb-32c2-8f3c-872f-831e70da6166@suse.de>
 <ffb33351-e26b-470e-9849-e195d9b05b52@grimberg.me>
 <1b9a7d09-1af6-564a-18db-2a73f27435cd@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1b9a7d09-1af6-564a-18db-2a73f27435cd@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_081232_223406_FFCE4A73 
X-CRM114-Status: GOOD (  18.63  )
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


>>>>>>> Add a configfs attribute to list and change the default keyring.
>>>>>>
>>>>>> is the keyring an attribute of a port? or a subsystem? Why the choice
>>>>>> of making it per port?
>>>>>>
>>>>> As per discussion at fmds each port might want to use different 
>>>>> credentials.
>>>>> We can move it to subsystems if we decide we don't want to support 
>>>>> that use-case.
>>>>
>>>> I think we should move it to the subsystem in Linux.
>>>>
>>> Easier said than done.
>>>
>>> We can only fetch the subsystem once we have the NQN, which we will
>>> know after the connect command.
>>> But out of necessity the connect command will only be transferred
>>> after TLS handshake completed, so there is not subsystem NQN allowing
>>> us to figure out the correct subsystem.
>>>
>>> So we'll have to keep it at the port level, I'm afraid.
>>
>> Question, why does nvmet needs to support user defined keyrings?
>> I understood your argument for the host, but why should the target
>> support it?
> 
> Hmm. Originally I implemented it to be similar to the host 
> configuration, but from the implementation we don't _actually_ need it 
> as we select the key from the entire key store.

Thanks for confirming.

> Having it is just a nice way of avoiding having to have a daemon 
> configuration.

I'm sorry, but I don't understand this statement. Can you clarify?

> So if you insist we can drop it for the initial implementation.

If there is a use-case, we can add it. But I'm trying to understand what
is it.

