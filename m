Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6A0C6FD1D
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZPqkkR/0p9ECKQLvZgUZJ1AhVrpZdZ7+Kiww1AvcICU=; b=BVsF7cnIhTPOQ2iwqBYYUg7+d6
	rzEcOt4KU4g6t0G6BKOqlTR1Xdx6hh8D/BLCNWjT4tQai+VVoEHHnWTPdzP1XJwzvjQUC4uePkgkc
	+NHWB0FeSHut8XX3v4J4BIrfQSiO+TCOyERIiPryejZDRh+MlvQwWB4pwHYSkqzElB45ccKWZweVL
	cS9kDS8mWtsCRFInkMHi+DYlPGDShHAF5C5aoEqESp5iDuurY0zR9sVsgYquVZlZrJR8ZImqkQqUv
	h4Wy4Ctm8C3Cd+Cw6ZnwRb7EbN1ftD0JRNf1HvjCvHpEeeBdkZ4zHuKxeby468qVhKwFuQs+pApx6
	RuzGp2dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peGdE-009LMj-29;
	Mon, 20 Mar 2023 14:37:04 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peGdC-009LLi-1w
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 14:37:03 +0000
Received: by mail-wr1-f54.google.com with SMTP id h17so10566879wrt.8
        for <linux-nvme@lists.infradead.org>; Mon, 20 Mar 2023 07:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323020; x=1681915020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPqkkR/0p9ECKQLvZgUZJ1AhVrpZdZ7+Kiww1AvcICU=;
        b=rOHUd2FkR5dVF/XpPNCg5986wvhNFRiZ+hGhGZFsAI+JgdzPwexh3CN5jsskRWI/py
         k46RhItJ4dppVRSm0leecB9lQQW4iDpN4xqSkVRCMq2R9hqyGvOQtXOfDY6Jrj2bCF8/
         wYDxxlXW+n1xOp+N6FJZWZK1jyqkfJJq39vbLjP71InsecRXikfTU1v4MSaVydgVE4Ta
         5TpMheX+7DqIvXO9s9dKe0e436i8qUGlQePcRlbef3Mf9KzHviO4eBzJ5Q0gjKDcaJED
         O5rUmSyE1X2zQVPN1YZIOnFEmQTnRNyIW2eWxX/JicjhfZ/+h4xKS/fEqco+48ffuHli
         Ycyw==
X-Gm-Message-State: AO0yUKWABKCNtuFct+f9ZHDBXVMCVzme1oCDaEXhbipojJHOS0a11Zu+
	WFv8WYZCzPixBBtmLBWXbnI7PZmVVgo=
X-Google-Smtp-Source: AK7set9EAWBM8MyMQOX9zx1PrKrDe5R8Ac+PCH73Vq78AUU4wR3RuUL2q+JoRH2qYnDEdy7j5MSdEw==
X-Received: by 2002:adf:f98b:0:b0:2c7:8a6f:5568 with SMTP id f11-20020adff98b000000b002c78a6f5568mr9437725wrr.3.1679323019890;
        Mon, 20 Mar 2023 07:36:59 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b002c55521903bsm9016622wrt.51.2023.03.20.07.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 07:36:59 -0700 (PDT)
Message-ID: <b8db776f-abf2-7c50-2b73-02fb30fed008@grimberg.me>
Date: Mon, 20 Mar 2023 16:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp poll queue crash
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20230320141912.avtauwpy5t4x2rvz@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230320141912.avtauwpy5t4x2rvz@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_073702_650550_09B5DB1F 
X-CRM114-Status: GOOD (  12.95  )
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


> While I am working on the unification of the ctrl state machine I run into
> the crash below. It gets triggered as soon a poll queue is involved in the
> setup, e.g
> 
>    nvme connect-all -P 2
> 
> An older downstream kernel works fine, thus I looked what has changed between
> the older version and current upstream in this area. One commit which
> caught my eye is
> 
>    3e08773c3841 ("block: switch polling to be bio based")
> 
> and a bisect test also points to this commit.
> 
> Not really sure what's wrong yet.

This was reported and is discussed in thread:
nvme-tcp: kernel NULL pointer dereference, address: 0000000000000034

