Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43551C28B20
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Ol1XekyyiNPJPw8ADcwVTT775gbgrzJGipyz5q9A+4=; b=hs6amKG1SBiZDTV/i/MvX06OBb
	3UrzIKiSh2DnXexGHB1NbnrzpVpUaBYonU9i1+xsJiP4c46yYSXHpLnZnUwVfwDKU6SUDpz/D+zXR
	wAf/7yTrLWnkjFIkRxk6J5OegDK9aLfK8Zu/JfVGAAcLSjwNXqmHPwmnsJshJPuxvm3KCAk9m2hdn
	PUzG7jpRNV5CaThkv880s4ds804EP3lYVGsB27P8VizcD9uYVyWboX1heyanPR2DeJ8xpzy5N5S2N
	Ey4ApBWI55VhQRKgwSD2jHA09ssW2pM1WpjJ7g52AjWZP2ZJSfGmbXNN1VXmtGpJ70PdoP49cXZv5
	pSFunBLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02Yw-00000006syG-2VBN;
	Wed, 02 Apr 2025 18:11:42 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02Yt-00000006sxk-0mee
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 18:11:41 +0000
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3d442a77a03so518505ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 02 Apr 2025 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743617497; x=1744222297; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Ol1XekyyiNPJPw8ADcwVTT775gbgrzJGipyz5q9A+4=;
        b=nPDydqTjX2HatShEiKQ57Ax5k7dsj7M5H8ATaGytD20Im4/1B94sKbPYsEt2swoH0h
         xxpT4yP8yIO5hlTmxdLQ0vvzPWCoRF4egVs4dVkmarkzcOcrD79lZoqQD2ZuKWv/Hc4Z
         PP1G1SIs//uL5L4Loi1zP2MQfWO3iGE0v8jubcniUtyDPNnV84EK/pDX6xpSsfUU4LU+
         OKemRTNYhMUy5TyM3OroGfOhLFTWunX+7kMJ8ulHOxoRQqu4NIlxgxb0f9GFD4/gYlkd
         6qXTdkJ7BwZqqFIpUW7g+oRoQO3wU+h0sCjTmfl914p91YonMm4+l4aSalggTspcOq2m
         /zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743617497; x=1744222297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ol1XekyyiNPJPw8ADcwVTT775gbgrzJGipyz5q9A+4=;
        b=FP225TYB1gQ3oGMv5hyhKT+Q2y0adFasz+MDb6JwlsPhdh4YG4aGOV5ggd2ZmeVBlt
         IFkzhG+rGdoLpKrWP2vlhfV091cmKgxaHwkSubk0MsApmqtdZwQCCfxALCG5bPDvv2qr
         tOucdEGGj0jn6IS/eyM9u/lgutbw3shPAvduszcslQHa0UdU61jV6+hZh/8sTGCjXXzH
         klh0wJUIzD5dBK87jBnR9Fc3LWJ3OGmcVDNj4GXfrIfQ+WBN4maCLAhZSquw9S3AQCqK
         ieH2HVeo4qUep7x9HNua3Llf7Hvd2ramYYlqveqXduYnk3VB3iRjYBD8icdy9tCa8yhF
         BrFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp/Ehifr41xSHarTBav1qM3zETeSqX8/2iDxvvp73H+z/8uhUW8XS5eFpADr8FuGNkb92Tx0bSaE4h@lists.infradead.org
X-Gm-Message-State: AOJu0YyqG5c7dm/UFawDP2dHDjHfCsI61bNrq9bMcSBzT6Dd4gqUYa2n
	xkqYGsQ8dCDlXal7/51w+lOT3v66R7a4ckdvOgkPCn19I0+pc/zzlgPN4+Pl6mo=
X-Gm-Gg: ASbGncsPkUmIE32InyKR+hGVOPjHnXgOs3LnnHLkD3RDpZqxJsXwuzItBxkecOGBZzj
	7k9xrB2yDhRx59yr/feuiup3QyV40nsy0zGF//DsN1YvqK60fNSEDiQZl4piUGv2xA5bnnxdSMA
	zMlGoPsu8/hqyVlRkQ4YQs52e8wFqhSXhHKKTPUL7ajfQiJU8T6zRKzGpxZPsVC4klnhZyVR9WA
	d79o6unKwPOYh1aT0Y62qW/QZjm2KbJc/cFdd3ZEC0YP6EU+iAUOnZqCESb9fhe0EW3eeXbZIBF
	B1ldQMqdMkT7aZlMnDIDQdScxp1z4oiklcvqe3zw
X-Google-Smtp-Source: AGHT+IGUtQYrDfWTqaMZ1Ztoh8LBN6zzns/PpLMMqM+7p+rsVkD5ln+oRzwq24I1wL1PrDGaEjGijQ==
X-Received: by 2002:a05:6e02:1488:b0:3d3:e2a1:1f23 with SMTP id e9e14a558f8ab-3d5e0a0b15cmr182323615ab.20.1743617497431;
        Wed, 02 Apr 2025 11:11:37 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f46475107dsm3027932173.43.2025.04.02.11.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 11:11:36 -0700 (PDT)
Message-ID: <87c2fc77-f156-41dc-b5ff-408f77a5fbf1@kernel.dk>
Date: Wed, 2 Apr 2025 12:11:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.15
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <Z-17jFW3e0ta22JW@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z-17jFW3e0ta22JW@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_111139_497777_9B5DCBDF 
X-CRM114-Status: GOOD (  10.84  )
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

On 4/2/25 12:01 PM, Keith Busch wrote:
> The following changes since commit e3e68311ead15d8be61e8e1a8d2f0d1773a7ba9c:
> 
>   block: remove unused nseg parameter (2025-04-01 07:21:35 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-02
> 
> for you to fetch changes up to 288ff0d10beb069355036355d5f7612579dc869c:
> 
>   nvme-pci: skip nvme_write_sq_db on empty rqlist (2025-04-01 09:01:06 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.15
> 
>  - PCI endpoint target cleanup (Damien)
>  - Early import for uring_cmd fixed buffer (Caleb)
>  - Multipath documentation and notification improvements (John)
>  - Invalid pci sq doorbell write fix (Maurizio)

Pulled, thanks.

-- 
Jens Axboe

