Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAE4D3C92D
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 23:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2FtgMoDRWubDYCabrPCOBe7ElnYbRzuGB0FImXpXzcI=; b=kf1sRSjHkH6Mv6mz1kF2YtVS9S
	5NiSiQMX/tlc+K1NircmtOZDLEt1vyl79FN4e9DwL1hd3DhQcoq4MkSiL7ZR2FUVcAWeCxEwGYxzu
	dwyx1FArk/5O3FI9z4DfHLNAiE/csJ5qDe6GUb/zwzQcJIqCGsJnIueQ6tnMKzs7vo5dkHvHClyAv
	1P63yS8sW6xg9goMyiPGjmxQn30WuiEzubucHW5qdzMjkC7whKEv/j/FXNrPUmdIBjHEOtywrx6uQ
	buOu9BSw6vLTUtz6UVS04OC4c9kc/SluOG3FkoABexuuuBLwSfiOX12lITGk8G/hhhjvatLZXt3wJ
	n4P2R66w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fUA-00000005dES-0AK4;
	Sun, 20 Oct 2024 23:37:22 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fU8-00000005dE0-0Cm5
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 23:37:21 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso32787085e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 16:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729467438; x=1730072238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FtgMoDRWubDYCabrPCOBe7ElnYbRzuGB0FImXpXzcI=;
        b=c/xGCL6lsDFD/Ed+P0h7pJsL8ETL3Mf2j5OPYGx3D6h0M+mj+O4MYGsffGeHm+DI9a
         F5uvz3a5haXo2T7qcugFUA1a5/sz3qP1SPgqO85JLPtmEwVJolcKNx3nPt9xW/EXv4zb
         GdZlIQZUcSBeXG/iQO652CdF9pvbHCAm8sG729oSTv2mOyBI68oJnGCoi6oeimvoedtS
         wW8punB1CbStir7ZDf5xk2Gnw3jon8irHjR+Pe70/WVriZfmxLhAbQvn9vgU2u648gMv
         hbs+ISVGet+RA0/EeDo3Rd1gQohNAYgOI+kTBzJfKyMfbZ395tZ17qhqeCxm/CU9MYu6
         qJAw==
X-Forwarded-Encrypted: i=1; AJvYcCUt09cNhcEDZlCm3v7WWbQPzkEWjlYUum/3hP+qfKqnGUTHkPw5nCE8A2BQdwPZeWwxXDNR25C0pih5@lists.infradead.org
X-Gm-Message-State: AOJu0YykGU1FgG9bU7q/TInCnkEnpbwCz6b6vx2V2UjPqwWAczuKoA0M
	xTWlfFmstLDZgnyXQlMR9Zt6uJu1FginIQtWNGlvTSFjix85KNIFNOx2bw==
X-Google-Smtp-Source: AGHT+IGKOM8eA/p466mqcgfWTIKu+bSG4+C/XU5rJTfrr3LlEitOS5D29jSAdThPEem6uu0u0PJDJw==
X-Received: by 2002:a05:600c:1c03:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-43161686943mr92703695e9.22.1729467437985;
        Sun, 20 Oct 2024 16:37:17 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc53fsm37595535e9.47.2024.10.20.16.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 16:37:17 -0700 (PDT)
Message-ID: <593c5efb-b433-4b2d-ac00-193aaf19d244@grimberg.me>
Date: Mon, 21 Oct 2024 02:37:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on stuck
 partition scan
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org> <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
 <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de> <ZwWY8d3vOLUaYaJ6@kbusch-mbp>
 <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de> <Zwa-MBS6wn_dGxge@kbusch-mbp>
 <b7ffdbbb-0b4e-4215-bf2b-b5c2f9a2dc08@suse.de> <Zw59LxZ3cngO17_f@kbusch-mbp>
 <4478f837-b504-44dd-8f5b-facab6aa8161@suse.de> <Zw6F5LN6YuVVqFux@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Zw6F5LN6YuVVqFux@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_163720_123467_4535FF79 
X-CRM114-Status: GOOD (  12.16  )
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




On 15/10/2024 18:10, Keith Busch wrote:
> On Tue, Oct 15, 2024 at 04:56:08PM +0200, Hannes Reinecke wrote:
>> On 10/15/24 16:33, Keith Busch wrote:
>>> Is that actually happening for you? I don't think it's supposed to
>>> happen because mpath_shutdwon_disk only happens if the head is detached
>>> from the subsystem, so no other thread should be able to possibly
>>> attempt to access that head's disk for a different controller path. That
>>> new controller should have to allocate an entirely new head.
>> Na, forget it. Not only doesn't it happen, but we need the
>> 'test_and_set_bit()' at the start otherwise we can't abort I/O.
>> So all's fine with your patch, and it even survives my testcase.
>>
>> (The first to do so even after several runs, I might add :-)
>>
>> Care to send an official patch?
> Should be in your mailbox. Here's the link:
>
>    https://lore.kernel.org/linux-nvme/20241015143136.810779-1-kbusch@meta.com/T/#u

I'm glad we didn't take the original version of this patch :)

