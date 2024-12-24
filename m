Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C72E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Xp7kX9nazD0V0Qs3XKwxvbba6G
	xKIyBWsjG8x0ZodqJijRx0HnvSoWFIYIgP5kw1eqobsHZ368PZYbpu/xS9N4UcR+y8duen97yzrYC
	AfmVLqX+bJrubuKQ2STogeY9yDJlwVOZbDZxLgGsyeyEfF6DB7oYvbygax9C2uhXk++LwxC/1fd60
	DVJq9jiFiOXFVuTrs4WKTfmcqvlm93cQolZXx1DPyDO2vr7LneDvTTKA5uJ36yWPde94cjm8IuEwr
	9UaPOmn2w/0l3NqCFU8orzsKfy5EtQS2Oi/OduALRbZWEid2dvSOuiIoaXwwItHX8dCeM+7YsFMCA
	+E5WSCOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ36f-0000000BrHZ-3dem;
	Tue, 24 Dec 2024 11:29:45 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ36d-0000000BrGf-05IC
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:29:44 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso37156245e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735039781; x=1735644581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=oXeQng5xJUW6hG3h24PuTBd/DCZK/u6YiDxi2AXHoMN9e5abhX70/wLU/cFeloLqpf
         wMZOe3lLd5H2qOLU4SLmX4EQ+JT1bIHYfKSEJ24RldpPe5w4OWN3AFfulrubuwAKMU6d
         Ru9JR0KstVNciyz/tbpJVG1llKOInhDq5vsM65w/2uBHav87N72vxeBDJ3199/s0nR92
         2a6rleKsk4olYWrsiXzG7R+FSc56X/EjpkVG9k/+vWPKvn6/fFT12aAaNYajqmTBt+wW
         l45dMesABPieH3vBdcTRsYGXbXwpDRH7dmhw8RdTns5DcF/mkTj5UsgulVQu3iw6RNpA
         919g==
X-Forwarded-Encrypted: i=1; AJvYcCXj6ZqNwBylVPuhgzCP1IYK7LkvWR4MAoFWWujjvTe4wXsbScZ3WBc35wKxNKppaRqjKKxTLZ6KNGxY@lists.infradead.org
X-Gm-Message-State: AOJu0Yy052cir4TYJoUjrIZsyhL5m2vnDHu5e9a1issbrpWGQ4Slqwmf
	ew4Knqr05MccPUS1l7O/PJBCrHFUqeduuzZ8yXXyyi54erucLm1f
X-Gm-Gg: ASbGncsoOzh/WzTa5Ghnu+HOOhkG4B5sAVUAgUodvyCgpcTXtPQv/gAPD70tCO8e3aB
	IZTItD5b1v0ADUN0u4GzlkZdI9fSJqQt0GBsh9yCfHdQev7r3qOms6QhcxBq+Y9wxBZTzfDkJa3
	wm/qgUfYsatDEcrX6YLPT1bSpiE5QQ6bNtd2o9amyAMM2fM5UT6RWTJLLNcwzm5G5LrPjPvSc1r
	x7Ed92zP8cMYUgRskdUORekGddyin+60/Iqde3q5tK1VtMja/ghiKFC0xG1z5RWZf1Nbo+5etlS
	mzs6tm3jNdRLpMNLP1xNOZk=
X-Google-Smtp-Source: AGHT+IF6ylt0DY/GvFmao9KH4fzhqPYuM4bRwWhBSSiHymM3g6EByXa+uLSSeNJO/qbUVTLRQsaYzw==
X-Received: by 2002:a5d:6d87:0:b0:386:3403:7b63 with SMTP id ffacd0b85a97d-38a223fd474mr13727987f8f.36.1735039781409;
        Tue, 24 Dec 2024 03:29:41 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829297sm14331836f8f.4.2024.12.24.03.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:29:41 -0800 (PST)
Message-ID: <21ab8529-6485-4b08-b45d-991863fad77e@grimberg.me>
Date: Tue, 24 Dec 2024 13:29:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/2] nvme/052: move nvmf_wait_for_ns() to common/nvme
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, dwagner@suse.de,
 hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, gjoyce@linux.ibm.com
References: <20241206111812.489140-1-nilay@linux.ibm.com>
 <20241206111812.489140-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241206111812.489140-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_032943_052529_794DF2DD 
X-CRM114-Status: UNSURE (   3.95  )
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

