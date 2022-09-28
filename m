Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0322FC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 06:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=DtH84dy69H826QzYftBY+85dpx
	Ady4XModUNZ3Q4WypK7EcCQUn1EpCyQEYrerCcnyHphrz/lg4JARv1ujV8MUNbVswA0PgJOsGEL58
	6Py51Q4mepN5uHxt2kUZJkznZCAwuW/TDco741LXKZEIcQiMRHR9BlEPARAl7cVVvhG3Qm8SKdnsP
	MYejPBkRlU4Bs6ndDes2j42BiVhf3icSNZUou/+5S1Q3z3w/BQ8GzQ5bmHBaKYHol1ee5w8RMYMsv
	tBYAVjsgTEpBqJcJDeyeEFEvA62O4Q2Qh95I+Uyjq30LOauSubWjE2NK8YAQldyl0wE7vbFJ5rj7P
	TSJpZWNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQp9-00EIwF-Ry; Wed, 28 Sep 2022 06:45:39 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQp7-00EItl-5m
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 06:45:38 +0000
Received: by mail-wm1-f47.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so486568wmb.0
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 23:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ZL0DAM6xTEu+JkosdAuff/QAXzoJ2bWOQkdagPeIMvnldbUthBr9chCNVKD9eN6+aM
         ssaX4QnonrYGV3G+weUrLEZ3Sx6COt7ZoR+Ieh3lAdZqaiZbCGsc4gSuA6K7ps9SPpx/
         4XswwV/ckd8/dtnvk/dpg8iOBDNraWAAD3fDKI776oEVlCkoMIHWJLHpI+yKHjgh2oqc
         N7prPRcG0XYJlGuohT+oKf6DTognrISxNQXsePWdCBIxbgkFZdKAAZ8aXcNrKNW2EJBX
         btkMzl1SFTxB5HmzdOl9YKkU3/3cltNIxvWSzXoywN7kaw3N8mNlmeB69CnW8wLITt6B
         xFzg==
X-Gm-Message-State: ACrzQf3Iy9HwAMp9I+WT/0JQRLnJNDgoiLCtTgFd2L6RU0Nrn0fkKyOW
	/EG9IR7NZ+EgSeC800olcctK1nfxckE=
X-Google-Smtp-Source: AMsMyM5L+NioNyB7Q+3yiC4KhfAUkjZF9jKVBpP8UBiQqy7uk82XYEwqAKm628MdsO430Z+9bMG0Ow==
X-Received: by 2002:a05:600c:3844:b0:3b4:becc:e43 with SMTP id s4-20020a05600c384400b003b4becc0e43mr5487256wmr.33.1664347533837;
        Tue, 27 Sep 2022 23:45:33 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j1-20020a05600c42c100b003b3401f1e24sm818249wme.28.2022.09.27.23.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 23:45:32 -0700 (PDT)
Message-ID: <5cab477b-4cc3-9060-07a3-fa4c482567d6@grimberg.me>
Date: Wed, 28 Sep 2022 09:45:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvmet: don't look at the request_queue in
 nvmet_bdev_zone_mgmt_emulate_all
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20220927120915.280166-1-hch@lst.de>
 <20220927120915.280166-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220927120915.280166-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_234537_238469_58DEE743 
X-CRM114-Status: UNSURE (   7.26  )
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

