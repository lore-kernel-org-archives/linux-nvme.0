Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6674CC761A6
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 16:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=cL+UhDYfvGd8N9ofcxEWl2ntP0
	7A07Ba0Hv7ETAd9xFNbSIIWO3s616yIf3UnI20q3kVkXuOThz29ffg45ejICkrxz7je9ZcqNjBTgI
	MtmDl3uBbyg2Nxsf6dwF9DGjJYNzyXj6hU5TtVktO33xXbMtLem9gx7JdJjFxj1zfl7otKIhqFVh/
	dahYW1M2wzQkSBveK0/F47Z+lUUE9LKcXYGzXRgSWC+8Q4UF+DYZ7hZxht0I7M7tqz7p9GTYj0WUU
	YI5cszHis/pBs27oXYyPsV+HvWTXd8RLk8igvGg8TiYZJ07BY9Yrf7ceej8igtZlnywuARZV+WWxW
	n3Wr1zsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phuyf-004REB-1Y;
	Thu, 30 Mar 2023 16:18:17 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phuyd-004RDE-0y
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 16:18:16 +0000
Received: by mail-wm1-f52.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso3618992wmo.0
        for <linux-nvme@lists.infradead.org>; Thu, 30 Mar 2023 09:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680193089; x=1682785089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=mhvNObx18Nn7dVIbhyBE/ssaHsTtqLTTUyMGQ2nPHcz1yfWHesjwK1Xn3eVGJZYV2s
         5Fmt+W7NnQGqMJf9cY0teLO2lFLjobMHBa6AVHqxP/LmB71cO5/HYM+syWvAbl+c2IX8
         5qHOELjKrxz0z/UfCJZpRZcgToqCapXPrKxyz57K70Vsbhao5IeA56QOqt1WigN/KwoL
         Nw+289/rJ3XR5+FYKiPNwHQhatG3ig1O9JfMr+DJPXD4vFPjbsJRYGbwSWOloLt21SPo
         xdTzd03FUq09TsxRCqJ96dg3QUYwFZ9b+eS+lsliHYR+2XA01iv+va+pgNg8dUn7rjuj
         PFQw==
X-Gm-Message-State: AAQBX9eiGGDfotHJ+/dZABjuXn11fIFU9S2SMIR2GmTGHGihfUbWsona
	2OLomjelQAPT4kM3+CQx9Es=
X-Google-Smtp-Source: AKy350ZfWphXkADHfmyBnpelsxPLXwfBpMThZDVyhfP3sldeRAIjW5hy6p4v6y3/2xtrQ7EMeadW3Q==
X-Received: by 2002:a05:600c:1d13:b0:3e8:7ca3:8424 with SMTP id l19-20020a05600c1d1300b003e87ca38424mr2401880wms.1.1680193089605;
        Thu, 30 Mar 2023 09:18:09 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003ee8a1bc220sm6960180wmq.1.2023.03.30.09.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:18:09 -0700 (PDT)
Message-ID: <5eb3ae1d-f764-6fb8-1de9-7cb65acd690a@grimberg.me>
Date: Thu, 30 Mar 2023 19:18:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/1] nvme-rdma: fix typo in comment
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de
Cc: oren@nvidia.com, israelr@nvidia.com, kbusch@kernel.org
References: <20220525145940.575-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220525145940.575-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_091815_343384_62F18E28 
X-CRM114-Status: UNSURE (   6.79  )
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

