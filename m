Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF0EC25B7A
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ERJE6ZS40ChgW7dJ5kQZvJ8tAW
	FdvKrjxZI5UQFav1aefqEYJ+WIu0yOXtWI8r+HYdtMdOoKi0tqkPznDmUgh0r95alVjLDEH2eljCD
	ft97dbYSEyNbLd9pMy0FHVlj3tRYW0Xm3loO4WiZ6LYjVqtIx6uDfEtelVNN+lsLgDDijSgWZD9aG
	I6szjKnkNdX5fMwizmiV/xT8ZTxlFnMpiS0JHCqJ/WhtTSqzmBmX5dqinVLzrUi6c/vqSnHHK1yYT
	hjp/lBsxMJA9YDvsVBa4Xr8v4Vg+85RgzQ2fxUJcLRl8k3gxb1nahxm65Cvzo4XpARN8j38CDrrsb
	QisGtvgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAWrk-00000009FEv-2zYa;
	Fri, 24 May 2024 15:29:56 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAWri-00000009FE9-3JzO
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 15:29:55 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-354c3a7f972so210326f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 24 May 2024 08:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564593; x=1717169393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=dqKpJZqsA2HGXugimUkhY3fPc5tKW37B5k4wHvdHuXbLYwmJxHhvPnwWpFMGFDphMb
         KoshHY/2gAlBW6iWlAi6LDQ//tat+F6j6p5+UlvbgjUCyxA1OqR/gwLGQNjxP4cktf++
         gqfNqQH0YPCOaRIyvAabhu4Rp/frJV5slpWUBS2M2Nna6eshmDJGtqFeNgmS8eZyghRZ
         pN2FEjkbr9/bvQzfEQjJ0HjauuSS//yeE4g/QFwRs2H8N7F/monLIt+9814CKw1wrw1i
         K0OADBmHJ+GVgjExLCa9TUtd2lwdYYxOhjG9e9Vy2aOetqNNF/4g9DB7z+AzDb/m9XZZ
         u6hA==
X-Gm-Message-State: AOJu0YybGDfE1gO4m02s3pdeKBae8BpOrEUqnm6HqYNwMNYn2zCMPmFP
	YkQjiXYzCRXoGMT0WDcquLM3/DOnw8ysVBEYoce1X602k+hiD6ox
X-Google-Smtp-Source: AGHT+IGydm3KFFkEOm5Dej35cysCFu2y3Rn5joLTpDVvHql4Yqq2H6FRVzp7ujzne9BypYIC9Ekc0g==
X-Received: by 2002:a5d:67cc:0:b0:355:3ec:c7e7 with SMTP id ffacd0b85a97d-35526c39f44mr1702503f8f.2.1716564592913;
        Fri, 24 May 2024 08:29:52 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3564afc3577sm1102707f8f.102.2024.05.24.08.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:29:52 -0700 (PDT)
Message-ID: <d492a0d3-5e3e-4f69-87e1-9d251ef604bf@grimberg.me>
Date: Fri, 24 May 2024 18:29:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
To: Kundan Kumar <kundan.kumar@samsung.com>, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 joshi.k@samsung.com, anuj20.g@samsung.com, nj.shetty@samsung.com,
 c.gameti@samsung.com, gost.dev@samsung.com
References: <CGME20240523113915epcas5p32626cec7fb138355e74415534a3ece36@epcas5p3.samsung.com>
 <20240523113149.29174-1-kundan.kumar@samsung.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240523113149.29174-1-kundan.kumar@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_082954_862649_E8FA2544 
X-CRM114-Status: UNSURE (   3.94  )
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

