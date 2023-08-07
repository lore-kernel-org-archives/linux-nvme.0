Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F146EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=14cHJWW3ugS6saw8nDfxz8czbb
	/CVP7aRUA9oUJebDpmIS8I/caNKSIQMqGlfy0o3PFAdEPyVj2G7rEk+HyIC0fVnxUmSplQe7amSv3
	vKcrmxHEqcjJz2rtprzf0v0YyOawEAt7NoeTdg2Q6G1/qB7CBzDj+pe0OwyDGIWWFgaPHe+j6SeZ2
	e5V0bZ6LcgdLRWW+7phHZWXh0pbx1IrFVKfJSBtRwzl34S1uh1/KCPYmQpQYc07MLG9pFkkvPa/fm
	Ff1hVP4X3m+bGrpEFtz+KkCaeTNJAJwpHj3cEhEQzOpTQrFtewDWgXqsMUDu2U+EPsSuYeDcT1Qcy
	DSSQZvIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuOc-00GKgK-0k;
	Mon, 07 Aug 2023 07:11:18 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuOZ-00GKfY-2T
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 07:11:17 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fc03d990daso7173945e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 00:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691392274; x=1691997074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=L5yM5k24BjqRZjhFkfo29A9YBQK9wOlIsyIFolPY1tXqDBjCyw8kI5ZyiPXj0H8shN
         FVzC7mAuV0DNLNGyWz+Rw8Gl4SnInH7iZ3aL++CejvKnQ6OHP+n+vwX6APIOlVEQAbYo
         s3MlH9XTCSoGIRDeSaTgz4+bmfK4RuVNBw4WepsJcPmAAxKLeT6WnGivQEV0gMYTyj+7
         rhMWayXW62LOPU+i5UbtOqCBWJhzGq7riscvtuX5ECy+pJwSbg9Vuu3LhO4rXLxVG265
         07ECpOm7/Rl9sC28sMjg4nq2ca8cRc4AvOQ776o7lUhSii3qtAzFUoBVIkh1nITwFNc8
         662Q==
X-Gm-Message-State: ABy/qLZ4F/kbX4q5rth+cy95YGRU+uB28DwlUeKtQNkGOYIargr6+vLY
	sQBslUZvVQEfRFL+F+om33w=
X-Google-Smtp-Source: APBJJlG6j/xAwlZr3sMwhV6PpoP1tOQk0y3W5M7uTtW+YARI01P6mbqLuFEo/P/HVEJRqAt/GMlTNQ==
X-Received: by 2002:a05:600c:4452:b0:3fc:2d8:b1f2 with SMTP id v18-20020a05600c445200b003fc02d8b1f2mr22240026wmn.3.1691392273823;
        Mon, 07 Aug 2023 00:11:13 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc347000000b003fbdbd0a7desm14132336wmj.27.2023.08.07.00.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:11:13 -0700 (PDT)
Message-ID: <b235e529-e8a1-5a5b-a02e-7831384d0bf4@grimberg.me>
Date: Mon, 7 Aug 2023 10:11:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/14] nvme-keyring: define a 'psk' keytype
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230803105102.30949-3-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_001115_798909_CB2CD787 
X-CRM114-Status: UNSURE (   6.57  )
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

