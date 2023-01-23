Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C004DC05027
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 09:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=hxcjWTROxfzJPcjeupK0ZEkb1h
	2fq3OfRO2gmnlfVqy+Bi9hRQTo7A/CtKbv+6RXlvo+C8mGbIVK5om4q6yru5PQqpogpGed/OKSFCB
	nw1IzDlleM+u1gD7wD4zgK4gNm7lB43HyZRSeEj5J6dVHerY0Xs3OARKixuYk6b0QGyi5oHgEqfpf
	VJAM6OA38IOfN0NERq2OvOxAqweV8onoC+T2THnawarfNuoAhWkHyFgAyprmjEZ4NkLLpEnI5aalu
	ypA3yLgk7/cO9C9fccgmte7Op7Adu9tXdSIJbv5WcJ61csMFtxIcGIooLL1ofCiftS/NpPuHRuAGl
	tgOuEcDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJt18-00GVRE-HG; Mon, 23 Jan 2023 09:21:30 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJt15-00GVQK-Vd
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 09:21:29 +0000
Received: by mail-wm1-f42.google.com with SMTP id o17-20020a05600c511100b003db021ef437so8000840wms.4
        for <linux-nvme@lists.infradead.org>; Mon, 23 Jan 2023 01:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=XrO7Pun5BUoZwkCc8D2DwobpZZEYcN1w4HK5hUPERxKDLdymix1EmLLz7hFtby3/Sf
         hCNf66l8FGeX00jO/KFoxOqjOiN7d9vCKC9dU1F8QKXqz17PWcvki+qltqHfD37zp2HT
         JLBrUOprepexkyZPyWj6zvURfxm7dQAqLPVlq/srkaQmU/Kn5W9Ruz0F23+e0hJ0yPuk
         x9eW7rca3qesZSf/QtOa7P20jZIaCPymy0CHg3S6YmCnrO2w9KjWXmYbi1AR4H9k0Eu0
         WOhmG912EJn54DcPK3Ugsc9F6DNzF7zPcEjuWNq4v8+AN5mBZ/Tp8LWG4Gc8vh9niRkZ
         iacg==
X-Gm-Message-State: AFqh2kr7vauBQtUnY8cKojQ9cQFfRq8wW7dQwr7Jg5fJShFNyOCBJe+L
	9eTkKpP0x/jt5sTyt/JMNgE=
X-Google-Smtp-Source: AMrXdXuqAKr2rydx4lP9tEAHT8qUcHTvzqYh2iKbjZuSAuY5AgfU8d6eHvzlYudYvF7EfyNy1gUMGw==
X-Received: by 2002:a05:600c:1ca0:b0:3db:1ded:1769 with SMTP id k32-20020a05600c1ca000b003db1ded1769mr15279495wms.10.1674465685056;
        Mon, 23 Jan 2023 01:21:25 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b003cfa81e2eb4sm10065158wmb.38.2023.01.23.01.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:21:24 -0800 (PST)
Message-ID: <69120ef5-f109-ba3c-7a03-127255d40a7d@grimberg.me>
Date: Mon, 23 Jan 2023 11:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCHv2] nvme: always initialize known command effects
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20230119164128.2159217-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230119164128.2159217-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_012128_040500_899018A4 
X-CRM114-Status: UNSURE (   5.22  )
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

