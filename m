Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5FDD6D241
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 22:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+vGIa3VCNJHO6JQLz4ZGXstEsMQO+dnZttYMqj281Q4=; b=osoPKgGJjPK0fXp5DBUjUeJg2M
	H3L+T23hHihSSxFHLUq2xY7DebKkd7H9HVG5vlbcY7XIwglHb0T2nJalo4i6ol8C6sg5nU4h1y0bI
	8VQss6d/AQKbDGY1v8XNasOD9Hd1cqohO1lClhrJ4Et0aKuoWpVO6HtGSL9j4jmwSzm03dElp6pgK
	9bxtGHXRby1uAjQ+1jLN65LkRyqA++IIRmMWaViVVluT5WsUgXDLdiZMfoEpxVsU6SF0xmb8iTLXZ
	ivgZ7LrjS4B1db/s84Lg1/zqMWyrVDrK1d62ci8iUGTi9JotTSpZ+QAtyTXAVcUvBlUiS6VlghEAN
	3u1hv2Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGQBz-0000000EAhG-1JHy;
	Wed, 27 Nov 2024 22:07:27 +0000
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGQBw-0000000EAgZ-3KzQ
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 22:07:26 +0000
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso231062fac.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 Nov 2024 14:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732745243; x=1733350043; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vGIa3VCNJHO6JQLz4ZGXstEsMQO+dnZttYMqj281Q4=;
        b=pyC+eSxnFSUffZ+VuIps8cOwDQICdvPkgjBMVGodi8JDWGmejkQr9h8A6lg6udLPGj
         sUQG5eBkynuO7k29QXWypu+d/ZdEdny9oVVQOCPuWQJy3vC6RiyaOHWTM/773vkOj1Xj
         pNeJHCfh9ays+NxB9MRjzXutY1e+7gxF82Gi/5b6Pi19oZPsbttVZv9YCmDQtg0NOk0K
         iS+BTGuqFMJXc8lmKhZU0nGC6EcRZw6gqwGHh5nIrLZBKVvwQ496/4qcIhsmBK6LWCU9
         2QU4KdP6MajJzeV7tB8AHqmBOsXAwhiVmGQXzl3rREeyqbLoK5VYi07YqoQQiMPbE9Ml
         42/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732745243; x=1733350043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vGIa3VCNJHO6JQLz4ZGXstEsMQO+dnZttYMqj281Q4=;
        b=H8cJ9acS5BtDzs8KvA/d4KQh/IZFkeQvVErIwNu+Wp2B8+5gUPwxdHrppYIP+enVG7
         sDxm9Y5g4W9JHUzE6ZTqOqbsoZF+ofjE+F9yY8FwRQj8xbAK5rNFcGJvugb/Gu1GJrRm
         pyzyb/q+u0QXAC92aDvFZFV+zyAXFYSgzpIFH9XALEKa2OeGifoC1rU+EoLzUQ9drPSx
         G9iKqH1nx7lXlZ8G0nLXayN1m1WFYFCq2up2yVQtRYtjZ+odPcH4xkumfqb3I4kXJkN2
         G2Cnz40xeKB5jxtTOwbL/JmxH/NgKP/cXFTtFJJ8+Cvqs1KbLYFtvMPx9Ua7IggygNq2
         40Pg==
X-Gm-Message-State: AOJu0YyLrGHUKALjv9g1Z6OvocsJmGyGnnn5uCLzG/sv5pcxERzu52+I
	N0+X6qjsBRa7pdu5vdzbnetarFaG4ViOnGmu1iwbtNB6uadBxcUG4864Z4KzjAo=
X-Gm-Gg: ASbGnctGWD0o0DMCNRKVvkTvo+5bxSSCsH5hAc3Fds+5YmK2ybUH7Kij2Cvq3lnWR+z
	6W7GcFVJsdrWa421ITcKVLh3Y4GZoWcZGYqZVvNm25fNVoqWYrrOJMZlNwLeVOAKPBaDdDveJpq
	u/1mBvfQ1U5M8j7Dik21vuDb45gWMsy1OArV9jw2gXqo4xde3CJfZmKk8j1JjnVfTSJiCBnlmz9
	rHxpDlPZmevudirhqTKl0k3ON2AwN7kD1Sr99dTSXJ4yw==
X-Google-Smtp-Source: AGHT+IHrmR2ZWd9Ex5J9K8h4s5L4LkPvzR+/+oNVCdvgDsuL32o0gbyhjK0y1FOLz1qlOSOvMyZXbQ==
X-Received: by 2002:a05:6870:4944:b0:296:8102:e80f with SMTP id 586e51a60fabf-29dc432d07amr5670452fac.27.1732745241948;
        Wed, 27 Nov 2024 14:07:21 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de8f24b0csm54645fac.8.2024.11.27.14.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 14:07:21 -0800 (PST)
Message-ID: <1b76ee0b-c79b-4c26-bc19-a6228806f26c@kernel.dk>
Date: Wed, 27 Nov 2024 15:07:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Introduce service-time multipath policy and
 document
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Guixin Liu <kanie@linux.alibaba.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20241125103848.67212-1-kanie@linux.alibaba.com>
 <f0b1f299-7342-46af-a26a-9488996dad9f@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f0b1f299-7342-46af-a26a-9488996dad9f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_140724_838025_E445C6F5 
X-CRM114-Status: GOOD (  13.23  )
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

On 11/27/24 1:03 AM, Chaitanya Kulkarni wrote:
> On 11/25/24 02:38, Guixin Liu wrote:
>> Hi,
>>    This patchset introduce a new multipath policy, service-time, and also
>> add a new document to introduce nvme-multipath and all policies supported.
> 
> When we added a new policy last time John has share his setup and 
> performance numbers to justify his change :- 
> https://lists.infradead.org/pipermail/linux-nvme/2024-June/048208.html
> 
> on the same line, sine you are claiming to achieve lower latency and 
> higher throughput in the patch commit log, do you have performance 
> numbers that shows the benefit of this change ? I'm not sure how I'm I 
> supposed to even test this patch perhaps you can share testing 
> methodology and numbers you got.

Agree, especially with now sharing an atomic across all queues that
is incremented and decremented on either side of the IO life time.
That always rings warning bells for me, on being a big scaling
reducer.

-- 
Jens Axboe


