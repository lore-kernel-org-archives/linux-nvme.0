Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4ECC30653
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 08:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=N+c42LXf+C70z5Xy1+tbJM9F83
	iNt0A1KaW8/YdQQ0v5+qdnigo6ANFoiGi0bwFUi4XI6SJpD1BKujVtIOs6C7qoxrdZrM6I7d7qWQY
	TNrp0ujQp91m/DWbYlPjw3/rc1bbZcpAqkqH60XkjDSyts8gRBQcwH7P84EiwSp/U/2XaxVHQT4QS
	3SxaHKzuAB+KdMBPUwxlU62s8Oni0hfH2Hsn0qHLdgQfn8xUuhDnpRQ2uVm9CLUV5DMJPRUSHraMA
	bEeXs7Uv1+nqwW3OqYXXmEK9kItGWC93eTGcCWtbRVb/Kt4QfiJvyBDuo96zJ/9hx+TCrIiPCukyA
	l+C5TroA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMNwy-00000005uI7-2Mzm;
	Wed, 26 Jun 2024 08:24:20 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMNwt-00000005uFi-2JOl
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 08:24:18 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42560ef9bcbso4265e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 01:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719390252; x=1719995052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=SyZ2LdpSlasP5cKBfnPCB+lgN+Eaz8sDIDEzJQF5dGBNk8ipYQT1uwv3iYLg6l+st8
         h6VkXWLED5N9xvFM7fyVxgKy+JnSf0Uccg3hkAeAvFNiLUpamc+XVz6aufE7YV0qze0p
         C/Z0PVhiB6hYYiEwnSaI+jtJsjIi5nHyjw0gq3dcv9cw5c8TpHx5uNGSWp9kS4Zy2Szv
         IIr524nLSoCJsehu+ANrpdsuplQ79pTelIf+JeyHfoG/r37U8tZDeX8bd7BTJMRM75G5
         lbAswmw7VgDzhmnwARXekmqs8j6ehUTEnu8zG3JuWM3bXsujh6mDmaj4J603QlTizcFP
         uVJQ==
X-Gm-Message-State: AOJu0YwoSWjgP5BqMS7Ce9iFGtN4k9VFS5TglEZ8+A+KA/dB59R9nGbA
	vVqQHN34ZU2AzbSvACaARDvnQrFPuNY+ns3NLASFNIK1xnVLF4WJ
X-Google-Smtp-Source: AGHT+IGdHFyLibIBAx6EykdH7v6q7ac5kTWgmkyoqn2R2pX73WHr5WR1MZfSlMVNzrh7gkDa+Fg8aw==
X-Received: by 2002:a05:600c:1c0f:b0:424:a74b:32d4 with SMTP id 5b1f17b1804b1-424a74b3445mr21608645e9.0.1719390251715;
        Wed, 26 Jun 2024 01:24:11 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c837dc4csm16071825e9.26.2024.06.26.01.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 01:24:11 -0700 (PDT)
Message-ID: <751b0dd6-7699-4773-a7a7-40141ec01db7@grimberg.me>
Date: Wed, 26 Jun 2024 11:24:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] nvme-multipath: implement "queue-depth" iopolicy
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
 chaitanyak@nvidia.com, hare@kernel.org
References: <20240625122605.857462-1-jmeneghi@redhat.com>
 <20240625122605.857462-3-jmeneghi@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240625122605.857462-3-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_012415_753736_F80212C0 
X-CRM114-Status: UNSURE (   4.37  )
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

