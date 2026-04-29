Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C72FF8867
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RvPkfVfPG4M+y2yexP1+g39DrvEJlO3S2GHq5Udlkug=; b=VmzEgFksEI5/mfUuS6PGjQhSXo
	ebTsgBU9xeFs2oKX66TqK4KaupFtFd2FGkAzuWW8AFDyrSxKUNmThwiLDpGPoa85/ZzHeZ7cyrEYF
	4YuK/17j9xLpgmsb+veCFKNMijK+lbrARpBJjbJd+hCi3Ch7uRjgYeHPstefd4Zo06DAAYHuXsjZo
	mvxHJX0HpSlx4kz0SB8QJk/VIXUvyjgGc4x62buXgP96a+mNDGeiN/uh3dW4iWL9y/U+x+39RnETj
	uF7Xi2bwVpgSXvmaWgTPsTR7xjxvqtlDE7sHgivgvXhwDEZi38BUk8QMy8Tfn19Os03hdwb15G0OB
	Vd8agd0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI4Lk-00000003av6-441C;
	Wed, 29 Apr 2026 12:49:08 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI4Li-00000003auZ-0s9t
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 12:49:07 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so434698a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 05:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777466945; x=1778071745; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RvPkfVfPG4M+y2yexP1+g39DrvEJlO3S2GHq5Udlkug=;
        b=UYS3huJ6ArpFnm4elqnbQTWhlZ+x3sQ3W3p8Tz26C06q5cJ3gPTxqBZtou3MnxLjlj
         7tlO7VZjHKpdkOwBzm8offYeLUuvx4m806qlHpTe4+j3G9H6bV0xWp1j+8Zq4jqCvGPF
         YTVTW30NmfNn39aE3HxDKVGUxfHVrYWG2YVIcfN1JMZqbgmQDZEoQegnHLOODLpNO4jv
         X8/ZY4p96SzphgXK6O4WuIJudUBeiJq12CNvqdJjIZXSs1PqXcZVOMzFdU/aqcDKwE9p
         tQACIwMq234GKSNuJ9v5Ki1jwkqQpJlJP/Bj0+82Hb+XurtmeXTwWH8ltOiNzXMNMuY6
         R5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466945; x=1778071745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvPkfVfPG4M+y2yexP1+g39DrvEJlO3S2GHq5Udlkug=;
        b=XIn1N+KW8nwiVtkNboUjZSabwtdYCznH+EgXkXtTlnKr9KIPdpfptpuipoLiGQxrjT
         pKSJUMb3CQPp04P6NHiw1qpE0o9Ybs2Hz5rwpP6eqijuM5bthpjVjHe8cgLxAI9c1Onh
         4cXLs983xqqnlm8DJYFM0STmPsRBxJGoOq+aacLlpqe7sPwpNfhUZszzIVOHzGo3A1nZ
         zvztU8NPlVQNLtCJ8keqHRb92gvwANbei6d6Y/jeWr7bL/hIlXHvkbcz4NrMMlCbI5v6
         uu0O3qMoL5yE0kmCV67MPzbT7dfg+vN+kPheoHSRpAlaTOQ7Fq/ayBXyWCk3BV5ue6Hd
         ClNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/N9qs8xt3AMnu01Zxajm+wR/Yibkqc6v6aTvvQvTv3MjK0i7v+JSVnXDFKP7Ir9T7nTc1I4sFNqcLN@lists.infradead.org
X-Gm-Message-State: AOJu0YySyFozYxX9OiCLhVF7ZoAtuaG1wYfpCdt1EXzF47KAlsQtH0FO
	XSqelowKENMm8Ap8GYpbKYK2+IDttKfUWHyXXKkO80ewAO63XPTpBz7H
X-Gm-Gg: AeBDieuj9Aihng1AYnAihNSKjDcONPP222XYM7XIQbr1AY5WNXtN6PKjXR22QlTwqel
	YUVXqr5x9dnp0v3uG4mh7gutZJmAA2ydGpk7xnImT/jh054+L6KgCf6VOU4BrY5ZJXL/XlA1T2n
	jloNNDdoVBOPGWkeJBzqYtXjhPv8p7O8ta8Jz3XTvCvieqqmyjAueRWns9qvDhyPtsS7Jk9EFkE
	87QMOhNlUjBIoM7GChm2APD4FZfE1n0c+6FnYaCy3acw0DPpv9iTdfASfd7JkEKMDbn6wFiTSd3
	fa5NQ+d0DjRtqZFOU+RVyw0NZh2P9vqY0hHnC+j7EN4MBNxU6gxrOnllRyurzU5dFGr/Kqu/J6E
	zAc5ZwIhDOlymhhhf0cNgw9+XklJ36Y4RWideQDdFin9W03SuouJevqPMMYGktNGt6KyfE6UUdK
	dfSyBud88ow04t9QKMleFS1aBMKNXp3dvB2cAKnRquOAIbmWlIS/+n7Tu6kTFC/8ynOxZzCT6c+
	oVg3wg=
X-Received: by 2002:a17:90b:3d0b:b0:35f:c156:a82e with SMTP id 98e67ed59e1d1-364a264440amr2483787a91.9.1777466945161;
        Wed, 29 Apr 2026 05:49:05 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:66d6:5480:f743:d754? ([240b:10:2720:5500:66d6:5480:f743:d754])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a2a4b65dsm906888a91.14.2026.04.29.05.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 05:49:04 -0700 (PDT)
Message-ID: <51b59525-c551-40e5-976c-4c5a7a1bc31f@gmail.com>
Date: Wed, 29 Apr 2026 21:49:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme: initialize known effects to set ns_mgmt NCC
 and ns_attach NIC
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
References: <20260425130426.10061-1-ikegami.t@gmail.com>
 <20260425130426.10061-3-ikegami.t@gmail.com>
 <afBY-0abdJwOfwxs@kbusch-mbp.client.m3-hotspots.de>
 <56500e42-51c6-4be9-aff1-f11b45c47b13@gmail.com>
 <afHF6FJAPbDXAniR@kbusch-mbp.client.m3-hotspots.de>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <afHF6FJAPbDXAniR@kbusch-mbp.client.m3-hotspots.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_054906_273465_296CFB39 
X-CRM114-Status: GOOD (  10.23  )
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

On 2026/04/29 17:48, Keith Busch wrote:
> Yes, but the namespace management commands are also optional, so it
> sounds weird to me for an implementation to choose to support the
> optional command that's more difficult to do and skip the easy log page
> that advertises support for it.
Okay understood as the changes not necessary.
> You can attach namespaces to controllers driven by a different host, so
> the AEN is the only way to trigger a rescan in such a scenario without
> admin intervention. An extra scan_work is otherwise harmless, I don't
> see a particular need to introduce a mechanism to avoid it.

Noted this also. Thank you.



