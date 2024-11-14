Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D9BD6A224
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6tJciY/qlJ5DcmAqQB8Ft+2wvxquf7I5e+jIdyLuXSw=; b=zEifVyDSaLP1+SXvoswyc2FGiU
	MCkyDnEoeV/0Pp8hqq2Ie/Ur8WrqbZilyVdI6fojXu59XgYq4erx7MW5ZQYGe9zTo0usu9pOaFgH5
	4IusBD02MaVtSkjcHTnnuLG7yEZoBO2I9xkvb13LMCe/SF0oDZ/gmSi6j8A2JprWoyZOFYDyseEO4
	vcUmeL+ccDw3/crynfUoaIwKUfZKJguVVY2/XksYG5bsm3W6Rsj0yciammcyS9yhRP+xbMJS8S7vT
	+Hd6M0XrosmBalX/SqyxQ2SVvPRC8+7mwal1qNdmdJRs5QBpCYYRDl80YEnJ6LsbiCShpVwj6nU+F
	wqEw3ywA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBeZo-00000000Tvx-2iZ0;
	Thu, 14 Nov 2024 18:28:20 +0000
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBeZl-00000000TvL-3aNf
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 18:28:18 +0000
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5eb67d926c4so412886eaf.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2024 10:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731608896; x=1732213696; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tJciY/qlJ5DcmAqQB8Ft+2wvxquf7I5e+jIdyLuXSw=;
        b=NUhnd8seIYAgi5bBd8Ri3+yiSSznm1iPfEos3mA3V1e6iab69uRL2HRbdPnjPDl0c8
         p7UDJI6Yu1Tnqv2mXhbx/VZXcI8Z/7Z/R/geVFv1Xhld5mWdIpDXjmxBLzDE0j7+bDxv
         lcaZYTkI5lwwb3k7dNmJx7z2XD7MZRzRH+X2K25PhuVtHhfwu0KaQTMW4b83Gs+5NSRl
         O75VmEtz8V8S5wz08C8KNVnjmm8u71YEjdR0SJbCnRbJ3ioRAJKA70hEefgjo6EsLHUv
         aui2lG6gcHG3qznzRKWaT/135IPDMd96rI0yGarSNI/zryNX1ATJ0lo11PRiztaUsAVf
         DO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731608896; x=1732213696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tJciY/qlJ5DcmAqQB8Ft+2wvxquf7I5e+jIdyLuXSw=;
        b=Sg3DBUZQgxpifYANfeYXPoOLOD7+qHrTB+AV3oryN/5+IK0e31DKG9LdOZFDRtAVMy
         Qosc49q/i4lQUAOwibIhZXypopLz+S4BBLWAwBwS6bTLT5hHUDL2MmbbNlvVv+P4g+l7
         rwCHMp9uEP4247U/tjrBJSNAUtI45A1zygLaySVfk2qsH/YkeWXq39Izq8H4+9UCLTHY
         gNkAdDPjcmaPTbAsvgbYfoP88TL46a6MoKobUIUzJRZxvtOlQIo3tecJ6q9n08TOjVFl
         YbU+Lo3wpQA+zx+ZReAeSWudgUZvrDNrzRwuEECHUkhJNYQr6GY6kQ0VHJIWy3ZoybBD
         Swng==
X-Forwarded-Encrypted: i=1; AJvYcCVoqi3PPxzfIUSahiiXzU8QEvSUK0REnRfO8Vwaa7GEt+YtcGSJWItpiIrroaSxBrElBHHXfOZoZHm8@lists.infradead.org
X-Gm-Message-State: AOJu0YyUIaKC5zT7bPHiPVOZwJ6s4OfiQldGXWcIm/7Q/kokmrKTKUbe
	P2RuqIT9WH7RcTgrZRJ/5wPteP6xSxcGfMTGDUQuQKJ/Qxfs9bDEgzrccAjS+qXXn3r05kYuh55
	ZUYc=
X-Google-Smtp-Source: AGHT+IGCQFLlx5+rFZspn8zRLqKAeXi3V6SUMR7eTmiYksCkEyeGs7KKwZ9YCDU51i4R1OWLPcz0Uw==
X-Received: by 2002:a4a:c207:0:b0:5eb:5eff:afbb with SMTP id 006d021491bc7-5ee9c84ba08mr2754217eaf.1.1731608896436;
        Thu, 14 Nov 2024 10:28:16 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a6ea91b24sm588458a34.5.2024.11.14.10.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:28:15 -0800 (PST)
Message-ID: <058d94f1-da1d-49d4-aeb9-10fda3069c99@kernel.dk>
Date: Thu, 14 Nov 2024 11:28:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fix for Linux 6.12
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <ZzY_Q785-p12Bl14@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzY_Q785-p12Bl14@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_102817_896535_03D87DC8 
X-CRM114-Status: UNSURE (   9.27  )
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

On 11/14/24 11:19 AM, Keith Busch wrote:
> Same fix as the last week's nvme fix, but for nvme-multipath. It should
> have been included with our previous pull-request, but I did see the
> message in my queue until too late.

Just to avoid yet another merge conflict, can we please just push this
to 6.13 instead and just mark it stable? We probably should've done that
with the other one as well, it's not like they are important fixes.

-- 
Jens Axboe

