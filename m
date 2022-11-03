Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5B9C4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Nov 2022 21:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TwWCq3AER+9qy0VGsdd8EY6lBEKzPPb8nN+YDaSPly8=; b=1k0xRt/3DBuozIZp9jD37y3SJM
	F7RlDbheNpMqdoEtk1wEWNn3xBvtx8fLLm7cRLCIvu4Lho+SOLt8v8+0e4fplXbWm7azLUDFH4mUJ
	MFTOA6y6BEO9qRHH+f2q65wCHR4xfzpPWEUiv247BnpzMrQmltnRHxSjLDg76+GDHyuxnr2lPjAjZ
	jCcbcRAHCV8ByaM8vYGMDroHmx1ez27DS1xblSnIWmDgEOXIU0Jr//E2g2f2da2Kf6helHhD5dabF
	SyMHRv5TRugmfUBmoi54YhQjSSkJ7UwXE8hOLcYQ6mrCbiWLzl1UnZbtqxqyxsob2HoLKUoIyO3E6
	oWDRiQew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqhcq-001jcC-Gd; Thu, 03 Nov 2022 21:19:48 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqhcn-001jao-Jy
	for linux-nvme@lists.infradead.org; Thu, 03 Nov 2022 21:19:47 +0000
Received: by mail-wm1-f50.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so4205549wma.3
        for <linux-nvme@lists.infradead.org>; Thu, 03 Nov 2022 14:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TwWCq3AER+9qy0VGsdd8EY6lBEKzPPb8nN+YDaSPly8=;
        b=EA/T6RiZBDlMhzwvRM73rL4QXVKa35IgT9Jmhjgg3NrCfSyBc5OBUlvIrIkNN17AxO
         G0hRwDxfmfOBEtSFElVKgTBaeY+mXZr6GA1aTxdunQZk5Qtp9rKU4Urd+OoEKQQuM36n
         hUz2azr72YGruEhKeXWWdzaf3Azmp5ShwHvTuaO9Yn6O2EW+HL6pyu8Q7Jm11FF0/txS
         /enTZfANS8wZCOXTT8VZNu7wU3lHc1VsXeb/42wcDNATWkUWzNVaHwV6jqT5bhnLkzAR
         8R8+gInMkDRW6jisD8fQz3thKzPkBs4S+GKPUZ7wqaIbfN+frvB8Rm0Vlza6r/0fQ1Gy
         +d0Q==
X-Gm-Message-State: ACrzQf3/cl6dTgGrPooV73OllVbHp5KIsRNmpucD40WTX9jdRtORJ+q7
	eLBVkfzsJRigTYIU6eNSre4=
X-Google-Smtp-Source: AMsMyM5V1OPw1MFbeGzss+IrkwSa8sy1xqnq97arQvHXctoGoTn2XXy33grs8L2gXy7XlraNmjWu3Q==
X-Received: by 2002:a05:600c:2212:b0:3cf:6068:3c40 with SMTP id z18-20020a05600c221200b003cf60683c40mr21324378wml.57.1667510383767;
        Thu, 03 Nov 2022 14:19:43 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id iv9-20020a05600c548900b003cf87623c16sm1169818wmb.4.2022.11.03.14.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 14:19:34 -0700 (PDT)
Message-ID: <4611b6ed-fb24-b17b-6320-dffc324b5ede@grimberg.me>
Date: Thu, 3 Nov 2022 23:19:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/6] nvme-auth: do not queue authentication if the queue
 is not live
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20221102075224.70869-1-hare@suse.de>
 <20221102075224.70869-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221102075224.70869-3-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221103_141945_726607_B91EDAFA 
X-CRM114-Status: GOOD (  19.02  )
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


> If the queue is not connecting or live there's no point in trying
> to start authentication as we won't be able to send commands.
> So terminate the work functions directly if the controller is
> in a wrong state.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/auth.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index b68fb2c764f6..719c514363ee 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -696,6 +696,12 @@ static void __nvme_auth_work(struct work_struct *work)
>   	size_t tl;
>   	int ret = 0;
>   
> +	if (ctrl->state != NVME_CTRL_CONNECTING &&
> +	    ctrl->state != NVME_CTRL_LIVE) {
> +		chap->error = -ENOTCONN;
> +		return;
> +	}

Why do you want this to run in CONNECTING at all? The connect itself
will authenticate...

> +
>   	chap->transaction = ctrl->transaction++;
>   	chap->status = 0;
>   	chap->error = 0;
> @@ -937,6 +943,10 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, dhchap_auth_work);
>   	int ret, q;
>   
> +	if (ctrl->state != NVME_CTRL_CONNECTING &&
> +	    ctrl->state != NVME_CTRL_LIVE)
> +		return;

Same here.

> +
>   	/* Authenticate admin queue first */
>   	ret = nvme_auth_negotiate(ctrl, 0);
>   	if (ret) {

