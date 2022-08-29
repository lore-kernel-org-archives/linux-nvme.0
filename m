Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2626DECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=B3a7wDn/S188wxXMlZHqaGsK1i
	7rRqa+9joZjs8sc2QZxkOAgs2AZmFDIP8ri9wa4yec3jKUJLibMYzrYjeHA6nhdpnbuFYgKS1qgYp
	r9cMHRFfaaFqpQdelJbiwid1tPfzKJxb87fAtXG6Cjp53FJOoJCIPb02z6KD67a1ZZfrJ+/aLDC54
	AMP1Lxdd/VxTCKzD8DaufuELupjDr8+CLQDmNcKpaGnwMZ/yQYuhb4koFMRxsF0CT/oSnuSAxbzTX
	6jzgUJi5HaRLWKD7gJr2fJLJ3NllXbR5wJl/ZKT+4okVxcNZKi4GZfC8c9XeEV7K0X34si+NZFUjp
	aH1aH1cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaeh-006Ts1-S3; Mon, 29 Aug 2022 09:02:03 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaee-006TlE-BK
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:02:01 +0000
Received: by mail-wr1-f45.google.com with SMTP id e20so9265974wri.13
        for <linux-nvme@lists.infradead.org>; Mon, 29 Aug 2022 02:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=4ZaIuAB5FBlZcc7EKuZ7bdEkeFZY4b396O0CdWnw+NBJN7j7SnvHwxatDXGKkjeY5q
         f9LifD0chrW8TkQXKUXW6fdJy94XgV/uoTVtCnJZizCfhseY+Nqpv5IwovnsCMcZKK+H
         ES+9pFC/7U7PUf/65gsjm/nOOdxEf68zTb+tgFTu5Y0iIHXD4DzzElR5w+E8JcoJtkFe
         b4YewQmjjuQR2x7aJZ1NlITJSp6bF2Yoj4Bt+ezGMsvPOwzWgmcGOv2I6TEe565uzChn
         vgVTh+c5y+X7d8rnX4TLmBWtfz4+TXG+NeX/FOO92j3TYShZBzNjBVKdFl8w10yLABx0
         agAQ==
X-Gm-Message-State: ACgBeo1u5D87kGth2tToJvSOEG3Cq67foKWUV+HoZzfXbi1lHi7f9pZZ
	N3c8KX2H5luwQxr54N/kin5j1+2Tq6w=
X-Google-Smtp-Source: AA6agR6phFqOtyP1ni2T+HyPizfV0IaQ2TAaINFwxUlJGUIj9W6CF9YvusAh/fJkU0BKHQs3ViPy+g==
X-Received: by 2002:a5d:6c62:0:b0:222:c8cd:2b8 with SMTP id r2-20020a5d6c62000000b00222c8cd02b8mr5568268wrz.124.1661763716388;
        Mon, 29 Aug 2022 02:01:56 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d4e87000000b0022587413219sm6493394wru.16.2022.08.29.02.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 02:01:55 -0700 (PDT)
Message-ID: <21345289-6110-1b56-4e31-6b1a0318f74a@grimberg.me>
Date: Mon, 29 Aug 2022 12:01:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/3] nvme-tcp: Handle number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>
References: <20220829083856.1850-1-dwagner@suse.de>
 <20220829083856.1850-3-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220829083856.1850-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_020200_397375_CF392538 
X-CRM114-Status: UNSURE (   6.27  )
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

