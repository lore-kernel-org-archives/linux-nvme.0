Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287ADC4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Apr 2024 08:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7iQITEksl69Ccmw8f0VSBNwllkDq+mpopOh4LZGdY3I=; b=izBfgRrz2/SazHKYX1g6ukZB/S
	bVFTA9Liap9FzgW4iqo2N5FTpZ6MQu8X6RNqjxLwG2rQPS1BQgBdba/VrFhIDv5mcX2CPcsGqvOSg
	MSERs+Ty6KVqRBpTufz9lCKlmDYk3fiTD+yYO9MphhAPKsFRNmx4N1aia69NZZXkokBBqK9p6Hlsx
	9kQiF7GLUNHtNJUxukB4wSXnv2AN1VWOat0Cq/C7pwkTqL2hJPue9WkDXUEtUZXsDLPtjxcW4QsuX
	nlc+1MXw495rVvVd5WyNJTIIoSH0uE6TGxQrU198UGpeEeJ5EXEqUiejSAhIvyL2YF2+0dg2sWeWP
	Cmu/dSag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvvGC-000000051qX-1HZn;
	Sun, 14 Apr 2024 08:30:48 +0000
Received: from mail-ej1-f54.google.com ([209.85.218.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvvG8-000000051pA-1wju
	for linux-nvme@lists.infradead.org;
	Sun, 14 Apr 2024 08:30:46 +0000
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a521d885c55so61943966b.0
        for <linux-nvme@lists.infradead.org>; Sun, 14 Apr 2024 01:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713083437; x=1713688237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iQITEksl69Ccmw8f0VSBNwllkDq+mpopOh4LZGdY3I=;
        b=HyItKXcUa9oYEy3YN489DaSvM4hZiQ++WAdRNmIedz4VJ6BL101u7zAa+oXCtVD1y5
         mRlg+jkUmMs+pAHZ2SeyDfzTkB+331TbDhgvqlU0XRtKqYBK6SBCeLygSPzQOYZ/tmC+
         Z81hxIa21s3vCU7tlzCoHP+k5jr/84s5MQo3dA36qABtEbup3+dYh2HtSFEYUO6UUhO4
         PNl2tn5MO1DqfiqHJpnz5v/xnz701THfK7MbsZsWrmQaqbvazQzPz5J5sMfMYOk+Ht9p
         xSm37QvLnUGJhWnr5s8xJWT0tJ4HoLMBBA9U6F/p7i74a0SrlUOSrS/bKCZphsU+qBzb
         77OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb//21Nnh9lNNrMI5aEUWfaetkAvQbyfQXLGvrpqCaV8R/nm0A9Yl4w5XTFpTSfQKD15hwPoXYvF4AbRByEFm9h9VvxWooa3gDSDjbB/I=
X-Gm-Message-State: AOJu0Yw0QgfqM1Yx502avgISeksFqS09BD/BxH+PihB0HGY/f8+VD9LY
	sP6bBtHauCHSZs9MqV/hV43doHiBWCkgqk3GUroKDcLI0tZ4h9Y8
X-Google-Smtp-Source: AGHT+IGQi4sYOlb6vNd0nwfOsLHhZ7bmietuId96dp/s38PTenwvVr3/zHjvJn8JX26Zfpyq6MKm3w==
X-Received: by 2002:a17:906:dc8:b0:a52:5350:f0c5 with SMTP id p8-20020a1709060dc800b00a525350f0c5mr1357614eji.7.1713083437141;
        Sun, 14 Apr 2024 01:30:37 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id nb17-20020a1709071c9100b00a4e6582edf8sm3893688ejc.102.2024.04.14.01.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 01:30:36 -0700 (PDT)
Message-ID: <afcd5e05-f4af-40de-8d13-9bacf5fadd80@grimberg.me>
Date: Sun, 14 Apr 2024 11:30:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: find numa distance only if controller has valid
 numa id
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, gjoyce@linux.ibm.com, axboe@fb.com
References: <20240413090614.678353-1-nilay@linux.ibm.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240413090614.678353-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240414_013044_546524_9151F997 
X-CRM114-Status: GOOD (  18.31  )
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



On 13/04/2024 12:04, Nilay Shroff wrote:
> On numa aware system where native nvme multipath is configured and
> iopolicy is set to numa but the nvme controller numa node id is
> undefined or -1 (NUMA_NO_NODE) then avoid calculating node distance
> for finding optimal io path. In such case we may access numa distance
> table with invalid index and that may potentially refer to incorrect
> memory. So this patch ensures that if the nvme controller numa node
> id is -1 then instead of calculating node distance for finding optimal
> io path, we set the numa node distance of such controller to default 10
> (LOCAL_DISTANCE).

Patch looks ok to me, but it is not clear weather this fixes a real 
issue or not.

>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/multipath.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 5397fb428b24..4c73a8038978 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -240,17 +240,19 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
>   
>   static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>   {
> -	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
> +	int found_distance = INT_MAX, fallback_distance = INT_MAX;
>   	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
>   
>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
> +		int distance = LOCAL_DISTANCE;
> +
>   		if (nvme_path_is_disabled(ns))
>   			continue;
>   
> -		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
> -			distance = node_distance(node, ns->ctrl->numa_node);
> -		else
> -			distance = LOCAL_DISTANCE;
> +		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA) {
> +			if (ns->ctrl->numa_node != NUMA_NO_NODE)
> +				distance = node_distance(node, ns->ctrl->numa_node);
> +		}
>   
>   		switch (ns->ana_state) {
>   		case NVME_ANA_OPTIMIZED:


