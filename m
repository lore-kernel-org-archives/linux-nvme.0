Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E66D5AE41
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Dec 2025 13:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oH2DaigrJ5QccAptSD0Ix7orh+WP2w20J8Xmm8iltxA=; b=EpV1xIK/+NKY2fs0DoRgTaWdu5
	epG3cWW3SwgoSOpuZC5oribibPr67aT49LLYedkJiAk0oR4XA1Z50rrBqhQG7UcC9aVRPiSG/LtQd
	liqm28uqfWqicXMQUixw4C57B2inhQmOlwgR1YZVd8Mnb54uSGuM1ZHXpH8Hu2/tXSM4qQ0hESfAD
	pInfROEICEuzGNBUND1I9KDuA75RvwEgEOwGKq+GdFbQzVPAELYnQtFAlHPXoP0x9GIzm5xoyFvzr
	ZjszVz/mHS3AO48JwZjyGeFM7YWTpJN8QcWUSsAyHE6Wfn9+m42p4GFYk7Yrz7fQWEAYI4ky7Rf3C
	IKm9/Z6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUPRO-00000001fLC-3WlH;
	Sat, 13 Dec 2025 13:13:42 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUPRI-00000001fKp-2m6z
	for linux-nvme@lists.infradead.org;
	Sat, 13 Dec 2025 13:13:41 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso9432695e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 13 Dec 2025 05:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765631614; x=1766236414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oH2DaigrJ5QccAptSD0Ix7orh+WP2w20J8Xmm8iltxA=;
        b=lxzKZpZt/wZZDr/jUv2JT5s58aTwuh3IgNbfuadA+nEf0Kk7AX/uwwR9/zHJnioqrF
         IVQcD3mtSs4ifQgXFKQEMtTOzsUDoiwf0JPA54IHg0UR7aBhOcNNZDSYOmoin/GDQe7G
         sq0tKtBs1fQHsK3hbbaMvAZGIhfnlCjSmCSWbVuh8TAB9HDnHDrOBkfHfCHUHIUexmp2
         sGSOPquF7rEFOujpz1STfVATd6zt9Rw7Uv4aYxvk0unh2gupnJWGDXCI23Q0PsSZnzkc
         mqs8T194+xWrMa7Hf4jCuY/8mzhiV3b3NAAj6AyDDvFnyuR2hkmIpSyOXvKq4mFwivkJ
         NhLg==
X-Forwarded-Encrypted: i=1; AJvYcCU6RwCzpaWDPIkS3Z1WIJ68Wdn7tU/CpyrYypfcbSNdw7Vr92HfLuDa5foeLPdWOHXej/oTLrgleNd1@lists.infradead.org
X-Gm-Message-State: AOJu0YyzlsIYi8lBArfGw9Oap3JsqxOHUD7Cl7pI/dZEZPLJd3qDLWpx
	/0kZqlOGr1IvQTijiD4yNxfEMWPEb1WSJTJeNg9hi+fzbg36k7tMEy4rJVpLcG1D
X-Gm-Gg: AY/fxX4YZuVlfQuGs1QvYsZHkhifj/2LhckBfquFRWVU8xiniFEMPyAaZGWYdOpmzdg
	/9v3RxoFpQgh6sEBPKgwGz28V1EemNfNh4N2nKcfX7WWUhhjOq+zbu7Wpatj4tOhYth7R4HceLc
	ospghS8URe91gIKsI+K4sd8kwrQ5OYZ1OoZ0ITND+gBTydu8A+1bM25NS8U0VTcx/cVnE4v1U0C
	AFb2zZa7Y3V0uumj8+IQQnR/qdd98vmD8crHmIk08dOMFXohgYjskvWAdD4TdCJNLZGlvReSc9P
	x9NnMOYL4JWd55GBPz3Yy4Y6zTvNW1w6/hAy7C2kmCBjIg8UgzeB1jSDmN7dcgir93v3at451rh
	bXLiGgL4fu4MTCdLv+Y0+aSA7uojlS1e7ygVrGmvxh6MyAs52XJXgvmk38V+kmqv9VDCUGTc64B
	zu0Mn5uicr7mI+8DljUIrtTytqe1G7ufVTGoBJYSH6TM+FeA==
X-Google-Smtp-Source: AGHT+IFSjZu6k+P3f+72PauXNrI7/vfyttxIsL5iR/J3kWafI93KM9oKUh11B1NKLEg9R4gHE+/QRQ==
X-Received: by 2002:a05:600c:c490:b0:477:9650:3175 with SMTP id 5b1f17b1804b1-47a9877c6f1mr3578745e9.0.1765631614129;
        Sat, 13 Dec 2025 05:13:34 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f39ed88sm84156785e9.4.2025.12.13.05.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Dec 2025 05:13:33 -0800 (PST)
Message-ID: <a58d2bb6-8b82-4b4f-97a9-893a3d2b921c@grimberg.me>
Date: Sat, 13 Dec 2025 15:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: fix NULL pointer dereferences in
 nvmet_tcp_build_pdu_iovec
To: Shivam <kumar.shivam43666@gmail.com>, linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, kch@nvidia.com, hch@lst.de, kbusch@kernel.org,
 gregkh@linuxfoundation.org, Shivam <skumar47@syr.edu>
References: <d5fbb80b-ed25-476c-a53a-2d9ce98a58ff@kernel.dk>
 <20251212210850.1025123-1-kumar.shivam43666@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251212210850.1025123-1-kumar.shivam43666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251213_051336_726534_F68ACB73 
X-CRM114-Status: UNSURE (   9.67  )
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



On 12/12/2025 23:08, Shivam wrote:
> From: Shivam <skumar47@syr.edu>
>
> The CVE-2023-6356 patch

Can you provide the commit hash here?

>   added ttag bounds checking and data_offset
> validation in nvmet_tcp_handle_h2c_data_pdu(), but it did not validate
> whether the command's data structures (cmd->req.sg and cmd->iov) have
> been properly initialized before processing H2C_DATA PDUs.
>
> The nvmet_tcp_build_pdu_iovec() function dereferences these pointers
> without NULL checks. This can be triggered by sending an H2C_DATA PDU
> immediately after the ICREQ/ICRESP handshake, before sending a CONNECT
> command or NVMe write command.
>
> Attack vectors that trigger NULL pointer dereferences:
> 1. H2C_DATA PDU sent before CONNECT → both pointers NULL
> 2. H2C_DATA PDU for READ command → cmd->req.sg allocated, cmd->iov NULL
> 3. H2C_DATA PDU for uninitialized command slot → both pointers NULL
>
> The fix validates both cmd->req.sg and cmd->iov before calling
> nvmet_tcp_build_pdu_iovec(). Both checks are required because:
> - Uninitialized commands: both NULL
> - READ commands: cmd->req.sg allocated, cmd->iov NULL
> - WRITE commands: both allocated

Needs a Fixes tag.

Other than that, you can add my:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
on your v3.

