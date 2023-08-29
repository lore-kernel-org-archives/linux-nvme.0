Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DE2C83F14
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Aug 2023 11:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mnBRLlrjJm65dKWmzfp0myrxXxwEj3XstWIqKRwvXTQ=; b=WYAF05h/l7B2E6b9x3lvIEINWc
	mY0TRH+lLYrMK6LP4MAthrSvvwm2zp86EdFvPIa2tawB+8RKeQJWSSQ3Hrothxl5C5a2GFetjdY4g
	/oIf0NhLKXlbaaAmZqjAh/pgqEw3L+knkpTQJ9tEkTZZH+ddcsREIrbY5OXCNcpd8uc+RXMPFEh/E
	613b7od3sqpUrUsPY+hBvCnSDIpFA5UxN6uxTEwYncMprKhdygNQdbtfGIVb3BCuax4grL5rXw9hM
	jnxbCermVodV+EZsayKwPuqLU6AGdHpa+2hJrcwyoh38+TFMmRyc73+Lo52R5hjmjIGKuXB9Zq/ee
	lbk0BebQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaxBr-00BRQi-0H;
	Tue, 29 Aug 2023 11:47:23 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaxBn-00BRQD-24
	for linux-nvme@lists.infradead.org;
	Tue, 29 Aug 2023 11:47:21 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-401ce65dfc4so4520645e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 29 Aug 2023 04:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693309637; x=1693914437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnBRLlrjJm65dKWmzfp0myrxXxwEj3XstWIqKRwvXTQ=;
        b=jt6Tb/KwviFsDLRCKLhL+6nY37Fmvu9viEgicfiWOangl0teaO1JZ8hzA6Fn3Ybu0G
         jyi08edM6IV3qdAuFBrFBmAFUyo566NgsewsIt3BD+D55BsiNh3W7KcUF8xJcoPZI1NY
         i42eIyM/Rv0jSElzkmJZ+fq3xuQC1KSXw3xrnFCOBrzueluOf9GlpWjJW9WZA3T8Nw0u
         JKksFC4nKQTyho8uivsGRzjub2Uzkym5sDbI3vuq0Uyp2OKmZQc3JlyXw2ju4FO4lpYl
         +CEqUC73FeAwD2GkMxkvXv7NiY8cfqNB9hwvwsL93mbhpqg8E1ppSAbwseC3t/2TW3d4
         2e7w==
X-Gm-Message-State: AOJu0YwYfK1m0vTgeocApd9cPvUc/3kashu4X2/DUCORP+KFLe2xydMm
	Pcl0XQzj6iNMyeP2ckwz21Nx9pOGyt8=
X-Google-Smtp-Source: AGHT+IFcIjreaBHVB78N+1oJoKt7GAcxh2dsQ9uagonFQatQi8ZL8hckUUUre/MBZrryPL8M9OYrKw==
X-Received: by 2002:adf:fc42:0:b0:31a:e29f:5eab with SMTP id e2-20020adffc42000000b0031ae29f5eabmr19677721wrs.7.1693309636564;
        Tue, 29 Aug 2023 04:47:16 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g15-20020a5d46cf000000b0031762e89f94sm13429070wrs.117.2023.08.29.04.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 04:47:15 -0700 (PDT)
Message-ID: <34c159dc-c534-2329-4049-7e9e8a53cd4d@grimberg.me>
Date: Tue, 29 Aug 2023 14:47:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] nvme-tcp: auth success1 msg always includes resp
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
 kbusch@kernel.org, hare@suse.de
References: <20230828212033.3244512-1-shiftee@posteo.net>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230828212033.3244512-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_044720_570583_A67B0437 
X-CRM114-Status: UNSURE (   6.85  )
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

This is not nvme-tcp specific.
prefix should be "nvme-auth: ..."

I'm assuming that this passes blktests?

Nonetheless looks fine to me.

