Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190F8C3DA7F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 08:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Sxdx4Kti0RcQNxbKNK8fV+9vOJ
	gWKvh6hAqueaImrLzpaXSje0vL7v3uUqTRKjho6zSLe38QBQl/M1Ndw2SaggkkovzTIPa0bW79FpV
	0GkkWmOmMznS0ybH5w/7TMPB8B1msot0oN7OHzORn+uT80nCKFCR2K/bUQ+Hc1B7IZxr+1dHfIasc
	Gv6fBOvCI0HxWVhOUYYs7MoPdaC8dEBeePpfFfy+6r+KFC3ZpHOJy8ZbTEjZ0JQMe6A/4xUQ8t9po
	dMJ3g2w9CaTJ+srq2KMUiySSjlJs2B5Kak4pk43i1Yfxsro9c8xrshAC6yv4FrTqq7E0SRY+tS7fs
	dDTnvk2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdQYc-0000000HIJl-2nCq;
	Mon, 12 Aug 2024 08:37:38 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdQYa-0000000HIJQ-0bZW
	for linux-nvme@lists.infradead.org;
	Mon, 12 Aug 2024 08:37:37 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36841f5f3a1so114130f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 12 Aug 2024 01:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723451854; x=1724056654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=nbaPjdMEzVuY6YBk4cG0fdFkGlcttGWp7b+fcvplUxcouahLoVFPsY8pdaRlXoP/tX
         YsbRIN1HTyKnpBJIuHakfGTJdb08QDO8u567ijbpRg+2Pkib+ZaVKWsYjZgWRv5UZCUV
         XsWxkjaIL0VptvzG2LI+rx+fyuVggt6HOP9k/m1OZD7Wl2EKAe9r94NfyIQW9YjErrYS
         SD3i+BC65nhlmsl+nvk64U4SGiQT4WGKP6OEQoRcOkz9PFWuy95QzHWG7XmBwuQEUtBd
         kWG+T9EQaXMko4DTC01TvclbyWTCFMWwJLEwrFTghucpOMpj5026a9T3Xg1/pXWhFvav
         5kXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw2CDMzCzlCFPUFIQNamroJeO+PMMFE91TbGDpnvkBFcbN8cED/USM/JGt7oUOUbTFjWLcMtaUQhZzDgoR2PIdStUotlfFuxejlTPAC6M=
X-Gm-Message-State: AOJu0YzKuvOzh+BE92a82EKKC7vjv5eNiBpUg77T8KBqGb9Mk1nUyskn
	G1nqjf/EWgHdyzujI88eo8TSirrHqSnglrHFT9Zn6l6Oy85i/jVV
X-Google-Smtp-Source: AGHT+IHl47OefcspPOG8ggaVunE2STKbt+8ufh9QSa53vp+7BPhGP6jZu6+Qab8VUY7HA0w8g+HEaw==
X-Received: by 2002:a05:600c:510d:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-429c3a68e56mr39610375e9.4.1723451853573;
        Mon, 12 Aug 2024 01:37:33 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750ec0bsm93450135e9.15.2024.08.12.01.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 01:37:33 -0700 (PDT)
Message-ID: <7d7e367c-6c22-423a-9272-f422068def90@grimberg.me>
Date: Mon, 12 Aug 2024 11:37:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: move stopping keep-alive into nvme_uninit_ctrl()
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>, Mark O'Donovan <shiftee@posteo.net>,
 Changhui Zhong <czhong@redhat.com>
References: <20240809135427.378953-1-ming.lei@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240809135427.378953-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_013736_214198_F1A5DE3B 
X-CRM114-Status: UNSURE (   6.77  )
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

