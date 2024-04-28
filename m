Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E53C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Apr 2024 09:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fiKNDgQsfHZbm+O/UaLu7MdhwiG+0tZh6lGdIYblQQg=; b=5GdueAnikJQkO166ZGWkqvdk5h
	2ldPSJixQIUyFBTcFBojPhZJh0YmU3DUuXLuUuEQgMzUuOgdBvK/XAU1fIgkqC1TDriWZB1ca06Ff
	A+LWFOO6JtkhdJCXQoOexdNXlRmg+panfOTww6Z9MwtFNzTN1z/XNBOHSJxmEVuIeGvPc44ul+5bu
	cqvH735BL4l2RdqKjNxx4U09pWvZqxQ4TQNZU61W6jlZQSt3xTxx7Vq02/X011XJlgfyBtro6eGIV
	L+3kkELHu2rv4jPLEIRy9ofjYmBwc7f/sck3oIooAlMwxbsfSgJ29bnVF5JhM6lJ+Y2aD6Uc9ICKu
	s2tyLnag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s10ru-0000000HG3A-1BI4;
	Sun, 28 Apr 2024 09:30:46 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s10rr-0000000HG27-03mJ
	for linux-nvme@lists.infradead.org;
	Sun, 28 Apr 2024 09:30:44 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4188cba8599so78585e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 28 Apr 2024 02:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714296632; x=1714901432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiKNDgQsfHZbm+O/UaLu7MdhwiG+0tZh6lGdIYblQQg=;
        b=j+lxD7zFVF9ae/I+Sx1vh05el9DsbIunONzHXOitB0nlgr6MmeKzn391GuMk0BomOm
         MqlkESytyTC+VqGOWg/Q7Ab28xJ1hAnKFl0Gd1zbgK6LInXPw75zA8ERmNCa29zb87QG
         gKUrPVUcUdHvskv3Rsjk5SZX+t2SOlsrsI14weQ45RuEJgfjgCGwU4R/8KBQjqbSpGMi
         bnCb1Dfbpx7GwvaCzXFpRP81pmYeTSoVyO+ib52im8t+7efYogZoBs3XlTztmj+8lgP0
         OziBZtW+xsjfcFhWBiKOPlu5TPcYgN9HyF98yOg+sXLU5/yITGopPXO9/bGDbXK4QSIn
         hadQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCZeaa9/5z7WXKJM+BytkJ0G/OZoDXAxphCpCBKq6/3iJPt/dxib6dou26AUN3D6EoiN+wIYNRzHUl7y3CbkAKtd5SiWSgQLoJxIpU9rk=
X-Gm-Message-State: AOJu0YyrbeiFiA8Ue0o8PwnSQOpKCYIa7nnOvLQDST4Zd42IoqGOcRON
	R8WcNjY4tgegbWnVPDb5bKtu7F1liy13PC1qgJRopWJui8gKnuRu
X-Google-Smtp-Source: AGHT+IGUUB4NZod29j0kMAukLhnu1vGK5/0QbtkzyfX+BfXcXARP3X/rtYYP16Z/G6kmP2SlXRbtoQ==
X-Received: by 2002:a05:600c:3b04:b0:41a:3150:cc83 with SMTP id m4-20020a05600c3b0400b0041a3150cc83mr5327499wms.2.1714296632291;
        Sun, 28 Apr 2024 02:30:32 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id k29-20020a05600c1c9d00b00418948a5eb0sm41394558wms.32.2024.04.28.02.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 02:30:31 -0700 (PDT)
Message-ID: <d206c1d0-5935-476e-be19-9bec537af1b8@grimberg.me>
Date: Sun, 28 Apr 2024 12:30:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] nvme connect deadlock in allocating tag
To: Wangbing Kuang <wangbing.kuang@shopee.com>
Cc: james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 chunguang.xu@shopee.com
References: <20240428063147.88058-1-wangbing.kuang@shopee.com>
 <d200fc7c-c781-49f1-8277-bdb5d537b1f4@grimberg.me>
 <CAG89T6Yyx4f6Dt__L=Ku4AwCzuEUhEOOEjuXbdE+GSSqVJVZ-g@mail.gmail.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAG89T6Yyx4f6Dt__L=Ku4AwCzuEUhEOOEjuXbdE+GSSqVJVZ-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_023043_096072_09461339 
X-CRM114-Status: GOOD (  14.18  )
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



On 28/04/2024 12:16, Wangbing Kuang wrote:
> "The error_recovery work should unquiesce the admin_q, which should fail
> fast all pending admin commands,
> so it is unclear to me how the connect process gets stuck."
> I think the reason is: the command can be unquiesce but the tag cannot be
> return until command success.

The error recovery also cancels all pending requests. See 
nvme_cancel_admin_tagset

>
> "What is step (2) - make nvme io timeout to recover the connection?"
> I use spdk-nvmf-target for backend.  It is easy to set read/write
> nvmf-target io  hang and unhang.  So I just set the io hang for over 30
> seconds, then trigger linux-nvmf-host trigger io timeout event. then io
> timeout will trigger connection recover.
> by the way, I use multipath=0

Interesting, does this happen with multipath=Y ?
I didn't expect people to be using multipath=0 for fabrics in the past few
years.

>
> "Is this reproducing with upstream nvme? or is this some distro kernel
> where this happens?"
> it is reproduced in a kernel based from v5.15, but I think this is common
> error.

It would be beneficial to verify this.

