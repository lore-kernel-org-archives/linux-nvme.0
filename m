Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A19F54AD6
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CGb7XwT6dZksneWtItSppfi6d0SJR5kEWJ5U/fM6W/0=; b=y1+InA1kaemUbsFLC+jcL8EdG4
	f6ymaJH55Mm5oMOF5SWajjHFzWtrrBFi0xh3A45ji9ANpjzh0uwH5MMtWqFp4OZLGrqaxIbzRex+3
	wpx2Rc7BCTtL9csFqjRFAWRMPJ/A0hcM+hmbIlaeHpxNK0JztU6KgvXpjXtvyRmhDQVUVJekNMevK
	/ulkO4FP8YwwtsDcvn8kiTMlJjyAuCVoIlNeXmgH1f8UjXIBoor9A24JOfVLe/zLx8kbhzR/o6+QI
	l+V04w/d28YP/lIQXWJ+H5LYq/IdjgXia41IY11F50qDfedIV0hOULKfEM3uU2h5ynfX18HCmTc3D
	g3l8WRGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5BbS-00000002N57-2sxX;
	Tue, 24 Mar 2026 23:56:06 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5BbP-00000002N4P-39SA
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 23:56:05 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-12a71ade78cso2419929c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Mar 2026 16:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774396562; x=1775001362; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGb7XwT6dZksneWtItSppfi6d0SJR5kEWJ5U/fM6W/0=;
        b=sYj0Q+KMfWq7gxgk+jYEE5TsVqbztCoVTPvBTp2myqvOcKSr3bq5aS0j5+0hVFzZVz
         aoQvw6vS5/p2uRQcfN3V7nSq6C6TkuXVol4CMk3hxBC88Luiu0DW13FwHMSKDkuMQWoe
         2Xn1lvUBjIkJnSw7BSLPkc21R8aFNHYWoNYvwhlpYO/8CnUqVTrlumAWjLOdjAcTCI44
         2FKuBJKCdH1foSSjIZAmY11bxolAWlVykhiOhPWbbAS7AkIWsS6EZRr9p3laPDptOlud
         iLllR31tXwuQalH/SGEH6YRZBrnonVvqwdotWvGrNOaH4i2F2RYf0KcU2J6pHWn+DFsn
         7MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774396562; x=1775001362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGb7XwT6dZksneWtItSppfi6d0SJR5kEWJ5U/fM6W/0=;
        b=UszHka56b3fYtCoTl4vxhqU6CNbFolMLt5WA9W5Z08cIiOIPLwU7aK+ype3pNaX5OM
         Z4OGWnLQymKue049xknn8bwF0cyWAPfYuIfyNO6FlA7qk1eqbCqkSBbsrsjqH2eEJS/r
         U1N/jbx+fZRRiZx5A6OOEpX2Lmeh2H3pHUZ16HqXLWAA4f84KDMi1K75cz9qZqQWnqs4
         shMjxq+7W3kEBdI/uly1kTd6zk0+FAKL9f6UxAzJx0zmj3KYsf+twMNI6cWDD7dn3pdv
         Mf7+63giGV3EJDx4TGlxbZAu243egC6hHnEESKEg/Z1uYmwWQhTP3pcC4f8Y6gicDC5T
         9rew==
X-Forwarded-Encrypted: i=1; AJvYcCXpJCoudeU7oM1gFzhkG4cL7e3rcZJasldwPgt28qCjejjx0htWZo5zsAdVBD/rxx4h9WcPH8ZmBuYU@lists.infradead.org
X-Gm-Message-State: AOJu0YxT2IuU5tqKvX9rITYUivhVYgy+t56g+q2yFVoT9XJYfFGn17Xz
	XOgIthe0GZNlwqiUzXavkdNjWHw6u6f5RojpAYfNkZrXWj5xoTebJwBe4qaFew==
X-Gm-Gg: ATEYQzzIathu0ONEMy8JejEUwyxf1i97AdYZpULP9lkkyPrnZjJbc06z2vOUkRu84fk
	uuZWrbPa10w28LlDTCmsXd5N6JebNOUj1Rxv3at5YD8dCJXgM9/WULKzM9g2XZYapGFJ9M+aWW5
	mIDNvpfSvGWpMdap4GNJiHUupxd1J3TILQfZUchjwfGoKGdB+S+Ntvkm2htNeQTuqw0WxfDzNye
	iuXG2op5BPJ5pBlP79H8qNfF55EOjNqXn/hWafj/3WA21GgiFPXtr3V4wUeppAm/Jpwkb1b8FLR
	a9ITa8fWBurLPGAsxze3Z5gB7tfYQy5Hezm7FWmy6TubN7loj7TPcOEa88W9RUukax3OU+2jkWj
	yIvBEsMDzaKAe4o01NyU9lVN6yrwCaEI6+RpGrMA8KyWrE1gbZ9yfbIgr3yFkvs6RlLM2HkZ9rQ
	WXLu/PycO9ErXQjOf+PdZpPudDV7ZtChWuT5a2F/dd8No0XQy72OSPNHzyY4GoErnd5+otwito
X-Received: by 2002:a05:7022:688e:b0:123:3488:899c with SMTP id a92af1059eb24-12a96eff7c7mr646452c88.40.1774396562027;
        Tue, 24 Mar 2026 16:56:02 -0700 (PDT)
Received: from [10.69.65.75] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a7330d1c5sm11716427c88.0.2026.03.24.16.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 16:56:01 -0700 (PDT)
Message-ID: <945a3e98-ee75-453c-ae80-f3c9e3e57e58@gmail.com>
Date: Tue, 24 Mar 2026 16:55:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Move nvme_setup_cmd before hot_pathing
To: hmi.jeon@samsung.com, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "sven@kernel.org" <sven@kernel.org>, "j@jannau.net" <j@jannau.net>,
 "neal@gompa.dev" <neal@gompa.dev>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "justin.tee@broadcom.com" <justin.tee@broadcom.com>,
 "nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
 "paul.ely@broadcom.com" <paul.ely@broadcom.com>,
 "kch@nvidia.com" <kch@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
 <20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_165603_797180_4EE4D471 
X-CRM114-Status: GOOD (  10.58  )
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

Hi Minsik,

 > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
 > index e1bb4707183c..8ea37102a836 100644
 > --- a/drivers/nvme/host/fc.c
 > +++ b/drivers/nvme/host/fc.c
 > @@ -2762,14 +2762,14 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 >         u32 data_len;
 >         blk_status_t ret;
 >
 > -       if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE ||
 > -           !nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 > -               return nvme_fail_nonready_command(&queue->ctrl->ctrl, 
rq);
 > -
 >         ret = nvme_setup_cmd(ns, rq);
 >         if (ret)
 >                 return ret;
 >
 > +       if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE ||
 > +           !nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 > +               return nvme_fail_nonready_command(&queue->ctrl->ctrl, 
rq);
 > +

__nvme_check_ready() checks for (nvme_req(req)->flags & 
NVME_REQ_USERCMD).  In nvme_setup_cmd(), nvme_clear_nvme_request() 
clears the nvme_req(req)->flags when RQF_DONTPREP is not set.

Is it possible that this patch would have nvme_setup_cmd() erase a 
nvme_req(req)’s NVME_REQ_USERCMD flag before __nvme_check_ready() is 
called for each respective .queue_rq?

Regards,
Justin Tee

