Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205C9C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 13:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/bXYExW/b90DE2Zf0Al+OvO0u+GA2I2C4g8Az2yccdc=; b=mHCvCihNVukbNdEN3iVo2udv8u
	9XDOKsLha38Wc+sgeyy6BGpCnyciIEOMdH9ENmyiSdQI3gW6xpPBFxNV2w0XQ1Z8D6A2MiEUA64kf
	oMaL9MEXS3lxapRH9vHTHUU8VyNSHhPAdujyeeXc+EMLgpnaEsj6zaLab2LP+XAZGGNvH212rmIsJ
	gDQ+VwEHUQxTQqnicEvDmyEUgG5OANnJx3H0MjE3mg77avr/nHY0G8ktHI8JR948lW1jBx3p4aVQH
	yVLZtS6+Ljv1MBvIdu3g20UtN0eMfFhzUIegFhPTZETxsQv4IyjpcPbHAWQpH+kxT7ZM0dl9VmR16
	eN6fVmfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTNrU-002ngD-NY; Sun, 13 Mar 2022 13:02:16 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTNrR-002nfV-85
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 13:02:14 +0000
Received: by mail-wm1-f47.google.com with SMTP id r64so78885wmr.4
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 06:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=/bXYExW/b90DE2Zf0Al+OvO0u+GA2I2C4g8Az2yccdc=;
 b=NhxGlLZ6MK6PsBUY+0I1vhvAX4hpMu0dxyrb1cDWMJNpJ3UmcAyc/TxbQ6UeS7IGM0
 9T24oFklKza9HMJTJsocXyN4EBZZEWfcQRfgfaa1k1Q31R2P4X/abZ7Adb8kyaqwK0OT
 lgwl4jqLR9EpJUXLecWljOUZ66GvpeOu64eiD9h9vUkJhPBZYqF1M/tEOVUyPk45KbUG
 3xvRv7zDVwNwQtLSRt2tBIFkxhOLv5O1DGTZzqtfIBloEOqrpiy/olhCBKdy86eeQZBH
 iSObWglFtIw7JuypE0AGQSTRYq6mI7RNPQUk6zpwbrKiOqI5pONYtNxPSns7REpMPiN/
 UsIQ==
X-Gm-Message-State: AOAM532T1n2EYopzwkto3MV7V7Q2fKVTUj1Dudht/cS9cLkB7XQ4i3FM
 aSDvZDpLUDppMwMRkgBNtbw=
X-Google-Smtp-Source: ABdhPJzqDNjXCkic2iIh0JJCLIk0JdUOc5Sws8j87GOmd8l3WuSKnyuSvB1WmxMnoDIgqnki5t2lBg==
X-Received: by 2002:a1c:e916:0:b0:37c:f44f:573 with SMTP id
 q22-20020a1ce916000000b0037cf44f0573mr22308079wmc.179.1647176531626; 
 Sun, 13 Mar 2022 06:02:11 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 r4-20020a1c2b04000000b0038a0e15ee13sm586822wmr.8.2022.03.13.06.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 06:02:11 -0700 (PDT)
Message-ID: <79c6788a-0c58-9761-f359-ace943c82754@grimberg.me>
Date: Sun, 13 Mar 2022 15:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvmet: add missing locks around nvmet_ns_revalidate
Content-Language: en-US
To: Niels Dossche <dossche.niels@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220309203449.63125-1-dossche.niels@gmail.com>
 <225dfcce-80dd-5b4f-5d9f-18c12107d4f4@grimberg.me>
 <a512e9b6-7ee1-4f4c-5c67-82315520bdf4@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a512e9b6-7ee1-4f4c-5c67-82315520bdf4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_060213_340052_78D02A65 
X-CRM114-Status: UNSURE (   9.08  )
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


>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Hi, thanks for the review.
> This patch is actually superseded by a v3 patch submission I sent shortly after this one, since this contains a mistake and its solution is not optimal.
> Sorry for the inconvenience.

Yes, noticed that, thanks

