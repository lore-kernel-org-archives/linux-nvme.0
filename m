Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85BBC3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jul 2024 12:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=RrLFarJjad+097EvHyBDRdQ5rr
	MDBL6yVD+qDskELL/FksLkoLiA17zk4PtGfVPcuOy3fc4C/JwNVbq2h0GRsCf974LmcrmKhZVp2IC
	sNEne5L4TrAuVS3l0iKTvAf/uwGI/rKeJOxNVPCHjOBJXhYrKaO4MEcmidIhGOYpXwKKjETse7gkJ
	rJ5zyIcOVPul97M9MPSQI4s8/RqbhkBAJJIx6xt3u5mmNPm6mBaKieDcZ/PsrcYEnXyxwzZXdfC4x
	jaR7xXA/SedFa4hJwIyN83ddCVRmDXoifPNkKTUno76W6IyUQKslDCQcm/fNLIKsSSKt0S5PQUiCo
	YDZmYwXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRsXF-0000000Dtk1-2lCB;
	Thu, 11 Jul 2024 12:04:29 +0000
Received: from mail-lf1-f50.google.com ([209.85.167.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRsXC-0000000DtjS-3aDj
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jul 2024 12:04:28 +0000
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e98c72d2bso130260e87.0
        for <linux-nvme@lists.infradead.org>; Thu, 11 Jul 2024 05:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720699464; x=1721304264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Y7G6AY/JSdOkosx1o7xmjXfoCMTT9uFtRxjWFDAzh3jpR+L7D1garjwFWMBd/8zM9f
         K1CJ6UMEQWqlJb4cYJvOhUDvR2buWbWtCmdF9mCkhoCit2djiO/3PmR6D2SqoK8Sx8m1
         J33JGnFPEPtqmzU+/t+tp5rYE3+dEASZott9p/Iv0hyT5avuXK+UTHOhmdmBHIf6+pNW
         bCi6NvngVQozpDW10azmeOkqAX1bxVvstosPEmFfbBK9ORF9S38IAxLb7MrY23u3UPor
         zz1wbl6EZNPdbGejW7zEhPelEUBrfvGj3fOFZI3DAYiAGzAoeq1zWc0SkmkaWT8l4z5F
         O9iw==
X-Forwarded-Encrypted: i=1; AJvYcCVFR0aGatUI2XkFjnn9TBSpaw20WPs5tCIgMFfEjUZ5Q/xcka8WCX8F/Ds0q436hbhoUi3XeOGBMNEXu3msEH41m1BQkePwInhRizljF+Y=
X-Gm-Message-State: AOJu0YzPGhJn3jLkFBgQc/MoZtFKMnW/J4jGYQ+cY+fi2YStlYm9B+/o
	TzCZwOxGfBS/yT4706AAd2cNn7yZpIPGwZsJhRtatyWtVhmlm4lB
X-Google-Smtp-Source: AGHT+IEZXrHyVeC5iwPcZzgUMGIl/PQUAqs3wA53rZ2tdzl2A8iPG9Nkpw1tuxIcnj/+NcpB5dJbTg==
X-Received: by 2002:a05:6512:3d8e:b0:52c:f533:1e21 with SMTP id 2adb3069b0e04-52eb97586acmr5824238e87.0.1720699463685;
        Thu, 11 Jul 2024 05:04:23 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab1c0sm7605584f8f.92.2024.07.11.05.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 05:04:23 -0700 (PDT)
Message-ID: <51079686-e74c-4586-8112-89248cdc383b@grimberg.me>
Date: Thu, 11 Jul 2024 15:04:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove redundant bdev local variable
To: Israel Rukshin <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1720698053-4076216-1-git-send-email-israelr@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1720698053-4076216-1-git-send-email-israelr@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_050426_921891_694BA30B 
X-CRM114-Status: UNSURE (   4.67  )
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

