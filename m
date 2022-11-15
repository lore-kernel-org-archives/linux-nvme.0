Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84741C43217
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 14:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ZTVTgNQ5LGjk71Vlhqz+Y4hmyH
	aLzEuC2HBc5xrn1roibfY2FBVxmHwBUUlEuHmTLclmFm3liDHCU2qExhWkEdJLWAURyv3+kYZ1Ev7
	sIvIozQavHyp9JPp2ujWA7ctgH2NjGgN6gqbR4KeiKBiS2tEyieXXfvZgsUvIPBm4bo4njpDrZnY/
	Q5LeOeJZkoCEIPXtFd7P3MKQgrwLI24/Gka88RfV2Bbqrti5p1zeDN+ZvHSBWWRhpq8fAN9ryVasl
	3YTaQBXPq5EFIiE9IplY/mrZOu46GQ0Vs/H1b2DOpjBoMCLQWaUl2vfOJZV7brkDwv0f1Re9LDtr1
	5FjkRa/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouwX1-00Bk6S-7x; Tue, 15 Nov 2022 14:03:19 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouwWy-00Bk4i-I4
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 14:03:17 +0000
Received: by mail-wr1-f41.google.com with SMTP id l14so24437427wrw.2
        for <linux-nvme@lists.infradead.org>; Tue, 15 Nov 2022 06:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=1FU1r5zm90WrXeOej8nd+wnlUAK/oHjVDsKPbbUN+Y8dCCtMCShQt5YlSBMGqGTEUV
         vTz4qvJKn5HU2Mc+Ung6PZe4ZIlpij/gN1wZBmfjN+vZhU8EZo6J7Ld6+8c0Fa9SfQ3e
         93nSclxmly4AUn9veKvUIfuWXwLY6uRS5hGI+dZHqwsSElbevRpddt/w4Am2Zi+Ncw2r
         UbS+FeVy7Q4wWfklbkSM46+hNOn+goYM+ABOkF49CO7ORtjR3g48j41yy9Z6yII1mQPM
         iIadVZxwQS8okVPNEdUAE7ru+3suBGp7BuTbLv9LK8oEDunbDxX05EofIOley4Ukbuj1
         2Y+Q==
X-Gm-Message-State: ANoB5pkhe++70709srLxARViMbsK3UqjUKTtmDwvl7ljGE3xut7b8yuQ
	yupGbCFDlah8UPLT4DPpdSw=
X-Google-Smtp-Source: AA0mqf7p6p+ZDfvQqxKvM00NFSk1qyWznv4f0Wq4d8IJjf5nzpY6+H/qJUAFTc9lREV4+ZTPg6+Dmw==
X-Received: by 2002:a05:6000:693:b0:241:8643:af8e with SMTP id bo19-20020a056000069300b002418643af8emr7098662wrb.406.1668520992631;
        Tue, 15 Nov 2022 06:03:12 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c2f0800b003c701c12a17sm20936606wmn.12.2022.11.15.06.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:03:11 -0800 (PST)
Message-ID: <8d8c508e-c1bc-688c-2c2f-39f41aa5ad4c@grimberg.me>
Date: Tue, 15 Nov 2022 16:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme: rename the queue quiescing helpers
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org,
 james.smart@broadcom.com, kch@nvidia.com, marcan@marcan.st,
 sven@svenpeter.dev
Cc: asahi@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20221115102346.1641696-1-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221115102346.1641696-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_060316_621448_9971CC4F 
X-CRM114-Status: UNSURE (   7.07  )
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

