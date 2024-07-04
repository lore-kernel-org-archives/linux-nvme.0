Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694D8C30653
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 09:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=akE1Q3g7Qa4HkyXq8fNv0RwC4Pi6ZVWYcLyhUeJuWM4=; b=nKW/fsZKBlZOZiZUBhQ150tPmc
	9r8NoINvVUQkX/A6C6CpgxKbueBuscA/0A7deF6zOIRJYmSCUydsocgUUB3eqQqd3a/xjpxLWPJGc
	7mOUBfUVRLC9J8gLtkNpSk5zBm0JxlQjoWC/oAQowkI3PaUKanwl9RtiKFHSqNkH8+URpK7yHiGa0
	49iC+nQvJUvzpV3fPynZyc+a15AShTDYx655LcZt9lbg2CS9Jq5GO1oVKiCTwsAD1Xpa6pNakghJc
	9k1lXtgbECWnTlo0EnxRUuqkts+4HMJyTH3/W+oHc+GfzmzSGv7YmK2MG0C/9+zlURS4mC+hTjUws
	gRXb3e7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPIXJ-0000000CiTf-21cX;
	Thu, 04 Jul 2024 09:13:53 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPIXG-0000000CiTA-3ZY2
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 09:13:52 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367a0645984so35851f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jul 2024 02:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720084429; x=1720689229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akE1Q3g7Qa4HkyXq8fNv0RwC4Pi6ZVWYcLyhUeJuWM4=;
        b=rG2Yd7+IXpM0FBSqJJlFPVdRqcMAZeYtBOMfFIhxz+8p9RyBHoq60u6J+6vmOYDmeR
         z036ZL3/Cy5caWrkJbq7NC64LvYwZe5W8zBMnV0MPjnl+jimvTmy04cCVTn8j2H7rwrr
         mU5fQ5BSq0l3gqeXqFJD/S9cq/m9V89jHyFBPKJP7iLPA7dVHzRGD0ZKJ6A+BdM0iP8h
         BT05mZg/rOliOo0hFMjbWzosyq7HWH3s0AcnOWf8fj97wlUGy/fQDInbf08Lx+tNbS9s
         ysjL6M7SKLo+Q29nW4RvAIRuIvZJaOxLYNJj6labbQE+zGC4nbwCZRO7RLfmQtUaapnv
         WLWw==
X-Forwarded-Encrypted: i=1; AJvYcCWUqQHy//WDHuE69Y5rgGc8Zkv8Sh+U5edu+BhxvoiNxZMqSg3jUOViq35ondiRAEGJC7aahjg2bCxf11Rgij7iCafRsl7iDUApdttzG2A=
X-Gm-Message-State: AOJu0YxJAXFh5wdl+owT31V81365M5P7LEUJsWbEgsmkxXDToUc2ZQbs
	vbaZvMF8UWdv6995DmnOYZ8aMJvvoyx4JPzbNnK8bOSsAJHmUqJk
X-Google-Smtp-Source: AGHT+IGeWUAVx70J2h6mAyNQGIYacgUncoCVZfNPU6MKWE+bxjCkE1KWZH+h6ZdiJTUTRPUB9l6z8Q==
X-Received: by 2002:a05:600c:45ca:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-4264a42901cmr7732365e9.3.1720084429091;
        Thu, 04 Jul 2024 02:13:49 -0700 (PDT)
Received: from [10.100.102.67] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679c12440asm1269432f8f.73.2024.07.04.02.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 02:13:48 -0700 (PDT)
Message-ID: <d92546df-db9d-4f70-8c2b-cbfd2632bab8@grimberg.me>
Date: Thu, 4 Jul 2024 12:13:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-tcp: align I/O cpu with blk-mq mapping
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-3-hare@kernel.org>
 <b6702586-12c4-4390-9085-2cc6d9fbb462@grimberg.me>
 <20240704053725.GB19735@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240704053725.GB19735@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_021350_924548_89AD90E7 
X-CRM114-Status: GOOD (  13.46  )
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



On 7/4/24 08:37, Christoph Hellwig wrote:
> On Wed, Jul 03, 2024 at 05:19:39PM +0300, Sagi Grimberg wrote:
>>
>> On 03/07/2024 16:50, Hannes Reinecke wrote:
>>> When 'wq_unbound' is selected we should select the
>>> the first CPU from a given blk-mq hctx mapping to queue
>>> the tcp workqueue item. With this we can instruct the
>>> workqueue code to keep the I/O affinity and avoid
>>> a performance penalty.
>> wq_unbound is designed to keep io_cpu to be UNBOUND, my recollection
>> was the the person introducing it was trying to make the io_cpu always be
>> on a specific NUMA node, or a subset of cpus within a numa node. So he uses
>> that and tinkers with wq cpumask via sysfs.
> Honestly, I think we really should kill this unbound module paramter
> before it causes more harm.

It solves a point problem that I don't have a good idea on how to solve. 
It can stay there, but we should
be careful before we choose to evolve it.

