Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042EDC35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 09:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rxUkTZ0H9oNZqMDbgBedHXxlXdrWLyaTXbBcHT/E2gw=; b=m17dDVxAUbJs7GiuqfO1XU1ocr
	Q1u5LPKXZnlxO/0GbnaqbqDk3Tz1wZFBiHGw4dA9u3sJKK9MrJ1AwR+eGq6LkWtI9Nqyoml0YgzyY
	9lEjiQhPxRtqCX7Wio5x2m3ZOq5jqqPU6/4X8nAsevCwpPhxjm3z5iYDGw8QffunbHpE0yJ33xZw3
	GG5sYG6CBPegVfT5QSga3SK/9fCwf/KbvXwhge5QdTVCY001qgwpd3iNDG3jI7sfHWPaen5mpd7Sp
	ypQjwn4N4m7kJaxhTqzoFlTMpb6mOjVPgdKB4W+sFAGKdDCFH+a7zd1ngJZJQZ0vauvmhkTWmyjSE
	EfYsCqeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGEwY-0029Gi-0c;
	Thu, 21 Dec 2023 09:02:14 +0000
Received: from mail-lf1-f46.google.com ([209.85.167.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGEwV-0029D4-2g
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 09:02:12 +0000
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e558cd186so162854e87.1
        for <linux-nvme@lists.infradead.org>; Thu, 21 Dec 2023 01:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703149326; x=1703754126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxUkTZ0H9oNZqMDbgBedHXxlXdrWLyaTXbBcHT/E2gw=;
        b=iAV9tgJWijxehIkBOS1zFWcDcaWw6A0nObLZr+rUyrHKwBsVJj+Dxn1JwloWKsvg+J
         3ciiJMFzmG1KBtGPT82RiPNsTTezKQedM6zrXQtmn2akUPOaRK0lHpbnHS32FfLywPNX
         +VY0bV3NmVInd/dm/rmxtQvtNOX3fyrxq+Fy95PB/D9dpL/Q8u2W2AKiLHPtKYH6Neto
         vuTCoRBXk/U1mLvnznUJBn2a39ttTQZVGzW26vkbSf8AsSWfQYNqXaLaAQsy4PGLobMN
         gq+Dt/zCeLBEpXmbZdC8DgCkpt5Ga27J1rSClW1+HqDbAHR2ZCS8+LQQ69u/b0jZqAE3
         pfZw==
X-Gm-Message-State: AOJu0Yz2xM7QickXV1VifMNd4oyNKfWXeI9HBmBh6fW///vFCCsW5+nP
	5ZW5MlRbCfg2KPxQyW3RkIQ=
X-Google-Smtp-Source: AGHT+IEzykzZnKJHPGzfE+LAgBIH+sIyyUiaXKlen+nRvx4nKP6HxRNb76uOINoS1oZ+FzdYIy2BoA==
X-Received: by 2002:a05:6512:b26:b0:50e:18e0:697 with SMTP id w38-20020a0565120b2600b0050e18e00697mr11911426lfu.6.1703149325688;
        Thu, 21 Dec 2023 01:02:05 -0800 (PST)
Received: from [10.100.102.14] (46-117-87-214.bb.netvision.net.il. [46.117.87.214])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b00336815d826dsm1515029wrh.76.2023.12.21.01.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 01:02:05 -0800 (PST)
Message-ID: <5694a097-eec9-45af-8bf5-2e5d3963a03f@grimberg.me>
Date: Thu, 21 Dec 2023 11:02:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme-fabrics: don't check ioccsz/iorcsz for discovery
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, dwagner@suse.de, kbusch@kernel.org,
 hch@lst.de, linux-nvme@lists.infradead.org, oren@nvdia.com
References: <20231220092745.35325-1-mgurtovoy@nvidia.com>
 <573c2ad1-8407-4c8d-b31d-b89b16f0fea0@grimberg.me>
 <CADUfDZrhPONOEK6xhbn3Uig4UZ+nwg0hDCRUziW8NA_g01raHQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CADUfDZrhPONOEK6xhbn3Uig4UZ+nwg0hDCRUziW8NA_g01raHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_010211_867117_98219BE6 
X-CRM114-Status: UNSURE (   6.58  )
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


> Why? As Max points out, the base NVMe spec says those fields are
> reserved for discovery controllers.

Oh, didn't understand that it was already the case, I thought
that the intention was to made it as such. Can you point us
to this part in the spec?

