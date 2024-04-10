Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9562CD128A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 13:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pTEBIEhSXX8ZuBnnW5p6JPC5VNWikcq932CQjXQrBDw=; b=XffFlFRwuyoEvMlxCxIXcOYf2u
	xFle/pv8zNMlZkmHNaC3vX9wasiMMSKf6ncm8t/QnQfJWFKxlDix03l7GD1ZVKdX9GjM8sZkNa/7f
	OduWa8qBZMpXeK9Utv+x8npZ+oq0aRBbto5pvwPhdGaGMHjdQsc0AjOfdtmWPZPti7iqD/vCoD+pg
	NJfb8BaqsrDcor5q6EESo7GHQ9h0W5VFCpLbLNVytCLMK7NkzYFfTuPgyxvHpyfO69hqbEP2TJteM
	/K/ERCeSsvWlN1wKGWMbAS/2Ilv8s1LNCueWoRjFMFbYjfF8yz64ySFA5VIUlfiQFuziGOLUxXDxw
	rULZ/oXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruYLp-00000007I81-2FeN;
	Wed, 10 Apr 2024 13:50:57 +0000
Received: from mail-lj1-f178.google.com ([209.85.208.178])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruYLm-00000007I6R-3YnQ
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 13:50:56 +0000
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d8915d183bso2827861fa.1
        for <linux-nvme@lists.infradead.org>; Wed, 10 Apr 2024 06:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757053; x=1713361853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTEBIEhSXX8ZuBnnW5p6JPC5VNWikcq932CQjXQrBDw=;
        b=sZWKz+D4fLzCNg2YpMSDYH7dw2NIFn0cI2n9R7Ds93Z38L7RZMhR3+8ZuwnPO07oDR
         Izwq64sx75tfxWt6APJUAe1BU2RmoCfOA1zRjQr2aGpzlfZnEsbj7ByVr9Xm3JMpjrj1
         Svb0Kh4x76QJpFAtNtM6pNvMXUPhlu2cAyavpDSJeAn7mD3LlrjYwgPfVaP+uxGCzSe7
         WNizWoCJmxsDhTEFWDrnRnClk6Qa++XgVR43haBFVM/a7OmepUjsS3+xplb0K+2s9Y4K
         /L0W9V7E3D+DH+9YX1sCKKPPHrwHZYy6p0H2EKTKHToXK96fpHuTD7jkJHOuX/Uv4V2w
         Az8w==
X-Forwarded-Encrypted: i=1; AJvYcCVAg/1Nl14sROTcMAms+Fln+UJCHutB9jjx0ED94ZVtjBrLZrZ6y/k+s/tt8COWyNAPFtzQkWQQqtDb13qAmUZxVm9Rmc5ACl/5jXfEqws=
X-Gm-Message-State: AOJu0YyusiyYGzbNCsVa42BJ7iioHEsEi5Jc/NK8BDOo84mrTMCPbAn1
	rEuNvZGnjnJWPaHlnfbXgS8lBHZWELLlggI6nS9Zd/uCh40SeTaL
X-Google-Smtp-Source: AGHT+IF3xGSIeEmgYEaI1UcHgqM9OP35oZaWJvE7XyA+Mkgth+mf7yQjmxPUXCcXdsr/KO9uedr9FA==
X-Received: by 2002:a2e:3c05:0:b0:2d4:7458:b65 with SMTP id j5-20020a2e3c05000000b002d474580b65mr2092025lja.2.1712757052461;
        Wed, 10 Apr 2024 06:50:52 -0700 (PDT)
Received: from [10.50.4.160] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d6752000000b00343a3e62997sm13714144wrw.50.2024.04.10.06.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:50:52 -0700 (PDT)
Message-ID: <959e5458-4c4d-4ab4-b9c2-8740156005cc@grimberg.me>
Date: Wed, 10 Apr 2024 16:50:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
 <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
 <7jqbhmskuzfvpjlavk7oqefmc72m5j2wj7525c7y2vlsfnaajx@57pfbmfvf4kt>
 <8c9a980f-4885-479c-9078-7f87dc92175c@grimberg.me>
 <03370383-d8d1-4b43-89f4-e9a3985c96e9@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <03370383-d8d1-4b43-89f4-e9a3985c96e9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240410_065054_912920_33A5F233 
X-CRM114-Status: GOOD (  25.22  )
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



On 10/04/2024 15:05, Hannes Reinecke wrote:
> On 4/10/24 12:21, Sagi Grimberg wrote:
>>
>>
>> On 10/04/2024 9:52, Daniel Wagner wrote:
>>> On Tue, Apr 09, 2024 at 11:26:00PM +0300, Sagi Grimberg wrote:
>>>>
>>>> On 09/04/2024 12:35, Daniel Wagner wrote:
>>>>> From: Hannes Reinecke <hare@suse.de>
>>>>>
>>>>> Any authentication errors which are generated internally are always
>>>>> non-retryable, so use negative error codes to ensure they are not
>>>>> retried.
>>>> The patch title says that any authentication error is not 
>>>> retryable, and
>>>> the patch body says "authentication errors which are generated locally
>>>> are non-retryable" so which one is it?
>>> Forgot to update the commit message. What about:
>>>
>>>    All authentication errors are non-retryable, so use negative error
>>>    codes to ensure they are not retried.
>>>
>>> ?
>>
>> I have a question, what happens if nvmet updated its credentials (by 
>> the admin) and in the period until the host got his credentials 
>> updated, it
>> happens to disconnect/reconnect. It will see an authentication
>> error, so it will not retry and remove the controller altogether?
>>
>> Sounds like an issue to me.
>
> Usual thing: we cannot differentiate (on the host side) whether the
> current PSK is _about_ to be replaced; how should the kernel
> know that the admin will replace the PSK in the next minutes?
>
> But that really is an issue with the standard. Currently there is no
> way how a target could inform the initiator that the credentials have
> been updated.

I'd say that the sane thing for the host to do in this case is to reconnect
until giving up with hope that it may work. This seems like a better 
approach
than to abruptly remove the controller no?

>
> We would need to define a new status code for this.
> In the meantime the safe operations model is to set a lifetime
> for each PSK, and ensure that the PSK is updated on both sides
> during the lifetime. With that there is a timeframe during which
> both PSKs are available (on the target), and the older will expire
> automatically once the lifetime limit is reached.

That is a good solution, and will also prevent a loss of service until
the host credentials are updated as well.

But regardless I have a feeling that simply removing the controller upon
an authentication error is not the right thing to do here.

