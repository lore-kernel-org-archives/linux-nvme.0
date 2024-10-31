Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC435D767DB
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C4P9MLV3fDDS5FT2v9AcQf0P+LDEaVB1lnLGZ0AJGZ4=; b=TqZsxvrmsvsgNPJMcGDxtrAlZV
	EEEZL4DePxW6LCstQAp5AtJxL7tcCdfIhx/3x21+lJCtXRs6n14pemFZTtIAHhm/ljDmpSXhsAVo9
	+mZBAL2q+eZuv1hJFbo99/Mayc79egvkCOtvRhSHpUvW2jCyC0Zamfkx/dppBm4FEHMYzoneWWNKo
	NZJrc09b30xthikqnty0u+OnmAMkZ+971AlNVg4IUFmCbpuM+DAB2ELTZw5UBSQUiZVb4bzkzINkK
	tqNIu+T7Xsxt47B19ozCxdLrwG0z6x/1TrgNurkSe3SmgeWIrArmZticlqEyckqKe6OWrZcRIN7Vx
	yYdLxVsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6XB8-000000040vF-11W1;
	Thu, 31 Oct 2024 15:33:42 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Woj-00000003vkm-1roJ
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 15:10:34 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3e600add5dcso581905b6e.2
        for <linux-nvme@lists.infradead.org>; Thu, 31 Oct 2024 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730387431; x=1730992231; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4P9MLV3fDDS5FT2v9AcQf0P+LDEaVB1lnLGZ0AJGZ4=;
        b=IWc4m7P1NhGCVThKyVvKW1U24CKwzz8/+71CcHk4SuG8kZ4Nx7DiRH0CGkw+3DzCMs
         tIf6armM+5RPnJ1MsugkkfbxoCbjwBJt80AaGsVpoqf9JV7KotBSHaif5jAYWlvT/zoE
         XaxCwCtF9iU+NM57DWkPufwZjo6+rH2CbgfUp4Pv+eVOXr8n+Pcdcx0VyKzVMhEutqX3
         ko6xzQt18gpQqNxGt5WLVUPIADa390c9LgKOCQRwOxanjI40tM2TqzjSthcoqRAQpbxN
         6Ug6YycDOnMcKfWiiqGNiUDqpwux9swe0lw5bi8gdACdLzSs7FtKp9WziOr7JfwSt7q+
         o42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730387431; x=1730992231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4P9MLV3fDDS5FT2v9AcQf0P+LDEaVB1lnLGZ0AJGZ4=;
        b=i04jAIvCVOuEeheQnUVGndkHtqLNirseQG5Jh+7OVdhwhpOsVZlP7Zmi1l4Q4S+N07
         w5vgvIwK7Up6MZ6slrPejZ4+hoTwAiJbH2WzUHN1Kw3sncDfZZhwCwQqcJQtlMxdZXJh
         lMpRyUo00o1qgvGbKRGUQ8X1J1+iq1r8aKLIZ0oBQCFXidud2te7Gv4PNGQC3Q3TeQZZ
         bwjGXTUr9AP5rkkSXBLzja4ABWD43SWGOD3szCVpAu9spioNBJvX7Hv744IwCsehib3t
         2//npBjKcPXcw6XMocueV8VUL1+Ziaenav5D4lfx53ROc4scneREdeFyeW5w3jZS97/F
         knPw==
X-Gm-Message-State: AOJu0YwG/oW5eH7UKzzkJmz2XRNYaLjZXtc+aTmse2qUP3/kxIccBE19
	G1EpVxK4rnvGLlSw79ElsLnk4ku1OqHDbf37/buqrTjdCjA5gqJgEETdXpLEvS8=
X-Google-Smtp-Source: AGHT+IFR60DJHuyQ1trxK9AEUoWLAO7f2XXN24jbkNw3dZS73+0wi0WUsug0xvhHQZ1IP9OAoaiQAw==
X-Received: by 2002:a05:6808:120d:b0:3e6:2d97:ca67 with SMTP id 5614622812f47-3e758cd62e0mr90726b6e.44.1730387431356;
        Thu, 31 Oct 2024 08:10:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048cd5afsm322418173.71.2024.10.31.08.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 08:10:30 -0700 (PDT)
Message-ID: <6ff663d8-cb7d-493d-9890-d09aa5f4a491@kernel.dk>
Date: Thu, 31 Oct 2024 09:10:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.12
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZyOdZWK7S1Q-VbcK@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZyOdZWK7S1Q-VbcK@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_081033_519215_A6905C82 
X-CRM114-Status: UNSURE (   9.98  )
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

On 10/31/24 9:08 AM, Keith Busch wrote:
> The following changes since commit 49c234b50a437eb827832b61cd662e9aa382f31a:
> 
>   Merge tag 'md-6.12-20241018' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.12 (2024-10-18 10:58:24 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.12-2024-10-31
> 
> for you to fetch changes up to 5eed4fb274cd6579f2fb4190b11c4c86c553cd06:
> 
>   nvme: re-fix error-handling for io_uring nvme-passthrough (2024-10-30 07:19:18 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.12
> 
>  - Spec compliant identification fix (Keith)
>  - Module parameter to enable backward compatibility on unusual
>    namespace formats (Keith)
>  - Target double free fix when using keys (Vitaliy)
>  - Passthrough command error handling fix (Keith)

Pulled, thanks.

-- 
Jens Axboe


