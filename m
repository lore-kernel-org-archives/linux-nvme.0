Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1730D3C927
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ilcKjopp3Ixsk38sKct1Un6j+cqQNHWSl5QguoU7UI=; b=ST6oEb4OlLcuq4TMkO0BCVpLuk
	il9VmAYFrpnJO51POc8O/yqEpTGp/MeuZ+DtGdlSf/VOibMxTAuhxxnbU82M84DmPW4xKgs17LmKA
	2sa2e1NW2+HOCiC9H51LdudjU/9CkuVB4j4hJywTI/ZfiEKjPvfku2tv1rnE+1iKBx8ZIgCoujnD0
	KdQl5OHsBP3N94/77Crcv46t8eyZbPxnIKUJhYwLXBHPa6Mwg7Odu41txUmBN1NhPBLw5iL3ZnTIB
	hboUk7t6rp4hSsPb5rsmo8lIDVARCQEARVpsgf3+W7XOqT8RGtfZNeYH778NAK2QeicirM2NfL5Wl
	4h/SaZng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fgn-00000005eYW-3Ure;
	Sun, 20 Oct 2024 23:50:25 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fgk-00000005eXm-0j5W
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 23:50:23 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315baec69eso34314375e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 16:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729468221; x=1730073021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ilcKjopp3Ixsk38sKct1Un6j+cqQNHWSl5QguoU7UI=;
        b=pITviNdiTELbvNZxmmEzHbq8cC9JmiDIFtP8pF7tc9GVXCmwZjmd9yYP3k6jJCMEmy
         oyzibtpJDTZtt8ByLnOW/60O7B5U7mgTEDGVg8kD6Wtahrgw2+5b/HbuGzcBJuE1uuH3
         XTiZgkE9V2R3LFthV8wsEBbN8KuaT2jbr5qaqAKDCvw1yyfSFIA96TjZFKRvVO0AQU3g
         osHApigN6RUA1B0eLrjQhZ7GGRDbZTgPfMF1rNtljKiHQeI0IChpI0hmP8BG+bcj5VTG
         VQ8DD+MJXrHskz8taedJsPP5VEfhdwvFrrj8ULiiZBk/tHk8Ud50ZK++hybSMkuaWSTU
         2feg==
X-Gm-Message-State: AOJu0YxjnwXrFT+quGmu9I1pDKJZpyjdytEj7c3emSKJMZfLrotIt9Ac
	1z76PeqDO2/TuTiz8IFM8fOl9tt9nj0P7zLwSRN7v0ikHSL5vLLQ
X-Google-Smtp-Source: AGHT+IGz6SBJjoFzIiBk/bgkbFl4ren7vlrNZ/7pMFauY2F6R8hTGJvbMmYoXGRMLdMZC8AockH1Bg==
X-Received: by 2002:a05:600c:1c82:b0:428:1b0d:8657 with SMTP id 5b1f17b1804b1-431616a3a22mr63647505e9.22.1729468220530;
        Sun, 20 Oct 2024 16:50:20 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc4c7sm37877415e9.48.2024.10.20.16.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 16:50:20 -0700 (PDT)
Message-ID: <377c051e-d940-47ae-9e73-3dbca0e07c2a@grimberg.me>
Date: Mon, 21 Oct 2024 02:50:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet: add tracing of reservation commands
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20241014101458.80491-1-kanie@linux.alibaba.com>
 <20241014101458.80491-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241014101458.80491-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_165022_416763_A40EE914 
X-CRM114-Status: UNSURE (   4.09  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>**

