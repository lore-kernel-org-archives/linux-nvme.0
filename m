Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8B2C4828F
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Feb 2024 00:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2bkMqsq2aQP8XZfD2bawJg8Dx/HL7ifVfV99szEpYsI=; b=WeLnyWuIBgqWTj/r1R/Fqc5zDA
	L4MjtCvRcvk6TithI7JxGjBdoRMnoC7k8/Sg4qZgHktKNNdHNM6BLm3T7WihSon908UkqOg1MEQjQ
	DFCPXKciLCwUrz4rASOPsW4t51AwVcQjjj3Sb1UWyogNvCL7jJbdhCUUaB28rcGp5CIlYXEC/le7z
	qN2qDxZgTHszaZI2zHjbyATMMDcx10PbRmyoOC/uoNq5aoxSOv9i3VkBdSja/KAL0FGgxZNcVEB/o
	GMIn9946ItOm8ZRx1t/0pGJZWuwORWVWN4l/Z/UkOiVoI/MbAUayD6oenlgauLKwyPUR/W8WNN8X5
	pTvb8E/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYEo1-0000000Fhvq-1gmO;
	Fri, 09 Feb 2024 00:31:49 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYCWo-0000000F9OI-3kwt
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 22:05:56 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-295f9e5f8a4so85915a91.0
        for <linux-nvme@lists.infradead.org>; Thu, 08 Feb 2024 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707429954; x=1708034754; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bkMqsq2aQP8XZfD2bawJg8Dx/HL7ifVfV99szEpYsI=;
        b=BPekTrEF2qfWoQaLpbOEShiVVOiPZvVyO3e/8/Bh8wOF3/jstgVFH/C8Rmt8RJ0jvh
         1scPtXtgJvjxmFWthNEXxM7pGbpCQxOzw9hd2O6Evgfm2ZJRLSJdjUb04Dh1ZAYyZdt3
         FzBYzJxQ+9wPv3AZE8N6gkq5AqOdTDXRrtdNprAtWDvWASTnB5GO20ngmT3Mavb4G8Dq
         Fr00GtiuZ75OVnRxDskVX+u3KPJCH5SvRQUzEAqB3+Q8MGY1xfvoMSUWy/L8qCftWswu
         XGBAU8tRNnqz7GeVFnBF0gigr1sYj9TlLC/sSsGLiOh7CoawTQ2LZN0zz9QDXn/z9K5J
         tVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707429954; x=1708034754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bkMqsq2aQP8XZfD2bawJg8Dx/HL7ifVfV99szEpYsI=;
        b=j8feySZE+3QpU/PaevVsmbwypOu6T6IGt4netHr0YbVvGY9zoNQniqaLQE07I8sYV3
         oGDzswtcHrq3POK6BH2UiHI14s1c1MY8c++CDW3b8Xmw/wg0NdUT5eFTNz9NWPLIsLaX
         lcGTnPtWk9H4mv5xwo5gftU+kTIvIo/dYCuXa3cJ74ObbOQW8mOUO4QH7wcBHN09mFIc
         lawHbXqyszyFsl/XKXhqLoNwNuVWy4kPdzdT5fIWhTBGJQjpCGsbBljP53Pu99+M4MRw
         wZEk4HHdEhiDPctBbfVf7o0Tw9UnmE27SpDRJzY2bDcs338FdZbjqJpLtRip2YzcZ93c
         LHMg==
X-Gm-Message-State: AOJu0Yytd5As0jTzLc8CfUQN6GbshRrhIVPeAZwmD/vVNkl73gmkTpcL
	0Bk3M46uav36ijS3qDb2RsNJBj6oXE23i1InL4OZ0lw9/cT8MsO2ssCvb0+EziE=
X-Google-Smtp-Source: AGHT+IGiK7U8vnZYLgZOlHbtrrp3a3mBJEFhCC429Hd8Yc7fDuJx6TJ99S3vlPRQp84klbwMHPeKWg==
X-Received: by 2002:a17:90a:9ab:b0:296:f78b:d9ef with SMTP id 40-20020a17090a09ab00b00296f78bd9efmr571370pjo.2.1707429953706;
        Thu, 08 Feb 2024 14:05:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTlc+0oUzpt9rtn29Elcxvd7oMTH0iQ20Jy8q3BPjYILQzxnl0WSgArSIaBNUN4i6gwE/0LxwhHQ6jNr7BwYtoGRaMtjore3DAPirL
Received: from ?IPV6:2600:380:771a:2bff:256a:9053:7400:793f? ([2600:380:771a:2bff:256a:9053:7400:793f])
        by smtp.gmail.com with ESMTPSA id qj15-20020a17090b28cf00b002966248d75bsm286683pjb.49.2024.02.08.14.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 14:05:53 -0800 (PST)
Message-ID: <d80f969f-4518-4a9b-ae86-59a3dc99ccae@kernel.dk>
Date: Thu, 8 Feb 2024 15:05:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.8
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZcVHAP3H2E-8BpUb@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZcVHAP3H2E-8BpUb@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240208_140555_154649_B5FDB438 
X-CRM114-Status: UNSURE (   9.94  )
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

On 2/8/24 2:26 PM, Keith Busch wrote:
> The following changes since commit 373581643d3d6f34f16389b481b1462c8cbd37c7:
> 
>   Merge tag 'nvme-6.8-2024-02-01' of git://git.infradead.org/nvme into block-6.8 (2024-02-01 09:11:02 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme tags/nvme-6.8-2023-02-08
> 
> for you to fetch changes up to 4054705215ad7e6dd8e4e6ff27c39abd7667f700:
> 
>   nvme: use ns->head->pi_size instead of t10_pi_tuple structure size (2024-02-07 15:49:36 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.8
> 
>  - Update a potentially stale firmware attribute (Maurizio)
>  - Fixes for the recent verbose error logging (Keith, Chaitanya)
>  - Protection information payload size fix for passthrough (Francis)

Pulled, thanks.

-- 
Jens Axboe



