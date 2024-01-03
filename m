Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532CCC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 08:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wVqyrOg+1RV/LBFr4y9/bhWnxnEg/HfoYtQrhv6eK3k=; b=ow8thd4ONpOY2DepjrZ7nzI43t
	YNoyBD4at8mylv9Np32gr/xgSJgZpTPRTPCsCjNDXc+90QqZpwFoHzNp5AJgO3Z7hisSnzrmPCWno
	7HpD69ctasJ6YhkdShCXRNB2SO8LlHrdumWslJd0DwCvG/4WxScvK+V/iJGzNU45oXI+wyB7fvMlS
	jSBSj8YFrI7blEYyWJe+GtZiiyWwUb/vNnMO0Nmr7LF5/d+Gkpk1fKiKt3HrOVPnATSE9/XKT4sgi
	0uOyiLGDVrwPJR/7cHuzuDJqeHNp6panXzi4N0GwM35s2yplMb7e43TL2ZOY29PSZTczDWzcw2gpK
	EoTRbtJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKwky-00A5iR-0C;
	Wed, 03 Jan 2024 08:37:44 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKwkv-00A5hr-2c
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 08:37:42 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d3da82e29so21805005e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jan 2024 00:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704271058; x=1704875858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVqyrOg+1RV/LBFr4y9/bhWnxnEg/HfoYtQrhv6eK3k=;
        b=EW+iA/LQch85pKJhW46PFbmNXHzGiQ8tvKSL2UECs0jwoZ1lc6leFTbzJG9EcatosM
         ZCsR0NEyR5xYIGBHLjqIMQmR47QSEPURDh1TaRqZ1vHjVDYGDYELrMxM4Rc6Km3fDeZp
         75KlSNXTFtxk+nB26uwbdziJl9ecs1NcfcjPi0BqK57O+t3MEQHkUuYpdVs6H0aWsKwz
         4RXBz7mSoNPQFUCIwIRluWAM+P3TiTZrbPYkY8AJo7RAwV0zKYzw4f6cFncTm1/qWFky
         fgr51/f/vWZO5IJpdCj9yhMY4NEwImbsy0jTLeCqZfmd96+9Q4Tm1ejOExgOLnrrzClS
         xHUw==
X-Gm-Message-State: AOJu0YwtHKmHviCj9ZlTNHBCU2llY9HvB8rXuuriviQI34oYfaSR7yam
	M6zDRac/MMapLcwloJ7MEz4=
X-Google-Smtp-Source: AGHT+IG9kJTxfYFC+UWEFphMYfgN/slNEihCwBZTKRByI+BRI3eihZB1Xx+GwRS0qT18Dzm+ZvOyRQ==
X-Received: by 2002:a05:600c:3c89:b0:40d:7720:30a6 with SMTP id bg9-20020a05600c3c8900b0040d772030a6mr9038292wmb.3.1704271057912;
        Wed, 03 Jan 2024 00:37:37 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d2-20020a05600c34c200b0040d61b1cecasm1578211wmq.33.2024.01.03.00.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 00:37:37 -0800 (PST)
Message-ID: <9f1220b0-3b3f-40d0-b1e6-14a14fcaf911@grimberg.me>
Date: Wed, 3 Jan 2024 10:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: tcp: remove unnecessary goto statement
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, hare@suse.com, linux-nvme@lists.infradead.org
References: <20231231065644.23319-1-kanie@linux.alibaba.com>
 <ZZR7jF79Cx6V6m4I@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZZR7jF79Cx6V6m4I@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_003741_851027_02308C32 
X-CRM114-Status: UNSURE (   6.93  )
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


>> There is no requirement to call nvme_tcp_free_queue() for queue
>> deallocation if the pskid is null or the queue allocation fails, as
>> the NVME_TCP_Q_ALLOCATED flag would not be set in such scenarios.
> 
> Thanks, applied to nvme-6.8.

Can you change the title prefix to be "nvme-tcp: ..."?

