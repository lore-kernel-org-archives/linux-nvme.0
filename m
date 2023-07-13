Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD3CEB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 07:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=r+R7Ma1YTVuzMX6zrCkQNR3Ofr
	uHiiJ8/BldQB4v0XRlmTkPPIN9Cb/8e3zcl1s6Sw8bLAhzl/oVlkeuHnbBJE1Qbi0WuebG7dTJ10j
	YgYUi2wvyvd/CMdY9E4eEOzJICEu56chrHlzgWD14QlEUlMf/Jvs0p43G9cqanUlM1BEhE+TruzMf
	2e06lO11oY6JM/tm5QzIRvy7N1fqYm+OKYnTsgwgNX7wwlQrLxcBTshqwaPyj3qdjOK236SJhGWhd
	b87x4a5IzlIPJ9Hg9tVD05VF0A9cmTtQHPCxAjS7SrzYpkzm4RSZIeMKfXM/IXaoRRS+ch5u506JL
	dF9Skg1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJqwh-002GKJ-2W;
	Thu, 13 Jul 2023 07:41:03 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJqwe-002GJc-2g
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 07:41:01 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fc03d990daso724405e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 13 Jul 2023 00:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689234057; x=1691826057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fxJcwI7oOxqoRJ8Iy4tMgoNdq/LPK2E11QjfdIF8612CQehFx3rtFG5QGDCVxnWQyq
         BAeDDWB9avapPIDKi3D7OXp8OCS7Oslx5N9+HtFcAsmIHDjAhGbA980RyKUzOfsdALaG
         yynvov0zJ4/EaZKlU3pU74sa/Yx+e5AHnyu4BVqsgGLx3xP5CflHFqSdjsIDyVbng7c/
         xsBRFwOfS/9yVaIgylDTburd4hlIfKnwVbLqN/LneEsGFvxsjnwvIHRcyCdj3Gog82v3
         W0ycPC8B49TZ+gTO372JwM0ai/a4SJpSpHfDi1yBnhlTjKm3xxItb1sUQhil6dVPQd+j
         jVWQ==
X-Gm-Message-State: ABy/qLZ5dkluAqgfIklQfDAXMCBp27AsSeC4A/CYY++NwnITZrPtbmrU
	UgWjp0SGufcjtIWZlqRmIUkpO+6zKOc=
X-Google-Smtp-Source: APBJJlHmJRDHFaKDw1UKTJTlq1RbUYHyt0Ovf3/Ax1JHY79B27Py98Xj3CIaMt28WoIR5HJi3Vg0Dg==
X-Received: by 2002:a05:600c:5191:b0:3f7:fb5d:6e7a with SMTP id fa17-20020a05600c519100b003f7fb5d6e7amr831441wmb.0.1689234056905;
        Thu, 13 Jul 2023 00:40:56 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba94c9e18sm7103021wmj.4.2023.07.13.00.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 00:40:56 -0700 (PDT)
Message-ID: <e7f86ccf-5b2d-d6bb-ee00-c3eed09071cc@grimberg.me>
Date: Thu, 13 Jul 2023 10:40:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2] nvme: warn only once for legacy uuid attribute
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Breno Leitao <leitao@debian.org>
References: <20230712152639.281545-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230712152639.281545-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_004100_873572_A3E76E5E 
X-CRM114-Status: UNSURE (   5.09  )
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

