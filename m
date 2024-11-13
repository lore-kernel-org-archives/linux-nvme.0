Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B575D637A3
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8PfkMekVPVRoiCE6Y24p8+tcJKtjjsEkCbZUPpOTq3w=; b=GsUns3ss6s0+mv+hN7SLbrZlVX
	js0p2Pim1RNYwrUzJO4tPYE28L9q1WKhbr/3W7oDVqdsNGypv6oEfqt4HDlLUKy+GaULAhEnCMpX/
	rv7r5LW4DkAZEUtCaUKuA5iRjEFHmus4b7Gf0CT/ILlVCjaZsNK/oxK3H+VRq1kALskYaHQ7d7bJM
	kx+D95MV3sZcwD7cNHOjg5USpVyASzSxTbvMtHOgnHaxhki0dyw0KPBbpjrpKEKs36BVH781UEmp2
	chPnNk0T2TXJ34b95rYgWIRfmzv9P1+PhaGAs/GElxj9axefQaSpPZJaNTwLYcc9vns3fNipVhFUE
	gHbeYX4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBHQ4-00000007bCB-2Jr1;
	Wed, 13 Nov 2024 17:44:44 +0000
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBHQ0-00000007b9o-3VoJ
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 17:44:42 +0000
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-295d27f9fc9so1270546fac.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2024 09:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731519879; x=1732124679; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8PfkMekVPVRoiCE6Y24p8+tcJKtjjsEkCbZUPpOTq3w=;
        b=1NFVPgrKH7kWW+DVJjPx8aG5OSgGHuGy8cjEPLwZHdbKkTt2uzqJ5bfRFfBOlBrt1f
         w+MTOgJAew9Pfsq/7PxtpSG/yElZ3yhLHhyZHdmk7OLmRMwhbEpXTIZd+a8J7hfq7PQx
         rElmdfG9LXlSNLXti2k/k/8PKmAxulKIhk6nRrPd19tXWA6wIidD3d1hSNJZWgJL4uxC
         DmGLuI4pU+Wo3jDSup4kC8DA0EkQzfA2pseb6MeQbS0yW7uew3+h2gzx80Q8a0vXEdHv
         J7P0e+2GNDL8ElcAvqNZzNuPBDSm3pOMhnJSfEy0+YkUjIvkJKs65ybxXS7H6hJHfECv
         ST1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519879; x=1732124679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PfkMekVPVRoiCE6Y24p8+tcJKtjjsEkCbZUPpOTq3w=;
        b=iyXdbOBaGlcd5FOYE7b9J5LeOOKehaRhvOxcTYR/M5HKwm91w+Gd52WXKq4G02/f8v
         Kz2xd5fmLlvb48zqgcWfSH5bE6/OI9W6Lys1NhXnFDiAA+NSEg/1ZIeV300pHqXsX2Kp
         GaPTRsS2BCE5rDpWhMuRsSWRU8AxUm1PBfZv6UV7QyQIBOcu3SD7rWmd0uSJd4ObTkPc
         OKOXaF/Mmaipb8nNkZ/ofB+DFHk9gtZQm5mUA4MwHde6kAhdEK0Jv72+DwPQwFQDScpw
         TqWKgDJP2RpxnZhRLwTgfbzFYJHXqJ0O6GWTo12TLWFKpEF48CRUrQoizq/XkrfiQq04
         4/aQ==
X-Gm-Message-State: AOJu0Yy0aOI9hxSf/ktpWhDa7FYh6VhTHpe3lASh+vLzWaE7Co426p70
	3qHd+EQb6WpwUEnft+S4lgLX5CqMLtWzACz1ru6MzLIV+LfUAIT7gJZsRsp8TOY=
X-Google-Smtp-Source: AGHT+IFzuXWBwH3Hy/duRtq7YZmDOwARCs6MTfsuS/CXUX5MXjRlOsIaNYUkknqm8tsIMud5/MZDsQ==
X-Received: by 2002:a05:6871:20a:b0:261:164e:d12a with SMTP id 586e51a60fabf-2956010ab19mr19193344fac.22.1731519879013;
        Wed, 13 Nov 2024 09:44:39 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e92c5ab0sm940990fac.39.2024.11.13.09.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 09:44:38 -0800 (PST)
Message-ID: <104ec93e-b6aa-4c64-93e4-d7a3265b2858@kernel.dk>
Date: Wed, 13 Nov 2024 10:44:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.13
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com
References: <ZzTeMJ60L4mViFPq@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzTeMJ60L4mViFPq@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_094441_188480_5B8E50E5 
X-CRM114-Status: UNSURE (   9.93  )
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

On 11/13/24 10:13 AM, Keith Busch wrote:
> There is an imminent merge conflict with the srcu list fixes (applied to
> upstream 6.12) with the queue freeze lockdep work in block's for-6.13.
> It's a pretty straight forward resolution, but I can send the merge if
> desired.

We already hit that one days ago in linux-next, my for-next branch
already got that one resolved as well. No biggie, simple one.

> nvme updates for Linux 6.13
> 
>  - Use uring_cmd helper (Pavel)
>  - Host Memory Buffer allocation enhancements (Christoph)
>  - Target persistent reservation support (Guixin)
>  - Persistent reservation tracing (Guixen)
>  - NVMe 2.1 specification support (Keith)
>  - Rotational Meta Support (Matias, Wang, Keith)
>  - Volatile cache detection enhancment (Guixen)

Pulled, thanks.

-- 
Jens Axboe


