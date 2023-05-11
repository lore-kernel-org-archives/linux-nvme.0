Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70799C7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 20:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4hjCuhDdEpisTNEgIUNHt8mdh/WtukpJUPhW4o+llao=; b=DKLW6dFy8ocUf0gCyZ30N+cpte
	DMI8gMWgaXieHr5xmjXnq/HUKJ2uhrvIJ2iWqj8N5Ib2sQsJjW0sOuOJyX9ytIYgN5JAaePp67NvQ
	tJqj+A3SWyTlOsL5IsLBaDWSyiLn4Sase6KSlhMiktolT2M0ZQ/TSu1dZgpiKY+ZLIJk1IxdVkqJc
	Zmh9MhSE6sKQ0kYNIqTi+g1AZ4Ayd+SSSir40Ba+/jTWZBdbs0R7RNeRIVDzruJWrwvgO3EoxA1es
	r938ewwlCeAzGTTMDrWg6YZJvaanqsNSsUl9MA3oA4Dv2CS8+45AgZWVYcxI0PKmOG5P7NSi1uMzW
	PbS3PWUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxD9B-009wWn-1r;
	Thu, 11 May 2023 20:44:21 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxD98-009wWJ-2A
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 20:44:19 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24e5c1f6461so6264889a91.0
        for <linux-nvme@lists.infradead.org>; Thu, 11 May 2023 13:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683837857; x=1686429857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hjCuhDdEpisTNEgIUNHt8mdh/WtukpJUPhW4o+llao=;
        b=DzptXMJESoyD2cU6GH7BV0t5a3uv+1D7VfT2KoLoczknojYd0DwBwVxS/eWthAieQQ
         hV1IvRE2P4Fo+45Tc06HCzsKRKcBdBRbE9sDTxNaVwX+sHDzhbrX2ZsEP+59QYUraARQ
         Z98FmW9d2rssrFBBPfl2ZwTGpqjUzEtzVky1JG8FP0C4B7rYWWjr9ZfoFhX/8WV7mMdU
         PWMN18rWFyfJlRhZUKGMf9JG0UHkX6nLqhJAtF24wd1F/pnpvAYsoHa/RlGBVfwMs9Ui
         ZdCgj69aBqIPQtNzj6lG5OJRQYs5I3N+NuDeukeFspYIRrC8kGuRZeedGFwD0KiZzEK7
         Avbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683837857; x=1686429857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hjCuhDdEpisTNEgIUNHt8mdh/WtukpJUPhW4o+llao=;
        b=DOE7YDS0+GIFOosFo15OEtZ+lALDDUGPRdwDgSmYIv9CjEZgjBpWLjfVWAqdDDpwe2
         zy2KUB05ykNnQd0NcwqsmFnETjDvRocaSoX416AibtSMDToPBJ3Px0hQoAikb6mmer2A
         8twC5WfjhWbiWo5DRAHcZxqNykxQBlC2e/NuhQCtFNC6kUEVdOOrOoekJuouyDrw//Sd
         dGPXSEgGVwF0jMA7ov/cTs0kCYjRECCkzqkf+9XFoJLFmZzH8qAh+oHVGgHl+rZrIwA/
         u87k5xMZb6AP91EA8ikYPru0sIT/giLSPij5OnpKh6sBh0ouAH8/OmOLh6CeVC1BsPUR
         IDlg==
X-Gm-Message-State: AC+VfDzCb7UOnPhiH0Af9e+6aIdwwm9+JlFabxfMdz4a/kV4AFJe1S1u
	7ZQYU3rHO6MIsWYK87cEf48=
X-Google-Smtp-Source: ACHHUZ5hQnUC2s8ywUsFomsmvpvRU6S4XCPDUAhd7Tb1dugMgzmlRcrqmf/Hr3jtex/qu9nuGVhixA==
X-Received: by 2002:a17:90a:db07:b0:250:a4f5:fb34 with SMTP id g7-20020a17090adb0700b00250a4f5fb34mr11969525pjv.2.1683837857291;
        Thu, 11 May 2023 13:44:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s14-20020a17090a760e00b0024e134a2408sm18906917pjk.14.2023.05.11.13.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 13:44:16 -0700 (PDT)
Date: Thu, 11 May 2023 13:44:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: host: hwmon: constify pointers to
 hwmon_channel_info
Message-ID: <38162cf3-44e8-4774-b60b-539075369699@roeck-us.net>
References: <20230511174650.279452-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511174650.279452-1-krzysztof.kozlowski@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_134418_729599_885158B8 
X-CRM114-Status: GOOD (  17.63  )
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

On Thu, May 11, 2023 at 07:46:50PM +0200, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> 
> Changes since v1:
> 1. Correct whitespace (Christoph)
> 2. Add tag
> ---
>  drivers/nvme/host/hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 9e6e56c20ec9..6aa153f3178a 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -185,7 +185,7 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
>  	return 0;
>  }
>  
> -static const struct hwmon_channel_info *nvme_hwmon_info[] = {
> +static const struct hwmon_channel_info *const nvme_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
>  	HWMON_CHANNEL_INFO(temp,
>  			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
> -- 
> 2.34.1
> 

