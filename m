Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97A5C02182
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2025 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LexUO0dyWqzj96LOm6jrGqzIF7oHbn6brxGr0knrWAQ=; b=bJxkcqKkPsst8XlDtO9WKNt8Pd
	nwK/V1Pp544uTEi/EwMmnPQpVdOBzjcKMhMks/y29fd/F19EJ2Da0wd2yvQgBZPocXZjfbs41SMuw
	ItqqKdZjs0V7vLnOhbqlQLKwa2ybxsgODux3QiyhfO5LTwDLqBfxL5t2bAb0362sD3TwFl5sQ6UqE
	Od2PkAk8qgNuAgRO2wvcPhI1VMm2qv4u55eSb1q29vm7zhWPJt20YfZVmUKigKt+gGriLauPqrtUO
	Znxxc3cwT/FcjQMeGIMKvKlsrL6GZJbu2dbQXhM35/IuF5dDCNjrmem6ipIt9VBTe2+yGAMPRf4Oi
	gQj8Isiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5gq-0000000DPFM-2nmL;
	Thu, 23 Jan 2025 22:28:44 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5go-0000000DPF1-1Ofs
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jan 2025 22:28:43 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43675b1155bso16377585e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jan 2025 14:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737671320; x=1738276120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LexUO0dyWqzj96LOm6jrGqzIF7oHbn6brxGr0knrWAQ=;
        b=fVIXHVlhlUm6NLtPjAiFA9ikLohq8dryn6Lj8PVPlxpE3WoP60wf7vJWcjyz9K95oX
         XDBNUXkSh2Gs0oAWZrtnXn+vyME9t9Bbu1IYQrrrujD7B5hCPcVsAIif5cdrhR3zuVc/
         dE3oRzHiP0Aq8GCj8G+DhvMOWS+lH2/HNGC9MS3o15xSN46zbf+i5bKZTs6E9fhczss2
         1wIx0s5sg+5DvcI+CgZFmFbzJjaqIcC7SfFmdwBzIeZezAlx4iqV3U9vag1+vf9egZ8I
         GJTOkRNubU1aRVpXVzDA1WVc82tua+3OxMLVfepLk14sDMQ+v50VUR15eAH52Cj/Na/9
         3Q4w==
X-Forwarded-Encrypted: i=1; AJvYcCXlpG0lLj3oSMJXHuKlMH2DpCBq9eB6JWKfjERfCPRG4rEs0KE+Uh8kI0kZ1OY5R2/IT+CzHJHV4VwE@lists.infradead.org
X-Gm-Message-State: AOJu0YzzPf+ObXMUvHZ2P9rIBKC96V4VAgpIsiTS8w0ucxvfDqNxl35O
	1JKl0r78IqayDSDYv5jJv2vLSaQiK6qpDq6Jc1CftytPNAAYielz
X-Gm-Gg: ASbGncsANkaS+xEVs+chjLuAIsUJh4p2h6HEciBZiLZ2/G9fmQJufkfAA2FRMj+ctTM
	+GWx+VPdkWBHagTCi5toSAH8XLNPzWJsHUR+gciid6jFQZhKgD5N2Py7R1MuNvs5XVBCDVHRHQk
	XMQfZ5xPZKt0TcIuJFa+JEGq5v2HXvoEjUagRnsFGRDr0whjYWkBcyMJtQF0RY6uMM3LuArTJ+e
	ZiCJ7xkiaL0wAeFTdR2uLC/przpI9EJZ9yuqprAMgpvspU9PhSEVG35FA/5l80TXdQBLGP8I8bS
	aJVAVseWGAre9VQpx4pm3E5SeB3IZYx2yUSacAr9
X-Google-Smtp-Source: AGHT+IHzNVnxb5zyWR1GG4wOjLxhvB0IE5xTTfs7/c+ZXxxy3IYIghzqLh0erKXL96CGH+KpvPXURw==
X-Received: by 2002:a05:600c:a45:b0:436:6460:e680 with SMTP id 5b1f17b1804b1-438913e0af8mr281352865e9.16.1737671320306;
        Thu, 23 Jan 2025 14:28:40 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4fa416sm5380695e9.6.2025.01.23.14.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 14:28:39 -0800 (PST)
Message-ID: <d34b5bdb-3e68-41e0-a5fd-4edada9db846@grimberg.me>
Date: Fri, 24 Jan 2025 00:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvmetcli: execute shell commands as arguments
To: Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, hare@suse.de
References: <20250121155932.1293912-1-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250121155932.1293912-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_142842_379078_E7D91B45 
X-CRM114-Status: GOOD (  11.54  )
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




On 21/01/2025 17:59, Maurizio Lombardi wrote:
> Hello,
>
> A few days ago I was trying to create a target with
> tens of subsystems and I found out that, AFACT, there
> is no straightforward way to do that with nvmetcli.
>
> It's iSCSI counterpart, targetcli, accepts shell commands
> as arguments and althought it's terribly slow, a similar
> feature for nvmetcli would allow the user to create simple
> scripts like the following one:
>
> nvmetcli ports/ create portid=1
> nvmetcli ports/1/ set addr adrfam=ipv4 traddr=10.8.2.212 trtype=tcp trsvcid=4420
>
> for i in $(seq 1 100); do
>      nvmetcli subsystems/ create nqn=test-nqn$i
>      nvmetcli subsystems/test-nqn$i/ set attr allow_any_host=1
>      nvmetcli subsystems/test-nqn$i/namespaces create nsid=1
>      nvmetcli subsystems/test-nqn$i/namespaces/1 set device path=/root/storage$i.img
>      nvmetcli ports/1/subsystems/ create test-nqn$i
>      nvmetcli subsystems/test-nqn$i/namespaces/1 enable
> done
>
> Should there be any interest, I can submit a formal patch.

Seems useful.

