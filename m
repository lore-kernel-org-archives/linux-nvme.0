Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580B4C433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 18:55:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C92600D4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 18:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C92600D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j8NQRV6fmNDEILel7BtOD0NJt6DdJE8byEYh6gLC+UE=; b=cinbnlNK4TBiPdNiitG/GW66g
	v0N7yGwCfYLDyEMyrNTTGWxlz0vVgtF5hMJGk/ZyItqKK3Ad/dDe4Ywb7paYMEWoRIPwOSO3eLK6s
	riFU9bVKHQSUhk3fGRA1pPLLAPAqGCSKw3UcZqL57pmvehuETA7IW3rcbkaxKby/BkKayLSPNo7Z7
	eiaI2WgseBIWNLeOgRqr8UswUlglqajPdJUr4jhu7Bwz5ReSHdfyYRJy0BmbhtvbhUwdLeGmjOcPm
	IKIAovBVbHVMo2WOqjQzWfw9Q1t7sbfwMjyEM0orF3q7xrZQ2djtzSybtc2KawJVWISQkEjNDuacD
	F8Sb70mPQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lajuk-0067JY-N3; Sun, 25 Apr 2021 18:55:31 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lajuj-0067JM-9G
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 18:55:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=PrEQc4IIoTHTsXOxriMgvj46cgYHAhsoAI5ytNJc5R4=; b=M8ycoxOaTV0pmnZAq5LRrznulM
 n2tqUXHEh1QEaFSrNDHRJ4UlEiaH8I5cCTbe8qUHGYKqn02ufnBnm9owxwVLaFYb/RmCrWZOdkzGm
 nKBs4xsUQNrP9LtYryqpU/InfnCPaHgYDvoPSSQyQzqI29GD/k1jrMrb345dvvh6uKLUENEABE9Ei
 RpyAZhdstKHBOBIw1lkvU+cKCsuwtlaF78bG1u6EcrXcZNQEJr52+B0x4SbNSqyMOiKnRPy0pUtLt
 Glp00EuVrKmYPbdx+jGJNKfjnmx14Z89Tw6N7QqN5wDNNUendNZF7J/+IQqeAj1zQQCaOX7KUkA3c
 hnJCHtvA==;
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lajuf-00FYYU-UK
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 18:55:27 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 gq23-20020a17090b1057b0290151869af68bso3874309pjb.4
 for <linux-nvme@lists.infradead.org>; Sun, 25 Apr 2021 11:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PrEQc4IIoTHTsXOxriMgvj46cgYHAhsoAI5ytNJc5R4=;
 b=VzklabAaUaZ+3pIZujbqlcSRE2YUSx80FhqCwplfX6AjFATJYF2h7oosiC/XphhusG
 +Iuj2xV0oLA6ZcZZ88wKVdScEPzfTFwc8ugoQd1AK4q9tZ2EAihhL/4VDwwmeJ1kAjIw
 /woLbnRlOdfVRT1pe3yGsjSKGmPZB8vQ08hpLPnnKFktSeb9rZzmxLJehUbCt5gT722b
 IUjGyLegbO8Q2UqQnbK+PW0aerhI6A32p9nuH3PvxGQvneT3S8eMPUpviQBS/PzdIqwK
 ysjsehM8z2eEeIzqOJonLXA34wx8kaQMEdy2WhU/yDlpq4965WSqjYx/1gIRZ7034ymJ
 fkqg==
X-Gm-Message-State: AOAM532BeI0XT8Kpb70r9yhuzbIKh3//FXJsqaIjz28iOEbdplKcA5s5
 r//MUWNQ2VSMakZc0VToOSM=
X-Google-Smtp-Source: ABdhPJx8/WSToc67TMnXO8iikYMeuXON9nfP7Eb1TbQajzj1IzVb8lj6kC2XcAWVjo+i6QdE2bsuCA==
X-Received: by 2002:a17:90a:77c8:: with SMTP id
 e8mr18468910pjs.69.1619376924853; 
 Sun, 25 Apr 2021 11:55:24 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id c26sm9272436pfo.67.2021.04.25.11.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Apr 2021 11:55:24 -0700 (PDT)
Subject: Re: [PATCH 7/8] blk-mq: grab rq->refcount before calling ->fn in
 blk_mq_tagset_busy_iter
To: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
 <20210425085753.2617424-8-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <6c0b0af9-ca71-d143-b1cc-384adfca5438@acm.org>
Date: Sun, 25 Apr 2021 11:55:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210425085753.2617424-8-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_115526_015574_219E6270 
X-CRM114-Status: GOOD (  16.72  )
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
> However, still one request UAF not covered: refcount_inc_not_zero() may
> read one freed request, and it will be handled in next patch.

This means that patch "blk-mq: clear stale request in tags->rq[] before
freeing one request pool" should come before this patch.

> @@ -276,12 +277,15 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  		rq = tags->static_rqs[bitnr];
>  	else
>  		rq = tags->rqs[bitnr];
> -	if (!rq)
> +	if (!rq || !refcount_inc_not_zero(&rq->ref))
>  		return true;
>  	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
>  	    !blk_mq_request_started(rq))
> -		return true;
> -	return iter_data->fn(rq, iter_data->data, reserved);
> +		ret = true;
> +	else
> +		ret = iter_data->fn(rq, iter_data->data, reserved);
> +	blk_mq_put_rq_ref(rq);
> +	return ret;
>  }

Even if patches 7/8 and 8/8 would be reordered, the above code
introduces a new use-after-free, a use-after-free that is much worse
than the UAF in kernel v5.11. The following sequence can be triggered by
the above code:
* bt_tags_iter() reads tags->rqs[bitnr] and stores the request pointer
in the 'rq' variable.
* Request 'rq' completes, tags->rqs[bitnr] is cleared and the memory
that backs that request is freed.
* The memory that backs 'rq' is used for another purpose and the request
reference count becomes nonzero.
* bt_tags_iter() increments the request reference count and thereby
corrupts memory.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
