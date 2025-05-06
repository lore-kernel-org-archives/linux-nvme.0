Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D23C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YOsd1DnTdHXFdbYKLUSHJH9USYpXJuhQ5YX4NwTSkeY=; b=qBhNYTDGXuqu2G8IMCzZDeJ3G4
	WK6MmpV9Itkge9YZur+G7zkhbCOl22s0EhH86wWkWzqkIawT0uywzlmmV+eCanMAqxKjFQ4vqzUug
	SJaCcA+ZaOTHLwVwlUHJ/8m054Ic0cQo49OTSEQNH9bQS8CvauimmyM9LD+PC9IWb6nrNrMiotf6G
	9gRjQKYbSiSYP2+Rc2BWwk41MSLgTZeCmOh6Wbfky3JgyDv1EUgaqjhAovPJErbNLd3ioxTxPlDJC
	hV0Ra0DiGNZb/+5EfXK/bmLqcd2w+9i2/8BLBjbj2DkM2CnYhZajpoQ53/UqraTzXyoOodF2E2Fqr
	Wh8QK4+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCRpO-0000000Dfvq-30Ss;
	Tue, 06 May 2025 23:35:58 +0000
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCMjW-0000000CwRC-0nx8
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 18:09:38 +0000
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3fbc00143d6so4343558b6e.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746554973; x=1747159773; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YOsd1DnTdHXFdbYKLUSHJH9USYpXJuhQ5YX4NwTSkeY=;
        b=I4jcGuDMQel6pw+2Z8Q79U0TDJ8VHGMGhJOCZ/m9fBFWexaz1goaShc3J8v0xX/b4w
         /uRpTA3ufxWONeXmbn2+nfmZkhpyvIx9ym9jEamoKNPZigusy3hFQyF9+aEEWS3bMsc1
         poV1oTgKtB65FC+Aqk6wNI8bP9Xwe/QZHN5tUW2NQZsaCoxN+u0LMw3VAQk2B1EIrOgL
         hW7QADyhT2Tr24/ORP+yq7TjPLMb3t+NFPnDBkpwrR83hZSyVobTJE8QuDq3vp88PWfo
         8O6sYi2PLOo8xArtMGLncknUOHO+L1RE4emHyb3SsjCK/0q4usRKrEZiNPG9WDIqLUXX
         /LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746554973; x=1747159773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOsd1DnTdHXFdbYKLUSHJH9USYpXJuhQ5YX4NwTSkeY=;
        b=vJXVNjid34E4b30MiHtGKERFmackgJmbbBXGT7YCtPlCtnfPI1DtnCibR4fBiKtdcL
         Sw0QBrO0Fk25Tze0LhFnhzm+et5bY4z1JGh0a8OOaUkPJ/pFdTjEwy7fQmu5VwOM2r2A
         hk5l1CQqGiqzWKVp9zIvvoaPvFDQDKcOPTLsWYpLQuaqvDncubMimqjheNrwipvO+jYw
         u1S+UJSL5xtj1SpxJW2bLjWSpAK6CnXAGGBS8Fn9MhSZOxqrwPStjuRDGhHFO6Saw3j3
         0bEThCTm0vGJqvo4ylpaONs1Re4mZC/Hk4g3iVjN0YAe251YeF8Q6Zk/zk9G/zEUlF4A
         tFYA==
X-Forwarded-Encrypted: i=1; AJvYcCUQrQhQ1clcAiRyPnfLh8+WSmM6YxF35H+hSj6vp0azx4L0JgnN97Um421Yj+UagouPS0SRpRKpz4Uw@lists.infradead.org
X-Gm-Message-State: AOJu0YzCpagisy5DKKjrWf+OZD3TvX8w2xcsd9Ipd0VQvqvgfGyc+3Ey
	Ngazw/0K0IDVwtF2tbOUIkEGO0/yDNO1tnhxlp8k45NYNQF483WHrZFvOhC6vfkplPpXOPSYYj1
	i
X-Gm-Gg: ASbGncugsjhjEreFkRDNSYJYR1WAhf37SLmw0xw7hNypybayX2lXhpxgf2CTVFhqgFh
	+70gQ8cLds1Cfurh62R8ikE14CgPD4C1mF1yuBUPaW/PCOmLqukSDsz7mFxnn87G/nL2huxbjf1
	3W73hUrS4nXexsxTFVcX5W18yagooXIlMcbtX40YHkudvx42dt6EiG7YCLy4UnAn+rVHkrQh1VO
	IbHefw78sR8ZXzgoERpRasc46E/Dc2U7To2QfUYfk+9++/fHg/dfXHvk1s5HC1xKcPgf5UVmCQU
	0RJHBYhyrbeJWx5ipyk4Xln560RPiOpDm6FE
X-Google-Smtp-Source: AGHT+IFmi+pWTuWcf9gnrvhHt6wYpaabrOoDlJmAmFbMtrt1R4LVZhrPKrPGIe3pTUdLcj85/4udAg==
X-Received: by 2002:a05:6e02:3398:b0:3d0:10a6:99aa with SMTP id e9e14a558f8ab-3da738e9570mr872925ab.4.1746554962620;
        Tue, 06 May 2025 11:09:22 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa8e3f5sm2344615173.117.2025.05.06.11.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 11:09:21 -0700 (PDT)
Message-ID: <6ce9274c-db51-4ff9-9d05-9d334caf2206@kernel.dk>
Date: Tue, 6 May 2025 12:09:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix incorrect sizeof
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: csander@purestorage.com
References: <CGME20250506180545epcas5p34d4857f38b838532678728db22df6067@epcas5p3.samsung.com>
 <20250506175656.23151-1-joshi.k@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250506175656.23151-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_110934_233179_3F36D936 
X-CRM114-Status: UNSURE (   7.21  )
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

On 5/6/25 11:56 AM, Kanchan Joshi wrote:
> Use the sizeof(*head->plids) in kcalloc so that we don't allocate extra.
> 
> Fixes: 38e8397dde63 ("nvme: use fdp streams if write stream is provided")
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>

Reported-by: Caleb Sander Mateos <csander@purestorage.com>

?

-- 
Jens Axboe


