Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6D1C433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 20:43:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5D5611B0
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 20:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5D5611B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aaQ5HB61WYTe/0MXnqUmNaOKfHzD0ACLDhoTFTd5KNU=; b=qpeIN4qp5p9yrDd5fdqpoQw1G
	UV11Gshk7+5/d8dwDB+zeHZlRvMxSdELg6ueYAe/4A9MgfJDbcy2wutbAV2MdlgnHkm8JuRaCVxwe
	FuVeHa1QxCdqUZNKcVHOWNzencQCHRvDe675VbIPar9M615+llwj1QQYklXbOK3i4sHc5SXexFvUG
	KdA7S7UBfszcv8BQAkwq40wsWFFMNaGJixufVyhFS/4JoSxAbP/xKqplZDv3N1XOh5t3yC05xi2zD
	hVQfuOonlG6YwsNfm7GQtFVu5qnHb7XD/ttl5JIAfkDR37WwaDK8PGr1URhea2tX8Kpwp6ZzLQpzY
	0nTjWBVfg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lalav-006GIs-6K; Sun, 25 Apr 2021 20:43:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lalar-006GIi-Jd
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 20:43:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=sQEBtvQIiwMUyXs4QG1unv0E1sFViEnCAqrsWxCtU+g=; b=Je3imT3PGypLVP6K9p4XkY40wF
 /dkOTjqwAVD+fUeEqrUYEbdq4oD/+qU4Z0A7aNrxjQghuvyrRtiDbF4tHb1YZBlz8xC5xP+RCu6QD
 AX+fMaIvjuyi8FRoU2Jss9RGUHpTCaDGr5DgkQ9umaS4+3wuflgecrSC39+MsCH8ez3Lg7YwDLDyj
 czXZDCpPnM32KubfnFAsPtXECBmu8W167jiDg7u3c6fV/A8646qwcH83H8nrubS4LpSy3WWCxjkdH
 wS7iXFsgd9B0qiiwV/lhL0/vvWM9Lp/csXiHtKUKV3gaVY/G539oa5lfD1lzNZj3r5CifKkrNMbkm
 blR39B9A==;
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lalap-00Fahn-5g
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 20:43:04 +0000
Received: by mail-pf1-f175.google.com with SMTP id g16so2931408pfq.5
 for <linux-nvme@lists.infradead.org>; Sun, 25 Apr 2021 13:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sQEBtvQIiwMUyXs4QG1unv0E1sFViEnCAqrsWxCtU+g=;
 b=fXRJGj1nnfmM/zr5XUkk5so0RyDFnxSCm00W2D0OJmi5j7sDNWzwN0UkExxu2zmxvt
 Wm9MJuHAsO/eSJuBZJTRTW1loO6MmGRIj/1UnCtEd6G8YIUOElDAvnmy03M5TQcfppAn
 5nqqYSx7FtbycbkoFHOY8RNNQvzGMFB7mkdB03AAGMU8iw8a8sLU8S/EVFrnrBzQb15C
 Mk+i0d9Gx8yZZY3E7y4eNDk5nMdvUbCicl5V3OHVa9EgpN1wCnz8PoVUcl2bUnpkG8lA
 7IoPeYnpIHK1cMMWkKlGM42RB8lFXmdYrzLKjCD/k8e7Zrv7+aChpqPD+Yt8ewXI/Cct
 LaxA==
X-Gm-Message-State: AOAM532Iz8FvfsPGiMyZpr+Ush2c/EPi6A2R3uKjYWL0JKhBekv1Kw6o
 5DBHwY799BIO7ZH2/y5fOoQXZCTUMIJY4g==
X-Google-Smtp-Source: ABdhPJyGCX1V73odUcSv4Vn0yEldUPFkSigSfvsOAnWlvGKx/7xu0JVHelSbPHU4PfV2e+fCapwsCA==
X-Received: by 2002:a63:2445:: with SMTP id k66mr13791516pgk.62.1619383381997; 
 Sun, 25 Apr 2021 13:43:01 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id a185sm9417917pfd.70.2021.04.25.13.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Apr 2021 13:43:01 -0700 (PDT)
Subject: Re: [PATCH 8/8] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
To: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
 <20210425085753.2617424-9-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <d3493eef-ff45-23a8-f12a-b7246ba9f3a2@acm.org>
Date: Sun, 25 Apr 2021 13:42:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210425085753.2617424-9-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_134303_247670_916D2D1A 
X-CRM114-Status: GOOD (  12.93  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/25/21 1:57 AM, Ming Lei wrote:
> +	spin_lock_irqsave(&drv_tags->lock, flags);
> +	list_for_each_entry(page, &tags->page_list, lru) {
> +		unsigned long start = (unsigned long)page_address(page);
> +		unsigned long end = start + order_to_size(page->private);
> +		int i;
> +
> +		for (i = 0; i < set->queue_depth; i++) {
> +			struct request *rq = drv_tags->rqs[i];
> +			unsigned long rq_addr = (unsigned long)rq;
> +
> +			if (rq_addr >= start && rq_addr < end) {
> +				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
> +				cmpxchg(&drv_tags->rqs[i], rq, NULL);
> +			}
> +		}
> +	}
> +	spin_unlock_irqrestore(&drv_tags->lock, flags);

Using cmpxchg() on set->tags[] is only safe if all other set->tags[]
accesses are changed into WRITE_ONCE() or READ_ONCE().

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
