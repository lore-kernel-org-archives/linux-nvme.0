Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4C8C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 08:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=KcU3rKzc6aVDoLF6Rt7jbv7HsW
	Xzk6d0PekyzS9UMSli++hUUUH6/0ChgCIIZ5HrlT/2bYtUAfOqyJILZvWbIbe6WnBVDSn5WBKA3DQ
	l6aZz9qfZ/jcptUj0PsLiDtOFkMgk+Hb+9ZhYHha3MRUTTdhRwdLoJXQm2lb/GNg06a5ZOgpJ9Pfe
	dD2nnYxdoc1LjBQvOWQZ5J3N26bXazI7L60/hn3ezyWqyNz12ugpzgCAmvEaaxZnYcNsaIWBh6Phx
	vFul54BeLCjeHQicCacW4o9X02qvlb4KMO39VKFfo1Hl1eMkfIDdW2YPl2sjzX4Jhdk3OhwzKAQb5
	YAQ8Dydw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4Ih-00GUA1-Ke; Wed, 19 Oct 2022 08:19:43 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4Id-00GTwL-Po
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 08:19:40 +0000
Received: by mail-wr1-f47.google.com with SMTP id bk15so27774214wrb.13
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 01:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=rlmlt4QSiho1uv4aFuo68cHeH9qwgTbBbteVt6oXYgU7zuLF8j1PWyEBrqo/A8aVML
         ZwsgPMK6kJhe0Qpl+LhqCSCjukc1XkYaiNzsirMJ32/5HLXuqQjD9UXVlC4f4AGHnroX
         aR+yhF0dSET6zJC1yoLeORL16PnLuReqysjuWis9TggVx7cgG+uCsTPsaumWPbkfsIuJ
         atYGrZOsBIX/3JeK+cAQJATWSf4gPJ4FCAy2iFGSWJ5IzOEPau9A8qHk/0dc3o1t5Vwf
         m3pvb9XTpoV+6NSoJZ6QrT42K783A/aZO8ysWd9q++puyfRT/CQW8Ae145Tgb/qwFrWW
         eObg==
X-Gm-Message-State: ACrzQf1jwt9GyWZ4GbbTwobXoog4FOL9phtbuxfYGzwFkJKTlDYE0f0/
	rXjmRIkLHJL3hHvCjHRBc24OkHFeYms=
X-Google-Smtp-Source: AMsMyM5wXkXOMf7f8IO6xMolfmR8pG6VjvA9rnVoAkzSpdMGj1++8w63nXLq76FhbkNVn2Vm63O5Jg==
X-Received: by 2002:a05:6000:1786:b0:22e:3955:13a1 with SMTP id e6-20020a056000178600b0022e395513a1mr4197623wrg.624.1666167579379;
        Wed, 19 Oct 2022 01:19:39 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bi20-20020a05600c3d9400b003b49ab8ff53sm15131879wmb.8.2022.10.19.01.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 01:19:38 -0700 (PDT)
Message-ID: <34fae217-1d72-3229-bf32-d0fed88cc641@grimberg.me>
Date: Wed, 19 Oct 2022 11:19:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/4] nvme-apple: remove an extra queue reference
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20221018135720.670094-1-hch@lst.de>
 <20221018135720.670094-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221018135720.670094-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_011939_862672_6454170F 
X-CRM114-Status: UNSURE (   7.62  )
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

