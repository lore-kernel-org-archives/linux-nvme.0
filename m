Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A657CCAC59A
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 05:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y+W9ygbEmaO7jSpGWluHHDCwNotO2mAvvUWbW9wEx2A=; b=nqboB+0P6R0MynqPXCn/GOVM8D
	GT38FDtZOj5ARwtpSq4wSQcwYggs/FMXUnzj2WMveGzm6rr3Fsk+8YWzk8RO1ddUAgLQU77h9lcRj
	yorJpmIkIimYMJrBjOYVnFD49LoCGc5JJaBiNwz3U13dgoCq+NTvtYxE/0f2t/YwxUuRdJFyZivHu
	Ysxwcn8YqGe/my0AXVP0/hGdNp2K8eR+VsCewPreCi7pVG65NkA9JvqHDEIkyQ+xucS/xr8OpSLzK
	+uJhSQYcfrVCaMb9B6Ht+LxxLDf2g7JOiaHKAFRiR5pPRigi/gOUV+dBAYw4EB7WwTajFOOQaGFCS
	xMf61uUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Hoy-0000000FYOp-0k6f;
	Wed, 24 Sep 2025 05:13:40 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1How-0000000FYOU-0Rd4
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 05:13:39 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-279e2554b5fso5626745ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 23 Sep 2025 22:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758690817; x=1759295617; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+W9ygbEmaO7jSpGWluHHDCwNotO2mAvvUWbW9wEx2A=;
        b=HAeOL352HbR1iGHS8kdx9H3Q1ihFK3q0im1vl1ydDjMKYcpkhSWmIuATUkqYeV9QUx
         63Wf5qLfzhDccnugJV112zRSqhmlscdQpojEMYsPbyfdnPqcDcZuNZHtW2zGywgKtLFx
         SvDnM19pDfZ111DrTKXH1wAcDzGGYPYUJ6l5YAaxoSquMwh7RGGbT7u02Cl/7LTtXeJI
         adi6XL8GBWw5AlAJtyf7g61TTYjUzYbjgXonHost7heFkDFEyJlQyfpWgSw95PUlEHQO
         lM5e0OXmBm4ca7eUabM70Nc/oN3ljtcbYj2cpROyVh6dERGnch13jlHASfq0+LlaY9nJ
         qcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758690817; x=1759295617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+W9ygbEmaO7jSpGWluHHDCwNotO2mAvvUWbW9wEx2A=;
        b=gjJPmtXSJJ8Bbwo/f2gRvWrnU8egLAaXqbGG1Tl0p32zfhSDTgpVQp9AycPcr2WlJR
         3WgQWHtsZefCNiSMjJKBojHRy9jNAExFtrB0lQzPBTDSk/CGHLoMxAeEagXOlemw+gEy
         OtlLjs6h6jlIPWLLRA/rhKiqhMa3IMddrkS/ouRJTA615NZg6GHv+Get+O7Pd+kogN4N
         4NW1Vr4bj+JjiSq8AmwCFABOG1CzPNZjbH7yPJPPCnmidD2VrMxBFdz1PQpyJgcMSeea
         uxug1VCa4PaGQQNo3jLPLH6UVajqCj2IjOdIo9ey99O7r22BlQkDvyMcfwQ/L52q5tTf
         DLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqc+Lo+EqnZ0fm3ZQlljeZELF0WMJd7CgT1mzjb6JIPGSwaPYA66S8Z9Fd1KuIKMhEErX/mdIeNptf@lists.infradead.org
X-Gm-Message-State: AOJu0YylBptNzSHNWpXioc5j0j0mNV9vUzZdOOS7fAqAekp13adePIKy
	kTbD0DT+cJUiMhIkG3+ApdIGA3A/KftMpFzCJjO8zPYhHX7Aw8OK1W/eQpYjepw4b4U=
X-Gm-Gg: ASbGncvYD/HTmRxjmsoQuaV4B7yo7TYoHdzcakkplH2OsXB6fXT5S0ZlLTLaEmG7SyJ
	U9H2d/Mx9+J0Gg52GemE1L1l7hxbtQJFFUb8ng73EZ6nhQJiC/YlxKqO6xLEuz41418pmOEm1RV
	N7DGWgMyl66vOwoWZ/xYoiq54Suiw+N9Acq0n8wokxtK4b3dHZt+aY1LAjjsBeBsEPTGqYb2YHA
	PKe8dzksOQkEBqmCuO4q3TOFMoC0drO1L2jvLbEypVpkhRnj1PzlQM5oI5z3rPtAvhQT7euEwWB
	s9xuiRCponRiYJLPzg6MwENkOUvLm2jHMbTG4Wz3SqKzLmw9izr82oO/27NCSMneME4YGQRkqoE
	0gOyBgJ1UfvZzYH7NjJOC
X-Google-Smtp-Source: AGHT+IGCiF5/W0lvGBVUNCosMaqLR98sj9vTwFLyCcKvakoQNPbvExXavzq0l8SXlDpCZgr+b7e9FA==
X-Received: by 2002:a17:902:db0b:b0:265:e815:fcdf with SMTP id d9443c01a7336-27ec126d6a6mr13588995ad.17.1758690817122;
        Tue, 23 Sep 2025 22:13:37 -0700 (PDT)
Received: from [172.17.2.81] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053da4sm178963575ad.20.2025.09.23.22.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 22:13:36 -0700 (PDT)
Message-ID: <79ff8393-9629-4561-8afa-4277a020d7aa@kernel.dk>
Date: Tue, 23 Sep 2025 23:13:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for linux 6.18
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, chaitanyak@nvidia.com
References: <aNMi7ggly46pZGzm@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aNMi7ggly46pZGzm@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_221338_156332_CDE10933 
X-CRM114-Status: GOOD (  11.01  )
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

On 9/23/25 4:45 PM, Keith Busch wrote:
> The following changes since commit 34585dc649fb255b40075dab56af063c1bfc9933:
> 
>   rnull: add soft-irq completion support (2025-09-02 05:23:56 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.18-2025-09-23
> 
> for you to fetch changes up to 2e482655019ab6fcfe8865b62432c6d03f0b5f80:
> 
>   nvme: Use non zero KATO for persistent discovery connections (2025-09-23 15:38:28 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.18
> 
>  - FC target fixes (Daniel)
>  - Authentication fixes and updates (Martin, Chris)
>  - Admin controller handling (Kamaljit)
>  - Target lockdep assertions (Max)
>  - Keep-alive updates for discovery (Alastair)
>  - Suspend quirk (Georg)

Pulled, thanks.

-- 
Jens Axboe


