Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8D3C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=m/3jxlXXDbCb7DGYDbgyclwh7T
	L6E3GELYdbyECdeUOHB2XZlYLR5xJtNWMUVDgx1sCORfFo12NF+VaUVRYOaCiJFFYHPD+6IlbFLLc
	qenDCoWM6Ct1MxJiUVQsUpLEHlMj5v0Y8K7y+Q4W2KbdejOfovsY+mK3c+5SO1akaQ1fW6RZk4h6N
	3ZUMN0/I2hCrBGFaL1gIhjl8yeUUC59xuh/OE6n8CXIsYSFTwgRzUE/PaISfntPIENUF7OUCrOjv+
	6JKJPkLUUuE2MGWT3+iqiU4APDZBOPQeX9LVNK98o/uVoLXmyHxIUnQ799dQ8IGXpmvxGeb1X0hpJ
	yxjkDJRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rScjC-003Lhb-0o;
	Wed, 24 Jan 2024 12:51:38 +0000
Received: from mail-lj1-f172.google.com ([209.85.208.172])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rScj9-003Lgf-15
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 12:51:36 +0000
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf2c9d91a6so651061fa.0
        for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 04:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706100693; x=1706705493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=U3QWvBF/0RzOyFr9yIHRCdIK8JNgQI2q/YmQMo2YVjCW1pNjPQiPy/9xc82exty+49
         uw1blavV9N9cDpDUa4HwIk1f5u6u09icSOMMy14uyeqcB2M695fjnC0IxSg3YAhIKmCB
         Y0ANyW+gHemZpLVv2kDsSZo+8G2W3ve0bm8Fik85ncOPWS8n94s0UbGY/FT5tmN+73Jb
         P65zJWu/lbKVRPafBfHbQmYQLyA2YC50hNHcX7e7VS+nBjiEyC58A8yE3SIrnTdGRdE8
         d/zWU2zYo9OwZ9P/pjZfGcY6bTHXHXBtImedVFz40G5GTMhfrgEIDuu77uMkssEgnnZa
         5Csw==
X-Gm-Message-State: AOJu0YyqO3GOom1cam4yxUrvmRhO8FpA0ZVZJTWlUv61oujkGHYisW0/
	x9ydY2GRkYe12RBUjZ7+P+YjrPHm2l25N+Y6k3MX7h6IdyVXYRCQ1N71c2lv
X-Google-Smtp-Source: AGHT+IG16o6Alu64m0YEUgQ84sJa4laZsGxtY5j4BgM3MkjscB+xLeO+SP9MaII5WNAk7sVjzI6WNg==
X-Received: by 2002:a05:651c:107:b0:2ce:ce62:8f0 with SMTP id a7-20020a05651c010700b002cece6208f0mr1490393ljb.0.1706100693293;
        Wed, 24 Jan 2024 04:51:33 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id vx6-20020a170907a78600b00a311a360433sm653189ejc.143.2024.01.24.04.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:51:32 -0800 (PST)
Message-ID: <f1f97480-5ee0-4ee5-9aaa-0eab3380cdec@grimberg.me>
Date: Wed, 24 Jan 2024 14:51:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] nvme: add module description to stop warnings
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, james.smart@broadcom.com
References: <20240123221341.7902-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240123221341.7902-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_045135_378946_EF1272B7 
X-CRM114-Status: UNSURE (   4.79  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

