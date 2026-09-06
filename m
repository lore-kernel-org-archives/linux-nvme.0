Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB5DC624DB
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2026 00:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=x4mJ24ajgZtEd8/zsmn6qqacIh
	kglfWXIAsHVeGYYGgd4ljxpRqeI5maQjN92vdT7BhZOBT+5nt2RNNk9Et8yP1e5Wq2uxr/rJXkqUV
	gOZZIP6gzBNvOaZIVPniKitHq2ggAIGDmR/gVSOtE0vsSNegDTD+aGgy/YkQxzmd+ZaB6sCsZw7oZ
	2xnoWrEjI8ipHqZsp9U74nbLcpXyqjNXS9mphpYA43PeJl1g56rriL63zEZ8M2l1LBO4RCP5Q0iYW
	zF80aTmZqXXi/uvPRYMq4D3ZAy9pD32Nmk+fW3ekZr1wNeuu2qIizd7aOVhlM1LDsoPdQ55l/bJMl
	d5aAlikg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30OK-00000004V5H-1Yot;
	Sun, 06 Sep 2026 00:05:48 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30OH-00000004V4n-2jI1
	for linux-nvme@lists.infradead.org;
	Sun, 06 Sep 2026 00:05:46 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so18019055e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 05 Sep 2026 17:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788653144; x=1789257944;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KQ+aOMOBvKp2EH58IOW/Txkyf7rB32ZaIdO+bEO/rCH2atM2SfdztWVay2lik1S9Wz
         NJt1kTZivhkp2zr3G3k17n22lqfqBIBW2rvpB3Yjt+H+/jCmGAeCmC0zkvfi46LI2dZR
         kcIKsN7ie8/cFUdjkorGPa+7KdyWKQ2pYVNbj+1SEigTplb0Q/WODgLf+XyP8iBKejkT
         ThGxklG2uz0H7u4gsfDIEjsUw6L7Zde3o7KE92W1yzhS73dislQ0yFiGjHSsjgvzDV3S
         Y2A29WwH2g6a2YktBSwoT02WbZQt5g8nlafEabsm2reNa5YqscBTCGUf0DQaVMXl9xQX
         nxew==
X-Forwarded-Encrypted: i=1; AKwUvBx7t38NvDoQfUskJICiuYRw9bPDZIYJy4NbD+9l69chQhDNXUPgcfmQkvgQXaga6KnU8Jh8B0XYN1+D@lists.infradead.org
X-Gm-Message-State: AFuF++nGiYm99eOEASWJ9IEXPwgCcyz+HRNgUuAeHztAY7sZA4sUBzSU
	zMB8gVvcqLFPh21bewY24IYQ0TbrqCpI2vMrvUgng79S8c4/j0Qjaflm
X-Gm-Gg: AYBFou3/UuGV70LZLPXrjrop3EpNhLKdgd+p7TNPJoQrXYYx2xiROVN/1wMrGiMMFGK
	OvGfj4cPHjYRNcQc48iBtEebxPyEc9HGMC8drpavv2kYtyh00HgU2wDlrWDO6v3W8Cs2pc3lKkL
	JQdYgDdvUY0i8xaU6Oo57VjYXmE0D6sy8VmR0sfyZa+ta/HlJvORP+aPUHJq41sKNwa7Zn5WXqQ
	Y/uudVVT6w/Hk5NIEtf9YZAO1zavxpA/WOJxfoCGfMMWBy3Ndz+XFXpu7RISmH+uvLuOT9w6Ekb
	VFA8J3V9w02ubnn4jafoQgmyrppLUXV4lxkMHZxgW6E2GLMT+jPWmulNn2GSreHFcVS3TmSkDiy
	lY9E6ea8dKeYmBrI7UnC02EHIiAsEfAxpTQNWsL4WLecmVFSAQ5t24mT0CPjyL9hWQe0BxA4evZ
	LQPM5URGEj5rgvi6kVsDYXbqpkTiojlY2IED+yfSgyxPnUKv5xfBSdE6UW5CRToXGR8YmJKDalJ
	+wjmZu9ltL2Oz//WsRRnQ==
X-Received: by 2002:a05:600c:c4b8:b0:49c:799a:177b with SMTP id 5b1f17b1804b1-49cf82be855mr139993475e9.2.1788653143599;
        Sat, 05 Sep 2026 17:05:43 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm414632675e9.15.2026.09.05.17.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 17:05:43 -0700 (PDT)
Message-ID: <8bd8c5e1-c165-4e88-a4fc-a7a93413bf1c@grimberg.me>
Date: Sun, 6 Sep 2026 03:05:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: reject C2HData for a non-read command
To: Yifei Chu <Chuyf26@linux.alibaba.com>, kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, roys@lightbitslabs.com,
 yhlee@isslab.korea.ac.kr, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <178730451245.442148.11684394617763960186@linux.alibaba.com>
 <20260822014037.1978918-1-yhlee@isslab.korea.ac.kr>
 <0a6b07e8-3ea6-4458-95eb-4a63b6108823@grimberg.me>
 <178842720109.1034236.7954869548413684234@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <178842720109.1034236.7954869548413684234@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_170545_699425_D9DD0EA9 
X-CRM114-Status: UNSURE (   4.30  )
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

