Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F9CC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gle1pkzUWioD7uTSFkE925RiYsXB/bHkDJkRMWFuulc=; b=Z1Qo2KxykSaR6QWSu7M7REj0Cp
	fyhyz6/OfhyQHpLh8lfhdud3UOhHBbalKZ5oVyl3mxphwTeUmyw5X85/icpx8osG6epIlLHxmQ0Xk
	HxEoX/VWBte99qspvNaGgtK80lAGuejSNsraRfXD9gItM39d69t/fjBUT/irzTT5BdJc3W8gdlwjM
	sw1ILc3nJ3YXisXxUdeNq5rGvTR45dkpHSx7WpyyE0iWZooJfB9WGvIO5KiLZYb3tGhI2tIbqTI0b
	MlvvwYK6LGrlJzHKwOQmCv+UZnINhtDPJZ/u5jLrlcRZASg2ZSz9IsJx7Pnv97xqACDtqv5TB488s
	0qH3dHrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox3L2-00BvGC-9s; Mon, 21 Nov 2022 09:43:40 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox3Kz-00BvDz-V3
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 09:43:39 +0000
Received: by mail-wr1-f47.google.com with SMTP id s5so1762598wru.1
        for <linux-nvme@lists.infradead.org>; Mon, 21 Nov 2022 01:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gle1pkzUWioD7uTSFkE925RiYsXB/bHkDJkRMWFuulc=;
        b=zr3C1QVKeE49CsyveTT2o4OBho8sKbsmPOjAI7Km2QTXaFdDNJ6Sb9YaG/eeMe3D/e
         Jm+CVBxhI4p19ofGFFLbyhMOgL2nxvkItXFFMnbkUMrk1dUBscb8cXfmJUh1lj/zwXxW
         p2ABKJfLyxJK7R02tsDL71Hy19cfxpbz1VnQ8jEG7MYPHjt3KctWWM989NPPh6FNxtvr
         Jh5LL73q+/vGIRuasBvqt8mmbMuolsYImr9GkuC9eVbuSp3ZN/3FF4Vx/Q3U0a7Dc39s
         So/NAaP9JKwnaOJdIpCgqFRvG1sZLn9AjWECbxVhbPTSjNG/t/I/ftqy7A35MWkp6Fmw
         +f4Q==
X-Gm-Message-State: ANoB5pk7bnw3mvSo0DXbbzGQKa+3a6SIEo07ywAIRZIK1/uf/t2mZNRn
	RFlWB5WJrlqMga4NBOeHmkw=
X-Google-Smtp-Source: AA0mqf7rDSlco6FbWiLRnikq1iqbD0PQ6/f1o4Je1EIgGjX4lc3XfALakCvDMqLeuzwIqs8miyksgA==
X-Received: by 2002:a5d:54d2:0:b0:241:c224:201e with SMTP id x18-20020a5d54d2000000b00241c224201emr7766635wrv.43.1669023816136;
        Mon, 21 Nov 2022 01:43:36 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b003c71358a42dsm22976221wmb.18.2022.11.21.01.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:43:35 -0800 (PST)
Message-ID: <a7092b30-39db-a58e-ea65-2cfd12201426@grimberg.me>
Date: Mon, 21 Nov 2022 11:43:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
To: Christoph Hellwig <hch@lst.de>
Cc: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
 Uday Shankar <ushankar@purestorage.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20221121074039.GA24507@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221121074039.GA24507@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_014338_028588_9E4B36B8 
X-CRM114-Status: GOOD (  11.85  )
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


>>>    	sector_t capacity = get_capacity(head->disk);
>>>    	int node;
>>> +	int srcu_idx;
>>>    +	srcu_idx = srcu_read_lock(&head->srcu);
>>>    	list_for_each_entry_rcu(ns, &head->list, siblings) {
>>>    		if (capacity != get_capacity(ns->disk))
>>>    			clear_bit(NVME_NS_READY, &ns->flags);
>>>    	}
>>> +	srcu_read_unlock(&head->srcu, srcu_idx);
>>
>> I don't think you need srcu here, rcu_read_lock/unlock is sufficient.
> 
> So the code obviously does not sleep.  But I wonder if anything speaks
> against mixing SRCU and RCU protection for the same list?

I am not an expert, but the point of (s)rcu_synchronize to fence the
reader critical section isn't it? so if the reader doesn't sleep, the
existing rcu_synchronize should be sufficient.

