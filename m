Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8791C54E68
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 09:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N0/h2iIBklJUoYvjrZIEqYbhLHWm3NnBtWgaf/OnCzw=; b=L7tebp5Zyc1mZjTZHj6jfSa97N
	9RweC6/i3f4wwIrqcuC4CHBRuo8pO+CPI6hmUf+vIBuuTaNhRJn1PRsBXNIDxrm/JXwHY8oUh3ECl
	yUxCCotUKx6W4lgjWrmCcp8RfdZ5QYQhBIKhiwXK982PfLkwVMDMsQtd8l6ja0JdFnHkMQmU1kDGT
	hrMlDACMMFY073xDuFKYXA6S1NCRlhluIYcANOty/GJUP/xHLZBsJ9xRTDmnVPWjMmw2SAOFdanda
	xR24I7OeA8dfgwMYmL30VF8tdDvZ66XBZiZS2q1g61BvEK8zSNQvcAdvf7dXhZK4HIbHFc4PaLxCC
	7DZwPOnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnEHH-00000002PtK-1ELt;
	Thu, 21 Mar 2024 08:59:59 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnEHE-00000002PsB-2td2
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 08:59:58 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4140fafc27eso1784335e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 21 Mar 2024 01:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711011593; x=1711616393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0/h2iIBklJUoYvjrZIEqYbhLHWm3NnBtWgaf/OnCzw=;
        b=lPhTtQQXCAhGkmfFsScbY2y5KRE0hPagMdXbzsfG37UzAnfGg3NXX+KRv3LPyqWA0w
         1brWtCHYAAmm7+tASBbfwaPxrflz6e5nllVAcp+KuHtwF1TTez74RJomriw9F5EJCruv
         cN/EzEy0UIfRbt9Rf5UeUnLErC0q/VBHbryEBLnYHXW/HYQRrEuCoBmiXIk6fF2sgg0p
         C1H5Z7vSpW9YypJCQiLOQR7Ij+Fg5Nd9+z5hGq7VSdHM1RQmlswE9Lx9EZ/su5jbm0Sp
         ua7kcsnky6RkN7Zg4Kphi0+B42jTDBPxHBn1scmLDKZRpgMToaM7opX2eZd7HrEP2qp9
         olrA==
X-Forwarded-Encrypted: i=1; AJvYcCXgiEl+25yg5XDeZHID0lJeRRrllvoNVgYXtdj3CzJbiHRqnFCI1Qxkw9Mqx/M1VeIULRfoBawxZiNUof9GVYNvKaUecB/8z9u27SD10Ls=
X-Gm-Message-State: AOJu0Yy630OnFShzPsVVaxBpm9p3LzRX1b7jVbC0c/bLiBSYKtWO7zSm
	CAuu9pKGYTF1pmKVEOwNi9pnpymuoY2Rx9Ah59FnUqk7KXXSAWRr
X-Google-Smtp-Source: AGHT+IFyFuSRuzwnUcwS1bRUyw1j0SNWnVqA7xmVALrE2loEcat8gqsLgrC+LtFOpuJIovK7gWGX3g==
X-Received: by 2002:a05:6000:b44:b0:341:8412:a6e9 with SMTP id dk4-20020a0560000b4400b003418412a6e9mr5364850wrb.0.1711011593208;
        Thu, 21 Mar 2024 01:59:53 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d410f000000b0033cf4e47496sm16602756wrp.51.2024.03.21.01.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 01:59:52 -0700 (PDT)
Message-ID: <8bea2b12-e043-4599-93ee-0874ed27f87c@grimberg.me>
Date: Thu, 21 Mar 2024 10:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/7] nvmet: debugfs support
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
References: <20240320144017.106283-1-hare@kernel.org>
 <eeba8428-e5d1-49ff-914c-cfdf7fd18750@grimberg.me>
 <a4ee4c4f-ac1e-4309-aacc-d25a14ad5091@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a4ee4c4f-ac1e-4309-aacc-d25a14ad5091@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_015956_791733_C0237408 
X-CRM114-Status: GOOD (  10.00  )
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



On 21/03/2024 8:55, Hannes Reinecke wrote:
> On 3/21/24 00:07, Sagi Grimberg wrote:
>>
>>
>> On 20/03/2024 16:40, Hannes Reinecke wrote:
>>> Hi all,
>>>
>>> taking up the original patchset for nvmet debugfs
>>> I've improved upon that submission by modifying
>>> the layout:
>>>
>>> /dev/kernel/debug/nvmet
>>>    <subsysnqn>
>>>      ctrl<cntlid>
>>>        port
>>>        state
>>>        hostnqn
>>>        kato
>>>        queue<qnum>
>>>          host_traddr
>>
>> Why is host_traddr per queue?
>
> Blame TCP. We're having one connection per queue, and as such the
> peer address is a per-queue thingie.
> And it really felt daft to look for queue 0 to get the peer address
> of the controller.
> Unless we declare TCP the odd man out, and store the peer address
> per controller. Certainly would make sense for FC and loop.

It will never be different, I say just take it from queue 0...

