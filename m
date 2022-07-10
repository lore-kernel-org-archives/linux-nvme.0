Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBECC43334
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jul 2022 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=odjypm/kFVGBzTHaJgTzRm40VR
	DXg3ET+dzwqLeMQImaA4E6CZMDcBSUX4vcbguEqhIhDxyPeHjxkcersggalVrpDKGvrgN2vM2Qz7T
	0CG/7j6+I+bZIzTIvPuboL5ygIjz1dYr1J9omOKHNmaiKUW1PHJ00wsPXjELyCK3UjNqCeX1xA879
	bkDERQZ/M8L/NhPIMRGaStAPXaYtnx6HMPM2hPSrdcn0jkn5RcMJtaJbk6Fcf+66Hq2X0qp+e+Xe8
	NYE89DCSr6drIIImTOwn4MFgsoULiPrPF09+9T/bDxTcgsOl9SxhVsfnSVxekdsP9LM+B57p7RQBa
	ath8jPNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAUle-00BUse-Vf; Sun, 10 Jul 2022 11:06:27 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAUlU-00BUqD-An; Sun, 10 Jul 2022 11:06:17 +0000
Received: by mail-wm1-f42.google.com with SMTP id ay25so1593658wmb.1;
        Sun, 10 Jul 2022 04:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fiSZiSTN9wQKt/SvnlA2se4TuS4IcfJxZvVyWB0B/oJWdYGSGJ7P/Zr5dFBdbM9S0M
         Cp9MhXKwa5lt6HeQOf7AWufr85GNDeweDJUrInJBOG76ub2pVWBJCxoHT7O0kBaV6sBk
         d5UKtqtTid9IkeUtONvebwKnjXy3rTaV/5kHUphhAJwer/wLgzOZkPPYp9LjyaXxsTlY
         5LHENJoXkOecNf8Shd1WzHrDazaPXnuGuBd9PCgOFOhjdkVsH5sS+/D6sMBT2BweA8WY
         jE1idNRDE+G3sFO+u+zjClj99U33ZL7s3PncvFkgYD2Ti1UmUX1bDhvF+Gae5C57hkI/
         t+JQ==
X-Gm-Message-State: AJIora9+bTIS12Q/2ILMAWBriG//G1v+R0sid+8Gguhh4eIWJUCazRkX
	mEOuoDjqfxqIxVyD6bSlCZY=
X-Google-Smtp-Source: AGRyM1u9OplNVMIijsptcBWCf5GDM/1rI8woV2vMUae2GcFGZYoiIZqzyFbxnM7NfxZwl0VgQDB9Ag==
X-Received: by 2002:a05:600c:2107:b0:3a2:d6c7:9d70 with SMTP id u7-20020a05600c210700b003a2d6c79d70mr10279044wml.42.1657451174065;
        Sun, 10 Jul 2022 04:06:14 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i10-20020adffc0a000000b0021d62e30a62sm3377035wrr.50.2022.07.10.04.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 04:06:13 -0700 (PDT)
Message-ID: <3773a28b-0a3d-72ed-42a4-99fb1c0abd48@grimberg.me>
Date: Sun, 10 Jul 2022 14:06:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nvme-apple: use nvme core helper to cancel requests in
 tagset
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, marcan@marcan.st,
 sven@svenpeter.dev, alyssa@rosenzweig.io, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, p.zabel@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org
References: <1657249565-89708-1-git-send-email-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1657249565-89708-1-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220710_040616_379038_4625697D 
X-CRM114-Status: UNSURE (   5.29  )
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

