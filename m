Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FF1C43461
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 17:54:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF51206A5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 17:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JZTF2Vtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF51206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qn/I5ZwNguKlrgeO1wV7Sab8Dy8Vl9TvPwQCg5eseH0=; b=JZTF2VtmfPhehrUMcfb8XjQB9
	zE2//Iyt0VkOl/mr/YzjUDIEvpO2mBOGU0mzlGXeRPLC8Qm26YsPn0Uar57cqTUhPsfcObJbIJkBD
	VsC9hWIhV1fUaq+PTTscbcJ2LNd1bqMUpAFZU1GUQghVdnhPgNfbilEKV68W/JzJFCf59yMsnSJMd
	AdXAID/+KvkzOUGjTVyr+45wnusWjKE7ARMW7qrHp3xMNnAtXfsZzHA8wcDcj62++rObfsQcWuUN3
	F3Ec/qmh8uB4kaFHqAKOVkGgwVGhvlSqpJcPjnEPZ8Nqqm8mi4BYxvtkZfsc3OJBlibfCccYjUDvE
	rZkKm0rAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFhp0-0001ZH-Nd; Tue, 08 Sep 2020 17:54:22 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFhox-0001YL-Ia
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 17:54:20 +0000
Received: by mail-pf1-f193.google.com with SMTP id x123so1464469pfc.7
 for <linux-nvme@lists.infradead.org>; Tue, 08 Sep 2020 10:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=cBTvIhJcHXVYn/Psbin1MuPoVps99Y51xyc6PCUNeBs=;
 b=Ii9M7mF09sUzMjYpT302oNPSil55CVLzCh0o1UOYE8sG1yCOgMb0Pqa2F32r86J5FT
 09QfT3XuEfgJY54zzfZnmLObQe53xkLiMoPtOIXo9OTY56nelcwAZQeKwGSAopQCn5Ef
 LRxs7FoBCw6dFSttUpNlyc5Q28cULNFyEqjJpfwHBGqttdc9VPiP5fROeqGXP6Y7xDUp
 me4S2EdXGWzuvQy0vI38AUwiAVOzDzJ2fpIHwIRbABi3TRFyHkeuLGtFquaYV48aDhy/
 WFnkgQY/xnHqdJlcSqYokHofF+9HR2u0kpdJUXhco7UYxYHIaxZwooEEwb7yN6uEdfOg
 eWBg==
X-Gm-Message-State: AOAM530mAzVhHAEJafhfkha98HETSLtA4DHW3sIvnG0RdMYNGtdGuMpi
 EHmSHBKbsKWId4lRU6C9u+U=
X-Google-Smtp-Source: ABdhPJzQ5uDDhvKRVEsDZ0KdoJBATv/6i6yPhqxvJhpfUJDybvOcwxCT8S6xUIxR+zI+43JOJhT+NA==
X-Received: by 2002:a63:a54a:: with SMTP id r10mr21415495pgu.5.1599587656769; 
 Tue, 08 Sep 2020 10:54:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:fb09:e536:da63:a7cd?
 ([2601:647:4000:d7:fb09:e536:da63:a7cd])
 by smtp.gmail.com with ESMTPSA id j19sm88376pfi.51.2020.09.08.10.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 10:54:16 -0700 (PDT)
Subject: Re: [PATCH V3 1/4] blk-mq: serialize queue quiesce and unquiesce by
 mutex
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200908081538.1434936-1-ming.lei@redhat.com>
 <20200908081538.1434936-2-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <8e040e37-d1df-ea5f-8a63-f4067d092b72@acm.org>
Date: Tue, 8 Sep 2020 10:54:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908081538.1434936-2-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_135419_640306_92474783 
X-CRM114-Status: GOOD (  14.64  )
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
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-09-08 01:15, Ming Lei wrote:
>  void blk_mq_unquiesce_queue(struct request_queue *q)
>  {
> +	mutex_lock(&q->mq_quiesce_lock);
> +
>  	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>  
>  	/* dispatch requests which are inserted during quiescing */
>  	blk_mq_run_hw_queues(q, true);
> +
> +	mutex_unlock(&q->mq_quiesce_lock);
>  }
Has the sunvdc driver been retested? It calls blk_mq_unquiesce_queue()
with a spinlock held. As you know calling mutex_lock() while holding a
spinlock is not allowed.

There may be other drivers than the sunvdc driver that do this.

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
