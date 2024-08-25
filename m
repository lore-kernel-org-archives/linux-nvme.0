Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9BBC5321E
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Aug 2024 07:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=JA09EnV6LCeyiwnb/uD5Js8WZX
	APVflNa0ANI8CVPH1CVNlyFOpVPe2nCJLRgpYFiwzx8tdCDKupm3ZyoBHRRog6Y+lZg3Kn4u3Wmz3
	9+csyUNTTa2v3vWwzmwmaxQweqtUPPgqiUR4VG7AFYmCeTiC3TvXU/qIyqsk2DwmtMb13VInswkl5
	vDSe9y9QyYPXuCL51qjlVLcVtzDp5H1/+MfKyp6EBxXYIer4S4tcJaex40LKcfbHQMyeChZYVdXtF
	WDw/nYfrZMPBcy50px8uAaRGkRqqNKLZjIj/8LFvdQJ7IY3/NTlp++Otjvs4wQp0qOrmWlLqlfTDq
	2Z1T4CwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si87B-00000003uHJ-3sDF;
	Sun, 25 Aug 2024 07:56:45 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si87A-00000003uFs-01O3
	for linux-nvme@lists.infradead.org;
	Sun, 25 Aug 2024 07:56:45 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428178fc07eso26581845e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 25 Aug 2024 00:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724572602; x=1725177402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=qSLVPeP/pratexV/X9WNVtRXyUhqizDwGyxf+NGjcNTfN2MvZ82c2bVVEpj4XDBqEA
         r9Khu8hk8oWTQqCBqmWO79upNDxX4YN5h1zcQ7RuPumdiMwHBx0WqU7r8u+8OD5omzPi
         1Ct+eaCumvAbDdsVlL2AnVwkjTlnmaT7mwQdHhl8+25jS2GVPyc9Rq7NqiUwW14QU2Wy
         jpExYjvxEvhp21kRzF+8znFhOcd9czJyLNaYfE038RgRaYQhYAwJhaSommYvR1UfwMt4
         /nQbMSiUHnQN9pAbsscAjQc9S7zL1Zr1gzf/oUj/v36j1DJIPxCYA3AVTPFzMyuOsxqM
         gigQ==
X-Forwarded-Encrypted: i=1; AJvYcCXInmKE7j2zTMiOhKFFU+tgFA5Rnf7kvTsUQgMdM+aGMwlLgQX8mTwpH47lrasEERzpXtIw67YbKQDG@lists.infradead.org
X-Gm-Message-State: AOJu0YyVpQ1LlAxfZRNxcbVOC9mPbZGDMYtZ0dpQ7g86ClCpiW6WOEJR
	DvwLsWsVkb/UoXifB0X1evXrCWTPaTvX2o8Q5wvPRWB8VvGI9lL8
X-Google-Smtp-Source: AGHT+IFlgQ9OOupwgTsI8zLVzWGDsCIiog2d+VHetdSw0H3RTOzQuk8lRocNHp69Tcfgz3DQPn0ZpA==
X-Received: by 2002:a05:600c:3547:b0:426:6000:565a with SMTP id 5b1f17b1804b1-42acd56028bmr42053945e9.16.1724572601555;
        Sun, 25 Aug 2024 00:56:41 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5180106sm117579585e9.41.2024.08.25.00.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 00:56:41 -0700 (PDT)
Message-ID: <a37fd63e-7d32-4074-8443-6b25db25fc89@grimberg.me>
Date: Sun, 25 Aug 2024 10:56:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] driver core: separate function to shutdown one
 device
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-3-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240822202805.6379-3-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_005644_048604_F1FED3F7 
X-CRM114-Status: UNSURE (   5.79  )
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

