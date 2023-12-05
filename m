Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98F2C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 10:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=l+WVIpxTdIMjaYIdQkbVygDNYr
	sB/F8+AHuDbZSIof41W6z4TaZaaIEL6rwn5N281xhyuHAgbup1PSD/fW8OGZ0UgFGZjbAOHfkpNJQ
	nOF7hBMLz5b1NLjLmMg1p4tAXe+s43FTq6bZkTMmQTTDvF8PoYDx1Os4l2fsVHcyGywifo5kwrrSU
	I/sXprBrwmjsCieea9gmZcX2o6NgCj+6B7da/WLIOcR1v3+xhjrQD+qO1nPsE+ZIMBV47UbF7hUJG
	SG66qohKtqmxeCGjC7PfUYP8nPiHyZd3HNYp8FtXB0bQuZxG6KknMRwmMHn3ZNsIVH3ZDQeUwP1ZS
	4/RFrnew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rASGA-006uoc-0e;
	Tue, 05 Dec 2023 10:02:34 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rASG8-006ukJ-04
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 10:02:33 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33334a313cdso702963f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 05 Dec 2023 02:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770525; x=1702375325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Oy9xjaiehPrEHeB0pXgijRSXmGli6utUXEcBPEvnWFLbwJia7O9Je7WIKjlHnVhe6A
         /NDJus7nl8XW0yufuUKEDgHvh7h/do/tmwjrWPNKMPMZtbDCWBFUT4h6M24HFRvBPVZ1
         kL3eUd7RTlVM3CnSheIBEKVVd8oWWLg1gIVGWp2Ewo2rYoGrd8tRb8tWjvBaZ2FFtD5c
         cEUc5Tva+vXMB0EU4LR59ZlspYubbHU2dTer8Zzs4kz8Rl6NyTeHBOzd9YNXNapV+oMd
         bNZ2vH0Kwa01JmszBMOR5LTvCcbpCAlMS/vUg7Gaihaue8nmyxS6n0K0DHx92v7YFHZc
         UL7Q==
X-Gm-Message-State: AOJu0YzTDEeneQysLa6NNVRXjkCcFsDiutzgBnhb19Ln3TDnH4svV7oT
	LO+o5G0HPEJxHoAmHPB6OyI=
X-Google-Smtp-Source: AGHT+IHSIaB4k5uEqyFyZ5A3xmycxourEMPukNsAwA3oQQE9jy3+9lGXeJ8lNG4e4Op/cg0754jGLA==
X-Received: by 2002:a05:6000:2cb:b0:333:4ba7:bcef with SMTP id o11-20020a05600002cb00b003334ba7bcefmr3462687wry.2.1701770524486;
        Tue, 05 Dec 2023 02:02:04 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k13-20020adfe8cd000000b003333c2c313bsm8339592wrn.100.2023.12.05.02.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 02:02:04 -0800 (PST)
Message-ID: <890ec165-8090-4054-9189-6ab9456b2930@grimberg.me>
Date: Tue, 5 Dec 2023 12:02:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: introduce nvme_check_ctrl_fabric_info helper
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <1701761860-17623-1-git-send-email-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1701761860-17623-1-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_020232_056322_D059F171 
X-CRM114-Status: UNSURE (   4.59  )
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

