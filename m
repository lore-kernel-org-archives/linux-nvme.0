Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C634C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 07:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=DVscS/4iD0SeV2u50WaBno04EP
	iJ6Cl71G3UG+svVc+/XB4jBWfb4Fb5JGNpW2YfsoWFBTVUYl2tVZs1QsSjqWv5+jnRWYUsUNGk1C7
	0et0JTZnmDzJwEIXm7uVymdqQyzzrRMsRLn1Bd2nRLUKAVy8r4tC5gclR876c9qUZ5eJ8CE2ozBxL
	CzjQxjfPxY3OIBBCu6e/+2SR07DqC4ApqhhCl35jQ/GE8/VsHMoeOO4t2UVnA9eyyZFRt7GG8+1Vd
	cttrAt9E58q2qT5hRLEG083MrJ/U517KQviliFeDJVTqigoPOQzEZsZFTcfqoft4rkII8jggLWneH
	mDlMlKoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obGJf-00Dimo-Ox; Thu, 22 Sep 2022 07:08:11 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obGJd-00DilP-Ta
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 07:08:11 +0000
Received: by mail-wm1-f46.google.com with SMTP id t4so2212468wmj.5
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 00:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Zg0rs9duoO5j+8OL5s3GYjwMRq/MKVDZk0WyG20Cb6sa5dyqR9AWVdXMIxhyim5MHz
         FU5cfJhmLepVOfjDqfgOYcxaEFE5iwdmTZVdC7B0LwLbAuquhPXRfD6CiOeNfObx3geN
         rd3bZ81BYv0eAwhtC2fMSEInybSQFreMtTTsm2xEJxS+wk01bIEquZBRYJElzaW0n679
         yCuJwuarSAOlwRfwKH/QIQevLYXUUzy9mrxez9j0O8s+dFo/BiBKza91VJ5gYh3QwjsT
         MeMb8PaP1OziXd6b0gR4pKJDwxkovnVNQ+DJj2PdXkcp8EXn1fhBN6ahY+CbYw6TxesK
         wANA==
X-Gm-Message-State: ACrzQf0Gkpi7cmBdlThLkr8J0FXRUOQBZXX5HsuMCdUtRQm1T2StAsnV
	XXvwDtYnl8tJZfSx3ZyA1ys=
X-Google-Smtp-Source: AMsMyM530FO/8mVaChDTJdndSiGt3YHF3QItRCZ+6Uj0jpAuNAIzlAAQPHmarxm9mjXEVjNE9hxTeQ==
X-Received: by 2002:a05:600c:6025:b0:3b4:8c0c:f3c9 with SMTP id az37-20020a05600c602500b003b48c0cf3c9mr8067924wmb.206.1663830485925;
        Thu, 22 Sep 2022 00:08:05 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x8-20020adfdcc8000000b0022a2dbc80fdsm4355131wrm.10.2022.09.22.00.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 00:08:05 -0700 (PDT)
Message-ID: <aaf0642a-77ae-0b02-6e68-50aebb746355@grimberg.me>
Date: Thu, 22 Sep 2022 10:08:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet-tcp: remove nvmet_tcp_finish_cmd
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220922070616.41918-1-pizhenwei@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220922070616.41918-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_000809_964563_0EE65F2E 
X-CRM114-Status: UNSURE (   6.06  )
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

