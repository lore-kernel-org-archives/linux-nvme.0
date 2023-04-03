Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4096C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 22:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oI60AhKaOY6m0mYlUKMejjzRNgeS8RfZPbR9wOSTtH8=; b=x74Czg4TaoMXirZ7K/6dN2F6Cy
	CVjRmU07ojq90SNN+I0OaAe+3rQzU+/+DIf0aM+UovXsY/kBrDjL78vEL9yGMbUjZlYz4fPaSYSJ6
	h5zKyVoaAGKY0g6bA6INxmZuDg3LJBcKEnBHJ8rOu041g/2S0Fs8oPOQRbBubs1vrvMBcqsyLGCt0
	vfDOtOUvb3IAfVoN1/cu/Z3MQiDVd9YBdd7LlbWOh4OatLQrzcrdCMqrsBLltHrOJD3QbncaY/wyB
	LXxtre3+U4aZugYdr6HVSHNMxODNi4JU/ncYttk7iCgcIpe8wlGLIpkxFJdk5AXCwXUBeRHCUySbU
	13//UsZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjSoB-00H5xI-2w;
	Mon, 03 Apr 2023 22:37:51 +0000
Received: from mail-ej1-f45.google.com ([209.85.218.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjSo9-00H5wh-0r
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 22:37:50 +0000
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-947a47eb908so32018666b.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 15:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oI60AhKaOY6m0mYlUKMejjzRNgeS8RfZPbR9wOSTtH8=;
        b=QV9nxE0gjNoOiVFzr9nrP4T2cMJwl1sdRYkIibHUCACa4vFLLXtoOc45A843+g4vv0
         aym6d1rzEXPHDT7PO8nFoZPM4a12RYyQUfJ+BCbMYc2id1VnW1jCHMkv4YocPokW4Gmz
         3YBPm0Rb4POFj/k0P/D0SiUzqemC65tlEWuN+aywrMbXtJCHbIxuJtLRIfVA7Tba7C1v
         A9cYvWHh7c2oFhNbMutPkkjcA2anm5stdiiWtTi5sfwgKWUvRgF+dSKNtw4gkvcpfQGr
         oqjJ7eZoR0Pykw+OvXPPr5vKPhLEhMXQJEai0MUvU4MhjWtHfFgDDLKodPG4PGFc8asu
         jN/Q==
X-Gm-Message-State: AAQBX9cQxo2QdTCJ+xkxF9lEuarha6yvAjN3UENkaO22r6S0fHNElKE2
	FjqoUmbJ0EiVnabl30rWOxo=
X-Google-Smtp-Source: AKy350aDVY1Foc6SC44SaAr+T0zkBcszgFYVhGlOzh827CRpS6ijeofy9+GtnT4xQmmY6Z31UVIqDQ==
X-Received: by 2002:a17:906:242:b0:947:8734:a05b with SMTP id 2-20020a170906024200b009478734a05bmr160721ejl.7.1680561466509;
        Mon, 03 Apr 2023 15:37:46 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id kt5-20020a170906aac500b0093a768b3dddsm5088105ejb.216.2023.04.03.15.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 15:37:46 -0700 (PDT)
Message-ID: <df40eec3-012e-3664-14ec-d15e1c57c258@grimberg.me>
Date: Tue, 4 Apr 2023 01:37:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] nvme-core: Fixing ctrl de-referencing in nvme_init_ctrl
Content-Language: en-US
To: irvin cote <irvincoteg@gmail.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
References: <ZCoguA3gBUw1CIdd@archlinux>
 <38fbc59a-94cf-9764-e4c4-0fd3c8f3830b@grimberg.me>
 <CALL+9ei1m2oj=MceRyyjM+FMuSrv9eD=nLKFrkX+RD-0Zp7v0Q@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CALL+9ei1m2oj=MceRyyjM+FMuSrv9eD=nLKFrkX+RD-0Zp7v0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_153749_300955_B343A26B 
X-CRM114-Status: UNSURE (   9.98  )
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


> The thing is that after device_initialize is called the reference
> count for the device is equal to 1. Now the function also calls
> nvme_get_ctrl which increases the ref-count to 2.
> However the teardown path only accounts for 1 decrement. This means
> that if an error were to occur during nvme_init_ctrl, we would return
> from nvme_probe without having freed the resources of the controller.

Not arguing the bug, just want to understand what Fixes tag it needs,
so that this can go as far as possible to stable kernels.

