Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E152C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=KjwK1Xt2sCMBREwHsBiwuE2+qc
	XJZoKYhCKPVSrTbAUStZsXGU7D5A6ysvXuG+UxSHXVJekUwRgT6wn47Ug8m/yLZI5PoWqsKF4d3DY
	XAy6b7wgDsLdMGIskT5EW6y2h+/MJMRL2RAqh/SqVPYtuTaCKIvNdrrHb4pe4ZW6CXD7EGAsPHrr3
	E2EH/68uG1IT+UTorc1A/jcuBeJyvU0MuxrdujZlk2T2rYrVpEBQEX+iBrJVMCSvYFXFX8UMBMx4k
	uYAh0YQXrtCEwOZhuZ7acV4xVEVOjk33Yx0/YXB2YcsA53ix3+yjoycDpa9NYhkFeCQ8uaAsVvfoq
	Ns5g71Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBGm-0000000EqTD-0V1N;
	Wed, 17 Jul 2024 20:29:00 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBGi-0000000EqSm-3g7N
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 20:28:58 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4265f823147so82185e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 13:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721248134; x=1721852934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=tKHEUewZe18Pmd7xXIaBDk6zI7qzzvwDLkBXuQtTxprVtO8azkwzE0zUBp7lnZDSIe
         +OWpgpKdtuPCBJWKsBkWGXmIUWj/C4I8Cp5sGIcFzOJOzJ8iZURJnVUtLurJatA6dvNC
         UeEixct/s7K9VfF6ix8JIQZOooxwy2e3jMTPvl7sFQx+0xQYOBOE95pr7TdT1zTkI+k6
         o24ZIbVyNRvRluSAQ/3U5kxV/v8faVwXRLlSKQQumQfefSIIVRAAzw7vYthtypEP9qKN
         6BqDOrG5Cwxz9nsejhP+i2tazXKxeYh5Jb7pm1y2siTJxWd9NIlfIp752WVRjZ4OgwQW
         rATA==
X-Forwarded-Encrypted: i=1; AJvYcCXJGDASP1dMpDRw1RMy5bePJ370vXB2HSac2n15fidAmnTuQn7A+gHKJYkYk5w3L/waClEUZfiAwZzWA+VZsbeimVEMjKWA5c5jmKyw+YU=
X-Gm-Message-State: AOJu0YyCZ8yWtK/mIzsaYBbQ8RkIIcLN+nAxjlra4Q/Z/ggnjIGn2oHh
	9rW9u3iQkd5IE9of3j8Jzm+42j9kr39xoBBmD4fUY+vE27P0pDsz
X-Google-Smtp-Source: AGHT+IFWDhgmW7Ns8Om9AVWutcqBouODovMIo7AGCd620iDuN7sKdZfHknUMPMGnS9hOBYqJWypgUA==
X-Received: by 2002:a05:600c:46cd:b0:427:9f6f:9bff with SMTP id 5b1f17b1804b1-427c2d33f06mr12930155e9.5.1721248134146;
        Wed, 17 Jul 2024 13:28:54 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7865f51sm9231345e9.48.2024.07.17.13.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 13:28:53 -0700 (PDT)
Message-ID: <3fe80e4f-6a6d-4347-b35c-ba3ad378f701@grimberg.me>
Date: Wed, 17 Jul 2024 23:28:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvmet-tcp: add unbound_wq support for nvmet-tcp
To: Ping Gan <jacky_gam_2001@163.com>, hare@suse.de, hch@lst.de,
 kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
 <20240717091451.111158-2-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091451.111158-2-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_132856_934344_0D8A58D8 
X-CRM114-Status: UNSURE (   4.77  )
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

