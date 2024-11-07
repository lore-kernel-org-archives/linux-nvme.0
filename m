Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F961D5D689
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=os4c1biWbeL1NO/zQQBvuq4qjp+21Cm7MWNnHluZ1JE=; b=4oalNGU0Q+VI8l+gxkNjQCpcbb
	x7JpdHpKHE+0Eb1kaHt6lJjvXhrzKwST1h4kaB4KO2eHkurxHjvaDJdRaPMQWFWFY5SpKnk4WdExF
	Bvzvm0qCfjNLY2Nk+jmKbe/VPWVdQBmeYcd7mFbkeu8HFsqVT2L0z6aMUaB4gYe4G0LDs4eDU+kiA
	Sb1YU2Fa+kdY3LRFZaKiJB4Oa7B0kr5UG0s2xZLu/5S791xaYWkCWjMb2ap5cxAJYLGyWx4VUOeqY
	Z/GqGjLZrvMy+hfFQxE/k64FDo7geJfRoQkI2IXWYP8WPWkUhQW62HXBY9+vQVcKPLUKc9DBzlvjr
	41T56mzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t99ZW-00000008JOz-3vK9;
	Thu, 07 Nov 2024 20:57:42 +0000
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t99ZT-00000008JOT-0QPM
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 20:57:41 +0000
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3e601b6a33aso943091b6e.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 12:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731013057; x=1731617857; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=os4c1biWbeL1NO/zQQBvuq4qjp+21Cm7MWNnHluZ1JE=;
        b=PbdZjjbQ8Gy5/ha5iYk42xoR0OV7q3bCFU+8CuhpSLPt5/D3ECyw0yHbwb/mTCz/6X
         HDRMlOA6LQ0632e6ceCiko4Co+qaMgVnJdXEKP2CHaYz8OSdTETx+JZrCkTWy/T929GY
         xYlayvq8cvh1fGCGOpkgolaJIQOCRP9CBOlI/vTrRmBJDqZDRlhWp+/QZdSllmyPoJ2i
         BRQ5AC3bXiWdwnm70Uwnl8fqXBfVPq0ubkjk+04sqVfBOYOJYnPkPNCzl4Y9Xl5nfkn4
         eIkWPkvH8Yye8H/eM5XxVgqRObSnepLMtk+fZr12RQDepgF2G0+R5LPXeofE2sprftTa
         4wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013057; x=1731617857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=os4c1biWbeL1NO/zQQBvuq4qjp+21Cm7MWNnHluZ1JE=;
        b=eaU+m1VwwZQ/t7c7RCzbapgIyTTxfkhUx5v+Oz77DorTcIz2/RwpCB1b+/GsOY9Q+n
         ppbdMYETFypJ3OJd5/I/Wf2iZYSwKfsVMgMWgaLi6Gz8hI3EG+5LSpQEzdaznuIrpZ6t
         GgUBaTIZ84x8476LaJyO4AEFiuUtdNZDZupGH/DRJ5BNmAQF2CD/WHEe7iTNgxx8yipJ
         u6BZkLoOz4oE9b9x4e814287HwnykHGk88MdZASM4+NDllFDEexo/B5K7YguQsx0KFUJ
         VEiET7EjbA7d/j2MhX8j27hIvRWH672vQHdlaq8Gx3mflE4uSDglAKJIjBGC7YuQIMLm
         UcmA==
X-Gm-Message-State: AOJu0Yw23HcNYfH8dJF5L4poe3kKo7O1pa7/xo0wc1O0M30iIVQkqTUB
	Gcq4PjA+5HhkBvnhSTP0syghbW9NFFl7cShYWF7UYtF9MlQqh1T7E+5hCIxfjhQ=
X-Google-Smtp-Source: AGHT+IH5aDO8SsLxV+g89N/00Q4AdhH5cjTviSW0ks8aj7B8A6TsygEH2ks2XE9WfNujLEnpV5Awxw==
X-Received: by 2002:a05:6871:7a1:b0:278:25d:d473 with SMTP id 586e51a60fabf-295600128aamr331580fac.1.1731013057473;
        Thu, 07 Nov 2024 12:57:37 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546f3f260sm580967fac.47.2024.11.07.12.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 12:57:36 -0800 (PST)
Message-ID: <3295560c-b8f6-4085-a412-f4fd0342a41e@kernel.dk>
Date: Thu, 7 Nov 2024 13:57:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme fix for Linux 6.12
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <Zy0btdXvfd8LA7Rz@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zy0btdXvfd8LA7Rz@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_125739_442854_4C812C55 
X-CRM114-Status: UNSURE (   9.65  )
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

On 11/7/24 12:57 PM, Keith Busch wrote:
> The following changes since commit d0c6cc6c6a6164a853e86206309b5a5bc5e3e72b:
> 
>   Merge tag 'nvme-6.12-2024-10-31' of git://git.infradead.org/nvme into block-6.12 (2024-10-31 09:10:07 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.12-2024-11-07
> 
> for you to fetch changes up to 6d1c69945ce63a9fba22a4abf646cf960d878782:
> 
>   nvme/host: Fix RCU list traversal to use SRCU primitive (2024-11-04 13:25:41 -0800)
> 
> ----------------------------------------------------------------
> nvme fix for Linux 6.13
> 
>  - Use correct list traversal for srcu lists (Breno)

Pulled, thanks.

-- 
Jens Axboe


