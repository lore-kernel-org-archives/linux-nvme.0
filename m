Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97D9C021A0
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 07:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=dFtDzYGdR7joLlvbY0WZgfh0CF
	ymMDvoNrjbvTGsHOtAvdOYWuxLwKRhUdxPqIwxpFG5hf8JoDr3zHLD6en8ctSWq1ycSd0PYyTunMv
	Jot4V+JiDFhoJJ6GroJVVjR7mz6VLG1tFnSZEEZx5gwLcjWFjm/jEREx/ycoDmR4M5mCSchDM2WE7
	sd1QyAFoXi1TvVw/ajo1jSpEXC+i9XOEDz3uYGD7V7gy97T3yMvyUT+2wCfi+/5xldJnPuyTNZv45
	CLWfRDLqy1NWFUPKhHKDIFJdb5CSATe0L8SasGYZJguJ8beJyySYVy41I9w7WQv8+Gb/dvjeKQKTF
	AkXo+kFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvrw-00000003ena-1k3C;
	Mon, 17 Feb 2025 07:48:44 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvrt-00000003emZ-3mSt
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 07:48:43 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f286b5281so1775104f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 16 Feb 2025 23:48:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739778520; x=1740383320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vcc6XshkDhaZMuKMwm4s+EbevqlBtSQgG5tw/XX0FZjjmUfmz/zru5X9dMLpoRqqqD
         1+o4qVuLHhC89aiXx520PieQURfi2APnA1ane22xGHTTsadsbykE/VPYDn5POfKWHodx
         lBvV/ks7tRXC0Zvyt3h4WtfdyFaDp46MfJm0disDtOWyHlWEDB1g251lroXYFTGPXe3s
         D4cWqhKXA2sSFo+X2BE8jauq5o1gzId1ILGO5iuZtqPfKs6ZjPUug3gZntpE9OAxc+zD
         GIMPjwXyfqUgp9W85mulI7SG/4HPjMlSvvaZLwU5PQL2ZhPbc6AzJquipt+zZ2nvrOPK
         EG0g==
X-Forwarded-Encrypted: i=1; AJvYcCUuD9RkBKLUJt0u/D7DAjBfyV2UBIFEnHb7pkvG4qDrh9jF1HpaUvC+/pN0TUBsDFTY6gpD32wuvgqk@lists.infradead.org
X-Gm-Message-State: AOJu0YwlXh1QcK5rujaY5TCE084P9b3gzyjzvT8PQ7yqxEMUxq1rolGe
	kIUif/OBKgDAxQgdFueLvB6IpFDXCH9WsVtF8pbmVkdxWpNGUutX7Q5lTA==
X-Gm-Gg: ASbGncvc3ZPkyLlD4YN6pkCU/d1mauZiqcYDyeB6msguvvAJyF1lj8Zb11HY3Jy09Ez
	deUiNjfUleJFK259C+kDtNmuHJ6iluHDaXYbUUA+mtxgdqy6UKoowYPaa8nzoE/QNdnHlXAd2J7
	pPaZ59Tb9gHCO8Btd7Xn+VDB4jwAS0kkMHhd+o217kWkRIDK6ypn4wR0rSiWm2+t4a7qxitc8fT
	xD7OXMlrg+sr5eirwgLSGMuNx5W5b+u2lvdpo08ENmcn+VcYFBvhvU8kmsWMBQbzVnGCaYvf5AF
	FGAdf5zDJ/1ph0ytbkj0QNyhlrP/qd57Pm/M7F/4R4sdkpYVU4FfDQVRCg==
X-Google-Smtp-Source: AGHT+IE8KtFl8VzbnXz66NbAZvi3FDqQA/c/mvG8iDYhdBAOdtKtjN3qziDifXWODxUH2AwZ/AwZrw==
X-Received: by 2002:a05:6000:401e:b0:38d:d8b2:cf14 with SMTP id ffacd0b85a97d-38f33f34cf9mr7444213f8f.30.1739778520060;
        Sun, 16 Feb 2025 23:48:40 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258fc8b4sm11648616f8f.50.2025.02.16.23.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 23:48:39 -0800 (PST)
Message-ID: <d421eeea-ee25-4ff2-b64c-00d90efb84c6@grimberg.me>
Date: Mon, 17 Feb 2025 09:48:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvmet: pci-epf: Correctly initialize CSTS when
 enabling the controller
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20250210002815.1744205-1-dlemoal@kernel.org>
 <20250210002815.1744205-2-dlemoal@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250210002815.1744205-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_234842_052404_F8826451 
X-CRM114-Status: UNSURE (   4.94  )
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

