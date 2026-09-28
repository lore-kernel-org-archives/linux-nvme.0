Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DA3CA5FA2
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hsNeGqhI2jJ4ABVqJGCe6/xWqAvJeMDFUNjKwnl04P4=; b=GHEEH4d8mkVhUcko1dKccprpTY
	71YmJXS1AOBIkuY2t68ColcGbWm45hR9/ZmNw4j76ShbN3GIpDKWPzQSaSM3umOVhbsOtk7FaozoF
	E9RF7ZOe2FWsePu8NLkAn6ax3aEvY5ZpAIG0un/cS4lutkJ8V/QGeY+Qs9h2Gzo9a/Pj2DQ8tSTWb
	yWT2zB0MIDmQ0wv3YvfgbmxR993qVm9OhMGCj9k+ufidpvVJtjigdhfV4jibIiqKCLbQTs2xj24i6
	Aeed8n5q1Zfb/1AKAWf3b+BE6iaaCsYQHaANWZJA1fpfnG/oI75MS/iRnKPymmIUXTq2klzyERrXr
	tsUHV1Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBBik-00000000hS0-0QKD;
	Mon, 28 Sep 2026 13:48:42 +0000
Received: from mail-dl2-x10.google.com ([2607:f8b0:4864:38::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBBih-00000000hQx-0Zds
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 13:48:40 +0000
Received: by mail-dl2-x10.google.com with SMTP id a92af1059eb24-142dd025d06so2086127c88.1
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790603318; x=1791208118; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsNeGqhI2jJ4ABVqJGCe6/xWqAvJeMDFUNjKwnl04P4=;
        b=N8nhrSJf358JrSAiPrlhximGPTsO/EVDn4ePsJ5x/tAek41z4QwQbUlowsnvGRuyUH
         x9jgVBR+RFDTgFp2TNIY4iC7YxKGP0N1wvg1/YisNoeyg1ruAWrNYNoHYGG+KMrK+RzV
         4MrLcgbXmca39iriumnuNWZuqiIeI5nF2Od0jCLEfEiJGuUHuh2MyqzkD0Th7nYmeJBe
         bXYoUpeCP8L/g51V9wVJzeYg46t8Nq0gc77UylLCTdKXz13QGbwga5/61W7ZQfLr/0xP
         1nUo67GZz6D6jg9+qcLMc9Tw/Mfx6FcMVPX8PJzlyl9XiHWivOjlGNzw8VV+lHjKylj8
         znDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603318; x=1791208118;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hsNeGqhI2jJ4ABVqJGCe6/xWqAvJeMDFUNjKwnl04P4=;
        b=kC1XcEh8lCYAzw9hthND4kURQWd+VBfhWdUcDq/Qu2M6+H/+LjZiaYdjSNeSEoyu3o
         EQgz+d96QonCYIDRQql6/R2rxWFyz9lMJumwMDzt0Tgy2HGc1s9ms3Fhsh7MS9aDwpPX
         +mzyYX/wKcTqgti2W3FIzTtSz1u7s8Il5kibUqrgFq7xE8WqKjUOOXcoxcMl94a9fqra
         enkVoU0j0qIMiogwJHwNl7N6RDeOzvgFEHD9gqLbrQFdkeznmkdDqYTAWCc4oEdcoh+Q
         JHvQ3SdMPi/4sA50+W7bMOJM33dI9yznnHkUPR5d5RfDksRfRmvwWewJmfXEXzIYImM0
         AJJw==
X-Forwarded-Encrypted: i=1; AKwUvByJO7mqwixgKERXGGzqzTUFwyRtjht/C2oeOkjLH3J94yOIx5ahGDjwquhmIaKJYS4/Pr3r9yZZAhpV@lists.infradead.org
X-Gm-Message-State: AFuF++k92VE8aemiAaq/sGPZ9fJM78yFD8t34OOBMO9p9BU0nYoegxUs
	YrnSp53JcBNDOLBCfUBctLeQ1J44OZuimLF871DByPeZ7BsrG9miGoJ2YCaykXrrZwQ=
X-Gm-Gg: AYBFou1ILsAe7bm8KvKnZeQLEEcybpHIxVkCttGSoDrtAC6kv2JpNQypCct88QrHonH
	4AUw3DBW4jeB6sVQIuWh7cA8hYXly6pIN2QCc/UDSt1H+g0SWHF057AgZagU9dAFaVd0FnfYWIe
	JI3yGvcTLJnhIryxSR+zLrEULPB/gm3t5HMwmuWECOPFcMfSKCt6hEXYw00EJ0VN/3glQeWzK+0
	A5VbNAIbyBERyiCV8e8rZIaD94DbFJ0KUSOyImIFin+WOmcCwLAE+WGwLLm6mDd7OnyBWYtczZa
	GZEEPxK81inMiimkid33gAgUDfETOc/5GfbPtSh4y+BuyJQcmVX3WFuU8Q4XC76FdnHIajgTseT
	NQs8Y9WxBmowN8PrUlso03oVcpnHktREl3FIYSoVZLucHckIAsnpmhiTxN7MKFp5yvEl7bAPJqP
	WsjwHe2fPZAY5Sa2lhi7xewe12yhda39+4tpJXBqUPXfyqFMiSJcBZEHqqBpwR4zVV5OZ0o92NP
	jAvSK0JQRXLN2YmTQSlHM/k8VVX80YkHXFsCJ5yv4j84iLe8oLjeG1icQ==
X-Received: by 2002:a05:7022:43a9:b0:143:4710:a869 with SMTP id a92af1059eb24-146cdfbecc6mr15283284c88.2.1790603317537;
        Mon, 28 Sep 2026 06:48:37 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm21698739c88.17.2026.09.28.06.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 06:48:36 -0700 (PDT)
Message-ID: <bb52a438-5336-4028-b802-2e7c69a0076e@kernel.dk>
Date: Mon, 28 Sep 2026 07:48:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 7.3
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <araRiDRUWyvJBca4@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <araRiDRUWyvJBca4@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_064839_441360_9803AA16 
X-CRM114-Status: GOOD (  13.77  )
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

On 9/25/26 9:21 AM, Keith Busch wrote:
> The following changes since commit 5067d4ba713961d8ccea1e06cd4c453793f3121e:
> 
>   sunvdc: fix -EIO issue due to lack of retries (2026-09-10 14:45:59 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.3-2026-09-25
> 
> for you to fetch changes up to 4a5e49ba0abb8b4328d6318c9aef0c0121f95507:
> 
>   nvme-multipath: set BLK_FEAT_ZONED only after the zone info is known (2026-09-25 08:06:22 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 7.3
> 
>  - Fix use-after-free of the command effects log on multipath heads
>  - Fix target namespace disable race with in-flight I/O and attribute
>    changes
>  - Fix out-of-bounds write in in-band authentication
>  - Fix out-of-bounds reads parsing SGL segments and ANA logs
>  - Fix zoned limits on multipath heads when the zone info query fails
>  - Fix reservation preempt and abort matching against a nil host id
>  - Fix lockdep key lifetime by reverting the per-socket dynamic keys and
>    delaying socket reclassification past the TLS handshake
>  - Fix controller reset and delete races that trigger spurious warnings
>  - Add a dma pool alignment quirk for the Micron 4100AT
>  - Preserve the target namespace device path on allocation failure
>  - Fix -Wformat-security build warnings

Pulled, thanks.

-- 
Jens Axboe


