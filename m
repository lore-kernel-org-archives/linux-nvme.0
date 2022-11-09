Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CDEC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=zQNTDrbp+XdRnejk3hWD16I0yw
	A4FWqOB3BeYvxLW6I50uZ6LAc/HPY49V5I+1mPdVupNrU9dh1sABCS7pIE3ZLUbrT2q81CYdghoyH
	g0eLGRZoSoEEaG4UEIO6uh+DiwOCmf0R1zCaOUiPrC8J1t2x5dY0tl0SZKqJqW2Qj6pdIaX/9B+JR
	CjGTE2BUXACAbKcPbOMydpJ5xBLRx84V2O7UNaDGAF8o2RVeHPMTS/VhX4Yx6fVAsPOmQ/+bnWamX
	01XclzM0A86aDgmRvf1xZCNwByW9YXh1T4TiXWRRiUKqh08pwMd5/0FnvjbeJJZdtEKTXhLMNFuT8
	e3TcgmmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbOA-00AE9n-QL; Wed, 09 Nov 2022 03:04:30 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbNX-00ADlf-8i; Wed, 09 Nov 2022 03:03:52 +0000
Received: by mail-pl1-f180.google.com with SMTP id b21so15874772plc.9;
        Tue, 08 Nov 2022 19:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Zj0Zq3vet0kFVZOUgxL5krdB7dTQqCMofaAI41cDGuKMWr3rGl1gBJ4F7vg42ghK4g
         i/j9e3fHUHl7qd5jIr1DkCvnmQg5XS4yLIIBUqPER1MIXWXWQa55XWHA03kVZPhpHWsZ
         7qCHyoAnsS1ZU2VGgP3fqAbe1BkBIoZLMHd6aKbHXQcxxjr6SJwpjZs56sc071jYzVWs
         pd9SmAQ1YL92adELdCWMkIxhPDttUYktCNTkR5BYbxDVUbxqt1+xd73aR7EIzcRStDqv
         riNHNVZ3i8zPTInXuH4pYaZ/Y9sVi8ohlqfAtX8X4djOSrO8wdY5JPOYu0NVOS/ILlPe
         F9YQ==
X-Gm-Message-State: ACrzQf04IPw532SKo21u34C0I6L+665LJkfFcD9I7B8c8cmC845ULvYF
	aOwW/VRWg+KGUGPQipT+HZM=
X-Google-Smtp-Source: AMsMyM5yH2lXzn7VDF5ie3+YZm15wjHVwD7Sey0dHpgdbcKem0aRVJ+LlPHaX/kg0Jic1Vga8GzBtw==
X-Received: by 2002:a17:902:7408:b0:186:88be:1cca with SMTP id g8-20020a170902740800b0018688be1ccamr58712921pll.155.1667963028452;
        Tue, 08 Nov 2022 19:03:48 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id t7-20020a635f07000000b0046a1c832e9fsm6458683pgb.34.2022.11.08.19.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 19:03:47 -0800 (PST)
Message-ID: <0431e3ef-f2ee-be44-d1c6-3c600dc143f0@grimberg.me>
Date: Wed, 9 Nov 2022 05:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 08/12] nvme-pci: set constant paramters in
 nvme_pci_alloc_ctrl
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-9-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108150252.2123727-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_190351_323618_9B245C37 
X-CRM114-Status: UNSURE (   6.61  )
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

