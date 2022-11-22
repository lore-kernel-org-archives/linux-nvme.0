Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5205CC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 09:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=FdM41awiPBfymLY7iQ2XBN9YPW
	i2ViPouxJu9oUAjvXoaror11fAJr0jaiXYgc+55odeCSaYB3A1f38JoRiqdUNHfguR3/JfkDa5q0s
	QleGrj02U5LKGKKc0Gq7fx+qs3jm4hpOVsWCEQmVZC42Ghkk9r/b9NDkEU5CnVLq2WI3HAbX39/BF
	M3fO8ZvtHa/Ls2ot2VTrIhfPST1Zzusun1j4cKRsEOGLfTyMyNwg000oXPPHG6mBZbyfQS0ISRbaG
	ETVI6cNMKNVpH4eIyVBz5R6ETPSAz0FWD89Av+rO7V0QIc5SSk++7dMaaYdEWwAjnFfKXYRw0GppZ
	KLcOl20A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxPq8-007FWV-Eo; Tue, 22 Nov 2022 09:45:16 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxPps-007F7s-9i
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 09:45:01 +0000
Received: by mail-wm1-f41.google.com with SMTP id p16so10296483wmc.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Nov 2022 01:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=jP0RsY2bzLyavdkUIermUfsJq2mYkwi4VZRMPyyCqV+4vBNAOeL+bJIXbdoE3R1D0M
         wbSgI0wDCarPOLsnVEDV9DpzqieCj3jxTOaXSSYwMrYZG86T+HSuAwRFc0H+1gb41mSZ
         Qs8bsFbcf4Gjn5sTQxy6K+TCmkiV47HNJuixCbF928XNAmV1kahza7zK/bK98Kc17XyW
         EEjBz/Ro3ykKcBSOxlAJN5ibB/HRuzrvtRbk/a9IrW6HQvL7SrOJfm4tmxyfbV/A++7A
         69Vakmqq1zQSNBepzRi/vzfvV+BIZklzw2mVoEjLrlv/qeO+Cdb3K6oStVFsHhQsWh2j
         jEWg==
X-Gm-Message-State: ANoB5pm7od2dQvlg0kiwx+xQ67tg3TR46OtnFLXxvFJ2tX7tq5SOXjd8
	yOC3iAp49/o0AT/T50h8nfo=
X-Google-Smtp-Source: AA0mqf5pgXYk8maJ+d8Fv/FNENLlWEklKnrOup+ABHjBTcpfRb5oc/aO75UZbM9zZXKtj9pq59PGEg==
X-Received: by 2002:a05:600c:384f:b0:3cf:9377:c76f with SMTP id s15-20020a05600c384f00b003cf9377c76fmr3703093wmr.189.1669110295894;
        Tue, 22 Nov 2022 01:44:55 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id q2-20020adffec2000000b00241d544c9b1sm6507555wrs.90.2022.11.22.01.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 01:44:55 -0800 (PST)
Message-ID: <aeb81204-9b25-a7a0-082d-d610256e4c77@grimberg.me>
Date: Tue, 22 Nov 2022 11:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Content-Language: en-US
To: Zhang Qilong <zhangqilong3@huawei.com>, hare@suse.de, kbusch@kernel.org,
 hch@lst.de, axboe@fb.com
Cc: linux-nvme@lists.infradead.org
References: <20221122044929.27600-1-zhangqilong3@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221122044929.27600-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_014500_373880_412DAADE 
X-CRM114-Status: UNSURE (   5.94  )
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

