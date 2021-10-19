Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F24C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:33:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED1961057
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1ED1961057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l07yJwvpt4gC7URbQxkuExm1F1rnL2quh7qmDanXbgc=; b=XtyzXZWXPa4v1p8XciIVDoHCNH
	A1o0wzei7rtfbV/mnQBVw1+IgioFrnhBq2hYgO3/ogsShqOR+8xEI072B/L23ve9vkOeyM/9X5dJk
	s53vWp5BNoR0EoWV3oYIWHIxs3A86C1J1ubXbk30b8oYUIbZF1OiElChRxXwOb1mtRAE+V192wIjL
	iNxabsznXE2AgKmns+DASQV2Cl/pLBLrzU8c49mFuXz1R4qXgDSVsdGDjaBk9dIKX3TWY+15aXR2I
	Li+Q+0+YKjB18+IZehdwDeP9M0mYGOqVhnAG9wRU2YXQCXEfHo2WENdj/az9FMo+ySFEbshbaC4Jk
	XFQplhmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcoIp-001Dgf-28; Tue, 19 Oct 2021 12:33:11 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoID-001DP4-Au
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 12:32:34 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 n40-20020a05600c3ba800b0030da2439b21so2569223wms.0
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 05:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l07yJwvpt4gC7URbQxkuExm1F1rnL2quh7qmDanXbgc=;
 b=xXhKpVWw5I7GChwXl8DSfX+5kq6dmeSYK8/+P4kPzbRLzk/g+pcTqy+O/xhX2I0CJT
 u0dCpPFxVLgTZPu2Z2CkJNhTPQ/ngupeaLJXjC5+MBqaA5bBz+qNwFK765bl/3gC9B6k
 DogT4G+tg5G7aEiOt/K8LaKDg3gyJNvpNjXSbN15e8eYxwnlx0LyQpmzLhcqAMIInNYN
 +UTbYw3v3bvo0XauSn4xX4BKOPUP/OlbIz0cFKWy9friTNIbYiuw6uWcjKsq76xyLH1T
 NI/Bn020L9JssUeocUejiljySrjmmPUMKAxr9QDbwE95i7wb1SjT6bU1eQ3vuEyMsG5l
 Yf2g==
X-Gm-Message-State: AOAM533G8fkIhKo1JfmATBAJWk559CgEwpN+/WM7rjKUbE+/zb5C+obq
 cmKm29qNT8p6QvlmhNy5FE50tSjzaLQ=
X-Google-Smtp-Source: ABdhPJzAZsTYz95W5EogSx06JnLFcmyUvksoapA90n7F+CZzB7Vnm2+UGiLuJeT4IK4h6yIuLkfjtg==
X-Received: by 2002:a1c:a508:: with SMTP id o8mr5682760wme.29.1634646751481;
 Tue, 19 Oct 2021 05:32:31 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id t11sm15026460wrz.65.2021.10.19.05.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 05:32:31 -0700 (PDT)
Subject: Re: [PATCH v1 0/7] Centrelize common fabrics code to core drivers
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com,
 jsmart2021@gmail.com
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <201a0ddb-cb5b-4295-8bdd-122cd1acb71d@grimberg.me>
Date: Tue, 19 Oct 2021 15:32:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018134020.33838-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_053233_423697_A481CC8F 
X-CRM114-Status: GOOD (  13.92  )
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



On 10/18/21 4:40 PM, Max Gurtovoy wrote:
> Hi Christoph, Sagi, Keith and Co,
> This series is intended to move common reconnection, device removal and
> error recovery logic to common fabrics and core drivers. In this stage,
> it mainly deals with the RDMA and TCP drivers which had the same logic
> for the above tasks. FC driver can start using this framework in the
> future after some preparation work that should be done.

This is a good start, but I think we should also see how we can
fit pci here as well.

