Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D26DC4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 09:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ua6b+Z9w0/7O+NxWtTfsvWiakj
	ZVHH1GVdK+6b2HGkBlqMx1evQhUd2zZTvtztborsEhbk+P21l4JLBii3dqCZfTdbxdYcCT5PVS6oU
	garR994HfF350aTJuzyl9ZAkVzCXoOoR+qFgjway8aie85xUAKqY0mktAjHkPGYxbwDlD2Bngdd52
	WppG0qZ453e6hxIvxp3xaaXZmgoDZG7SQIIlZnujGmwYOLfaTF9RzuG17kHjnLn1pNJutIaYiAaxu
	uYOp50oizXA4SPx4wzUtgvbpa4IUT86E04avHQ5NMXHTfKffX4f3Jmtdp25/2XZcIl+TDi4+FgLtv
	I0cMFERA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Gkk-007bzU-1a;
	Wed, 29 Nov 2023 09:21:06 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Gkh-007bxg-30
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 09:21:05 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40b2a85c99bso8340815e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Nov 2023 01:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249661; x=1701854461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=H3N2OU8vxiGCPR9aQyiF9eNW37yj+Rnm4RWBJXkGMAZgndoXWwhAtj6C3KY+kj/N70
         0zMsKBUVg0Sraznw4QA39HyxY82e7w8m/FqVqJAOL/AtBvAs4dgTaWAhiWlLDCDKnRGM
         Nt5FeCpbYg9Yj+0GjZL2zW0/NWIak67ZLqJpvqAdC1P0A2k0eOlXFzs1bZMbyLqmD341
         9RGa++L+4oya6YYVjAq7lSoxcJ9BusaCm77MCTUKyOM/Hz2a6+alPom5gEeCjr0EEbnU
         AEkIFcrU8UDqiX35Q341oq83jhBHJlHGAiIa4yQi0OzA8CU2zbyi6FUcq1QrHngBbFID
         fzhQ==
X-Gm-Message-State: AOJu0YzZaTfJOYMu7DmZ5bz006aZSMvgWajH3WM8UMJLL4IFO/JXhSWI
	sAOrJk//MbJZTE3EjoHTfHM=
X-Google-Smtp-Source: AGHT+IFQ6RlFtLFB6xfkrA0P8xsDLVIq36T5EecdHlfY4tG1fIAl8LBdKRPnOYx0zVCy/sjWTl/xqg==
X-Received: by 2002:a05:600c:8512:b0:405:358c:ba75 with SMTP id gw18-20020a05600c851200b00405358cba75mr12331021wmb.0.1701249660759;
        Wed, 29 Nov 2023 01:21:00 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b0040b360cc65csm1524542wmq.0.2023.11.29.01.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 01:21:00 -0800 (PST)
Message-ID: <43910a20-b527-46fb-942d-86293026734a@grimberg.me>
Date: Wed, 29 Nov 2023 11:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: prevent potential spectre v1 gadget
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: error27@gmail.com, gost.dev@samsung.com, nitheshshetty@gmail.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231128122958.2235-1-nj.shetty@samsung.com>
 <CGME20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6@epcas5p2.samsung.com>
 <20231128122958.2235-2-nj.shetty@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231128122958.2235-2-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_012103_968262_B98E11F5 
X-CRM114-Status: UNSURE (   6.37  )
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


