Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61166C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12UMdmYoYrrFYK3VfNeGnEK3WmXz254CwsHVBYebRMk=; b=KM4qEDLRuQZ9i7g/DNiaWeaWDj
	x/zgCs6JeQ36GWXG9Yo0e3KuP2QMBsBL2iqPn4o0XZyAaKcvc7K6aMXOZsYYYphj4UeyAUctOatqY
	DS3tP5R0lEEqipU/zFRPiebOwnSwjirYkibhn7tOECLyPGi+sG53BSN7c7rNC6igA3pdJsViRbndU
	Hgo5Lk5/X7xLWqRGpjCom8yTh6qfeufeOTTuJu0948AKabQELMkAmLPSKDTkjxa9qke48VGplNpDC
	WmVmUi0Xf3mt9grvHckJmTsw82hu2CUm6KS3SGUn7uDZ8vMB4HpLHogNeGahLRy6lQX0Zx2F4fFJS
	doinEUlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmzan-003zXR-9U; Fri, 06 May 2022 15:10:05 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmzaS-003zO8-KV
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 15:09:50 +0000
Received: by mail-pj1-x1032.google.com with SMTP id
 cq17-20020a17090af99100b001dc0386cd8fso7106880pjb.5
 for <linux-nvme@lists.infradead.org>; Fri, 06 May 2022 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=12UMdmYoYrrFYK3VfNeGnEK3WmXz254CwsHVBYebRMk=;
 b=LASvZd/kr+O0L5A3bEKuR8CTk3fHm5Tsd9lUjfYwpqn33d7k3Q1zsMSLxqM2Wvmjfi
 U9X9eV7HuBPN5VQdn6QkXC7TyhZPYAzEmjTJjpaD5GIOeD6QowBVqIADEj4QvOrPEVtg
 ixMVdzrHVAvfbZZWmaW4tVERpTCm8iDa/gmWxbCttBjaVWUI+z2M45U6eU6/izM7UmEw
 06W6+xGWjrV9ntNXVSJcxZeWZPlDMQeHyRKnhuxcRvfzKtHy8hThyvLAr/AALg2Mc12H
 wnFPOPC2IlEl29O2OH/A+ASOIh9PPps0VTvp/TnkmuOcnlQwc43q1Oz0o8B4VKCBOUQ8
 GpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=12UMdmYoYrrFYK3VfNeGnEK3WmXz254CwsHVBYebRMk=;
 b=Vg/es8XZLlMbafu0QeAqM6JkE4AOja9pxxnLwHAQVXFNMry8avf68S9hHheLCWMLVw
 rGPyrRgumNUIxEspHTev+oWVMwkcPxuKX9bWD4Bw+fO4eEhcLxANB16GbO86VrzRjiOb
 E+Lk3Mot93RrKDyxul93I6P9XnXx2V+YwSr5dPTW/5SS5MStu3sgfGDvsLZbw/pNaJ0n
 rGbkiGWn6gw/OdxM2D7yS2wz2Hr3oScoRGMFZ+HQpCQZCclma1ut7wUfI1YvFRsld5LT
 AjCxn64amWBFUeeMW0jKpeHrt0ci8jd6VlhUKzlHKn3cBMxbsWw5CcvEhs0QoWleaGtT
 g/Sw==
X-Gm-Message-State: AOAM532D/ENIUJ39qRPxILKZx+CoGsaQR13RL4sTvItJMRU/4bhbNi2H
 11kw89JxmmU1piJCeEbAE7O0rg==
X-Google-Smtp-Source: ABdhPJyXNCnjMbf233x1TRm9Ax9LXKujaxCcbwMHpOtAWrTw2hiA71j0kvmsMI4qbPaIDzeMtLIaSQ==
X-Received: by 2002:a17:902:ec83:b0:15e:b5d2:a81b with SMTP id
 x3-20020a170902ec8300b0015eb5d2a81bmr4083716plg.64.1651849783670; 
 Fri, 06 May 2022 08:09:43 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a170902b70f00b0015ea0a679ddsm1868392pls.251.2022.05.06.08.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 May 2022 08:09:43 -0700 (PDT)
Message-ID: <4a87c2d9-89fa-2cec-7707-08fc78c88bf8@kernel.dk>
Date: Fri, 6 May 2022 09:09:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme: Ensure ret is always initialized in
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <20220506150357.2443040-1-nathan@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220506150357.2443040-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_080944_809790_D9A775EA 
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

On 5/6/22 9:03 AM, Nathan Chancellor wrote:
> Clang warns:
> 
>   drivers/nvme/host/ioctl.c:674:6: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>           if (ns)
>               ^~
>   drivers/nvme/host/ioctl.c:677:9: note: uninitialized use occurs here
>           return ret;
>                  ^~~
>   drivers/nvme/host/ioctl.c:674:2: note: remove the 'if' if its condition is always true
>           if (ns)
>           ^~~~~~~
>   drivers/nvme/host/ioctl.c:672:9: note: initialize the variable 'ret' to silence this warning
>           int ret;
>                  ^
>                   = 0
>   1 error generated.
> 
> Initialize ret to zero so that it cannot be used uninitialized.

Thanks, will fold this in.

> Or alternatively, remove the 'if (ns)' if ns can never be NULL; I tried
> going down the rabbit hole to see if that is possible but I got a little
> lost :^)

For the admin queue, ns can be NULL.

-- 
Jens Axboe


