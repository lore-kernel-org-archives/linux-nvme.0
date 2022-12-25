Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254FBC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=cl4Ym+YWcA2++DtG4gJUouyFTl
	75YUk2sJFhXB0btYII9oustngOSy+ZUXWCWNTcKTljWw499ToltH0FdMCk1Bak8JkaiV3VZzBMkHZ
	ek/7p5uM6fDosbwW6fk0cl1sIzTFk7yQoNG2qung8ByIxuoKaQO62yX5seRlfB/CsT2fd/X1TbWoX
	7qKa/X2U1SrFOrSkQx/NVtDkS9B5IJ1XqJ1/R97Ym3QmHSrgxuQ/lJEFnMSXUQw0qN4+GUHGDabhr
	1nm6Oj15WBhkzZjGwYEUwitx0j3sn8uVGFX/xvwwlcZnbSNEnna+rs2J0np60EtlH6TzTmMQpA3CN
	/yzl5I0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OWs-00AAay-Si; Sun, 25 Dec 2022 10:46:54 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9Ntk-009pBV-HB
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 10:06:30 +0000
Received: by mail-wm1-f51.google.com with SMTP id bg10so6207155wmb.1
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 02:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=dgsIUAAPLJ43Rlh/MWQ2xrZF7xK92BdlNmTfirFx/+VB3zUZlt8kr7ukD++XUgrEiS
         0aLhfZ7HnbFdv0p93rLlImZEzMvd6INcMpnJVz5cHZcd1iGe4NvZCiWIyVmkf65NdiOL
         pVUqFXtuISW5YpioDvgBmMcB5xqgSiK5aL+R6M3h0Baxy0hegU/Gj1BbGuLDWSNrh6fn
         b4i3Z2Y3fO1WbTafaXVlKa0Owajd6vxHV3NdqhmV4I5cStCQAuB4r6/k6x1drX++vroz
         hJfmR0FwxM+gKWf2Ejqa7z/thNEiXmNLhGQwl6xsqxuTq6Yz6KXWunoXIKeomNTfLwK4
         nj/w==
X-Gm-Message-State: AFqh2krpe4Vg/A8a9f40NDl3ILVsJw0QH+s0HrBKhk3aRPHL1M1zy7qn
	7mQmrP7wrSAtapBNCZ55dOo=
X-Google-Smtp-Source: AMrXdXvvWgueskzxwzkyZMonOISF9P/s09sjY1ob+ID7fib5HQcCZ9OyOBD/XxrsWRAdRSihpNBi5g==
X-Received: by 2002:a05:600c:4920:b0:3cf:7514:a82e with SMTP id f32-20020a05600c492000b003cf7514a82emr11131722wmp.23.1671962785826;
        Sun, 25 Dec 2022 02:06:25 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b003c6f8d30e40sm16418467wms.31.2022.12.25.02.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 02:06:25 -0800 (PST)
Message-ID: <ef81df0c-4fe3-adbf-44bd-8c60fad5819e@grimberg.me>
Date: Sun, 25 Dec 2022 12:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/6] nvmet: use NVME_CMD_EFFECTS_CSUPP instead of open
 coding it
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
References: <20221223071814.43564-1-hch@lst.de>
 <20221223071814.43564-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221223071814.43564-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_020628_616009_8A0C4415 
X-CRM114-Status: UNSURE (   6.26  )
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

