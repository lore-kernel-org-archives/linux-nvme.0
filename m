Return-Path: <SRS0=XP6N=CS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FAAC433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 20:53:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73D320768
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 20:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P3OAqN6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73D320768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OeJ1/HI388+e9Q26MseXMHaQupy7OoKPfpXo1NAFc9c=; b=P3OAqN6eoc5QcFvxelqZR04mb
	E5iVmDLTtTUS4SDapzCERiUr/0qo8TqEPMYDk8u/EPvlOjeYWpG5K3TzvEIoMcSUWaeKaeXkYLkVF
	L/986fRjI1n+1tmtohbdnWcZygA/8CmPq7fgd9XN6IEBvwJxPmOu/HhM1Wng9iSMZwN2ljw5QB9XR
	03z1DdSwJmwb/2H7TdjYLMdHmohthCDW9lqftLOBY7LszAatlILTm1PrZoC32ASI0oBa2LWdAUvXW
	JY1xc4USkLhES5MXEZ4QzCKz7u6wsgG3s66EAYDYdCbGBNhP41BOvHJy1gUG+kOZv1aXo3AWrI5xK
	Ci3ukCgzw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kG763-0001yC-8s; Wed, 09 Sep 2020 20:53:39 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG760-0001wg-Lg
 for linux-nvme@lists.infradead.org; Wed, 09 Sep 2020 20:53:37 +0000
Received: by mail-pf1-f195.google.com with SMTP id o20so3211265pfp.11
 for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2020 13:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8ScU0r+gXwX86iZJWxxwUa2WSn8lrc4iNy9X+IZrvWE=;
 b=f2JihEAJAmpzCI6G+m801G9btg9sBlGagkah8vUQtJG+b1u8Mn9JDQSA39cEPoVnc3
 zegqQMxvVi/FIHmchoE0aBVhEqK21TOLyKFooPVMOKlPInkZ19jfF27x8lW+PJYpvP/X
 ccPEgzaFDRjMqpFnzRm7ekrRptvF7l/9VWJ3i855X/5LKM7n/Jt5GffpAAwVZPIwmxr0
 tcsilgOCwIIYp1ZR4bYvxpu7mZs7b0A5xE5xGjKibVPwro56wZRnOkSxhPWTjzsks2Xk
 pUFx/bBkYVC7VqoFjSvPfN+UGDEiudhd9DU6vKjq5Oe0v1bJRwJrir4K4x2Q+rHes7nd
 JmQA==
X-Gm-Message-State: AOAM5318Io3PqSxTTV1UGc8KVREnQM3nIOvyFtyEswCPqGu1m+4qPtPY
 2VDMYvEG2MSXsfgsJfxrVx8=
X-Google-Smtp-Source: ABdhPJxknxzrUZz+JsVrvs8r5KVsMgkBl0lLFEQip7Npd4GkgYxJqjD0FHImdhYtZaEBEUv6fAOASw==
X-Received: by 2002:a63:5663:: with SMTP id g35mr1943565pgm.163.1599684812840; 
 Wed, 09 Sep 2020 13:53:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5905:3209:6aa:d817?
 ([2601:647:4802:9070:5905:3209:6aa:d817])
 by smtp.gmail.com with ESMTPSA id u2sm108640pji.50.2020.09.09.13.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 13:53:32 -0700 (PDT)
Subject: Re: [PATCH V4 2/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
References: <20200909104116.1674592-1-ming.lei@redhat.com>
 <20200909104116.1674592-3-ming.lei@redhat.com>
 <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dae73b2c-c191-c8a6-4287-838ab4962467@grimberg.me>
Date: Wed, 9 Sep 2020 13:53:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200909_165336_919402_25254274 
X-CRM114-Status: GOOD (  15.34  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>   void blk_mq_quiesce_queue(struct request_queue *q)
>>   {
>> -	struct blk_mq_hw_ctx *hctx;
>> -	unsigned int i;
>> -	bool rcu = false;
>> +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
>> +	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
>>   
>> -	__blk_mq_quiesce_queue_nowait(q);
>> +	if (!was_quiesced && blocking)
>> +		percpu_ref_kill(&q->dispatch_counter);
>>   
>> -	queue_for_each_hw_ctx(q, hctx, i) {
>> -		if (hctx->flags & BLK_MQ_F_BLOCKING)
>> -			synchronize_srcu(hctx->srcu);
>> -		else
>> -			rcu = true;
>> -	}
>> -	if (rcu)
>> +	if (blocking)
>> +		wait_event(q->mq_quiesce_wq,
>> +				percpu_ref_is_zero(&q->dispatch_counter));
>> +	else
>>   		synchronize_rcu();
>>   }
> 
> In the previous version, you had ensured no thread can unquiesce a queue
> while another is waiting for quiescence. Now that the locking is gone,
> a thread could unquiesce the queue before percpu_ref reaches zero, so
> the wait_event() may never complete on the resurrected percpu_ref.

Yea, where did that go?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
