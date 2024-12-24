Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC95E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=LePVTyrbT3sT9qjmWdUSastx9C
	M0BuWBXSb7Miu3h0/i8SN8Wp0zpTn6GsVN7wBE2RlIxcVYaEMNQeZCDFk74IZmdZyPZtxZL00V2ia
	IbFnUpbH6DYXfGGHNGxpPxPzPLVb71bLVEOBfr1CFlvEgv/qfg2MbOf1XvL4hsYxHcDx9/uuXXkKk
	4d+x5X2ngfUlZcN8zYkMeiNliME9W+RJQ9DTFRb0gNBbkpEBCh7EMX9Ne6LhoJjWSqNef11yuinRH
	RhZxX7meXro9XkgeahvJrJIMHHSiLZufeUTc53ObfDyyR3ghjSTVHBC2qToJF4ZFrbeALNJRa/Gpx
	mJVfBDHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3Tn-0000000BtuW-2tMb;
	Tue, 24 Dec 2024 11:53:39 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3Tl-0000000Bttm-1vCV
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:53:38 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436202dd730so36746495e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735041216; x=1735646016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=CRVjFMtdZltf3mz0K6Sf1jwUSDQZMiFaVsVOwH3GGyvyrSuCkxBB516ZwBBoxbqYob
         S48+fdqU6sX4WgjLvlVPUnvSHFgytimBAGSEvRlzouOA9O351oVi3DO0e5LL14v7g82S
         ujoAXQfT+PF/XvQJeGBlyP38PVRIrubCybzIyWezgfiDiGItJ3lTTNgAJIJSUKZ0IzVz
         IYLpGl8g+jcwSfnpRt1ETYCFlz9vgnKv0IWHkFOhiP28kYEO+Ehu5Ux9C3aDKz//U/25
         ZiUB1q9m9Z+/wLqyO8O6y4+G0/zoz/LYOm8fV2D/aZ2kq+WXgODBQWLTmhBd71F3pU/1
         +Emw==
X-Gm-Message-State: AOJu0YyQNe0DYamI34X053JYVLr+gB1inJ/rCHLp8Usz3MCvEetJE2cZ
	28KwKIKrTdIpVczxX3LeurkMt5gJzuTV6kAqZ3p/2ouhhDC6YxmN
X-Gm-Gg: ASbGncvzXCFLEjWjMc/dDj1L21dJ1P6+v1H4+1vkrdVg6UaA2GyNjsLml1h6R5aLZIm
	Zocbbiia4EPReuAPnKrqU0mkCqDBcsaoTLmXQjcQwa37h3kt1u4bMOTfX84XWzlhymrYfXV7kQ+
	W8ABgEcmBC7rUQhhX6MOzDaPRO5foDeRQe0KW+LlETmQVmPTzlakGbOxUAFS4IRYH2mPZvxORzB
	Dx0RpuHyXaOp2ddUSpq8r3/f0pj4sKUTB4/kMY4Wb9vQbUattQxCi87G2CsbTBzznrdLDA7w+vt
	UKD1IN8jXkif64hZYI7vHVc=
X-Google-Smtp-Source: AGHT+IFaZWa0GKUHshRVySw3lemfGld5ba7HO/JSW0n6p43Zct471ZbFuCPyvjuFbi/Ag0XKMmZOLQ==
X-Received: by 2002:a05:600c:5102:b0:431:547e:81d0 with SMTP id 5b1f17b1804b1-43668642eb9mr131390835e9.11.1735041215932;
        Tue, 24 Dec 2024 03:53:35 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea42esm168163965e9.9.2024.12.24.03.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:53:35 -0800 (PST)
Message-ID: <58f50485-7ee4-489f-ba5f-8fc408e63275@grimberg.me>
Date: Tue, 24 Dec 2024 13:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] nvme-rdma: unquiesce admin_q before destroy it
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1732368538.git.chunguang.xu@shopee.com>
 <9379940137a8dfddb451917c1d069eebaf3c209e.1732368538.git.chunguang.xu@shopee.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9379940137a8dfddb451917c1d069eebaf3c209e.1732368538.git.chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_035337_491275_E6449DD8 
X-CRM114-Status: UNSURE (   4.68  )
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

