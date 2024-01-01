Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02BBC4706F
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XwqGD554/0o2iSobm9NaQKU5yK
	iy2BDULVrDOmQq5jLTMMhJS8tOrJ5KZ+V557CKWHGgP5kRR++TuWIMHUKWCf/VG3xypdemhdmcrXC
	ehZiUawjq6L0+ooqguNDVyg9Scpit8THFdcRbGNn3490awwntQeqtEE0B0UnFgos8ermTlCIDYBXZ
	ZgOpAceBTorgBc9C36VSj/hjrL3lUs8cARvsFTy3q3WKCtdxlEdLfw3YmurAqfeLLXSDk+xxJXY0I
	klgdLhHAI8nHp4v7ubTNvu/VYdt3yuAXB5aAH+fJc22C/LbtQWWZdBP0Sup+DFYT+n1mFEAP2cCIb
	Tvrrh9Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEyA-005rNI-1Q;
	Mon, 01 Jan 2024 09:52:26 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEy8-005rLn-0k
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:52:25 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d855d0e40so2712945e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704102743; x=1704707543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=u3pIJjfLY2fBxzXkb4Yp+m2/LRFknTAaxyJch3GCnzULlbz7lCw9mpEoxTRqP/zAHs
         NKemvw3OPRWi0g24i/43kAJP1NgGAugIX8PAgWEEAodrYx96MbI5fuWBqeS+9jq5/C3g
         wLora0/OMppFRyfDBWZnGnxdhaE9FI34FdXuD8fIYZ0eGlM6sq/fU1uQ0+3c9fSh62/S
         wVwUNI4VgyY6tPtE7+/3WPupPpeRyyZLb3ys1hnP/YmFCXKNEMpf1yAufzhBEx2Q/4sZ
         whrUdK6b951cy0PwbVbUFVMFQKBbDH6MwZH/5JPVCAD0B0rJmKWRoARyFo3bBwiRZW7M
         1O0g==
X-Gm-Message-State: AOJu0YzR6+H5mJKwKFrHmDMyKvBKla/2kT1F0SUhUl0mjYy735Xe6o0/
	Zqd1AYe4NSKDlA6EOfz6i9YUsAjx2Zs=
X-Google-Smtp-Source: AGHT+IHCp4hdH5lz7mRX2kcbCu5kU4UDCgxD8BvdC+EU5fIXMBDDz4lUFv3fSxPBWRHp8HdfsR2Dww==
X-Received: by 2002:a05:600c:1c12:b0:40d:5bc3:6a5b with SMTP id j18-20020a05600c1c1200b0040d5bc36a5bmr10831323wms.2.1704102742739;
        Mon, 01 Jan 2024 01:52:22 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b0040d6ffae526sm13976226wmq.39.2024.01.01.01.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:52:22 -0800 (PST)
Message-ID: <98dbb135-9234-4c43-b529-e622b3578f34@grimberg.me>
Date: Mon, 1 Jan 2024 11:52:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: fix a missing endianess conversion in
 nvmet_tcp_try_peek_pdu
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kch@nvidia.com
Cc: kbusch@kernel.org, hare@suse.de, linux-nvme@lists.infradead.org
References: <20231226081329.180017-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231226081329.180017-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_015224_268263_5C2B1768 
X-CRM114-Status: UNSURE (   6.08  )
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

