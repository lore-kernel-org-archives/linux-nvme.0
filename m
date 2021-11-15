Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61D8C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 10:22:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4A561B39
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 10:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD4A561B39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BF/osmNNPfDts1fW+0kCRVGbiBTFAPA2CyU1oR+zBR0=; b=WKl3zGpWyGgedltFdpbzngQRoF
	lZ0VUuuaMA5Xt+rIe+qZVX5PzcMXia6KoBamt8eP74cbgI7gKxqwApvkcBnlGyYHdfVY6ooOFAF1k
	xCekXCEKq+kDVn1bKS9C3/npHjCv48U1rzAc4NZoRQcQy14avSrmelMlmPmVGpFqSzaPCxZiLXuBN
	21jiJ5YwHE+Ma/eYcTX7LtMedje5GfN9JMZv3gyzt3TDCnE23PngFW+jfAPEpvkslWf6vHa01GM9t
	u+CoUB0GnjYot7sWYWJBlUUOawZ12Db5bXHyWWh1Eflryc/sZzjutsQy/+QnWkcVLlcgmTHmyt/A1
	xp5V+Taw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmZ8F-00FAIH-Kg; Mon, 15 Nov 2021 10:22:35 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmZ65-00F9iE-40
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 10:20:22 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 f7-20020a1c1f07000000b0032ee11917ceso12024253wmf.0
 for <linux-nvme@lists.infradead.org>; Mon, 15 Nov 2021 02:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BF/osmNNPfDts1fW+0kCRVGbiBTFAPA2CyU1oR+zBR0=;
 b=5gYRC6oeOaWiu3BR5fg9YeW8W+bxxfTmiK+x1iD8Q9qLTEYzyEmwwN0v8reOoKWmuE
 2Koq8N2AuV/AVHtT5uXzfKnHxDHBe7qD0hti8MsEpQYWAuYKKEojyCfQSvyEkJ4I8+Jg
 PosvZabRzNr+5UGQ3aOw0Qq1qKRtWf0zCMIvLbiaPWBHqIoyBmTFreLhERIX0gyrdFMQ
 EhLE4Xr7+Z/kk5/9NBS6upuqInU9cGW5GmmUY9Z6lEiP/Jlch7gmCZVoEX7mNR/9G82I
 FSu7O5mQk8R+oniYUutolVm2Tqb/esxGYpqpsoHQKCCntg//p90UKNEeooeKLz1kDlTm
 uVbA==
X-Gm-Message-State: AOAM530d2Qc5sRUB9OQQpca2yubzlmyaFITr5oUD7woonz6TMh+bQ0AP
 GqvrBF0+Vv5MiNPHKeCXiXNrxRr9TGE=
X-Google-Smtp-Source: ABdhPJwHtMNWBlf6CjJhbujzn8Xi6oBFGscH9w9KFPZMp53i+L12Bbpfr2eQBs2SSk5aOMJkfm/25Q==
X-Received: by 2002:a1c:287:: with SMTP id 129mr44747564wmc.49.1636971618146; 
 Mon, 15 Nov 2021 02:20:18 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id g5sm20696736wri.45.2021.11.15.02.20.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Nov 2021 02:20:17 -0800 (PST)
Subject: Re: [PATCHv5 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20211112125928.97318-1-hare@suse.de>
 <74db7c77-7cbf-4bc9-1c80-e7c42acaea64@grimberg.me>
 <f67ca46e-f421-33f7-da8b-ff6e47acf8c2@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8553266f-005c-f947-4737-2108cb7062d1@grimberg.me>
Date: Mon, 15 Nov 2021 12:20:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f67ca46e-f421-33f7-da8b-ff6e47acf8c2@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_022021_235687_D0098868 
X-CRM114-Status: GOOD (  19.75  )
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


>>> Changes to v4:
>>> - Validate against blktest suite
>>
>> Nice! thanks hannes, this is going to be very useful moving
>> forward.
>>
> Oh, definitely. The number of issue these tests found...

Great, good that this was useful for you.

>>> - Fixup base64 decoding
>>
>> What was fixed up there?
>>
> The padding character '=' wasn't handled correctly on decoding (the 
> character itself was skipped, by the 'bits' value wasn't increased, 
> leading to a spurious error in decoding an any key longer than 32 bit 
> not being accepted.

I see.

>>> - Transform secret with correct hmac algorithm
>>
>> Is that what I reported last time? Can you perhaps
>> point me to the exact patch that fixes this?
> 
> Well, no, not really; the patch itself got squashed in the main patches.
> But problem here was that the key transformation from section 8.13.5.7 
> had been using the hash algorithm from the initial challenge, not the 
> one specified in the key itself.
> This lead to decoding errors when using a key with a different length 
> than the hash algorithm.

That is exactly what I reported, changing the key length leads to
authentication errors.

