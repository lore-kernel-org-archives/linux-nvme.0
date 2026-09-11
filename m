Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DF5C88E50
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 22:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6NfEd6G1HqoGC/ktFofSinHuBQljkOMNK8NE8adc0Us=; b=pArVpMTBMv+sf0RBU0+L/bsZHU
	ZI0OiGNfEPUKAhRUof/RrVE7h8JVhUENq41WV+Vc1U56SUqrt6OvI3JcFPv7xrSaMjfrB3so5b2Jj
	r8a2wv12yYt171m+1OlsgWYag/DRreWoqeiMS4skldpEFx1X18yj9+0qc9AKzKtc/OTpLy4K6MQnC
	GJGUNaMIceZ49c2cmxwrI24POcBq6LshJD2EYlGDT4FY4CZBlchckaztxBXWaqXorQXwxVJg69kuZ
	Odt9iTRwakR84j97qnpgC3VB7ugT1nYKtDSVtrKfe6ATjRnOFPIzn3Tu/dmMjadZybe+8rVJA3t5n
	J55fXhug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5A7n-00000000IhW-2ylX;
	Fri, 11 Sep 2026 22:53:39 +0000
Received: from mail-wm2-f12.google.com ([74.125.225.140])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5A7l-00000000Ih2-28p7
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 22:53:38 +0000
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso4632855e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 15:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789167215; x=1789772015;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6NfEd6G1HqoGC/ktFofSinHuBQljkOMNK8NE8adc0Us=;
        b=b/aiGbS8k6jh3FmZk3CQXCKwqW+oFt6CsrAgrdYLylPa0C7LWvDz0MKq79Dr0Zcs+5
         KUU+yXX6lu/DzJinw5ebUYx9vzDdDRBp3JS8ITHX4SmF7D+WF3wU0p9EovlLg3LcSTXd
         N/s8Fu1nn54o4sYRQWmWlggmE95pVy960NQn7NySrFpVLKspjxqEWa3qGtLltpUZIHYU
         QIWwnvTSnFJfmWoMqF/56NYqfmGwSQbG4t1lw+5mxn5BsTV5oSPLTnpSusAJ0vAzsKcg
         uszT0qqPrXt0bhxS2G+wrmQ/k2CXWszMrWt7R8i1EfvFRgVsA8tGEaokHcBlaajU+CXe
         WJwQ==
X-Gm-Message-State: AFuF++kzw4h19XY1DLRErlhc8heuLmJdDDxwV69K8V8KcsT43F6ElsOj
	TG3Tnv0Et4tVfTpKRe0XQmeWFgx/lFmiWPSW58qlWR7u4wzktswIP8dn
X-Gm-Gg: AYBFou2Spgr0Q9K1h/7iin+ukjEVQKStcYd8j0o/rVczZ9QTiutkEByVYoxiA6UBE7O
	qcUhpW1TOnvKh3f7l6N4665bZGd/nTenS+r+3RvlmHmvIgDk01OtwwyCa/IgYl791GdpgyyGonn
	cipyo6kjwfBAJdPpHE3egmPFvfC6hrAeT+MbELL2ZGBvoIefHfmJnQrvyOGrm2Dgxrd2OHOIUYv
	Ycp96EHjQiY0K/P0WZFwUpHRBlONnz5L+BGNIchkQDUygfSMTQoaLvHSReSnxL3D5Jcuqo+l0Si
	Vafv9BIHSJdoqksGw4wykwKL0QxYoYiMJJ+guWyqFcDACRzU8wFCLME9HqQSXkj7ToY5guaEwOh
	iZ1Z1XkT+noaIGLOcnxl+YDxCJEI4AULfvKQz/8eX76uDuhPbzoE2HvdTw4YSWTRn/cT7BdGQOk
	Fl7gdmCOJTRBLV+L1/ncm2OxKDTdyRpnnvaXbhKp2rzsEOBfq3ogw8qRznhqTuYB4oQLN568+Gb
	8AP2CqLhT/b+76bBW/aUGxWfvkgKnRwdw==
X-Received: by 2002:a05:600c:8411:b0:49d:1e09:694a with SMTP id 5b1f17b1804b1-49e619f5049mr161756285e9.11.1789167215404;
        Fri, 11 Sep 2026 15:53:35 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb350686sm9504395f8f.27.2026.09.11.15.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 15:53:34 -0700 (PDT)
Message-ID: <40660c92-52fc-4599-b933-4625bbc97703@grimberg.me>
Date: Sat, 12 Sep 2026 01:53:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] nvme: add per request retry timer
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Daniel Wagner <dwagner@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-4-sagi@grimberg.me> <20260902134156.GC21649@lst.de>
 <f6fc10fd-4e45-4127-b43f-51e66e15f347@grimberg.me>
Content-Language: en-US
In-Reply-To: <f6fc10fd-4e45-4127-b43f-51e66e15f347@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_155337_562027_C9049ABA 
X-CRM114-Status: GOOD (  14.55  )
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



On 06/09/2026 3:09, Sagi Grimberg wrote:
>
>
> On 02/09/2026 16:41, Christoph Hellwig wrote:
>> On Sun, Aug 23, 2026 at 11:48:59AM +0300, Sagi Grimberg wrote:
>>> The existing command retry mechanism adds a request to retry
>>> to a retry list and modifies a request-queue (controller) wide
>>> dealyed queue timer.
>>>
>>> The issue is that the existing requests in this queue may wait
>>> for longer periods of time as more requests are completed with
>>> a retry crd level.
>>>
>>> Instead, add a per-request timer that will allow different
>>> requests retry in a way that is independent of other requests.
>> This blows every nvme_request.  I think we'd only need a per-CRD
>> level retry list and timer, can't we do that instead?
>
> I can't see how, because we'd be modifying the timer potentially 
> indefinitely while
> requests are pending....
>
> I understand that this bloats the nvme_request, however this is not 
> accessed in the hot path.

Christoph, would it be preferable to have req->retry_timer dynamically 
allocated? It would reduce
the size of nvme_request.

