Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D102C2D0CD
	for <linux-nvme@archiver.kernel.org>; Sat, 17 May 2025 09:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L1xybqkdxpFEj1EI8QA+pvcqPiyMXAo9agsU9POzFbs=; b=4MQqKL0eaFt0DszZTwDIQ9KuZn
	usunNbl1HdhN1t9SPt3msIahu3DJxbkVPM4EYcnm9TRhM5/Kh8kF6YkJzCQWu2oSHHIYGnxsGgX1H
	QU8KBFE0SmHg7NxHv362FoU5R16opBANLuVm9IQewzth6nT3xp6tB4EC40OlkLpr2j0H5koF5amuL
	RuVUUkxqG/Pyb94cHk3OwfEmthg8MisxdhvfAR/Zw4vNycImQqtpmltob1MzIp8McGeeEP46W3on/
	Jpx/vUX2ZRsiUuZ9WDG6eL85KXu4n0kECZgt2zLdXbbR3u0soIGqVCoQwPp1xsh820n0fBXT+Ba8j
	yXKePALw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGEJV-00000005VH3-3iU0;
	Sat, 17 May 2025 09:58:41 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGEJT-00000005VGR-0nDG
	for linux-nvme@lists.infradead.org;
	Sat, 17 May 2025 09:58:40 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-440685d6afcso30085215e9.0
        for <linux-nvme@lists.infradead.org>; Sat, 17 May 2025 02:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747475917; x=1748080717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1xybqkdxpFEj1EI8QA+pvcqPiyMXAo9agsU9POzFbs=;
        b=so9nVkaR/nVM5YTH0WL/p4eQPE4x3iba/sHzSsPR99OlrFpNgThBE/IewxabTLRP0W
         M4QTEH23z4jwzG4gX85D8Hrc/8EV3agIR9fIwYCaRNHT08uFAVjslmb5kYHEm9eG13zV
         fzKpbFlzc7yw6wPY8TVzJur/PsZcO/iAr/mVWPIs8Nnkd4MTf49scxfCLeGl0PR/5gye
         hpJhK7d1WYw0ANc8aUp3+w3wW8hjlKeD9m6Lw+D6IdLmWEAh6iyr3tNJCf5WGHLoPrqd
         QWG6OXNtTYeUCtuB0JBe0ZNfpkFhTj1CdkMHj3QThDvVdZ1neO0s7ALDX1pVE1/4UsGr
         XmcA==
X-Gm-Message-State: AOJu0Yy2fcA5xHuOEJqdoZtl+DEi2zvnIjw99TxS3zMKpW8LxfreQOik
	6KiOIfMyJ0QcQHuV6dbmXyFZcAKwRGs9EwPmK2tHotaJAx+3GizUkI4M
X-Gm-Gg: ASbGncuPJGmABGMCilixG0r4z6Wd1qXQKQnwMQVoheZhVBSELEnLNSn8QZov6RZaVyE
	OO37KSATsXHhp9/r4vRv9lIbb1+7cl2Ah9vkMPLEAv6ykbybGDBmwzsPK/LlEIbtENN5anyJsbA
	jiBuWKYJ5p+sFQtxIV25GnjVKnvC5em1w6ACgBvGMsapNxT0kFPJG7fDahptnvZxk8On7Sx7ShE
	1GMSoSnmrZQWZ/BkEvtOQCsU+qVQcydwm2v28ILU2bDPKfaLSDOqT2KzVIkVBJA+UIFzypWwVWd
	x629QmZeCrm8MXasl4toeIvOEm7SxQ87cckliOnKQDTMTwb76jE6nmHhRIdnBlaBVVA+vfHJeFM
	a50KY9eXI
X-Google-Smtp-Source: AGHT+IEL1yy1dVgbHcGpQ/e6QxEBlTdRtwZtph6z/27chlWDRnOkl9UnAko5e06/JsZwHle1RrNcjQ==
X-Received: by 2002:a05:600c:1d82:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-442ff03bd03mr53445255e9.29.1747475916740;
        Sat, 17 May 2025 02:58:36 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd50b983sm63604445e9.11.2025.05.17.02.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 02:58:36 -0700 (PDT)
Message-ID: <8b4db290-00c0-4627-a03e-d39a22c56fcf@grimberg.me>
Date: Sat, 17 May 2025 12:58:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250511004110.145171-10-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250517_025839_236467_1250EC37 
X-CRM114-Status: UNSURE (   6.48  )
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

>   #include "nvme.h"
>   #include "fabrics.h"
> @@ -166,12 +166,12 @@ struct nvme_tcp_queue {
>   	bool			rd_enabled;
>   
>   	bool			hdr_digest;
>   	bool			data_digest;
>   	bool			tls_enabled;
> -	struct ahash_request	*rcv_hash;
> -	struct ahash_request	*snd_hash;
> +	u32			rcv_crc;
> +	u32			snd_crc;

Let's call it rcv_dgst (recv digest) and snd_dgst (send digest).
Other than that, looks good to me.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

