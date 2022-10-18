Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCB6C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fq5kyyPbsKUWwekokR2u1feGH2ITW5Wkh89zI+stEh0=; b=yNHd0ctgkGM0LmoJIAVYUM7EHi
	aoUeJJG4qNjh1stxGXVDVpWbnziyBXhT+J41RUV33BFAT+y8BJVlQKSik26E1iOQrGz++5Xhe2q2r
	b7RZgiq/UD1laGwBHl1vfow7zJ1TCnw3VTma2m6esWSt0q3X8s5dYQapNkZAvBU1NpB28GWLOisIE
	BxFksKWOiDl6mlZzUXR9EnVZrvXsTDRWXTm9aELoyRZ/RoUTUUhDqJDERt10Q0ycY/bPoJhF1ybs8
	ixscan88MZYIz3kfe6O2q5IScpQKqL703Nt4WkC8xzcAurRBQPT5pxpi1DQz+IEG9tsvUHccjcbUk
	+6lJNxxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okp6Z-008UHp-Rp; Tue, 18 Oct 2022 16:06:11 +0000
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okp6W-008UAQ-OA
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 16:06:10 +0000
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1324e7a1284so17339456fac.10
        for <linux-nvme@lists.infradead.org>; Tue, 18 Oct 2022 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fq5kyyPbsKUWwekokR2u1feGH2ITW5Wkh89zI+stEh0=;
        b=jjrWOPA9KmP7QEw+lIMy3vKPFeeOac+HruAbVBuVMiy+o/JPaFvnUPkDtI8B6p7Si0
         ufMKhV9WDFp0OElsq3jpTmLSrkqO9BJIrdbrREV1PLfIB+sBSX0+qSOFL7WD83oEn6L1
         OUqH//HVJpch6y++FiECzC0kiqIeE3pGDlJbUZ/zLf3IkCj6yWPi3FSD5jqaSQ8PIAgf
         mWoJQrZGF0kyDHgxoEH4Qroj1kzXdbM9RtC5bkiEEMoe4/eZiHn4bsE4Vt+ZD8EoTrU3
         WfUkILiwZTzNjJ8c13+NuwSgBTm83vKk0FIYpU6qjIeAORe/ClXUHxsGbHCqoYy5FPdD
         Hm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq5kyyPbsKUWwekokR2u1feGH2ITW5Wkh89zI+stEh0=;
        b=61GEafbKzif7Kn2O6Kid+ktVQ7jd+CWDKVxDSWLxPZt5nKA8V6BT2O3tjf+g+XJcMF
         3pPq9Slil3U94tz9SAp9DaMwlreGrwesUcShJCyr2ss8T297tEZoe9oGjMJ0alt7Tci0
         HF7EDBLVQBHBOaKRO2U7Eb5tT/sfGphpAWyUrurN1KvOJSsUl52lWylIdHGkvtN68ZQE
         b6M/xeU1F3YatmRZk8knAcopt+1WDFt/GzRb0WrJyUUxVgQ+Aeozye3K3aEO3NFGVWKN
         eQAIfVubk+oOOMo2tDjJbFVdiIa4vuNSN6VJimrNZKF03WkjPJJgXoYtltwO78xvD/6t
         jhWw==
X-Gm-Message-State: ACrzQf3fxQZ5earNUFWPzfeO6S0TW4R4fCAaGLUhEU6BMTQ0DhgcFbdR
	iIJgsopAANmLw5eUu3Xu6WA7zz9qhE8=
X-Google-Smtp-Source: AMsMyM4XD1pq6b2uWg4kKRXT5OKaXWrli02LdyiTId/0imUQ/aTYW/Q5cKkgBnfXE6cI0Q3uj46BTg==
X-Received: by 2002:a05:6871:687:b0:132:fd73:4551 with SMTP id l7-20020a056871068700b00132fd734551mr18749651oao.195.1666109166682;
        Tue, 18 Oct 2022 09:06:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z34-20020a056870c22200b0012784cb563dsm6284711oae.22.2022.10.18.09.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 09:06:06 -0700 (PDT)
Message-ID: <cf97693b-2361-aa2e-bd6d-6a6873e3bdf7@roeck-us.net>
Date: Tue, 18 Oct 2022 09:06:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
References: <20221018150056.681478-1-hch@lst.de>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH, RFC] nvme: add Guenther as nvme-hwmon maintainer
In-Reply-To: <20221018150056.681478-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_090608_815036_CF4B77C0 
X-CRM114-Status: GOOD (  18.47  )
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

On 10/18/22 08:00, Christoph Hellwig wrote:
> Given that non of the overall NVMe maintainers knows this code very
> deeply it probably makes sense to add Guenther as an additional
> MAINTAINER for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Guenther, does this work for you?  I think it's better for everyone
> if you are Cc'ed on any patches and bug reports for this code.
> 

Makes sense.

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12984711f2fe3..fde92782fbbdf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14640,6 +14640,12 @@ F:	drivers/nvme/target/auth.c
>   F:	drivers/nvme/target/fabrics-cmd-auth.c
>   F:	include/linux/nvme-auth.h
>   
> +NVM EXPRESS HARDWARE MONITORING SUPPORT
> +M:	Guenter Roeck <linux@roeck-us.net>
> +L:	linux-nvme@lists.infradead.org
> +S:	Supported
> +F:	drivers/nvme/host/hwmon.c
> +
>   NVM EXPRESS FC TRANSPORT DRIVERS
>   M:	James Smart <james.smart@broadcom.com>
>   L:	linux-nvme@lists.infradead.org


