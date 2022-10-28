Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9E1C38A02
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1gFqco6UEVzAeGcPhvFyecEOeAZPE/mx2wyz2/XqA94=; b=Y26zpYWyuJxGQfZKOpSkG1IJaY
	sxAKWgdXIj+vehna5Dl9IU7IdIHoNtjruWuwZMe2lrFOcyrrrnsW39YXc9LPfkp8BLfvVFYw1M/4Q
	O65e1wOtUA0M5DEHFlaumUe3lH9Ve2wl7UhJ8EHbhXoqzc3jasJkRGAOAFHtx6A1f7D8Bc7XFNU9h
	vrswhVOJbQ/meUHOZPq7jlLnJxHOondwYGMOREO11cOxX6s/YDEdjfFzVCO7eJ2mA1agC1B6EdLVY
	bPcSXRMvjrJDushPTzchXrSEsxY/zHlyhz3ywHvhD9KIOFnmpTdde/8Nh2dUBTRCkHCRk5lxgGaRM
	T0FXSUdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooSaH-0012dI-Ld; Fri, 28 Oct 2022 16:51:53 +0000
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooSa4-0012Qr-O7
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 16:51:45 +0000
Received: by mail-il1-x12e.google.com with SMTP id m15so1075220ilq.2
        for <linux-nvme@lists.infradead.org>; Fri, 28 Oct 2022 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gFqco6UEVzAeGcPhvFyecEOeAZPE/mx2wyz2/XqA94=;
        b=ulndHu9ozAehUbyrjxpcOxx1wsulqq8RjXODlkKy2EDGY8oAewQEydwAHrVgkFJjMB
         55JBEa2wUx0HETZgYmEeVvXJ6LhdLSasoDu8WoI+fHz+swmCAL1DUqxwW1QvD/xtxy2+
         WHXEr1gnen3Om5NJdE0pja41Ec4ZQotnCDVjRgWhC0YSDhgtRErYifDLiigukDbbUQ1g
         g70FmSed5yVv5kf0ogBwEiRO4V2t66LA+lsOs9KFF2ZIESnoEq06Og0OyWG4c2d+GWLq
         yuZlePi5/vFyO5cfQVooUygWr+12X4TGP97/fOeoz7YQ3jWyWFLqS+bhqa1GjqNxh9hS
         e+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gFqco6UEVzAeGcPhvFyecEOeAZPE/mx2wyz2/XqA94=;
        b=Yu1aUOoqHl50hkqZQhKQk3ZqlpBtVV0KZdC30SzfyurAmeLe6K9fnX+2qWHfDbv4eS
         5fBRfJoswRjAf2R8W77+ftKy2bPGeoNcnj9bE4KluXZ5m6z+1RuYtcPeFVkqxtIzMg4u
         ZJE4PaRUvghGRPAPqK+DnnZR/VmX5ZKnFYYYOSNXJTn/UHga94XV75Z3Cnwbyienur4c
         SoCzhx57501ummCGNu+fZi/xjcORomKzhZkcnjdJzf9oKx1PjieEPHD3LtYQK1CpVYtA
         +F6wHk33eM4rGp1dwqU69Wt+f4dPUh3elAN0nz8zsgbWXLDNIMXRqhMqGhEazJ6XoryC
         Js8A==
X-Gm-Message-State: ACrzQf2/pokxYk8VvVrQUdsSmDiFuhs8kCVOCJ0kXJ9Ln1t4EHLQSVDb
	r9Rye/hblFxYSIi9+tvYr07YgQ==
X-Google-Smtp-Source: AMsMyM4mp9UwbYQ6rj5Y6Jte1jHl8DsEqXZ5oPAe4yPSynzguEE2SgwfMtWTf3+/jn4t2bDEgMDexQ==
X-Received: by 2002:a05:6e02:180f:b0:300:2f31:a1f1 with SMTP id a15-20020a056e02180f00b003002f31a1f1mr148460ilv.179.1666975898595;
        Fri, 28 Oct 2022 09:51:38 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m9-20020a02cdc9000000b00363aec42c13sm1891276jap.65.2022.10.28.09.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:51:37 -0700 (PDT)
Message-ID: <4a032972-c012-39d4-0601-24f85594fd60@kernel.dk>
Date: Fri, 28 Oct 2022 10:51:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCHv3] nvme: quiet user passthrough command errors
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, chaitanyak@nvidia.com, joshi.k@samsung.com,
 Keith Busch <kbusch@kernel.org>, Alan Adamson <alan.adamson@oracle.com>,
 Daniel Wagner <dwagner@suse.de>
References: <20221028144435.1613982-1-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221028144435.1613982-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_095141_080418_1249ACFF 
X-CRM114-Status: GOOD (  10.15  )
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

On 10/28/22 8:44 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The driver is spamming the kernel logs for entirely harmless errors from
> user space submitting unsupported commands. Just silence the errors.
> The application has direct access to command status, so there's no need
> to log these.
> 
> And since every passthrough command now uses the quiet flag, move the
> setting to the common initializer.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



