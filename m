Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFD8C2BB3F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 19:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=WIFvd5MSR8WPSosqw0WafkYEk9
	s/zm0HN8ewKcMy1IAn98now9CrNqVWoxIdCIytnePKD3HUXuQINiKE9h31prgnKfUQqu7xBgKdBQd
	WglFrVzyrwNhcw75QzZSD3N1b04Px1utP3TUxnjS8D6/n/9nlP4zPK3EnfWfBXGT1VRvhdZJ3Pci3
	qfqMs2UrNjlWlI1E/UiESGggKOrjEseXM4nTjpOe6jSzddHYP4M7QGpewMot/UMN2LOnH2LTMXJoE
	B+sjlDiyyEft/B7y+cdfSjnECAeQkVZXMLvdGGDlP8vvEsByLmZ7ZpSxanDqJSwQYBJmQrQfauf/L
	3dLpUjSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r59ax-00EfNK-0T;
	Mon, 20 Nov 2023 19:06:07 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r59au-00EfM3-0E
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 19:06:05 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-407acb21f27so5044515e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 11:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507159; x=1701111959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=n+H6DEKBWaojcUZpRlwBTV7ybIGdFQQGxnX1zx5D03JHD++XmuRicKIB/+thEPVslN
         7r6EUMIiCrtPa99Gnx6K21JsmAZIL2Xc3VFp6TL1x17++48mthhvfJqSVJD30b35NNce
         kjAjBaXMQNDKdx1Hf0QpR91/KaGeal0w/71kqLEMMnmOdmKfljaTHXNnLsfPQe/yCghU
         5XGPC3yQ6AJP9wUSfSJUa+8/20VfjxxGSjV9Fwkq9NcykLpInob+tCl8KLSHsnax01gM
         5Zh2WqSCCr9PhoDUh24lI9PWG0d9312a+cSuQ3gF/k5YvmeTsUtF1vBJDqSwO7ZmcLZG
         KjUA==
X-Gm-Message-State: AOJu0YxNZ8hP9nuPxOwspS+CDVedC1KRJvAU0z/tHQXFK1eclMggwGU0
	lpcUEFLPVjFQjhGb2Cusfmw=
X-Google-Smtp-Source: AGHT+IGbJXR2CK0dTYC8RFHXbuTPwCsGDQB8maVLUQ/WV42ad2a/xDULaZJFJ6Zxg846izK0v6C7qg==
X-Received: by 2002:a05:600c:1ca4:b0:405:1ba2:4fcf with SMTP id k36-20020a05600c1ca400b004051ba24fcfmr7017692wms.4.1700507158909;
        Mon, 20 Nov 2023 11:05:58 -0800 (PST)
Received: from [10.100.102.14] (46-117-95-192.bb.netvision.net.il. [46.117.95.192])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b0033130644c87sm12027998wri.54.2023.11.20.11.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 11:05:58 -0800 (PST)
Message-ID: <b7beb838-00a3-429d-a45e-4534e99b1dd9@grimberg.me>
Date: Mon, 20 Nov 2023 21:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/2] nvme: introduce helper function to get ctrl state
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20231120175035.978147-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231120175035.978147-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_110604_120485_5C802525 
X-CRM114-Status: UNSURE (   4.47  )
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

