Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3908EC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 09:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=dYpchDTN4LnAML5Yb9Z7aX+Cbv
	dOx+qY6Zt80ifuOsYAMzUBLicvIfu5mBMgW9tfY/RFrC8n0dgcRZy6O1s+Lf/xVdIOcN47HBdMijJ
	FY+2m/yVNFUulqwQJZSetZe2Iq4cW4fGyPT4ZwTrxBa4RIjtsqaWdDy3frH3LBFILloR0wDcHLhhO
	z+4R/dxF4vRuCnloc4kEb+v1hlMmsniKO3625xqw8D/SvpIkTVRb/N8Wm7mrmZKQab0kGVRvGFzeX
	LjnpQB7qFI+SFc6Dl0exdeeD8F6sdkj7ZjIEvEtvShMNvXA/WrvuVgmeEvSRKcRN0s+S034ckBDL0
	Mgh0SoJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nE6lB-006HPA-PR; Sun, 30 Jan 2022 09:44:37 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nE6l4-006HNk-BI
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 09:44:31 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 f22-20020a1c1f16000000b003525bf08b1eso2912048wmf.0
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 01:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=ZHZrGjOI89Ylj5s8mOw3VAOUaLDjHkC7hIETsMNrvs9rpEiR/HSVvKvT6W82+9uxje
 AEmZGfAbB1xWB1H4qeZTyOUDA3MiYHcIZ5M1M5OsEVVn/eGmI+qGIpmH1koidGfw4nA6
 pvUPSrtn0dy/oerjjrFGiBGxlez99Q7utilHYe9N8zPH7LezHAqazRQ0iL0OrqJqyE3d
 GfzNEf5hw3QYer45rBlhK/YE6OWVZU6bo9vInOQWUL9GQL9TW3BnJDAtiW/Bo1eznB35
 HhC4EPOJXbGtJEvmjbHVs+RdNFDN/vEpT0SD523Vrn9lw+SR3NrBFCDexeoASIJqKj27
 N0xw==
X-Gm-Message-State: AOAM5309QuodzgUJw24+EOH8r8AdDDRanpDlywtEg3vx6fvW3Khmpl6r
 HjjUMLc4u0CNzUe8BRvrZwA=
X-Google-Smtp-Source: ABdhPJwevjrb6t62dvgl/OFio6lbSf2C5MVefoufTMd9hNv3714ZnhoD8PHcdAl8T6X8cmdHcDIYbA==
X-Received: by 2002:a05:600c:1e8b:: with SMTP id
 be11mr22707429wmb.96.1643535868908; 
 Sun, 30 Jan 2022 01:44:28 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id j28sm2737433wms.14.2022.01.30.01.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jan 2022 01:44:28 -0800 (PST)
Message-ID: <4be20b76-8bb0-6746-03de-206fcc399fa5@grimberg.me>
Date: Sun, 30 Jan 2022 11:44:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/9] nvme-rdma: use helper to initialize connect_q
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
 <20220128092015.19289-3-chaitanyak@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220128092015.19289-3-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_014430_398625_C5BC1EDA 
X-CRM114-Status: UNSURE (   5.42  )
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

