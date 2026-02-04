Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA72FE95389
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 11:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QHhoGSxKy9vmjCLMZ5KoEcOBQkVZjkB8fx4BIL0Kk8U=; b=lwjA9N0/Hn5RJWzsXKt2w0s56G
	erHzF6XF53UOB8OQVgL+MFvNNPLljhZK89+vgIFwb7yOGlqrro1TJUQosTn7GrmOmGega7f7uv45h
	IfBQCTEOAvCpzK09sdWpo8wbHKpWXJaym6UL5gqP65ClBnih7HhNCjKM4rp589himH6xmMd58PnSL
	XsR1O/MBleOYNnPny2yQwbOvPDxGL3hb6OrgFBzXsDwxabTdzDonLPY7m1SeaoI24idoWhQHsUew3
	6q9dKHS64GtYwwMoDrqWhk2lqtRZwPcVobop+zeII0iwctuKt6rV5BsKz68lP6dGE/+UHDRrPpWwl
	nThjVENg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnbD5-00000008NPI-235S;
	Wed, 04 Feb 2026 11:38:15 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnbD3-00000008NOp-0JbK
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 11:38:14 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4807068eacbso56442465e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 04 Feb 2026 03:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770205091; x=1770809891; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHhoGSxKy9vmjCLMZ5KoEcOBQkVZjkB8fx4BIL0Kk8U=;
        b=amSGonkK+0lHiTfBFZ9GPaJ0TpKCzFBlEbBnREKpnIw2nsxMpDsBdopzz76fmH3elv
         M7v3t69DPvrz0csWryhauwqRKjdYlu15gRXYL+shv1RK5cITCqglH1jdSF47o2mQqOlk
         XamYig0cVkHlk1sfMPSOol7NlQmkKRXsAkWMlpF+f8n99hc0tAwdwdwV4rE/Vn2lERaW
         Jh7OUnVB0LhOLxIU7KD1rNWyaIiOLrIdYvcTK5kmsoLjz9XWdt+TBEeB0GGGFBSLqkJw
         9PpKvn8Qn0T9jW7D66BHQf7lPxYbQi/cCkCZZlr0+gcbi6W9kcpLor9Rn7UBrpQnLBH3
         OnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770205091; x=1770809891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHhoGSxKy9vmjCLMZ5KoEcOBQkVZjkB8fx4BIL0Kk8U=;
        b=s0mvqirH9Sianbwc/1C+Q64GpPk6dbczWnbzJgiiNFcvkyE03+i95wGVyriKYaHBsS
         InTaEblAT9Rxv62c7qAkA+kN/gQT7GL1luv5OP3+GX4vMcEI4aIwXAw5gxp+6uwpV25p
         lf9ODRV1pCgSC4fsEBhCs/DF3kH4X+yOX/2oFJFhzi0h9LbN3amnr66PTs5ERxxWRzbo
         7vMcSRSMHDb7Q+6DbTM2CpqTty/NBfeLjEllGnG0RNnHDDtrO721ViBFVkaliw2Zl9Mp
         iOENuOh0cWbrJx2utBxwiotIUUgeTzfmZsCEp7BunttsmSlQpPC3oDR9xMiV/QQ3qGZh
         qhhg==
X-Forwarded-Encrypted: i=1; AJvYcCX9jS/e7p04i745BQs6GcPLtyNEOrasvbYadRofm/5k55gUd/FPYDJTbIX3LqKqjiFsA6ZAUdhdzo6z@lists.infradead.org
X-Gm-Message-State: AOJu0YxX8WDe3DUueHpV+fOMnonlH11HHRoY7nJ6MQq0TZINo9NQqk45
	fnxbTG8XDihWZZDksZl1P8T1xiUS4LIh4AjIaZ8Nz0jdNVTAss3MufuX
X-Gm-Gg: AZuq6aJJdxFuOSxqn6J/DykvdnxNziApEmNgeiiB4+EzDLKMIMEdR5tI5ZNc2erIgHk
	+G2JoLOujx6x1HDqoseHUWre2FmpkpeJgpeVVQe5R0PFDHXVQmYX32iInx1kuONkE1IajCKNa6L
	tptoAcSTST1Xm/sSAXGt7eFYWoHLFyfb3nVcl4qp8CpWAeru3OF7RhJ/7Q09G4TfEAQhT8LIOjk
	w9XnwuJ7sA+mN+OBq7xNjavfwfSfX++YNWt5YO4XTbZ43PsuhQMpHGo86pCVRZEU9F4xulhcUWd
	5IAlpDKjCJZw4Fqh+k3ibzZf3WWOgomecU0ca0EwW/MBNHN+IXxuCZOD7J9GPYBrfqtBXWjlOnV
	ASSUAeNoQH4rS3BQiJbTCKUwKIDaSJM+r02YH1rBU4xDdJUhSgQbiLM85xdmcpHmra373Nuslep
	tvC6eenG9mL70C+1XthJ+7Ig4opOiYJd+ajRKTIte8gX4ZV+HPyQrZpT+OlafBruqoWMX7Gdwat
	w4U3KsqWRSTETzkiXKMu5dB0KT2fRnOHFMT7/9SrdZi5cQ=
X-Received: by 2002:a05:600c:34d1:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-4830e92a768mr33410685e9.1.1770205091057;
        Wed, 04 Feb 2026 03:38:11 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:d656])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831089d547sm52311635e9.14.2026.02.04.03.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 03:38:10 -0800 (PST)
Message-ID: <82f0e957-94ef-45d6-971b-951540bce136@gmail.com>
Date: Wed, 4 Feb 2026 11:38:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Gohad, Tushar" <tushar.gohad@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
 <aYI5S1puAZ-rPvlC@kbusch-mbp>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aYI5S1puAZ-rPvlC@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_033813_135008_6471EB27 
X-CRM114-Status: GOOD (  14.76  )
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

On 2/3/26 18:07, Keith Busch wrote:
> On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
>> Good day everyone,
>>
...
>> Tushar was helping and mention he got good numbers for P2P transfers
>> compared to bouncing it via RAM. Anuj, Kanchan and Nitesh also
>> previously reported encouraging results for system memory backed
>> dma-buf for optimising IOMMU overhead, quoting Anuj:
>>
>> - STRICT: before = 570 KIOPS, after = 5.01 MIOPS
>> - LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
>> - PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS
> 
> Thanks for submitting the topic. The performance wins look great, but
> I'm a little surpised passthrough didn't show any difference. We're
> still skipping a bit of transformations with the dmabuf compared to not
> having it, so maybe it's just a matter of crafting the right benchmark
> to show the benefit.

My first thought was that hardware couldn't push more and would
be great to have idle numbers, but Anuj already demystified it.

> Anyway, I look forward to the next version of this feature. I promise to
> have more cycles to review and test the v3.

Thanks! And in general, IMHO at this point waiting for next
version would be more time efficient for reviewers.

-- 
Pavel Begunkov


