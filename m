Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDA8C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 21:30:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9903A2075D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 21:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="evBCMQrT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gumY9iKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9903A2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=scuMHI+DjP5YgxV+S4UoVJDMHVGAG2/JeJimmiQ0kyc=; b=evBCMQrTiqNLiEnis2roEwqeW
	ColaZJoRMm0RULVw50mJqiBt2dEpGxY6OOIChQ5IX57EiKH9heWUg4o4xQjE71QIIxfrcFZcXniPw
	l2MzP5cn9Y99uPKC15bLV+Ij4QNgGVTRs+TVb0FJJTRWBkV5ZWk3uKIskRKCml90mlM3dR6GYolXy
	MRCg87xuKUJf8m4VzEKASs5p+5qClrF+wLb1yhG2XzLky8EnTEXx8iduBVupYOk0tNJRU3Bbj5Qg5
	gLy7pWg7JaKTXudaBCjU7dtANC6VqOm0UpU5044DZy85rAPOGIV7pchbdm2tFY8eNhgfjF9K4Lyuc
	Rt3tZscwQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Ahh-0001Mz-PS; Mon, 27 Jul 2020 21:30:37 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Ahf-0001MP-0w
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 21:30:35 +0000
Received: by mail-pg1-x541.google.com with SMTP id n5so10689160pgf.7
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/Yi3V338uN2DHFSxpTCjmg82EGkr6UhtwNTzyF98WoM=;
 b=gumY9iKTo/cv7/WJEH5V6VG0+qO+ubyHBAYlM1bmQSCCktkobPj6yEcZw/sz3tHwdt
 JIOJ/gyYT8SBLguVXAEOyyCGqUO/44sKv2hPdpEPzNix7EMmokX5/ZLs95jTZDwLuIwi
 MLOCONAREQ4LFocb1aVN7mNYoNLAvYXjfkXF+mXiVhI5/WXgSzC5z9N+uaBEE7c7EAt9
 WCN5em9/MNvz0wa9+GB1OfsHRR2tK43/nqLq2bfS/2S2rLwR68D0FXYujkZWc1KO3cv8
 tdTE0B8kduHsj1xrSnyY3okou71u3TamIq1q0gEB4ZBk5rTo3hHFHd6S4izKiuuWFDHn
 NLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Yi3V338uN2DHFSxpTCjmg82EGkr6UhtwNTzyF98WoM=;
 b=uISa7n3x28QCwIpolw7wQpGbxeiFVKf5/CH16yNjnoefdVPaQvp/uusoNzcYxV5qc/
 jz3eIn4DQOzs40lj4PaamOQKPvSNLOygUrJ7CEqieTN9u0jJHNF1ssqJZkhGFdoO6itZ
 1cVbl+LnylucbuJ+OwLlrJcfh9WBdCqR/jhu+V3YmjIBr/irgYoAPCf/ipUVAPhLEXup
 JAkzw8OZhMdPhZ0xUQ4dHclKcPA3shXpToYrwSj0U3T/w6UbFSeLWODQR3qtGdkIX6wV
 KUG1srSVHERJYLPreyKbhXsw+j2T0Ywu46KmBkmvJnkt/b4GwJtQtbDJUr4e5bS25BLP
 zwoA==
X-Gm-Message-State: AOAM532ktOvu//p0mz05vKi2X02ghPDHUnGZrYOTakEPyIMYGAhOupA+
 IFbb5yChV1HZGYW1m5wN3QF+rA==
X-Google-Smtp-Source: ABdhPJxnXR2P+K0MBF3zXH7c1/69/MgiK6FmzxDzerT6fFfcywUtpm9MzWKAnWo2GACGZWBL9WJ/lw==
X-Received: by 2002:a65:6650:: with SMTP id z16mr22644108pgv.161.1595885432947; 
 Mon, 27 Jul 2020 14:30:32 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id q17sm18307298pfk.0.2020.07.27.14.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 14:30:32 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To: Keith Busch <kbusch@kernel.org>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
 <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
 <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
 <23ad666a-af6a-b110-441e-43ec0f833af4@kernel.dk>
 <20200727212137.GA797661@dhcp-10-100-145-180.wdl.wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b8e79e31-05a8-2238-8aca-d4140d3d4412@kernel.dk>
Date: Mon, 27 Jul 2020 15:30:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727212137.GA797661@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_173035_086334_B4407953 
X-CRM114-Status: GOOD (  21.05  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/27/20 3:21 PM, Keith Busch wrote:
> On Mon, Jul 27, 2020 at 03:05:40PM -0600, Jens Axboe wrote:
>> +void blk_mq_quiesce_queue_wait(struct request_queue *q)
>>  {
>>  	struct blk_mq_hw_ctx *hctx;
>>  	unsigned int i;
>>  	bool rcu = false;
>>  
>> -	blk_mq_quiesce_queue_nowait(q);
>> -
>>  	queue_for_each_hw_ctx(q, hctx, i) {
>>  		if (hctx->flags & BLK_MQ_F_BLOCKING)
>>  			synchronize_srcu(hctx->srcu);
>>  		else
>>  			rcu = true;
>>  	}
>> +
>>  	if (rcu)
>>  		synchronize_rcu();
>>  }
> 
> Either all the hctx's are blocking or none of them are: we don't need to
> iterate the hctx's to see which sync method to use. We can add at the
> very beginning (and get rid of 'bool rcu'):
> 
> 	if (!(q->tag_set->flags & BLK_MQ_F_BLOCKING)) {
> 		synchronize_rcu();
> 		return;
> 	}

Agree, was just copy/pasting the existing code.

> But the issue Sagi is trying to address is quiescing a lot
> request queues sharing a tagset where synchronize_rcu() is too time
> consuming to do repeatedly. He wants to synchrnoize once for the entire
> tagset rather than per-request_queue, so I think he needs an API taking
> a 'struct blk_mq_tag_set' instead of a 'struct request_queue'.

Gotcha, yeah that won't work for multiple queues obviously.

Are all these queues sharing a tag set? If so, yes that seems like the
right abstraction. And the pointer addition is a much better idea than
including a full srcu/rcu struct.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
