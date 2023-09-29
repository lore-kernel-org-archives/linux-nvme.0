Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2FFE728D7
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Sep 2023 17:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9/9Gv0T5SqN4UKcP3WTfyU63gOyTEvwA+tYFqPn6v4=; b=AgiiAF1oYKoEWjEgsLXBf1KKGp
	8mALdc37MAiYBeNdtM5qZD5wO6WgUCAkFuINUnv48RAdmMHbd3WsGMU4eLeqqZdmUIDUJO4PlBzeB
	i5KrLKSPIC+swO7EWuL7J2ensyNeggo7YSoDqTn6YCNLYmpmjxRxvNU1QAKAIsoS33n+n7Vx8rAyc
	zutoNXgx7KnOwwDy61/HicVxo0sSStbLox9zehVZ+lbttboPQS7jLGWhOa1SDCZMmqpj/BzFTzCGC
	XArYHtlqqbo+gPaDD91pHBafQhI+d2PP2oPmSSlXfF7HHMf7Sju14+AZ7jYm+D/QllfWkL+niEp6Q
	mzg5qpkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmHhK-008N7r-2P;
	Fri, 29 Sep 2023 17:54:42 +0000
Received: from mail-pf1-f173.google.com ([209.85.210.173])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmHhI-008N7S-26
	for linux-nvme@lists.infradead.org;
	Fri, 29 Sep 2023 17:54:41 +0000
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-690d2441b95so725334b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 29 Sep 2023 10:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010080; x=1696614880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9/9Gv0T5SqN4UKcP3WTfyU63gOyTEvwA+tYFqPn6v4=;
        b=DoI6t6a2wRud3D/FPC3DsYD+njVHzUDvweE12mTS8gsowcdE+GMlaZep2SR1bNo5gM
         w+FOBNphuM1tGLPh+Z7GJTMr5XqIVvwz9fe1K/7jD9LnkxFmZWMLh4aShKpHPlCIECgH
         B+koFR6C2WliAutBzbdrZqa1BSHSO8H1XptZXORD9YzGVbQ/Mrl6ViZjCtPPLLViLoJQ
         ET32yKJkLPphlFVv41jqIL714GGGV7dYXa7adRuw1lCgAGJn0JmuV00peFqVTxSpY31q
         noXu4aiYwSD7kX9LGPP5qP6tMVizZNPtlM81vR4nOyP4AJZwpPvyu1PWBJMiwff3wYUQ
         iGUw==
X-Gm-Message-State: AOJu0YxzGa9anj7xk6+1GPLn+7JvwZag06O0taheFODZrXWWX81s8ppK
	rAWnRpqeItlHEGXWs8+PTzM=
X-Google-Smtp-Source: AGHT+IF7T70L+W8FzWQ7S9Hp4H3npZwWUK6+DQgaST+LZ35UudBV+LIK350rWU8eXdmjL58O/JFyrA==
X-Received: by 2002:a05:6a00:2d96:b0:68a:582b:6b62 with SMTP id fb22-20020a056a002d9600b0068a582b6b62mr6846347pfb.7.1696010079849;
        Fri, 29 Sep 2023 10:54:39 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id b2-20020aa78702000000b0068620bee456sm15197789pfo.209.2023.09.29.10.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 10:54:38 -0700 (PDT)
Message-ID: <2e5af8a4-f2e1-4c2e-bd0b-14cc9894b48e@acm.org>
Date: Fri, 29 Sep 2023 10:54:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] scsi: sd: Support reading atomic properties from
 block limits VPD
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
 linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-19-john.g.garry@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929102726.2985188-19-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230929_105440_686867_747CD5D2 
X-CRM114-Status: UNSURE (   9.76  )
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

On 9/29/23 03:27, John Garry wrote:
> +static void sd_config_atomic(struct scsi_disk *sdkp)
> +{
> +	unsigned int logical_block_size = sdkp->device->sector_size;
> +	struct request_queue *q = sdkp->disk->queue;
> +
> +	if (sdkp->max_atomic) {

Please use the "return early" style here to keep the indentation
level in this function low.

> +		unsigned int max_atomic = max_t(unsigned int,
> +			rounddown_pow_of_two(sdkp->max_atomic),
> +			rounddown_pow_of_two(sdkp->max_atomic_with_boundary));
> +		unsigned int unit_min = sdkp->atomic_granularity ?
> +			rounddown_pow_of_two(sdkp->atomic_granularity) :
> +			physical_block_size_sectors;
> +		unsigned int unit_max = max_atomic;
> +
> +		if (sdkp->max_atomic_boundary)
> +			unit_max = min_t(unsigned int, unit_max,
> +				rounddown_pow_of_two(sdkp->max_atomic_boundary));

Why does "rounddown_pow_of_two()" occur in the above code?

Thanks,

Bart.

