Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F5DC636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 10:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=TSPv32VjSvwCKxyuDIjLm/40NE
	4iuSx0jMzy9d+m0NXxV7kqCg7eH/rd9f0QiP+7Dzemsnk8F11Zd77M0UghAc6qGwJKeeT04AyXr5J
	fVhbbKsBoMtfHeBS4LGpou64BSViDqGrrgUCo+dmcWvTg9jOwfas4PCQUUZz17Hcyhg2anlGDRx+x
	kImcHvJCctu4NjLtvPE5xw/Wx/d5nBMkYO5BE+4LW84rISuIBehk1JZ/+1fOF32bwcFxsbIz5+rmG
	L54zX2DQmBHL4RHAI34nUJ5tDtebHLnwWH4+9I21GJ9dHoWTsNCYRB61CkitsGX08/Nc/HbhEW9Lr
	/xucFCZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVvt-00E5f9-AU; Mon, 13 Feb 2023 10:19:37 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVvq-00E5dl-5p
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 10:19:35 +0000
Received: by mail-wm1-f43.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso10869487wms.5
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 02:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=TmNDBepcsU+7ZJ+yJqUFDLzQQZucywxzN8eK4mR3FNUd/SVizzI17GHn3Hfn2aRk9/
         STfAJ0xlSNA4Q3okC1GEBswbzfbFDj8IcKvOX9GlQ9ZP6SNnjTc/HKzvk1XVRUJJZj/z
         04p6rGwZcv/uCbmtQvlNW1dIWWFS1IQJ+8zS7RV8+afXa/NKkBcwhwjioWLMhWrwQ1Vv
         DSjQ7gPnE8TqOn4mTfiDws0VxKaFF5creyLGeMERUhuHooeqkGE2Mbjq+BUzoNDH/JPz
         Az26AhoefaBZNoPGBG1R7k9069h2uwjiYLTiGO3cto4pqU0lqnJHPat15lazjefG0Y/T
         kwnQ==
X-Gm-Message-State: AO0yUKUoDAXp8T+fbajDEqC1VKMipqsOn7iJguvirVsmdmlX8dstiM6f
	2Wehgrz1RcNSuiCzpTDlNT4=
X-Google-Smtp-Source: AK7set+Hz/Q3aXqr9hsh6Z+ZP8A6dDns5IxHvuyTeJAe/9Ew76l277wQmS5/5aciIxP1kpBrxR5jUA==
X-Received: by 2002:a05:600c:1c1b:b0:3dc:4234:fe89 with SMTP id j27-20020a05600c1c1b00b003dc4234fe89mr24539593wms.2.1676283571603;
        Mon, 13 Feb 2023 02:19:31 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b003dc36981727sm18060224wmo.14.2023.02.13.02.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:19:31 -0800 (PST)
Message-ID: <43c13a32-5c25-82c2-5bce-30e6f611419a@grimberg.me>
Date: Mon, 13 Feb 2023 12:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/4] nvme-pci: place descriptor addresses in iod
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20230105202833.3225645-1-kbusch@meta.com>
 <20230105202833.3225645-4-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230105202833.3225645-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_021934_222670_525E7100 
X-CRM114-Status: UNSURE (   5.82  )
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

