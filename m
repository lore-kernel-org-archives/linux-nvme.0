Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF53C43465
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 15:50:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D578D221EC
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 15:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WNGhO2y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D578D221EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=18T9+36V3+V57+e83whn1JrGfKjvVGXDe3YCb/NL9tE=; b=WNGhO2y0HQrviACSJVTzZitew
	NXyKD5Sdv60RP+yRDObIqVSS5eSk68xEvyAvnNJBk7F0M0m0L2h+SwFKyfpntBC1t61fXioohJJ1M
	WF9lVXi61lyAPV0P557t2ZB0qkXCW2O00mFwf6shzfE1EvLmzPrY9TzxcBjhSnqm8j2kvfCVN4ABG
	mTK13jL7hmChUyrIWQCL4VkCMxU264UCAq7NcpKgFmyG0te7VNysy/VL09Do7aOQocrpj+Jd++MvQ
	/n2rDmS9c1nOBS0iOZJG4yHW/RkCottyQcRYyBqXKzBheLHdRKiJVPcU5mvvopQPkdZwH7IQXxvND
	XTBvWkO+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKO5C-00050v-Pq; Mon, 21 Sep 2020 15:50:26 +0000
Received: from smtp.h3c.com ([60.191.123.50] helo=h3cspam02-ex.h3c.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKO55-0004wG-Q7
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 15:50:24 +0000
Received: from DAG2EX07-IDC.srv.huawei-3com.com ([10.8.0.70])
 by h3cspam02-ex.h3c.com with ESMTPS id 08LFn5r7084222
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Sep 2020 23:49:05 +0800 (GMT-8)
 (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Sep 2020 23:49:09 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.1713.004; Mon, 21 Sep 2020 23:49:09 +0800
From: Tianxianting <tian.xianting@h3c.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH] nvme: replace meaningless judgement by checking whether
 req is null
Thread-Topic: [PATCH] nvme: replace meaningless judgement by checking whether
 req is null
Thread-Index: AQHWj71pi81Rb9ZmlEuvVhznKWqiEqlyrIIAgACJanA=
Date: Mon, 21 Sep 2020 15:49:09 +0000
Message-ID: <be133ab59334475dacd4a52a2834fe71@h3c.com>
References: <20200921021052.10462-1-tian.xianting@h3c.com>
 <20200921150824.GA4034182@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200921150824.GA4034182@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 08LFn5r7084222
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_115022_069407_413039BF 
X-CRM114-Status: GOOD (  15.17  )
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
Cc: "axboe@fb.com" <axboe@fb.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

HI Keith,
Thanks for your comments,
I will submit a new patch of version 2 for the further reviewing,  v2 patch will contains:
1, retain existing judgement and dev_warn;
2, add the check whether req is null(already did in this patch)
3, simplify and make the changelog succinct according to you said " This is what I'm thinking:".
Is it right?
Should I retain the nvme_irq crash log in changelog, mention the difference between nvmeq->q_depth and tagset queue_depth? 

Thanks

-----Original Message-----
From: Keith Busch [mailto:kbusch@kernel.org] 
Sent: Monday, September 21, 2020 11:08 PM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: replace meaningless judgement by checking whether req is null

On Mon, Sep 21, 2020 at 10:10:52AM +0800, Xianting Tian wrote:
> @@ -940,13 +940,6 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	struct nvme_completion *cqe = &nvmeq->cqes[idx];
>  	struct request *req;
>  
> -	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
> -		dev_warn(nvmeq->dev->ctrl.device,
> -			"invalid id %d completed on queue %d\n",
> -			cqe->command_id, le16_to_cpu(cqe->sq_id));
> -		return;
> -	}
> -
>  	/*
>  	 * AEN requests are special as they don't time out and can
>  	 * survive any kind of queue freeze and often don't respond to @@ 
> -960,6 +953,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	}
>  
>  	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
> +	if (unlikely(!req)) {
> +		dev_warn(nvmeq->dev->ctrl.device,
> +			"req is null for tag %d completed on queue %d\n",
> +			cqe->command_id, le16_to_cpu(cqe->sq_id));
> +		return;
> +	}

This is making sense now, though I think we should retain the existing
dev_warn() since it's still accurate and provides continuity for people who are used to looking for these sorts of messages.

Your changelog is a bit much though. I think we can say it a bit more succinctly. This is what I'm thinking:

  The driver registers interrupts for queues before initializing the
  tagset because it uses the number of successful request_irq() calls
  to configure the tagset parameters. This allows a race condition with
  the current tag validity check if the controller happens to produce
  an interrupt with a corrupted CQE before the tagset is initialized.

  Replace the driver's indirect tag check with the one already provided
  by the block layer.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
