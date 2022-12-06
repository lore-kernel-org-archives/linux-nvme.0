Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A89C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=F9ED27uT8EgO6Jxm/hAm1fAGZ9
	uMu7vbE3VxJuXP8ZICPea1WfYR7P6zq6oUriQCqZrjVB+l6d0iuBDo0ekknON7OLsgw3ziZ2zM8oE
	blvPT5TiOp2v4JuopnNQV1Vn0wPqZ3tDcAfL5k5uaH0E1eJG2hoRYhJDlEf7tmnK2s482ZmcpKs8w
	8Qln0uYRI8Mj1d7ituouPBNwYi9Fy+vzuwwKywPA7tvCpjAkXlH36xyWpsLezX9/LAwA4rNXzuiep
	pcxXMdjtkUSM5YbZffgNSxNHAsFfDtem5bKgcsIG+eRH4EreWcDi3xaBcfnRkEXs/vxM88139Rcmg
	gkasyKXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2WuL-0091SA-6i; Tue, 06 Dec 2022 12:18:45 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2WuH-0091Ps-2R
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 12:18:43 +0000
Received: by mail-wm1-f45.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so14154763wma.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 04:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=JI6EqWnfnoomQyuQ1LuQTMYLcoMMOk+mAHoSNMslqZKz0/0okysTqrBkg0N8HOc3a2
         ojIHTOq43B4mAygf1OwQWH5ElKjOK3olU/4jt/ad7m3I4SVgUHONrlVjjdVQQFmpb3Ps
         jlGlP/4PFaKHU7piL8QlqOCmmZy/w9+suQjvn2fhQahjT+ROWVEKlWZ5KgcFMFTWql2G
         siM5ARjG20iPIQJ18BtMxb8Od+p7pwg//mKxrwwu6vY+d78IGKZlCxcYPHm2AFmcWJcy
         sv5aV9wWM3n4KLULGShJTIDm3ckPWOJrRpUCAEwPm0Dwcuy+XmJ3STRHREMAxIYEZG4H
         JuWA==
X-Gm-Message-State: ANoB5pn2fooMwhseEV3IuWEx2l+WXXOq3tS4PV9mBIlWMHy3CQtxt6Z9
	QXuv9nZ2JRhjaWrploKQdf4=
X-Google-Smtp-Source: AA0mqf5ARJzV5nNelgkDuGdxo6D+L1/QK90hI9x+pbOGP1CNLmJW5hSy9dHHorA4abxNVOciNahDxA==
X-Received: by 2002:a05:600c:1d1e:b0:3d0:4720:5293 with SMTP id l30-20020a05600c1d1e00b003d047205293mr36694833wms.176.1670329118296;
        Tue, 06 Dec 2022 04:18:38 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id t67-20020a1c4646000000b003cfa622a18asm23902118wma.3.2022.12.06.04.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:18:37 -0800 (PST)
Message-ID: <9e2d614d-5c45-a9c4-8a9b-901d1ea457c9@grimberg.me>
Date: Tue, 6 Dec 2022 14:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/9] nvme: merge nvme_shutdown_ctrl into nvme_disable_ctrl
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129132208.4337-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_041841_120745_135C9DBA 
X-CRM114-Status: UNSURE (   7.11  )
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

