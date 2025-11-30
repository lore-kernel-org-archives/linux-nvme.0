Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7BDCFD376
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8plNFLJKGtj9RXNTPLAKfL0u0LL9BSxQBfuHCchW85E=; b=VSKLuxnMTDYFQo9hmmP0XHDHSv
	ve0vWoFd0Y9sJwq9gqgjSlamZwKKR66H/jSVnEyg/M6bRHmi+elDFV54+WH8TzxecUhl8yEnjb2aG
	L/xV7Surv8IP2GSTo9iz4UBvyArxnZiyak39rmTVku2FkmhxhjxmST+w4gbEA0LJgdc3a97HFeru+
	cQHURPfcmNIcTdyh1Q1pxXs+wvIa3V2ClBnTtQYQ6TyfefT5SrYpca4CebX5Jz1vjpAPw7pHvOVNy
	BVfUX4cK/LYq3KvEihs9DjXHMH/Mmjx96ZX4MLDxLvVAHJO6tXZWHf1XLfsmaYsFeosQT/era6lkK
	T5pCyP5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPphT-00000002cNk-0a3n;
	Sun, 30 Nov 2025 22:15:23 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPphQ-00000002cNB-43vn
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:15:21 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso20916245e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764540919; x=1765145719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8plNFLJKGtj9RXNTPLAKfL0u0LL9BSxQBfuHCchW85E=;
        b=W5oHfsAPykJfRQCOOAhko9HIUE82kH4Tb3QsC6fdZ/TGwYe/6CkDzZdyhpxz7zYWF9
         pSMkt4Lt8pXqwNJIzZrPE3BpKfZzXpLSTir9OD3/uL1RVDTwKM0ZDHcHypUqnyvEUh00
         6zmG3ui63TYDSsb7FaRYP6Ltq22PPXgl0ffm0oUuOiTYq5NNhcaprMVNc2WZU/pFBK2F
         Ky3gdI6hdavdTjuNkIjANtaGwGGCqXJw8WVEOQ5QSjuO4iaX+6bxSD+r7wF2w722B/Ik
         YcFsv0m+EObT1zAAAbY5gqNI50jrZuMnrv7bIqfLVfIeHstACSBGSf1R3YQ27PU49Dbl
         6IyA==
X-Forwarded-Encrypted: i=1; AJvYcCWFuhFS22LlRw3zX51YDn57AK0rRR0x7W0YeUl9fpCtp1QifDvrIt+wS7Tp20mWSJDDiWD4h+HfIM4Q@lists.infradead.org
X-Gm-Message-State: AOJu0YxKjEJcMv+zSzdQQY/0QwuKnmjeZ+gmDfuWabR2JrCLRPnE4Ydp
	NSfdclXR83d5UROwlRUaavWaf0gyuilknfEUxinntbEn+3GJ2GdknrKm
X-Gm-Gg: ASbGncv4pE8pWtGZFC5StFsCkK7a83QHQUqWgmPW+XH0ShUbbialj9D2srbyYoSyepp
	0rXCjqOlTmhHLQyCCThV8+d06ZxDwhdy+0/9QaxA6uK2IeZnlfsse16lroltv+nRTugaCcXPhhy
	b3N+mK8VcjY09xoq5VVtc0Llm8E24z4+m6KiOyY3qHI7o1fkrw17tciGgj9GQZN90s5C+bkYIyE
	CGM4WQBa9t3fJopfu0pvZ1f8/wWl1LOsdPBpaTqdA8iq2sbb6BPZ/GOTA4kkWloB6LBIj5neyrm
	JmL+Pqxzkn1+wc7we4CTnHf3l/S/X8FVqRWQZa6iGLlBRN+wQXodHprvpHVWDMyMnPABu7U6rt5
	GUjvqU9F+WwfA4RzFogEzpRdxohOknXNKnBAJFsBeVEhZMEFcN+zctzCjwx7YTW6CHDEjfOeczf
	ZjJlI79KKri91G/TMIgShm+CiVvKpSxKubGU/KSdF/DyPPEf+/kbA=
X-Google-Smtp-Source: AGHT+IEkJYVzxdpswBAJrJSNLzIZn3VW5v/u/YK8wWhx1kE1p9BktQ3xDK+fjMhaJbrkXQyKoBSZWg==
X-Received: by 2002:a05:600c:1994:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-477c016e402mr318989955e9.10.1764540919134;
        Sun, 30 Nov 2025 14:15:19 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040c70c5sm144610555e9.4.2025.11.30.14.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:15:18 -0800 (PST)
Message-ID: <c876a821-f46f-4c1e-8b7c-e0d53ba6a4ca@grimberg.me>
Date: Mon, 1 Dec 2025 00:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/9] nvme-auth: switch to use the kernel keyring
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250703093924.GA8177@lst.de> <0752f56d-e425-4fb3-af4a-bb1af2ddf2c4@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0752f56d-e425-4fb3-af4a-bb1af2ddf2c4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_141521_016177_B1BB8FAB 
X-CRM114-Status: UNSURE (   7.39  )
X-CRM114-Notice: Please train this message.
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



On 03/07/2025 12:43, Hannes Reinecke wrote:
> On 7/3/25 11:39, Christoph Hellwig wrote:
>> Can I get some reviews for this series?
>>
> Was about to ask the same question ...

Very sorry it took so long Hannes... dropped the ball here.

