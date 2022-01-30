Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554CCC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cq+jysZBxWMjCtpLzaxf8YQYXiLulfjZNk3EdQTREm8=; b=3jmoh1SKq3YWbEn75dY8B+HD13
	Nj314Z2BwU+qwEYLjf4+c1HFrqVTzafLaPVVMB7uQVn1b6DHv72KMEu36WunZrx6dBHmsQ9/uKCWE
	eNqNcIrw4L8aJkmPhjXlnzMoTPFmW1gdZpNd8dMtUyATorTrxrx2tGuxrBN8e2BMEXJM7DSWEhUo4
	lrgTIWg0p8nUGetVkkYbkYLJ2gRwwFWyt29H4paZWrBAAfUVvshyQfDTt6XO17gEXCgQttPD/YRtG
	u6vhNCdlkd7vZ9ucBeNvNaD3jEYjix6szkB2TCWN1Bh8GGp4aYbVLg7j/tQguKN6nu3Ogb9bzee3P
	Jdqrs5Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEA5z-006Zph-48; Sun, 30 Jan 2022 13:18:19 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEA5x-006ZpD-4a
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 13:18:18 +0000
Received: by mail-wr1-f42.google.com with SMTP id l25so20204268wrb.13
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 05:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=Cq+jysZBxWMjCtpLzaxf8YQYXiLulfjZNk3EdQTREm8=;
 b=Wv8kTsZa9HUCO6c0nfIrZquVY0G6lNioJf8GhjyQLPLAxWZGhJKHpRUp3S8/YDETvh
 qq0s1pyr9s3fjmE6uW659zF8sJfvwZZJazQ/BKdFP8sx0x9sayVGrg+EG4Q0nqF8PQwY
 EJhxx0muMnuL6lhsdcW81EEcGuPSThnn22FW9ZFu6jwKQrjZ5a/p5IPquJgSHrWVEfhx
 BV+LY0E0hAjWnse43DXNw2akOjv2avCsXgE3J7PY4CrNNuHiKD7TZwZ02rcKDVfWxX6W
 4gDbwZTRwbJZLSgRKSa2QqZRh26/zqaU4t1hXVvMGtQB7VyMej0sVsHFhGXpTFF3DfpP
 UAzw==
X-Gm-Message-State: AOAM533T31HpemIE0J2b1JmqDLbYrvkno+M+rNBxBDwLxavuF0HzgeK1
 weIGB/Q7UYO37u4H2diqvXk=
X-Google-Smtp-Source: ABdhPJyDYvxRf1VVtWt+XbYbMGvWZF5hMzY9C+6FKw+6OSwUwezPcB7C9I2vdHhj2lYQRNhTakGK+g==
X-Received: by 2002:a05:6000:2c8:: with SMTP id
 o8mr13285597wry.423.1643548695604; 
 Sun, 30 Jan 2022 05:18:15 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id u19sm6312045wmm.39.2022.01.30.05.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jan 2022 05:18:15 -0800 (PST)
Message-ID: <15725ffe-d706-9723-de5a-d0d247859c84@grimberg.me>
Date: Sun, 30 Jan 2022 15:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] nvme-fabrics: add tp8010 support
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
 <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <37587400-076b-059f-f163-fd90babde443@suse.de>
 <SJ0PR19MB45440F98F8693F571669C012F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8527332c-3126-1297-f161-f2cb818a3061@suse.de>
 <SJ0PR19MB4544DE97C58FDCDA5930985CF2239@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <e4c48b97-8f79-a373-96ea-13286632624b@suse.de>
 <13c327cf-8f04-e005-298f-0e43bb39b89e@grimberg.me>
In-Reply-To: <13c327cf-8f04-e005-298f-0e43bb39b89e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_051817_209468_7BF65EA0 
X-CRM114-Status: UNSURE (   8.40  )
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


> Yes, thgere is no bdev for discovery controllers. We may add a uevent
> for userspace to consume as soon as the transport reconnects or when
> a controller (re)starts.

Something like this should be sufficient:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd18861f77c0..55e11ee19460 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4396,6 +4396,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
                 nvme_queue_scan(ctrl);
                 nvme_start_queues(ctrl);
         }
+       kobject_uevent(&ctrl->device->kobj, KOBJ_ONLINE);
  }
  EXPORT_SYMBOL_GPL(nvme_start_ctrl);
--

