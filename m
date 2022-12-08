Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42865C3A5A7
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Dec 2022 10:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GlwkP5/yaGxdm1ZxtVt1NNx3z+SkQchm9MoOng/Zc68=; b=aV34rq8lX6UcgHs+qj3LeLdd6R
	Q7ftepEAnxRwKhylWTyROQMNdxmcFeUWyK+J94Ym4cPr/f7sC7Fy0d5Xw9mNZJmKD4LwRUTlaSo1R
	xEUP9oh+W1Vad0OGGWoHaSQhkkXGd6jYIeOg/EMGYQFEEZRqX/sWFbSQTJZBfUwDAbLYtra9jCAsB
	i6LZ5Mh1OUYLuV7nFqubuS8pYipX9AnS4VhuQsiQ4Lw1QpQyquDfzAkdH2Vvv4AEhj5o4t8EaKD/+
	goPZaejOABzG/XSYdhUZXMuNCUUZ1NMNpWHpfLIZGGZyNOI7QTJaKTNGXzGElgdOYsLKomXNmNXuw
	I0SOXsdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3EIL-00Cj5L-JJ; Thu, 08 Dec 2022 10:38:25 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3EFv-00CgaH-UW
	for linux-nvme@lists.infradead.org; Thu, 08 Dec 2022 10:35:59 +0000
Received: by mail-wr1-f50.google.com with SMTP id f18so1095083wrj.5
        for <linux-nvme@lists.infradead.org>; Thu, 08 Dec 2022 02:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlwkP5/yaGxdm1ZxtVt1NNx3z+SkQchm9MoOng/Zc68=;
        b=hZDDnyhT5Xc4VakD+qdXsJE/IvwciMDZZIaQUnAwGIirTP4X9Q+k0axrwwZ6gLr0Dr
         w7j1GUeMw+aaXv8Y1dyZVZqjIgj5f8ZVHDXDdKqLjiMFvnn5tDl8UQsxK4dtmR9jFES6
         zULuytXn+iGQZnWzyJnc3M29YmbrrfpF8CK+C4dxZAUobrFxHpAT6kOQ/K4q7c330p6D
         V8HLAFH8fj+Ywy4N666Z7i7D4ME3x7+nUyvAb+YDxAMkYzDHAoMlBYw1qLAiAW3NTR+O
         Sv0KaS91tcZjb/s5BMFt16sxHmQ7/tSi95UYCvqQqmDn/3t8p+dAJzMtPE7+ndmTHeFI
         wkUg==
X-Gm-Message-State: ANoB5plifXAHWnOJU+buvCo+JDf3zfwxUk+uXOTCTyxsa7lseChWD9ub
	gUhtXFgXHxh1DRn+QXGPNTXaf1uYQZ4=
X-Google-Smtp-Source: AA0mqf4ucVhsrdw/rfZBvlqKZo70NCeGAljWz0R/pKDIpRV8v/tRbWd+/UEq3JOEGDI7hRLdTf5MsQ==
X-Received: by 2002:adf:dd92:0:b0:242:4b69:5f8a with SMTP id x18-20020adfdd92000000b002424b695f8amr1124706wrl.14.1670495751063;
        Thu, 08 Dec 2022 02:35:51 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b002366553eca7sm10005555wrt.83.2022.12.08.02.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:35:50 -0800 (PST)
Message-ID: <22709590-05f5-c98f-03f3-b5a5f840d03a@grimberg.me>
Date: Thu, 8 Dec 2022 12:35:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme-fabrics: clarify AUTHREQ result handling
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Mark Lehrer <mark.lehrer@wdc.com>
References: <20221208074920.43828-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221208074920.43828-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221208_023558_423737_AFC1A8E9 
X-CRM114-Status: UNSURE (   9.84  )
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


> The NVMe 2.0 spec defines the ATR and ASCR bits in the AUTHREQ
> connect response field to be mutually exclusive. So to clarify the
> handling here switch the AUTHREQ handling to use the bit definitions
> and check for both bits.
> And while we're at it, add a message to the user that secure
> concatenation is not supported (yet).
> 
> Suggested-by: Mark Lehrer <mark.lehrer@wdc.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

