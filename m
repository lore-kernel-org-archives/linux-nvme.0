Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53220CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 06:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o4Gt2A/YlxbVubczq49Ydic0OlMC6zIRUZ48mhZIweI=; b=4EvWlK6tBliwdiNEoiNuvxYVRd
	PesslDufHZpB/8QzV2/8xoUwhIAtp+bZvrncXYu4bPkHYbEJA9PTsi+0vkatnLQLmne9dWGimc8h3
	gxBNpvspp8OMSxBQGmNvTbeAg2SaTPdaSTKnKkSoQ0FYEqp6936nBJBTQkYqvJRbQZHxb5tkacAP9
	Gy3ICKjYIBpRDiysQCdArA2TT21XGxo06iHSknJeo+llw6VmpPWfbOJs8bS07PCIYS+L9KObyJbvM
	PekugMK0JJg+Sa32NGMnqAP1u0dr4PT2nlFvlMwfXFAskOvSzuqUgRMtVMhM6DyBVhJeLxGPTTRna
	sNm2WxoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrXsk-00000009x9t-3PhR;
	Tue, 02 Apr 2024 06:44:30 +0000
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrXsh-00000009x7C-25dI
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 06:44:28 +0000
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6e673ffbd79so3128731a34.2
        for <linux-nvme@lists.infradead.org>; Mon, 01 Apr 2024 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712040263; x=1712645063; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o4Gt2A/YlxbVubczq49Ydic0OlMC6zIRUZ48mhZIweI=;
        b=hoVcxkixMpv7cUsDsb2sVQcZhps31v2YlHQLMk7OraS/R7EbzmqEQZkoJhJjcd5fCh
         oKugMz1zYGluP5wBPgJ38929Lzjl0/DlJKbB62mAezJnFOlI0R9qlE9Ad/+pp7ScrqCU
         9f9ah5kY9QAu8b8wnM6Er5hscw+LgY3LkKg3iZcrtrzOyR/iTYMHEO7XShx0/gV2qeBN
         l1ScluCRn0u7FFAkkxlisF6EeM0iOevhL2oHkCQ3KNmFgXEcTQeFgSYlWgR8LPYwilY6
         nWiMECii+hvtGcBhsCZ68avgYFkjuHmsnJHoxUmu5EVQWrIPzhP2A78rEl9QwyuzgK/W
         +JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712040263; x=1712645063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4Gt2A/YlxbVubczq49Ydic0OlMC6zIRUZ48mhZIweI=;
        b=GjFCh9nT/HEhWdQ3/fjmr+BaqADFqPMBoisOCUvfhPSYBtGjs7oRtrouH0S0nSHf4b
         UzIV1xQCXDb5oyjmUgxRoUYJbeNbBIxS46Z/GH13axLLP3j4qYC+1mMpR21Zlvm6DTas
         8FJDTXcK78KBbUwAQuVXzUq4Pw92PUuq6VNaK/uyfSqhvMQ8gA2VZbWclf3WnL9NpPLV
         n7XXPoukEGUSe04twtoF17JTpTm/6r2POBqPCHxFEIyzLHNDnMa1fKrJmKSz0Qlob9eg
         RipMGuLCKIED4s2LSP5o+CXsvIS4D1OQQXodHTbYIrZ6AJsLJofpyGWYgPy/jIsR7X7T
         s4zA==
X-Forwarded-Encrypted: i=1; AJvYcCWl74u2rGCgoJXQUWDOGs4xyWqZWJW4wnxZoosj+ysv3+WFkmmHhn9wCuee2TiSlueLkORWt5hYYKI3jILc49HkQ2H/uP4cFgUZHkGrIoE=
X-Gm-Message-State: AOJu0YwUg1rC4MnjIDjkMCA5KhEg4kFn0DYAbYwwMROVb6lWE6gKyqdw
	e7IKPBnZs+YkSXMuYd7Mn2/bqpPv8pPis0juO6QD7Cj43ZSCA+W0
X-Google-Smtp-Source: AGHT+IGsALuz+EYbsn3NEk9dyZFdNc4oYqbTtk6nUxsCzJEfOMWdydw5yQ9IV6Tn1FPKa+CognHTmQ==
X-Received: by 2002:a9d:625a:0:b0:6e6:d5e0:2308 with SMTP id i26-20020a9d625a000000b006e6d5e02308mr13185747otk.4.1712040259823;
        Mon, 01 Apr 2024 23:44:19 -0700 (PDT)
Received: from ?IPV6:2600:8802:3800:75a0:2378:fa3f:c6b3:24d1? ([2600:8802:3800:75a0:2378:fa3f:c6b3:24d1])
        by smtp.gmail.com with ESMTPSA id q20-20020a635054000000b005dc120fa3b2sm8756141pgl.18.2024.04.01.23.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 23:44:19 -0700 (PDT)
Message-ID: <30d1d907-4585-40e9-880d-e23a2a5e88c5@gmail.com>
Date: Mon, 1 Apr 2024 23:44:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/30] null_blk: Introduce zone_append_max_sectors
 attribute
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-19-dlemoal@kernel.org>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20240328004409.594888-19-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240401_234427_570822_C6BBDB85 
X-CRM114-Status: GOOD (  11.75  )
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

On 3/27/24 17:43, Damien Le Moal wrote:
> Add the zone_append_max_sectors configfs attribute and module parameter
> to allow configuring the maximum number of 512B sectors of zone append
> operations. This attribute is meaningful only for zoned null block
> devices.
> 
> If not specified, the default is unchanged and the zoned device max
> append sectors limit is set to the device max sectors limit.
> If a non 0 value is used for this attribute, which is the default,
> then native support for zone append operations is enabled.
> Setting a 0 value disables native zone append operations support to
> instead use the block layer emulation.
> 
> Signed-off-by: Damien Le Moal<dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke<hare@suse.de>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



