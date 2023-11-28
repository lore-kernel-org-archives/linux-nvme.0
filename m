Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E342C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HkJhq7XwCqokpeMhVk+ENGQd/7AIzYa5NLVERDlYbl4=; b=C/tj6ftUyYUja9dsJiTMFvTDgt
	0h/hXtJ5AQHmGkYBkJtvmNZXd8rxwQEHwgt/h4YNlDG9bzH/wp43N5DozrR3i0WOuxLqiygX06/kG
	vsw4LM16VpeK6gFARJjED6P11XSdR7tZtJ5z2Xq3d9g6VvqinpeayRvhpft2QuzNHo6MVX58ijqU1
	k9PJsM46hnt3chf8wV3Eep64dFimzsvDvtfyvYFgP2DgY8165YPqXBNkAPNYuoE9KgEQNCzeR6IE0
	O2n+ygQJawjmjwubyB47hOJFXluAoVy43Vw1GjOVVFDlFGthlH42pF0q/7FdYJifiaR8M+IZkQwfA
	rnHQ0lbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r83Tf-0068RH-1b;
	Tue, 28 Nov 2023 19:10:35 +0000
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r83Tc-0068Qr-1C
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 19:10:33 +0000
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35ccfc5323aso3172145ab.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 11:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701198630; x=1701803430; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HkJhq7XwCqokpeMhVk+ENGQd/7AIzYa5NLVERDlYbl4=;
        b=MczZAUxLE8eltipaHESq9qslMLUyDpVIomcxld5rRCd1INiVK3vjktrjyAIEXcfXLv
         2Ksxsv5P9NubfgLuz0b4ssVk5ChMsKyn3cRAJYKREIUP3MPUXVGgSNn0XgkdE6dxSzT0
         ups/mfshjJzxK7kQHAbTdMUB/zeKp1MVHHwvkPyqK3HWFNtc1kdipBNWYCGMQ1XE01U0
         uJZBKQdjbOJJAgiDaJFNwCE9kulMcEb3B0f7skMoLpxxmhDmWpjX+hraUU20cKhxD+TW
         cMoAw/W87QYW25vXQ+HS8Z5a+wkOT0Tf54caQ1KyAbRaxxsRUQJ70ebmOFqS2BqZlHzq
         le7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198630; x=1701803430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HkJhq7XwCqokpeMhVk+ENGQd/7AIzYa5NLVERDlYbl4=;
        b=CZHJrlADA2jrN5fetC4vVQe69jNGAxVWGH3cl5bua9mvcjQOg2UaRBcMCBkf1AjW79
         ZIZxZI7QNnM+vMqtBY1xOOec5jEonufcV5DskdW46WC4U+7YuQ0OzGJYiTYWcmNKQOXx
         /d6BfdDUGrthzeHxB0OGXAxZQzGntd4vrgCGYvpCY0EtiGxvhAUJ5kzKskNIVf0w5dev
         qtRw3x4C3WIBDlK3OjuivS9y2Bm0FMlK19OWKYbqAbnbhFNHCqI5FCTs3l33SbbldLQ5
         YL0UVvfGpWp6Jvjv11w1roX+goUiTBQoamD0ZFi22TuzBgD+5jEhA7A4ejX1aSJsta5W
         Nr6Q==
X-Gm-Message-State: AOJu0YzF78eYL55l8m3T02sQO8QEEVdi3e2DCktiEDicYc5oGcccNW3v
	zkyJIpZfHNugfM7PrBiPyRdEIg==
X-Google-Smtp-Source: AGHT+IHjHJf1IyzsoYR7Fz7yxWCzsa6rAkAS60Dj7NGX3qUxs/xLp898wG/8O8owhsvUNu/IrWAK2Q==
X-Received: by 2002:a92:c84b:0:b0:35c:baec:750c with SMTP id b11-20020a92c84b000000b0035cbaec750cmr7940911ilq.1.1701198630532;
        Tue, 28 Nov 2023 11:10:30 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bz10-20020a056e02268a00b0035ccce14fa6sm1576660ilb.87.2023.11.28.11.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 11:10:29 -0800 (PST)
Message-ID: <276e4ae6-a591-43d1-a80e-e07dc72b33d4@kernel.dk>
Date: Tue, 28 Nov 2023 12:10:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-core: check for too small lba shift
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
References: <20231128173955.339941-1-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231128173955.339941-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_111032_409349_1461EB58 
X-CRM114-Status: UNSURE (   9.31  )
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

On 11/28/23 10:39 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The block layer doesn't support logical block sizes smaller than 512
> bytes. The nvme spec doesn't support that small either, but the driver
> isn't checking to make sure the device responded with usable data.
> Failing to catch this will result in a kernel bug, either from a
> division by zero when stacking, or a zero length bio.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



