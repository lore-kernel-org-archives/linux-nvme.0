Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1807BC5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 21:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Thp/mBUP7GvqRjqHHxSjlZ4atKBA1Nqc0FZDlg/XWjM=; b=HLZKKzlNkI8AekhZrcLHM/utu5
	Z4cgDl/25DWqbmYcw7k2Fxq/2Y//VpmlW1fc2/ifGhvvmsd807Td0ZzTzZ+7etr7Q8neQurkQ88m3
	hTDf/0uYIqfx2/pGF1a8tvg/rKzt1p80OoakSRPlVMFn1AHK5OaVKKDctfK/S8BjR/QebvVjHLHmM
	HyINyo4fBUd+n9yGU1IDdunuByQIxVySB2kUq0s1qGWVxFVsJ6bqU+/Q7sZKWzKkOhN7sh8NbqrAY
	blb+5CSgdnH2Txr31EpCwmA/gyuRVbkI6MxRSLKtQ70a4XuSaLTk4GWOYFUOzW2f318ODE4Hhn3gS
	ePfCGFBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtEv-0000000EoEo-39Pe;
	Sat, 22 Aug 2026 21:26:57 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtEs-0000000EoEW-2c1D
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 21:26:55 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c20fb91ed0fso318476366b.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 14:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434013; x=1788038813;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Thp/mBUP7GvqRjqHHxSjlZ4atKBA1Nqc0FZDlg/XWjM=;
        b=OUjKK3qYOZ2DN/v/rW6IMBNpOQ1638Z1j0YgP+l+GC5G4HY49YnLzLXJwKgViGR3Xt
         4M1+dVQnPyTtKBvFF8+a9bKLZ1me37a5bCI4OVTsp4UNH4nVkqFKR+Ge0yM0BxfDsoyQ
         OLJzxM7HaxzufooAE1yK1kUV3cJKR0KSapLBG7OBBxxkkEZNL/jXWa0IpSV5fOLZYaL6
         VqtohJ1Nu2XUW9KnaVxvUMHY95RvcmZXq4Cp7KrW72Le4GL68YsZvdvQ1S1YxJ/pqnit
         XiTOmfKykixylgW5m5hD4IEbwAxpTAefJhCfZo5BpA+5aJc8WaOH7g67vSIdYA+Mwurb
         po6g==
X-Forwarded-Encrypted: i=1; AHgh+Rr8mnWyfdzOWs8NcYDazAdHg3a7Px28efV3TJYjUQqoRsmUvc0lV141ILtnuOSvAu0Pv+KHlN1L6rQQ@lists.infradead.org
X-Gm-Message-State: AFuF++lLmpeEvZwaLu8kiSkLdHq4g6Bis/N6ck/gWwOyrGPzgBTRsXKy
	nITkjs3XD14KzBiWuxM/vG60qbgmCusFIUw2jG8GBL11fk2W+CfBt4ktryamgg==
X-Gm-Gg: AR+sD127L7mp+UoWp+JhKvKyeeHRG9ZkRRDua63zaXshycl/gooGJfsUrBQjbKEKnou
	dDo+nAUlLyrrR69c0j6EwCZv4B/2lSTctB3/QK02jKvC6PiWm/IeX7MfzOaPnYxeUcjw9wB7+ae
	WVxAcpqJimujvCmj2BPdFFXu2GNa5uCGF2xZgZm4iZbN+QvYgyGJD0IxFQM48nJ7XL06ark0ks4
	T5UPS8R5mxMcubOgfDaHWb0AU7jGG20iYwymunC42KuB5K79KS5x7owdqcfjZrTGmp9yzQw/I8R
	jKwrKmrdQJSGbqjbDOir9UCmURfi+DllwIYWxPxfUt7rHj4t3lTw3vQTc53lPl/3Pgaf4cLdCdI
	/G4OjT9NCT7F3GzPv156ydM0UH6s8T4JB5VTbH7gYg38W7y/wBdea1ISHLWWih89XuEWR36vHNo
	N6QKDzYE7pPJXQz0Uc78jXSfwMfq6aA9Q3f/xMLfB6nigWNbBBYuf1dicep/sEAKYQJzIShQFmg
	cgC4FI+UTxH+ZJYWVyFu0s=
X-Received: by 2002:a17:907:da16:b0:c21:34a3:4df9 with SMTP id a640c23a62f3a-c246a2cf648mr1741311866b.3.1787434012464;
        Sat, 22 Aug 2026 14:26:52 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm543431466b.46.2026.08.22.14.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 14:26:51 -0700 (PDT)
Message-ID: <bae34152-2252-4b0c-9d3d-2a60808c545d@grimberg.me>
Date: Sun, 23 Aug 2026 00:26:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: reject C2HData for a non-read command
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>, Chuyf26@linux.alibaba.com
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk,
 linux-nvme@lists.infradead.org
References: <178730451245.442148.11684394617763960186@linux.alibaba.com>
 <20260822014037.1978918-1-yhlee@isslab.korea.ac.kr>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260822014037.1978918-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_142654_673274_89CFB562 
X-CRM114-Status: UNSURE (   7.32  )
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



On 22/08/2026 4:40, Yehyeong Lee wrote:
> The same check was posted on 2026-08-18:
>
>    https://lore.kernel.org/linux-nvme/20260818110405.590548-1-yhlee@isslab.korea.ac.kr/
>
> It rejects the same PDU in the same place; the two differ only in the
> return value and the message text.

EPROTO is more appropriate IMO.

