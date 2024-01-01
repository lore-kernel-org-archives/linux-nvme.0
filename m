Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0493C47074
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V9WZE5tQflVY7wcU5FhMs8vgcXQ6eondacOOpyY2Trg=; b=tVekryadxWkIqIS8ieCizsVcrl
	IZKlCukOU+a/E+y+XEMgrkBowI6Mg/b1leMQSjCjJSm1GSnuW5COqNbZAX5rGhBBOz32HzuAY5VC1
	Oa5ztmuPjuIT75J7OdYLGIUPYiUhBlL139maZjuq61MKOsQGNuMhQlNcB+eWdbVMgXAhJ2CiclVb8
	Dxyto4/YOQnuCcIGEPHr7DZ1djIx+9PWVaZcEIMZFADyNqVev0SHzhnNpaNC5CcR17j8yWlOwCGig
	KVU5dHKNT6QtakRCzDpfk2n5QFjGVjMaoOyixJMchGctz516Y1ZboQ1VnZUEPOikpMfGEYbPsU/wI
	Ou18LOOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEju-005q9H-06;
	Mon, 01 Jan 2024 09:37:42 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEjr-005q8U-2o
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:37:40 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d5a733823so2500665e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704101858; x=1704706658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9WZE5tQflVY7wcU5FhMs8vgcXQ6eondacOOpyY2Trg=;
        b=dI/TywEKR8eIQvKkeZ07XIydHAwFyVEqYVAsY2pryLK1tzCrTLsHkSlzDUq66jMLzj
         dGyZ8DTItkxZ2odS2jyfoyJHCVI6IxqPfMccFy2rYAJW3znEWpTWTy6XGMvSKyq6XCuk
         3hAutwcZP6XPRfjIhrhzdbSxofjTO6/c/7+83vevZdZoVsMI8bfFolea2ZKBRt2NbsPS
         /Jf2n31N7wVsXnZ5yg0RGbuQB4XdlkaCFY6LK24Qph7Ri8ivxQLHsvs72Z3hAF5Enhhe
         7K+drfwenSzPIBBK2hqL8Bj1N3ScqqquzpGMV5V++qh2IRa16T7N0s7DmbWInMF3sqGM
         eemg==
X-Gm-Message-State: AOJu0Yzs3tg09+ddMObjGgXgCbw5TXzcmyo3pIKqItxpExJ7GWg1aItr
	AND5BwGxJZPfTlFYnO26gZFNAmedVeo=
X-Google-Smtp-Source: AGHT+IEOuAf1DoQ9oW19SKV+d0hmbv3HNUsos82fW3J3v1wQWALri4QNxh6eoV8qrKGHh1JCUtyq6w==
X-Received: by 2002:a05:600c:16ca:b0:40d:3ae3:2337 with SMTP id l10-20020a05600c16ca00b0040d3ae32337mr19166353wmn.2.1704101857896;
        Mon, 01 Jan 2024 01:37:37 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b0040d2dfb10e0sm45883926wmq.11.2024.01.01.01.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:37:37 -0800 (PST)
Message-ID: <7c408936-07a6-4477-9c11-94977ef62513@grimberg.me>
Date: Mon, 1 Jan 2024 11:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] nvmet: introduce new max queue size configuration
 entry
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-10-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231231005249.18294-10-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_013739_905316_DBEAB459 
X-CRM114-Status: UNSURE (   8.65  )
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


> Using this port configuration, one will be able to set the maximal queue
> size to be used for any controller that will be associated to the
> configured port.
> 
> The default value stayed 1024 but each transport will be able to set the
> its own values before enabling the port.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

