Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A849C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PiOpBEd9eTlXYSjfI73oUvNaAmf160IGkOO7gJdLzlQ=; b=LIFZ41IHFHGb0HtsJkHw+RSrVL
	CqMH137kbJiVfXQoF/gYgy5nuymND8aOo7688iMYpYrt34gQMYrRtlpsLj/C5KCu7rcj4vm9EX5m3
	SXRD/hYA50zqRM85BiHINI/XmpKQwsWTWZ3bVzH0kLYVpPqQqGG6wKxOy4QnhF8Y4xzK4HMje+m+O
	fqIY8jEzLi94HWv4Ha/TtK8970C+dIyFyJ3jNo5c+mdvikqMyhQed8uGEDhSM2C7awl1PeEKkeDL0
	ZtbSLKKXUMP/juVgY7WTxyclhGMwJ/sOWwtEEOkbB+Cm2bHXzEuWXTchXaestH/Ja4KGu6OlLksEN
	b0iJlKWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbZT-00AIM9-VB; Wed, 09 Nov 2022 03:16:11 +0000
Received: from mail-pf1-f181.google.com ([209.85.210.181])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbYt-00AICN-7h; Wed, 09 Nov 2022 03:15:36 +0000
Received: by mail-pf1-f181.google.com with SMTP id y13so15506122pfp.7;
        Tue, 08 Nov 2022 19:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiOpBEd9eTlXYSjfI73oUvNaAmf160IGkOO7gJdLzlQ=;
        b=JnhWM98wkEyQUpZo9k1jEpZ2orA5DBeTiTCmzpH0133+fBY4CN1V6LGtJVn1zyOn4S
         jIiAYchQEivUD73JE2kvTiAydSODBWt7UahXuPa9A/0a04hD13EstYlANKqrbRNViZd4
         mDHluuLBHAE3KfYHzOYVBVn2n/49J5rpB1i5ZtP/azDYlaXQSqNMc0DpsmGMbBqLx6us
         Xt5fV360e2W8nIROzHj6BdoapEBPcEV3EqZEghh90nYT4qa1xi2lgJxTCA2gDLk5X7B3
         0h+YN8sNAeJc7Un93rc/xPsdE3NtdHlr6pCnL4B4Hma1+biC+R8AmYZ/hH1ODtiTYqfZ
         W9dw==
X-Gm-Message-State: ACrzQf0zk5+oA9iClleRvIPRXwc2GWFHnQ92TODatJ3VP+lnZfkUDkhZ
	6Y4MGU01Y0UkKF/GmOU+m3E=
X-Google-Smtp-Source: AMsMyM6vW2Nm886FOvXuvNBItj8TuK/IQ5WJuWfhUHATOwxAXqxiWgCBAbdr6QsQAFhTP3VXIduZeA==
X-Received: by 2002:a65:4d4b:0:b0:46e:c389:75ef with SMTP id j11-20020a654d4b000000b0046ec38975efmr1106709pgt.108.1667963732834;
        Tue, 08 Nov 2022 19:15:32 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id f30-20020aa79d9e000000b0056bbd286cf4sm7065837pfq.167.2022.11.08.19.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 19:15:32 -0800 (PST)
Message-ID: <64a3cc1c-20f0-ed3f-4f5f-001bf063cb36@grimberg.me>
Date: Wed, 9 Nov 2022 05:15:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 12/12] nvme-pci: don't unbind the driver on reset failure
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-13-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108150252.2123727-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_191535_312951_53C2EB06 
X-CRM114-Status: UNSURE (   9.29  )
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


> Unbind a device driver when a reset fails is very unusual behavior.
> Just disable the controller and leave it in dead state if we fail to
> reset it.

OK, that is fine by me.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

