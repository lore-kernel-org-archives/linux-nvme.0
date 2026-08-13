Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36742C5B572
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C3Tq/1YeW734kYz8TPkv+2sBOGdpmAh0MUZOVgryGXc=; b=YTCMZWsdPmGL+vpvtWhne27LWu
	Y5Fd++Z/HGw9l1IJEtdsaLPL0srwSX9uUlDbUfcFPKvbMCwcXhiw5/W27UaoEyi8bASEGnxolTz0D
	aG7xh4pBm6Hi4HvmGpKRVlxnLToapL4Xh9w9DPszihuxIMjxOsgAI+wCgGravKBEN1nJpT/3QBzoh
	OL/dB6PCcHMGl5VXprRH/6FUoI4M4jraXO2GTAiJwgLefp0kSngi5gQVYCMrY4exPzf/TuDp1HtTI
	qIyZPd0PymfQmF7LsePEgcAPWij1LsgMqGlBwWBEHPz1A1XXQK3reRl0dQy1eSfhY6YFoK99CTMy2
	KiNd4VEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuaIC-00000001ObM-1NUy;
	Thu, 13 Aug 2026 18:36:40 +0000
Received: from mail-oo2-x09.google.com ([2607:f8b0:4864:31::9])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuaI9-00000001OaO-1h3q
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 18:36:39 +0000
Received: by mail-oo2-x09.google.com with SMTP id 006d021491bc7-6acacbab39cso61033eaf.0
        for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2026 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786646194; x=1787250994; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C3Tq/1YeW734kYz8TPkv+2sBOGdpmAh0MUZOVgryGXc=;
        b=nZvwA9OgLfrvymXOnqRymfs52H8h/VmbVcLYoN2MDaR7gXuC4Mzt4JzolNNtv+QHZ6
         uVAxh9L/LY3v9v5641gBwM0fuOPQ0LjBy1sX72tcjNzifkczMHqLdUXpO9qNzsoPyBus
         dwmbvevaAx0afq4x9U0d78uBVAzbu4VxyEOuvswKYaCUxVMm3XTpMiGsJ1PKwLbwRiCf
         DCLbTGyebafVDyCjzNPqvxMJ5CTm3/3W7d+zU+A5LY801s0xMftXS3NzJwIxtIwPm/Zh
         rrE5ZD7KBhCE4q9m/l194lZYkNioZ+4ghSTw/wz7+5+36BBi80Vzq0/07oaHjd7lcavj
         3VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646194; x=1787250994;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C3Tq/1YeW734kYz8TPkv+2sBOGdpmAh0MUZOVgryGXc=;
        b=XugsO51Un9iiVcPQnjbQ4LH9m+BBa+nciniwmxmgpHmhvwhCwNQOb4J2j7vbxWLYzR
         VRKBWh5W8COIvNbswni9FwtmM4y6KMWLzasrFXFrksCsHRadW5sLOSl5OIhy71asR/Tz
         CG2CNbMhwSbYK0x138EsGzHQ1whMGxQHDyymMuMgo36sPVPd3GaT/HoF2/BAigipxvx4
         2a6K5KW/fSi1G0AKvUUmcekWJYt6rs4qcQdipHPtYPOzNLNfWBTPt3nos45MGo2bTym0
         OspiPpofGC1RfXKD0XrEK4riw9dt2cNuXS5ZCnYErOSUVp68fzDbRX6xyThQDcqXXjlT
         OnEA==
X-Gm-Message-State: AOJu0YxWjOVlmLI56rcqxxPd+UsBJ6+n7BY1Bc2JKXixKLfWEkNVeJa+
	sXFe1CT/CPRXdkG75a48oHKgVyEPSzSHS2PkFieJA5MzZ3stPjyFlJyvnHUDHvTZKsAxvVlVA99
	8eHiUQvaShzZY
X-Gm-Gg: AR+sD130HJS4oskaBo8iYvs6+3gL/Wf1h9EaUWMKuY8XLvjUAWmzUDYvpZ+pl9owkX/
	DJZAb0IDo7x+sLckcizE87LFGY7XedzMT0g0QWGWWKxgz/XDp8NgXhuWXX6QMackkSyxyJDXGM+
	6rZfrSJmfwHL+UeRGWm8vG2UOdwRlzD8/1rApHk+0Mvchu2F2zVTGm43DfsJAIO1RLndGQQHAIU
	E2Yr1deijskvoNfnBkmJVPo+B6EHou55OWGra4vD01KlRUZ7pZfvOc2KdwkBrEh4npCx5xTVVnq
	wAo7M4xMPc6cjFv2kcbuC+3h0pw2ur50jmFAnYQldE0scPKj49/Z3TcbaYTQdibdzd+IoRRYyKF
	vxA1XavIgdITIl76PVq0rBtTl6edlPTHoM2Dj8hG0cIHLe8EbAZZ298HfQ6sD41AKJjcN4LqlCN
	bRnfwsrx+PQdAwezoxXRQBEuecPTjoVrzzJtH+TX/XCggc38nluD/YzsGfVNA8ME+uc8TEIBYlb
	pmwKXEnk16NgyACzTbbpZcJV12fQMw9QmfMSBF45I8V/AEsfu1zMLDE
X-Received: by 2002:a05:6820:570e:20b0:6ae:9661:fcd1 with SMTP id 006d021491bc7-6b0d61bebcdmr390990eaf.16.1786646194600;
        Thu, 13 Aug 2026 11:36:34 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3c9ca7b0bsm2737447a34.15.2026.08.13.11.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 11:36:33 -0700 (PDT)
Message-ID: <c5f8232a-1e52-464d-93c6-f2c91a403f97@kernel.dk>
Date: Thu, 13 Aug 2026 12:36:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 7.3
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com
References: <an4C5I9K70UhVBpN@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <an4C5I9K70UhVBpN@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_113637_698873_99834D98 
X-CRM114-Status: UNSURE (   9.83  )
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

On 8/13/26 11:46 AM, Keith Busch wrote:
> The following changes since commit f01f5275feb77bac9fefbbf7cc584fe0b3850a92:
> 
>   ublk: snapshot batch commands before preparing I/O (2026-07-02 06:25:21 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.3-2026-08-13
> 
> for you to fetch changes up to f1a8846e06388113dfdbb89dee005083fa9afdf9:
> 
>   nvmet: fix max_qid race between configfs and controller allocation (2026-08-13 09:26:44 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 7.3

I think we deserve a better summary than that... What's in this PR?

-- 
Jens Axboe


