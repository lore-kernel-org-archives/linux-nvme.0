Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1928AC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 01:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eoo4T84Cts5mCJ5g3kZGM62SQtBcCIpHRfTeXSGa8nc=; b=nWt+15psx2BAIdth/JQTf5vwyQ
	nqFNBin5kBkskWVn4A+Xvowjx2+kwVv314il7t0Gz4B1F7j6mkkExztv6/0vUv2rdcowwuhbOqwK1
	xmKbdLlaq7HwXgX7o3CDX9h6Gx9Y5H00RO8KY9EzRuf715KFsKmyFOCiywFfdVeoyImRxz8saf61R
	DtpKszFuxw9XqNIhf3zouPrKnZeaguTu5LEAU4aro2uAORpsgvnWYH4qegQEh7HkmWmq3oH428CiL
	MOFqgEb9d82J4sN0URYDNWD2lVBsbYeylu+ylOTB9wKxGLTAuwjCzawUzblypI70WZawu1euBZisr
	SKunAQWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCV0d-000000062HK-3AXS;
	Thu, 30 May 2024 01:55:15 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCV0Z-000000062Ex-3HEl
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 01:55:14 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2bfae86f1ffso55874a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 May 2024 18:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717034109; x=1717638909; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eoo4T84Cts5mCJ5g3kZGM62SQtBcCIpHRfTeXSGa8nc=;
        b=y/K6HV8SE04Cg/kv5xIITPeb659nvkemg92grnwuKwNqYTat6+gKpM8dCjjAZjLy+c
         ZJl5QL6Ryy3eZBfUk9/UG1lE8YAHnTsFvshQRn6xPku/Yze5OV3OTLvdBsa5oOzsg+Pk
         JuYPpPGUKru9Ufi11beQRSbimbn+PVMfEUIlS0rBrdWJvoodHT+5+ifVhH+yKVJpCwJF
         8+j0B0sf7kLJ6k6+ixau355Ae9ryWwaDyUjoEmxNAQGQizwz3ohUaTEwtVTv7AAy7kD9
         cl7RfLlwo2loYoxD6bpC0Zey1lCG3ZJMTtm8MFBd6CUK26K53J0BXzuL1gtygeHclJut
         EElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717034109; x=1717638909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eoo4T84Cts5mCJ5g3kZGM62SQtBcCIpHRfTeXSGa8nc=;
        b=tEu7lTyVuuQIuRSUQjRPReFk+Mr76M3r0tmpNZEcdDe5beu0yMfqLopZQtlXTh61t6
         RQgDcoWTh/7rskNwX7/zhFMyg7idCfZkgDBnIP5jCcxPlMwbNHEmc94FhxXtmgIm0xTc
         hZrxuDDHBBz9CedSrMNQKDpGv3tqDNXieBiV9rDHwd4dUIMjSXq4LLNP2mmyHRa3854V
         zqWMk7OVD+65sTO6DE3z7UBBaU7uH6BZaTqRLdYtE248pM9yE1DozWZ0+W4asJPt6cwh
         7v/HUNYrlbAx8562E7SutqifXeTF+KILa7kF7s9Yly3h/l48kmUr1tzMxtuzjkvo9W14
         4+HA==
X-Forwarded-Encrypted: i=1; AJvYcCVgqgZNl1ukATJJrTbX5UglSLhuvdptP6hIeFQLBoaSp+bUKeokp+lFDytxGCrBi2HI5OSENC6z5g77qZvPJ1eS6xMtjdBFQvLQRcfrCT0=
X-Gm-Message-State: AOJu0YxmOsCKPRq+rxbWrxUIn5y7TJ2JNTUHqOAHuO0J88Z/dUcnOZZO
	hV9yBHb1hNf7ETQS8n0tkatTfdS9hPkRqynX2VZ/TQY8VPL/l65P4zJa2GiJ7cTrTE3vxdssIzB
	q
X-Google-Smtp-Source: AGHT+IHsv32HB7SMXOhxF70RnG42n/qpEx0OAi0muS3tDptYvA4w5Gi6gtEvMWAwxxOHh9E+1DMXPg==
X-Received: by 2002:a05:6a21:60a:b0:1b2:53c5:9e67 with SMTP id adf61e73a8af0-1b264687786mr669373637.4.1717034109171;
        Wed, 29 May 2024 18:55:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9b87b4sm109261355ad.264.2024.05.29.18.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 18:55:08 -0700 (PDT)
Message-ID: <ff000445-6ad0-4977-b407-36e74adc1dc4@kernel.dk>
Date: Wed, 29 May 2024 19:55:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.10
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <Zlen3slew1w4dneo@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zlen3slew1w4dneo@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_185512_028131_4DA89A17 
X-CRM114-Status: GOOD (  11.14  )
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

On 5/29/24 4:10 PM, Keith Busch wrote:
> The following changes since commit f0eab3e8d1530b87f3523cee060004dd513a6d2b:
> 
>   block: t10-pi: add MODULE_DESCRIPTION() (2024-05-20 08:07:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.10-2024-05-29
> 
> for you to fetch changes up to c758b77d4a0a0ed3a1292b3fd7a2aeccd1a169a4:
> 
>   nvmet: fix a possible leak when destroy a ctrl during qp establishment (2024-05-28 10:01:52 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.10
> 
>  - Removing unused fields (Kanchan)
>  - Large folio offsets support (Kundan)
>  - Multipath NUMA node initialiazation fix (Nilay)
>  - Multipath IO stats accounting fixes (Keith)
>  - Circular lockdep fix (Keith)
>  - Target race condition fix (Sagi)
>  - Target memory leak fix (Sagi)

Pulled, thanks.

-- 
Jens Axboe



