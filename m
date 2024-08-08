Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE526C52D7B
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Aug 2024 18:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F5C9fQ8Z3ptO2N8z2dXaF33PXejC4/m8nrDf62UG4eA=; b=GIFb2zShd8E7Ha7fyRc5VR03uQ
	GBzlBzDcYVBw0Pr8SHLG+VTyeo9S63KNoSlhs9lysVnFmM8bmFt0JDAupuvZVfSJmlKEvwpMD/Xk/
	TwhLnnYf61USR64hhvxP7t6doca6IsZdzgYHWBNtu8aD+xTrUjRpm6ca97XXUxT0scOxo2+Vlcozn
	3czKP90IVNY354pkDuaUcdz8gaDXCEPUQFAd12djj8ZO4lQqGhmkACAho5eDn/CWzH919eAYrL/Wj
	ESnkj1jAB6RQV8QC+PyH96UqP0DkDBkU3mSHCnYv7zQ0xUEro+vE48MFDa4XedadjFWqo2hLX4nJ/
	udPbqY4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc7s4-00000009COx-04oK;
	Thu, 08 Aug 2024 18:28:20 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc7s0-00000009COR-0LOo
	for linux-nvme@lists.infradead.org;
	Thu, 08 Aug 2024 18:28:17 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2cb4e1dca7aso241462a91.0
        for <linux-nvme@lists.infradead.org>; Thu, 08 Aug 2024 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723141694; x=1723746494; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5C9fQ8Z3ptO2N8z2dXaF33PXejC4/m8nrDf62UG4eA=;
        b=k8mTLoRA/wWo0Bzw32IRPdYVG/MChzmtnA7vXY5gMquKYkgJ1UMatljjgMLxn6SA/6
         3khiLVd4h8+IqwolWeEsSjhtqhGKnzI8IT4laNZMlwvxa1scLn0gCXXzxDSObaoC4z8g
         bF+rQvKqNlGyOSiA/ZFGOmpRGkjH3dT9xWtfzg7bpGgVh6t9FdK0Kn03DEsaAkmzJNc9
         d1+rNp3pAmgBUH6vX1eUHEYiARu/HOzxBSxLjqRYpsMDX/d+RjEH6Bs39Oya+DImUZKh
         gwuYUZ7tSDFGAK+ZxoFlxQLchPmBZGBMMq3fcIzEELrzPGXIlyIVzLtsjioPR+oOpIju
         yfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141694; x=1723746494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5C9fQ8Z3ptO2N8z2dXaF33PXejC4/m8nrDf62UG4eA=;
        b=rmLUw9ObbG5GQ3El4yzFbebD7Pm/EsTsWPZLg/ATxQMdNN8hu8w5VcGvy/iJU45r6/
         aU9ysC29RYdrPo7d9mFC42MO0Jg0QY7998XNWJCxRsb7an0J+LBNfJd1S8h5DDhtSgXk
         8inXq5ITwPeOActyTyw43XXhrv0k2U/WWRPsMTLq2br0tGo7gxJ8Wa0okyr60EZA2FlG
         ZjxKyxMG13vvRwoOoYBK7G+9rbftgOwdHAAjm4qY3sJjzQXTvU5B1xAlpmEw/i2OMzuL
         Opb5fJOLQuer+pD2/N2zupu0vkp6SesJ3d4HKZW1N1g8yeyxUM9fJxrulVJxJnzqdK2Y
         8N8g==
X-Gm-Message-State: AOJu0Yxosy1uH+WDjy+HDiuTtQvX7AjEgnW3RhR5UrLVD077ssTID74j
	cJyu+BOIOI0W3fsqIlJp9wGtf7UUGY3R7M7fl4treHoAgl2yosmKOTHgv8EF72S3DZy/Rpx5R6z
	Q
X-Google-Smtp-Source: AGHT+IGjQUxCGElWVubm9GONJPEAdhXM1DKEf63DUrDZKmUs1ciyPc2y9Ik2OtENhVBcIWpyUJw1Fw==
X-Received: by 2002:a17:902:e5cd:b0:1fa:ab4a:fb02 with SMTP id d9443c01a7336-2009512ebf0mr20262115ad.0.1723141694070;
        Thu, 08 Aug 2024 11:28:14 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59059f6dsm127390985ad.132.2024.08.08.11.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 11:28:13 -0700 (PDT)
Message-ID: <fb32a033-ea32-4d09-80f9-7ae5853bae77@kernel.dk>
Date: Thu, 8 Aug 2024 12:28:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.11
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZrULTldJ0zUbqorU@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZrULTldJ0zUbqorU@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240808_112816_155823_49C12A4F 
X-CRM114-Status: UNSURE (   9.89  )
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

On 8/8/24 12:15 PM, Keith Busch wrote:
> The following changes since commit 01aa8c869d0cdaf603f42dc1d2302b164c25353a:
> 
>   blk-throttle: remove more latency dead-code (2024-07-27 10:33:25 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.11-2024-08-08
> 
> for you to fetch changes up to b4c1f33a5d59f577814d87704c45a745a35d8bd9:
> 
>   nvme: reorganize nvme_ns_head fields (2024-07-31 07:40:10 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.11
> 
>  - Cleanups and improved struct packing (Kanchan)

Pulled, thanks.

-- 
Jens Axboe



