Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4526C4828D
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yCsIYTRxZx4omlarlTxC4HPZixLQAWbOVLHsoqrswxQ=; b=yJyiFdCBTrAefjJq0B5PCeL+nX
	OWm7QfmQCjljSk80ofNlrOf6yJLWpSr2BvpvJkq8riKhUsxwoXVguqj7SsIu1VYUHzeKCGom/7eu3
	Hi23h4777ESek5Rvzy22FTJXBi2pb5YfKN7e7cmfr9KaTIVBfmxb416pECKt/aZ73c8EJfqIoNEJy
	JAfckE1lvhWy+TsMz86SjPOZcBEStO7FNHiUjPaQ9CkX6kc8iGrh2+1cAR67PWWjVmauEu7Uio5H0
	VQI+DiNKiNuJTBsikvE6vAsnT+BlwCqUjOXkkoYvAmawhgIhdkpkD+LH0dzUog6dnD+rJk8rjlMYD
	Vvnwr6jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVZf8-00000008ZIo-3SFs;
	Thu, 01 Feb 2024 16:11:38 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVZf5-00000008ZHK-1eRb
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 16:11:37 +0000
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so10344439f.0
        for <linux-nvme@lists.infradead.org>; Thu, 01 Feb 2024 08:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706803893; x=1707408693; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCsIYTRxZx4omlarlTxC4HPZixLQAWbOVLHsoqrswxQ=;
        b=FCMzhG0OBkPQc0veYpUtKTZoct0bA/7k5Tdn7W/J5c3qskZfJxUAZChUqqZz1udyh4
         ZRtYwLBg0QX55NYXAco/rBTSOOvDEG0O/4Uo7ozXFepSD+5St0r5DVL/7mWmiDrgSH+c
         T3U5J/ldt/QIQ1E/01A9HBR4kjF23WFn9k4H1Hsgv16ZY8wA93iwsOoWqzHFq9+8ZN9U
         K2NaIvsSgpo21Bnjm7Ga+Q7UvPoBhL/AQnbRT6hXGeldVRYoOysuCTetwAmb5bXcqhfA
         /essXMbzsE1xT/WQCADfuBwvbOpxjqeupIw15uElzaCoFToIyMBBeCFulO0ianyswmLC
         B8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803893; x=1707408693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCsIYTRxZx4omlarlTxC4HPZixLQAWbOVLHsoqrswxQ=;
        b=Z43btI3QqZOo8o/7ptYD3FxzpfGWQaRsQKWIUIWXJcQlkp1qUK4dwHx1ZCY4vEUHkT
         i68oWUazxnpxaHFfjBV86rGoCl4sJDv0Y5YGo07kMCqiHpYhJ+DP+2MWQK8bMqhGN4Y8
         mKdNO2Pu1gg8MXwn8sflq0OtOXZ+14STuzTItNiLw20Dkgu/U/oRuSzidae3uaU/nU96
         EQnLo3e7Qt8/uDiC0Oa3JmDRfa3Ni3OZ8RuHvCTLyVvggXSDnnGUBB7xRBgByPX1utKC
         YyoWDLTZYhy87+yrrdsw0aXIIGSIKNUT0aqYg3MrQ1MIj9mr3iCYtnzv8eRq1xOUdZbm
         m4Aw==
X-Forwarded-Encrypted: i=0; AJvYcCUtHEHUm7cNJUdPfxkv5WTB9tT9yBSXbYm+/m7o0hCZ+FQCovPBO+GUDXJ4wjw+N6+UL6ZQKhMmMnDePHQoO7tMxS00+XI+eXisgSunPSU=
X-Gm-Message-State: AOJu0YxqBN/GZ1Z3Cfh5bGgi1pcXrVK12ANSvPP+76SI2aPfKX2k3l/I
	T6s+lRYuMN9cWbvAlfryMm4RZ9pFgL5cLGgdUfMaJca4BrJ66rQN56YXdf2bjN2Fb82AnsPN0ix
	UrqE=
X-Google-Smtp-Source: AGHT+IEYUJHf+Ff/LwORMIEiuk8qBOMrJ3MjfyQsF4rs75fi6jQI8s0hiTBSSUzXGTYyyzyOEDG1MA==
X-Received: by 2002:a5e:9506:0:b0:7bf:ded6:eb8 with SMTP id r6-20020a5e9506000000b007bfded60eb8mr3516274ioj.0.1706803893061;
        Thu, 01 Feb 2024 08:11:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW/YqPsEOhrdlChIYdeqI+hEKr4JufkLt+WH4pbzvyBeSZwOqLEazBYjMZup1hkxQi2566jx1Y1xFFKnK5sLRHZZ1y/YSjKkSgdVDPicEG+SsFcPy358TNLIUm6UgZ/AXk=
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u2-20020a02aa82000000b004710630d4b2sm71348jai.13.2024.02.01.08.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 08:11:32 -0800 (PST)
Message-ID: <ded9fdf2-7a68-473a-a748-c04472e7c6ef@kernel.dk>
Date: Thu, 1 Feb 2024 09:11:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.8
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <ZbvA5mjkhOpso5Nj@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZbvA5mjkhOpso5Nj@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_081135_656348_FFC35E44 
X-CRM114-Status: GOOD (  10.70  )
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

On 2/1/24 9:03 AM, Keith Busch wrote:
> The following changes since commit 13f3956eb5681a4045a8dfdef48df5dc4d9f58a6:
> 
>   block: Fix WARNING in _copy_from_iter (2024-01-23 08:56:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.8-2024-02-01
> 
> for you to fetch changes up to 9f079dda14339ee87d864306a9dc8c6b4e4da40b:
> 
>   nvme: allow passthru cmd error logging (2024-02-01 07:44:53 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.8
> 
>  - Remove duplicated enums (Guixen)
>  - Use appropriate controller state accessors (Keith)
>  - Retryable authentication (Hannes)
>  - Add missing module descriptions (Chaitanya)
>  - Fibre-channel fixes for blktests (Daniel)
>  - Various type correctness updates (Caleb)
>  - Improve fabrics connection debugging prints (Nitin)
>  - Passthrough command verbose error logging (Adam)

Pulled, thanks.

-- 
Jens Axboe



