Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FCFC0218F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 08:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XohjsgBLKPWGQoaKpsU3tj+iZX
	yFJx34aKUSK78o1HVvv1+dx8b3PGO1/xf+N1tlYRmeJkdnVfYCbxoDTPKb0UZ6q0Cm1bxidvo3MmZ
	RgLMTZrdaMeCVt3mF5kCTqfvtNV2CApUUbmyVcskruBTMtxhMtumX77CPcaQhEQtPBXdZFgxiLRTu
	a9REaraX+/YYLYrzdO22x41/5WZShXrM5SdRdTnFCyNeV1QaeEIT3TLhYfJH1CB/yzJVNkaL+A48s
	YyiWnoDIYSILFjeCQkXWvS+FW70u6a/J2ttSd5IoC9F/oEyF2wG+/Hw4odflsOwsgP39TS/wBF5cV
	fWeYh/Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm5t-0000000AAnB-469C;
	Fri, 31 Jan 2025 08:09:41 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm5r-0000000AAlv-1nBZ
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 08:09:40 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43635796b48so10252075e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jan 2025 00:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738310978; x=1738915778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=CACg7L6bwXw74PE0XJlTBktzhdJyGZSmzAQSLSPONSgV6l+zO87u/tee81iK5RAjpp
         SOt9nwnQH3JYBvdKnH1NbbPq98lEenEZzt0cHpAAtEYhQb+qL7NQ+rrOP3vykfM4gTbw
         9FQ2UnvcL+VJCyjTv6o8ow4NONIZm9DsT7qcqSX/w16XqZrplsyZa2B2Bbn5Y+7/OqYu
         67DbnTrtZ7zXImVHRWYQuS/2qO7iWGtHqwLr6ZqSPZcYYlhB6Nq49giPVWOx5vLMH0fa
         7Qnuh6HRKhhJjVAlyu5mbvDH/voQ25PtC7STRaQP7pEq3dnBg7FxVnxhHSv9U3J+PnkC
         qAgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP98dbgPb6ykPQc0CyTEmg5n9bDELqHuk4pEzfg1y+APD4FhIQuSwFuzekJXRVo55p032bepvpRvQk@lists.infradead.org
X-Gm-Message-State: AOJu0YxFTjsziFiJQ6PU/yGghBP968s8+GsXi0nOXB+oOGI7JOglhY8V
	ILuUS+JkYH9wWSUMBHXCfsBVZ2XR3wgpKLrdYmeB8z50AYW2VKFs
X-Gm-Gg: ASbGnctEoDHHA6NS59a+PO1Bm2QHcnGhq8ZCnpn261+8svL0sF4N2uJm5FTljx1Cth4
	QT8W03Mmo8KNIeu7c5rCctS6wydCPvUOuq5l4n4FTh+w9JYa36JL8Io3McAOyOVin6UmlFItNS6
	to4UGiaxJW9covFnh7nnTIZP5TJpxxPjE+vT30kcA/B9+UnKgcNrboUXNExpTMPrNDZF6MxSyF9
	bk9nDjn2SGqKpZ3kgbV2rybKp8aIdxISYg6yo/NaM3wx1gU1iC4Pz51sopVVDvBTfCf+OBAIEwC
	4rVuPvpo+5O1eqW7gGikCQwJTJtYlasDO7E6grvcOeA3KeqAhEY=
X-Google-Smtp-Source: AGHT+IEOa8+IpbuEPDc7gAyIcz+T0tvKBmWOlS+MQPYG2yPPBrjEYLG3AtngfnrHGnIVnaiRdHpnyA==
X-Received: by 2002:a05:600c:1daa:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-438e6ed8f0amr20942705e9.9.1738310977796;
        Fri, 31 Jan 2025 00:09:37 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23d42dfsm48323865e9.4.2025.01.31.00.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 00:09:37 -0800 (PST)
Message-ID: <b7b36d97-cc1a-425e-8877-ff1bb4359bc9@grimberg.me>
Date: Fri, 31 Jan 2025 10:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-fc: use ctrl state getter
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-2-40c586581171@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250128-nvme-misc-fixes-v1-2-40c586581171@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_000939_460927_6EDBF5A5 
X-CRM114-Status: UNSURE (   6.70  )
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

