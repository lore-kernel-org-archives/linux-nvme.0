Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8E1C25B78
	for <linux-nvme@archiver.kernel.org>; Sun, 26 May 2024 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=45YG/zonO4lEQMMW+/r3w6Z/SNvvsENWlJX0B9DhbCs=; b=CcbewUruhgk9X5K51+tqJMYPIq
	zu/TOID/nZKO+PRF7fsIRBImFLcEdoNRpkFPCjwzyNyx57Z/MuGKT4YszOWWR7wLsjJZWjOblFDc8
	nWn/b4W0CMZ0WHYl14eNhIo++8KJ/Aho3gcwEEFiLcZ9BKjXcKjtlGU2LIV6Ci/S6AFNFGFlzGUIC
	6mfqlZHkaRXy30zMROusQ/ew1TIY60s5GzKfI3Ars+ioNiO5nx3gMhVTvu/1EmpAb3gwhhl0+qY6o
	Jl5IDLR0ug4UDLro1I+9B+icW4kaBevErhxlyM2dGjzPtMJM8U7EYFwTccKdWyVSsHo9wsl1gcySX
	FcjSfhJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBEJL-0000000ClYC-0Wmg;
	Sun, 26 May 2024 13:53:19 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBEJI-0000000ClXj-0rOK
	for linux-nvme@lists.infradead.org;
	Sun, 26 May 2024 13:53:17 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4202a1ead57so1038905e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 26 May 2024 06:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716731594; x=1717336394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45YG/zonO4lEQMMW+/r3w6Z/SNvvsENWlJX0B9DhbCs=;
        b=gcp98gpHctltPxbAeK/H6r3xNRcOEPmE9NWETOgl8dCIk8v2fAUKYpUeDoxot5NiLs
         k3SHW/EHMgvL0CPF9IjpEOfd0HBPtFWsVfT5fHzEQeqqhesUcDlkm+DSmPiIaMkNoaE4
         TvHQbek53nBi6DcHWNKIVHQdb3qHrmYn6z35SQlwGO7ksOUjJqf6vkkJIINS9ylUgidT
         0knchpzkkC23emlXq28qI4FFqYBzRME2rWmedG9My+F2HOyV5P3TkJqA8sMUcnFBoVPC
         63UePbutQVSUE77R7bWXEhf4V/yDpyRDNKAqE6uFB2y/tGHBHP7uD/f806ew2n7SdUQP
         D6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVAGGZGTux6bd3oYyah8afIxltZ7OUqh6B/XTtZ6j488tCwmCRFygcyM8cX1oQxNMRELXOPIKPJqOF3W9KCLb+pRSI49hR5agqUb8SI748=
X-Gm-Message-State: AOJu0YwW2MtYGnj8b8AVTsckGUWdxClwlaEV1IJmIu2AnGgDgHoeSA/w
	YKSlsWwmWAw8/bm3jyFU7ed10GCUGj3wrcUssai9cgwE0s9MNO6j3gAItw==
X-Google-Smtp-Source: AGHT+IE/MiczL/miywMH9ilDeeq6cRkdbDGlWRWLXmxotFOgG/RbxJqWdon8KIxkAOqAsjv7dfeIXg==
X-Received: by 2002:a05:600c:1c93:b0:419:f68e:118c with SMTP id 5b1f17b1804b1-421089e97d4mr52804865e9.1.1716731594217;
        Sun, 26 May 2024 06:53:14 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9546sm6476601f8f.82.2024.05.26.06.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 06:53:13 -0700 (PDT)
Message-ID: <5d423d6c-fed4-48cf-b5ef-123ee83b4cd3@grimberg.me>
Date: Sun, 26 May 2024 16:53:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] nvme: use srcu for iterating namespace list
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 shinichiro.kawasaki@wdc.com, hch@lst.de
Cc: axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
References: <20240524155345.243814-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240524155345.243814-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_065316_280887_96DDDC5F 
X-CRM114-Status: GOOD (  11.27  )
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



On 24/05/2024 18:53, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>
> The nvme pci driver synchronizes with all the namespace queues during a
> reset to ensure that there's no pending timeout work.
>
> Meanwhile the timeout work potentially iterates those same namespaces to
> freeze their queues.
>
> Each of those namespace iterations use the same read lock. If a write
> lock should somehow get between the synchronize and freeze steps, then
> forward progress is deadlocked.
>
> We had been relying on the nvme controller state machine to ensure the
> reset work wouldn't conflict with timeout work. That guarantee may be a
> bit fragile to rely on, so iterate the namespace lists without taking
> potentially circular locks, as reported by lockdep.
>
> Link: https://lore.kernel.org/all/20220930001943.zdbvolc3gkekfmcv@shindev/
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v3:
>    Use kref_get_unless_zero as needed (hch)
>
>    Keep the original singular namespace check for nvme_dev_user_cmd (sagi)


Seems to pass blktests for me (outside of unrelated failures).
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

