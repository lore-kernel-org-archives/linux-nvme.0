Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3C4C4167D
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=voU8mOL+J5QOfe4IFZhLIxeD/Gkdfs+/A3Q1UrHuIlU=; b=xyUWM5ftFRZK9oNyfxDo+Ca8IO
	QmbziUYDuXeQYiRfoBP8qHpXpnBgwvTXEnhQYO/Tlu88C5lv9wxKHWU4K1mmEeZbIdeS0wrehZTZ7
	3vAmOZ7SKtQUCphMfhvPXfNsbuvb8Hc30yYeBNqxUzmUQFvipJWX5i7+zlUiEQivPPteDKZU8Mczk
	ZXzXUm5sh/q3k3VTgWKQXSclnSuOcKWW2P7L4k0kFjc9s1NSDQuW6dSO6AGCzhBfHbdpix9LYAkdn
	GLsE2/MLU0DPMGSFC54QybBqi8TdPBh+dj4gmiIorMHcpuCpeMejaVyERi8VVfRtzWPjNwUfNTeuj
	XYrrADpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPYu-00Erh4-1M;
	Wed, 13 Dec 2023 13:46:08 +0000
Received: from mail-lf1-f51.google.com ([209.85.167.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPYs-00ErfJ-1m
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:46:07 +0000
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50c0b80ca9cso1759116e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 05:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475161; x=1703079961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voU8mOL+J5QOfe4IFZhLIxeD/Gkdfs+/A3Q1UrHuIlU=;
        b=HoX0JsChQwS4Mf8Ejkq7ckazbhBO6g4u1lFwQ+vDorlV/RSkzIj7ELCt8jKl6WBYrb
         uz0ic+RSbIviDjjl4/zxOSNNdZbsYsqS2QiZr85r7qI5y5yj6yZRV8n/Lyq+AzfZb9bU
         QFU7yAf3A0utRrrp9Vn9DVnm7r1upSu7refRRbZda/M3cjvpu/E8eHtPG6UMTdFP2mN+
         /5qf0mzKqEZ76zlHqOhsl/3DzdoL5wPUz7RfYSxdAh/HQ5nDdvSkJAqeIW7526CYIcG1
         l3pA7QUC0ibc5M0LjiZYU7MnjgM54AKEnkc0UOaP/GtyDox/EKR/ATP8oF2uX0p1qXVo
         4bog==
X-Gm-Message-State: AOJu0YzzTu4hXfdQWg/Iq7UO1KXxvXEZTaAMjlZ7qYL2pMg5ig5o+ilW
	mgEvveepJNDctl8OCESDCvg=
X-Google-Smtp-Source: AGHT+IGXeiAP6kMgM7JEwx7j6NYOz7PJrhkfPhd78vSGuEdrq8X6Dtf02w8e0tSYHeU5nnXVn1HxWQ==
X-Received: by 2002:ac2:5f99:0:b0:50b:fea2:29c with SMTP id r25-20020ac25f99000000b0050bfea2029cmr6279335lfe.6.1702475161030;
        Wed, 13 Dec 2023 05:46:01 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b00a1b7769f834sm7702467ejc.81.2023.12.13.05.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:45:59 -0800 (PST)
Message-ID: <0ff3cadc-9c09-4a53-8867-497a1cfd487a@grimberg.me>
Date: Wed, 13 Dec 2023 15:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] nvmet: fix wrong error handling approach in
 nvmet_install_queue
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
 <1702449172-8920-2-git-send-email-kanie@linux.alibaba.com>
 <20231213084319.GB6184@lst.de>
 <2999415d-f1db-4796-b558-95237daa2586@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2999415d-f1db-4796-b558-95237daa2586@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_054606_591367_9EE3C8F5 
X-CRM114-Status: GOOD (  11.84  )
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

>> On Wed, Dec 13, 2023 at 02:32:48PM +0800, Guixin Liu wrote:
>>> In the nvmet_install_queue() function, do not set the ctrl pointer
>>> to NULL if the sqsize check fails.
>> Can you explain why it is wrong, and why not doing it is desirable?
> 
> If a queue which is already connected, then receive a connect cmd with 
> sqsize=0, it will set the
> 
> req->sq->ctrl to NULL and break the queue.

It is not clear what is the issue here. Is there a dereference later on
in sq->ctrl? It belongs in the change log.

