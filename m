Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BF7C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 16:37:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB13221744
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 16:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GBU43kzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB13221744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gKH8bndIZyEkdrZx9BLr7mb2Aw3cgUCldG3qD6AqceM=; b=GBU43kzVLoyogPEFiXRtwvvZz
	ur9h2FinnwSuG/Cn8zJw7nhTywX8fxZQzWvh2L2NyPECB71DOKAxLu9JPleRSTDBjYATrkKiEJ65l
	ScVXnmWEEmXfc71NNOybC3pz9y4o9G5b0sSEDp7iol5MZDdKvjBRNIUCO43hqJWKg0viI/tIUNB4f
	vidYE5RDjZ3aJP0WU+i3SxlNGUubqJJHjz8RQaudjThvJLnEbn3VHRtAMF8tPcZ6dNEy31fnLpUJ4
	jIbMzUx2GiLOHtdDG2O/mxpRIACWo5xsuzZBVkHdXHJ5BghGBBMZXJuFlk7lh9ILCDapGLHF7ikRX
	uS+5yLHyA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k45Mx-0006J5-1d; Fri, 07 Aug 2020 16:37:23 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k45Mv-0006Ic-0n
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 16:37:21 +0000
Received: by mail-pj1-f66.google.com with SMTP id c10so6416731pjn.1
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 09:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IGOBihw2RaRydNVMv9yxROPAHrRNnsrTubbIJZmiX8U=;
 b=uQRN865f8VosAuUoiZ/XwXwnqb1aK569kRfbs3cQWLPtiF8SBfqmuuPzNdnKzLxnCj
 BCuxECjAq0ADq67FeNOS2BBiYfimQkVQLbI4PEosQYMQF3VOpGX5Dk+S4WeDbqJE+gpc
 UFdSmk1g+14uVx95Hnf4McvTU+E/NzweaQYvKIaYlRLO1AgZuoGXgX/H49Zb5nZCuOvp
 8r7rPl/okB0WmZ7vPsgQNiFs23JIGNLQux6yC+PJHYRHRZZbTXXrnqIwATZwNGx/R/iR
 RyAQ4mATj5bFNQxDZQGUUIUqh6o9eSkuX+vGe5no9wpAyvlfYFm+mBaS1HlLID8hX8kn
 YyXA==
X-Gm-Message-State: AOAM530I1GHNB0s0QsaqS4JfiQavomHaP69BZRsJvG3b1+z3KBNm2fMH
 d2f4D5/xKHfl5Or3dQFgAjrYtomB5SY=
X-Google-Smtp-Source: ABdhPJwolUnv+/WanlbsWum2u1Pemy3dezf66gK6kzbV1uxvZ/qoLd3mAya3yz/zSaGouUV280Ue5g==
X-Received: by 2002:a17:90a:f2d7:: with SMTP id
 gt23mr14578990pjb.0.1596818239526; 
 Fri, 07 Aug 2020 09:37:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id l63sm11093432pgl.24.2020.08.07.09.37.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 09:37:18 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
To: Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>
References: <20200807090559.29582-1-lengchao@huawei.com>
 <20200807134932.GA2122627@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d3bedf2b-58d5-667c-7f87-6334772a5772@grimberg.me>
Date: Fri, 7 Aug 2020 09:37:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807134932.GA2122627@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_123721_096164_53C45C01 
X-CRM114-Status: GOOD (  15.31  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> nvme_stop_queues quiesce queues for all name spaces, now quiesce one by
>> one, if there is lots of name spaces, sync wait long time(more than 10s).
>> Multipath can not fail over to retry quickly, cause io pause long time.
>> This is not expected.
>> To reduce quiesce time, we introduce async mechanism for sync SRCUs
>> and quiesce queue.
>>
> 
> Frankly speaking, I prefer to replace SRCU with percpu_refcount:
> 
> - percpu_refcount has much less memory footprint than SRCU, so we can simply
> move percpu_refcount into request_queue, instead of adding more bytes
> into each hctx by this patch
> 
> - percpu_ref_get()/percpu_ref_put() isn't slower than srcu_read_lock()/srcu_read_unlock().
> 
> - with percpu_refcount, we can remove 'srcu_idx' from hctx_lock/hctx_unlock()

Ming, I don't have an issue with your preference, but I don't want to
tie it to what Chao is attempting to fix.

So we should either move forward with an srcu approach, or you please
provide evidence to your claims if you are replacing the fast-path
synchronization mechanism, as this warrants a very good justification.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
