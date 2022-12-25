Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63220C10F1D
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 10:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qk6I/lS7fnKBVpYqL3VEvHkVHx70hSEGn39gUKgWJDg=; b=4hfDQo1micrr6ZTgz3JeiU+1Cj
	mYI0I5h7Tneo4xkWG93mxHg47oZA10i3NfdJP7eK3j+S8HZxrmVtvbAxSEUX5itb5IUJ5ZXcKzf5/
	qr5Id4/kI6U9nlV4gpv6Rf2vLiiHZQHIOeoUBCr0YNnAJJYHLxycgBsXS2MWd5xux1piVkYBhRiLZ
	gdJkDjiDex3rvsn/aQoChhDGXRr2RBPeJvJLs5xPxzvHNZ3AbpoylfwCwpdTt1otJH51tPqdfoAwU
	FVym+cx6maE5v/6M5TO9c3H53txIRldZrpctIy6HSUf8tCaqrZIJQlJ4rW0TklOgK1JnoEvvhQrBE
	QQpa2o5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OWT-00AARn-Kv; Sun, 25 Dec 2022 10:46:29 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9NYU-009d5t-Sv
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 09:44:43 +0000
Received: by mail-wr1-f43.google.com with SMTP id a17so8065089wrt.11
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 01:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qk6I/lS7fnKBVpYqL3VEvHkVHx70hSEGn39gUKgWJDg=;
        b=7D1TlRScE/SSY9uuw97JjRbsXMGVES6wGMvXlIHyeJGaXuJdvASbtCVg+9kQh3N04G
         tPbS0ead+oDAlhaHLUT/Tz+YeitSwvxHTcB9NhBLFQxVWJMK6JY0rrBJGSBcpsjNimO+
         V4if8ivLZJAoWWM7zdgBVaVXhcVo7Fn72+EuGU6Oj6ShueRKI6IpgiA/Cks9hC/xQagU
         DbH7dFTeYJF9XOYGnTG+Yh8tycNGycv/994C1xIczDyelwx+mOAqOKuJ3BxOgd+wci3j
         /NEtsyPbWK7NwTVCRTUslGiUWojgtp+hWvb4TDUqIpagduzl1++pQoZdZawmD4JhamR0
         +G9A==
X-Gm-Message-State: AFqh2koiJukXTkx2XJQXu8aqSi8uTTQADBk101nlPmgPyPoStLyyxCa/
	W5pyPwQqj23xuhU0BB1XOmc=
X-Google-Smtp-Source: AMrXdXuRiroDrDyT7wm1EYzRDEbjDdJ8uBKO50xwfpP/TdJImp72XPY8xxuqyiRaIW+syUancIyoKg==
X-Received: by 2002:adf:ba4b:0:b0:242:14f5:7a9b with SMTP id t11-20020adfba4b000000b0024214f57a9bmr10724248wrg.44.1671961469047;
        Sun, 25 Dec 2022 01:44:29 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f6-20020adff446000000b002425504ae7dsm7272725wrp.80.2022.12.25.01.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 01:44:28 -0800 (PST)
Message-ID: <edc14cf7-c6e8-8680-8b8d-c5afb002b325@grimberg.me>
Date: Sun, 25 Dec 2022 11:44:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] nvme-pci: Remove SGL chaining
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20221219215457.711617-1-kbusch@meta.com>
 <20221219215457.711617-2-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221219215457.711617-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_014431_177623_8EF997E5 
X-CRM114-Status: UNSURE (   7.00  )
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



On 12/19/22 23:54, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The max segments this driver can see is 127, well below the 256
> threshold needed to chain an nvme sgl segment. Remove all the useless
> checks and dead code.

What about nvme_pci_npages_sgl() ? is it still necessary?

