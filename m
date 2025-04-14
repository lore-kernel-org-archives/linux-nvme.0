Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA299C369B9
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 22:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UnBojxyK8AJskXSUV/SUBz0D1VplfvQQo2KJOpyb430=; b=hRbh3KbQFOfoXwjR/gkp1VO73g
	1TkbDxNb+9CHorMQDTRVuhbmuDHmLT+v4qBGHnM9fxWHMnq3wL3GCJIZBUX3ztJV8qE/RecJsghfW
	tIi2d4KCRJPlZhwU/elwmsl4L/73OEJqhan1rIIguOiO7DyY90F6cJ+YNrpO+iVHpMea6aOq/m30A
	voqwXyF8jCO3N0mJsEHPFT150YISrtYFdYbco2ydnneaQ2cK9NBAxDLwyr6gdtY6zq315GNGBFDS5
	thcaoCHhPH+apVcazdWABo5YC5Ki8cZTRGwK76TYP9EVbhezIj00dBLSiisrcIAWTve2EGDfMbeck
	6/8Ym5Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Rxw-00000003g5M-2CW5;
	Mon, 14 Apr 2025 22:07:44 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4RhF-00000003cM5-3jZE
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 21:50:30 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39d83782ef6so3807078f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 14:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667428; x=1745272228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnBojxyK8AJskXSUV/SUBz0D1VplfvQQo2KJOpyb430=;
        b=btDuPQciwkw0FPY5eZSnxG6evdOzT6LorxRMUCjAFHn+wbHgWQ45SKCgEOpmjpYb6J
         fa7CvhE6sHuKARNU12ef4lYpXSL/M26pKOWbHbJhfp+57hrFER4L2guMoJHbjmY+NS41
         V7fMYTsEde9Fj/gHek+P5515rRWawOG+Yh66lNUIb21Y7oRp0sUTSXBx52jhOEqw2bSl
         IYJCOdyJczuRkHgYAAZ24earhy0pCW7cwEa47Ru/k9cHQO9CTzXZwWicLPmBAVzCVdpW
         C2z50D+oTcLlLybIyluwJ3lP5+SKYI80OA1ZxJIVWAAEm9FghYGLCcxVAzQbxCuODh8u
         IRHQ==
X-Gm-Message-State: AOJu0YyvN7LIdIOxV7OYkt14KKBtIst+ni9ndPOZ1KeZrCIQ0xqUrnPH
	ane4R7M4qR/BdKkI7WFGnEgCaHwRMk+l0XtTB8rq5EVXFAgsu1C8hXfB3JAN
X-Gm-Gg: ASbGncsaM+EWQpd/9zfBgIP3RH52buLbPRoMOgpSiEHTi3vASZ4e7dAUNPrBftVjmsP
	x8o6ySM1DV5XF/D9BWC0ThGlz3kk92q/dec3cM//OFaMf4n517TpVAxXKc91Xis1InFXt99lVR3
	l9d7Osw+9i9LV5NGcaVg8kbpWz4Xf9SUa/cNt66MzxfN90Jv1la8CejI/CgruUGStYSVK0qPLxf
	ftuIeFZFU0VtvJQbKNcL+TZrTULqLEoVtweeJmk0/Cis2HrEKiHTFgTuGczoiwQOs6jvn3yvOY2
	hFuL9U5hoNqU8QBVDIVfNNmUBxtkioEk6g9kPuhi/P60HW4COD5HiYTJ6nsKIbJKdHNVKQoz
X-Google-Smtp-Source: AGHT+IHs2+5L8C2jN3K1JDEA5pgerFz+MtLOqiqcBor3LjCHELkbnnxDEZL3sC5IQsqIJta9aJ7I+Q==
X-Received: by 2002:a5d:6d88:0:b0:391:3207:2e68 with SMTP id ffacd0b85a97d-39edc3055c8mr643458f8f.9.1744667427934;
        Mon, 14 Apr 2025 14:50:27 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5d82sm188851805e9.37.2025.04.14.14.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 14:50:27 -0700 (PDT)
Message-ID: <d88872cc-a58d-49a4-ac3b-3caf29102949@grimberg.me>
Date: Tue, 15 Apr 2025 00:50:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme-fabrics: reset admin connection for secure
 concatenation
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <a10a314e-0a2b-4b28-8aaf-38e4e2129e3d@stanley.mountain>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a10a314e-0a2b-4b28-8aaf-38e4e2129e3d@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_145029_942184_A8FD87CA 
X-CRM114-Status: UNSURE (   9.91  )
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



On 22/03/2025 9:40, Dan Carpenter wrote:
> Hello Hannes Reinecke,
>
> This is a semi-automatic email about new static checker warnings.
>
> Commit 104d0e2f6222 ("nvme-fabrics: reset admin connection for secure
> concatenation") from Feb 24, 2025, leads to the following Smatch
> complaint:
>
>      drivers/nvme/host/tcp.c:2359 nvme_tcp_setup_ctrl()
>      warn: variable dereferenced before check 'ctrl->opts' (see line 2355)
>
> drivers/nvme/host/tcp.c
>    2354	
>    2355		ret = nvme_tcp_configure_admin_queue(ctrl, new);
>                                                       ^^^^
> ctrl->opts is dereference here
>
>    2356		if (ret)
>    2357			return ret;
>    2358	
>    2359		if (ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
>                      ^^^^^^^^^^
> so hopefully this check can be safely removed.

Yes it can.

Hannes, can you send a patch to remove this check?

Thanks Dan.

