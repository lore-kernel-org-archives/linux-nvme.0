Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A26CC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jan 2022 09:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=sjW/taFkSg8ne6BXD1NQyd2P3j
	nltN7I25NHOQx5QSDA5jYWTa44tx5aNaqwPCJ78m/K+P9DN0froEyo8wlpXMPpoA9ji+IBc8UD8Gt
	wU6pP02BmdgX1Vcw48EScJf8yTcBhzLGaRgp7Mkh075A1uIbtdyzTyOYC6/xIfYpHzrZXZhRwXq7A
	JI6XrvIFZ71yZc1pUjiLZyZbZjUOZMuzG2oLMPiQ8mwCNvj6wg/LztITmm/kaW7jUA/13Sm038GWx
	u3c73tBiCbkrOw56Yjf8fXlaPNCv6YK09gQS5bYRZx2BPwRX8/5oJb/1ZztunrXwqSchvFlIvrPq9
	l3gMrlvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBYzY-000VZ7-Ld; Sun, 23 Jan 2022 09:16:56 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBYzW-000VYX-PL
 for linux-nvme@lists.infradead.org; Sun, 23 Jan 2022 09:16:55 +0000
Received: by mail-ed1-f52.google.com with SMTP id m4so50623369edb.10
 for <linux-nvme@lists.infradead.org>; Sun, 23 Jan 2022 01:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=hZIDF9gL522K6yUbFH5pEgtNmtXpu2nimXPGw5iw/RRlmm3HUbvsqTIe2PC0xLi4X7
 pGCpkRJyrtYGGfz1IBEXqVg07nfcI6Sd5pZmZk4VHAVxV+V+2yVQU9Qqz2Cu+JxsDeYh
 NRZSC7d917OYf031HuXX8xB9jmOOlRiT2j0mB7/yuZ5gBs0XYRwiISmcywAeCwoomuP5
 eVS/Ngy1IvFk+N69i7WTMmbQlFz11Xx5O0NeoI40z1LIRfX0iUOZwRmup6AZsyDka6xt
 0Bjj4MvCaN2Y30kb1nTemmmORaH/vlJ696tmJ50Pr03C6pMnLu0D4FixgullgLlzNQgQ
 irCA==
X-Gm-Message-State: AOAM533dsr7cJq3j9zJN2ser5u6ceDBmf8ywmo7DX0GK/2+VmohBBybq
 myJ63Hz/zZs5jZ7shev+31mC1YBrxrw=
X-Google-Smtp-Source: ABdhPJyroPfnQDhcyUbsYHUCBLYt3vcMzY1QM2dwnvS0gKlL7IS1UHY+k/HyYe/nTILXTOVTS8Qu7Q==
X-Received: by 2002:a50:d0dc:: with SMTP id g28mr10810282edf.25.1642929412330; 
 Sun, 23 Jan 2022 01:16:52 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id ch27sm643434edb.74.2022.01.23.01.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jan 2022 01:16:51 -0800 (PST)
Subject: Re: [PATCH] nvme-fabrics: fix returnvar.cocci warnings
To: kernel test robot <lkp@intel.com>, Hannes Reinecke <hare@suse.de>
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org
References: <202201221116.hWZkKqts-lkp@intel.com>
 <20220122031737.GA31599@fba2a898af35>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <aa0e01c1-4d3e-eed2-d32f-d1ecb9a97e90@grimberg.me>
Date: Sun, 23 Jan 2022 11:16:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220122031737.GA31599@fba2a898af35>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220123_011654_836803_9CEB8048 
X-CRM114-Status: UNSURE (   9.02  )
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

