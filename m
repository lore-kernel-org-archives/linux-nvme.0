Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265FDD13587
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2024 22:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=km++zG4vg02Ht+RD0+buT69S+/
	MOagC5RDXOltRrnLS8i85ZHc5IIfWeBj2Q8AJFUDNxPJYCRYqfTYPpmXxKdEKNLijYwIN35Z11RV9
	uiPFxHwMrCfnQbXqDhhKkEg4qsHgHpzdwSFiXdNbUPX+MMCwxsamAFZtOdbNyv2pXLnp+V0Pha2AR
	7pEjEL109VkxDXZ45cAx0g7IfW8V/xpjCEZQEpJFZw9Hof+OGVepy5+60ewIlqNbutMdcjjnXhaoY
	rv0G3/kLd9L9nBmfXc3UQsDLkv59AICZQ2LsKMwWyhHWczT15LS/1Sc48YEkdPaygqQticMKK3u6W
	Cz7hqzaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5BOS-00000008z68-32re;
	Sun, 27 Oct 2024 22:05:52 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5BOO-00000008z5f-3LWZ
	for linux-nvme@lists.infradead.org;
	Sun, 27 Oct 2024 22:05:50 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43155afca99so32012965e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 27 Oct 2024 15:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730066746; x=1730671546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KOE4OZOdl4qvC14jprMgxPnFA0wkb4kHCU+3nT7vU0Ybc/BG2e5HnugCYchZn6TF8Q
         OPsD5gi7vZD0kySm1JfiWKRYuFy7m6JFstsFkZRxMC31jj3LdHaRab1AytvYa5/0ICXS
         KtMVZhhywg2x4TFfnWerZUPAG95gvRHA9WzM7TbxOXeFCG++dmcN0K87+bgccWyVyEqu
         IBtR2ohZXWLIx+6mqlhsm87Z6BWEbuXSMNe4+KA/Euq3Yyha+mTSeOS+0ocNzDHyaZ5R
         SOcwqWBLis2AfA+NOw8CDPiE3mqpfLSleIepGr+I0MYd1FULPLCro8T+31zGk46ab0uH
         44vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNQPxSO1MV7bIlA06yYUHq/WWJiCQbDEfaFEcVXKGKeyxaE2OwGExs99vbPupam6rWA5C56y/tVKuN@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3ZRYVBC22DiDMJD80tMQoB8oT2z7DdgOj07NHgKOyke2bwKiR
	61/5kYFRkojvGdQhLUSCPPVss8ARI6kH4NIhMfIQz1wEqlq7+Ukf
X-Google-Smtp-Source: AGHT+IFF8i/REK5BhY/aEoNJ22xqWDHuCIMTngCn505k4CdMAsz8ZlFDeAJZLMRPhl4hm9kvaInIQA==
X-Received: by 2002:a05:600c:3b9e:b0:42f:84ec:3e0 with SMTP id 5b1f17b1804b1-4318b5b301bmr102337775e9.9.1730066746221;
        Sun, 27 Oct 2024 15:05:46 -0700 (PDT)
Received: from [10.100.102.74] (CBL217-132-142-53.bb.netvision.net.il. [217.132.142.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b58b7e8sm119570845e9.48.2024.10.27.15.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 15:05:45 -0700 (PDT)
Message-ID: <28506f5a-fb8a-4702-ae07-0cd6aa43bb7b@grimberg.me>
Date: Mon, 28 Oct 2024 00:05:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Revert "nvme: make keep-alive synchronous operation"
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, chaitanyak@nvidia.com,
 dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241027170209.440776-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_150548_873251_D64DEF63 
X-CRM114-Status: UNSURE (   4.36  )
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

