Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A16D111A8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=UtFlNaJN0j8LFSb6NOqHRnx9h2
	wWGkvgI4Sfi5SNx4HBRZg2bVak9E37S3AV/J24uECSZzXQGOCDRpusdhs+I01wfXLyR/ox/WLuKOt
	gq5gjHon+sn1fjHbA/+QNB8gTQbo6Qix0SaWvettBp4vPhVSV38TQA6SxLUPZismsBEr1k3ZGnI4y
	08/DVAa+viHOUnz8LTGdt+i3T1xUuBU1MxRN/Ez6+bRCBZlDqBK/+aSZ/vM0Tc/Qg/juDoXkg+X1X
	Rr5Zpsx/YhFgSirEQQTXSaWZyWOSVu2ANGvn/Ilav9C036HEoG+rgCqXvMvis9DTkrw5rQ5u7Jt+k
	dNCVSUvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqHg-00000002dv5-2hfU;
	Sun, 30 Nov 2025 22:52:48 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqHd-00000002du5-3XM0
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:52:46 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47790b080e4so16086625e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764543164; x=1765147964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ZHei4ZddoEWPVn4F/bD4CIEzkw89Hd0WhCCojt9E17J0EMtLXWKz72uvODJbqTCU+F
         SI/6qd40kPAM7EbjR/RGWLtTUf/cg+Hn/ugmxJJcht1DkKgdqGHJGhgBJrVu7jBqhWGL
         I1of9fknK95mAsMKB7jIOVGTGbNUj2xV6y0iX8Kej/Cn381dd8cBgUwd9RGqQkLwrK6X
         JSiGDhKTZ9v+ObElY//Z1k4AYwes+LklNHT+qU1HcBN4/pbhTOB0xX40qqzkg9eVX3KN
         IoeOTpPdsg7UF8260pXT1HUrztzowEt4E0+c0d60hcJnEjVlsFCQ4in5nb/NP2sm5V3v
         cIdg==
X-Forwarded-Encrypted: i=1; AJvYcCV5xqBlhcQmfl6MDorMYqrV5+6L6nL3tG6LW+dvXz4RbLNNae7k/IQIMevNWz2W9duzITGHlXkxqhA0@lists.infradead.org
X-Gm-Message-State: AOJu0YyZfbTY8EIcvzrmxOFHWGkK4a5LfRCflPumDeYt6Z5rQNOgpGmb
	i8j0hsPmya4Nc681Ogb1JqK28RLQNjgvAXunGUn6Ypt6HynYv0Pf5gFrdVzvZg==
X-Gm-Gg: ASbGncsnULe3fgq5EdG4JAVmQc+wZGCkYc+uh1OZWuP5ho7c+qHlqp3TDwvlFL1ZGPL
	pW73GqWT25orIU1OP+UCLHY7+mLq+CWnQNVzt6XGSlTGFXhzQsFQivjzfevgr3jCtwrlzpGM184
	vLtdNWf4qcMzFylWv4PGvorI+5Q+t1hmpLVp2BymXAX917P7WzoTGuV7uvinh8d6E2B4m7lccPi
	dIZPEf1ExwN1U1fRIkYz5fyJrEiXUb+Sfv940Qna+Btqlm5OGHWTMo5b/7hhjXkHPx2Tzwfz9jy
	UUGFPxrqnmy5R13baX98nnz20y7qUT30hVBIBUjI0WOMuvX3wGQ2H2Zj9UCvQ0Yr67K4fYrcQsR
	QNiMQzYA91Q0M2ct1/tcxMQ3zENJ5/6FeIeakEVT9qy4gX8R/N4t2bsjKxrxAPwbr179XAgWAsV
	sOCAjpB0VIexT02kX/8lb1rs9zEOAjatoGdtLSmxqG
X-Google-Smtp-Source: AGHT+IFb+v1JdL/gC42eHU5bkEWJaNyUQ8rWaktSZKXfZDD4p2uBG35UtT0yXpmTJ8Z4ZlV9gQqatg==
X-Received: by 2002:a05:600c:3b05:b0:475:e007:baf1 with SMTP id 5b1f17b1804b1-477c1133955mr375103255e9.34.1764543163945;
        Sun, 30 Nov 2025 14:52:43 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add608bsm271968105e9.5.2025.11.30.14.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:52:43 -0800 (PST)
Message-ID: <a8787265-e204-4a7d-9300-26ccc0f1ef13@grimberg.me>
Date: Mon, 1 Dec 2025 00:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-rdma: Use kvcalloc for commands and responses
 arrays
To: Israel Rukshin <israelr@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>
Cc: Nitzan Carmi <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <1763966961-32140-1-git-send-email-israelr@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1763966961-32140-1-git-send-email-israelr@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_145246_012194_83A4882C 
X-CRM114-Status: UNSURE (   5.41  )
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

