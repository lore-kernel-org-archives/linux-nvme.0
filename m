Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83A9ECDFA1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 08:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHtF9ER2Or/nLigCVnn/Rwp4YAkOBbty21/0YYZd0eM=; b=PiaNAdvnALiYKJBnONVGkyAzqE
	eemECuUmoX1c4nQqeGeUV6AV4/PzNXuw/U928CE/8Tn9lt8bSeQNI5AhVgsrVEbbXYy5eHF8N/Wqj
	upiuGbG51uHNWlLGm6sxvYB4/OLjj3M6TgTfJBPfKk+z0sSnppq4KIPvGkP1GdG/3XTOZsiO1s6V6
	u8g8WxT85TfWSrs+Q6ANvBphDej9MtTsSeLY2VYpqvy8FgtQDW2dDkfmCvTmW5ISop5XfrIEwDXvZ
	P7TYc2pBtq+Abq8tX75T+EsMsDwXpo0SwtPAMJtUNKAvxlTjCHcz6eyU2NQxdoHu35N2Q19EWVUPH
	Vo1PCCvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omt83-000EL6-Ss; Mon, 24 Oct 2022 08:48:15 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omt80-000EK2-Oc
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 08:48:13 +0000
Received: by mail-wm1-f53.google.com with SMTP id t4so6105167wmj.5
        for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 01:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHtF9ER2Or/nLigCVnn/Rwp4YAkOBbty21/0YYZd0eM=;
        b=O8hAeiYJ8rECFbdOvfr9iXoQGAqX46ebnP7pYLaaB6mbPNLW4urjB2CVJwlGCSLfMG
         e+k0we2CYisM6C8g8kz94LYYRWQ6Y+tKHtyulLEVycKrjFucs++MllXN3CFkHjzg6aQz
         +Uvisc+j8tmll3GQ97s8MxuNvDcaKvX2w11L1newuwJFQdj9ljo/1IYpz8Ev+xIo+1dT
         N9TRXsIq61pybDhm9GG1T5uoiU6VUeaILsRV8Z5moR19z4BlcKZRrUAfpMAgk188tBhf
         hHJSus2itlYysnAz2r4G1MBJOJUlEFoEFIMOriKIZkN+oEQSddF685OUI2xWNx+xBwy6
         EZnQ==
X-Gm-Message-State: ACrzQf1rh4atIVRxMaj1fx9W6JhhirF6MvGffSe/dtHPCGJRO4YvI8yu
	rYgE+5s5ZvVUroD8v2zn0jc=
X-Google-Smtp-Source: AMsMyM6Rhf5JxAEKMXIy0ZoLMiuAbPkfy1l5rP155lk6IZ22YaJ7mbHRCic1wXvL2q02rWJ7Un6f1Q==
X-Received: by 2002:a05:600c:54f2:b0:3c6:bd60:5390 with SMTP id jb18-20020a05600c54f200b003c6bd605390mr42004705wmb.206.1666601290328;
        Mon, 24 Oct 2022 01:48:10 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b1-20020adfe641000000b002206203ed3dsm9774655wrn.29.2022.10.24.01.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 01:48:09 -0700 (PDT)
Message-ID: <0d4dbbe6-f9da-1a49-1aa7-4610c6dea6e3@grimberg.me>
Date: Mon, 24 Oct 2022 11:48:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 7/8] nvme: remove nvme_set_queue_dying
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-8-hch@lst.de>
 <55dfcd8e-c2f5-d064-bd4f-770383fc5305@grimberg.me>
 <20221021132950.GF22327@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221021132950.GF22327@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_014812_824184_2F8D1F7F 
X-CRM114-Status: GOOD (  16.64  )
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


>> I have to say that I always found nvme_kill_queues interface somewhat
>> odd.
> 
> It is..
> 
>> its a core function that unquiesces the admin/io queues
>> assuming that they were stopped at some point by the driver.
>>
>> If now there is no dependency between unquiesce and blk_mark_disk_dead,
>> maybe it would be a good idea to move the unquiescing to the drivers
>> which can pair with the quiesce itself, and rename it to
>> nvme_mark_namespaces_dead() or something?
> 
> Yes, something like that is probably a good idea.  This entire area
> is a bit of a mess to say it mildly, so maybe we need to sort that
> out first.

I agree.

