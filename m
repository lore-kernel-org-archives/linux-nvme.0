Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92415C77B73
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9mU7ro5HcFAICVqy6W2mlslgDQU6AbDwDcSi7rn2jLs=; b=UPAUfYhu/di3bvvD3i3Xmoig5B
	9WGfJBISBaKZ+keWHzhHlkMfrETeefa1YQ7mMwyFyV0ZyXlvd5y+Gscn50bmIjkFDJ12NinPs56+F
	R0Gi6tD/IUzcWzAF4EMFnBdkUxvy87KD9r916MZWsx/ZgDDFaSKRM0ST7KDGqDzvlTft4gx8MF6qe
	Nwv7D7R7WvpKDLimTUoQ4Qd/zgHiobgIf0UHo1cO/GlcVJGCzh/NZJ+u3VU10iYo4+y5sXi3aa1Gj
	IZgCYSWtizOgPOQaRsOKFThL2jZkBIMxI+MovH4TarATEFNgTB3FGjvjrWtvAtoD+Af5Jeys1E12H
	vsDrkafA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqy2k-00Gh36-2j;
	Mon, 24 Apr 2023 15:23:54 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqy2i-00Gh2l-0y
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 15:23:53 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f167d0cbb7so10217955e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Apr 2023 08:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682349830; x=1684941830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mU7ro5HcFAICVqy6W2mlslgDQU6AbDwDcSi7rn2jLs=;
        b=DeZ2aA2LmHVcTE/8WRUeqwZfCc0yIjtRcjYAbFeYy8Nhxv0BFTRK8ec2HOZ0DVIbta
         tKQGSBWFJT3vs0wr5sLymUKEgpJqz/5pdZ+pjA0rJaNYwWUfpW0O0A/dk6UILH9dPvHK
         5C8fay3MaWogHFkPA1VTzwoB9p1uQFBhsX/xULtc6ZBP9t4h+G8+/6O3X2XdWMksrRBf
         MNLPdAzsvZ8miWENQcgcsP21s8MTKcDjp6My9R3CRomL7feR89PrTu1oZfK+PVm43TMh
         k5eRaXRa+MToqywDqH+byZ/61yC/pHPSWR5Zj988z9B/cwgkYRVZ+V2mEC+jzp0x4c5B
         a8MA==
X-Gm-Message-State: AAQBX9dgb6uGdC0DGWOo6NDZeQLHwmOYeahd47Ky1+jha1L3f7ssJBmd
	v/hqkFsNpSlUKrDk/JXY6Ek=
X-Google-Smtp-Source: AKy350YSnnkIFJj7b06mbLsg4FixSzn3yuiBzhssFilR18Zcfiwv7bJPCxS8S7Uoh+eFzbAlnDZCvA==
X-Received: by 2002:a05:600c:510a:b0:3f1:9242:5994 with SMTP id o10-20020a05600c510a00b003f192425994mr7724312wms.4.1682349829560;
        Mon, 24 Apr 2023 08:23:49 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003f1958eeadcsm8344453wmq.17.2023.04.24.08.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 08:23:49 -0700 (PDT)
Message-ID: <162a487f-f651-50c8-3ddd-cbe18fb0bd89@grimberg.me>
Date: Mon, 24 Apr 2023 18:23:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] nvme: add a dedicated .c file for sysfs interface
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk
Cc: oren@nvidia.com, israelr@nvidia.com
References: <20230424141818.16173-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230424141818.16173-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_082352_355993_5C61F9D2 
X-CRM114-Status: UNSURE (   7.27  )
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

I'd rephrase the title:
"nvme: move sysfs code to a dedicated sysfs.c file"

Also add a short comment that the patch does not include any
functional changes.

