Return-Path: <SRS0=ElFx=C5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D08C43466
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2020 08:28:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A462084C
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2020 08:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UeFS9w88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A462084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=1AsfEU69O3JC9sBBFCYF/MdPsqnbViHClUvTMVzJvt0=; b=UeFS9w88S/e/jlHMlWnBdZ3Pt
	CW/91sFo9s52UvRmXi0zv5T4HCCvmdEi/gGMCRa36sO4tcD52pkkevx1FwwY/FYyeiUxuTNV4r8qG
	Om6vV9C7aKdJukezjbOluYBSZKnXD2OkJrGfd5lVfqVknGHTWjUJjaxIiXPixMPrQGLxYxH9Um9MI
	w93tyBpgPDtnUIyIxF7eiqvb0OUcDnV6OK4NRgAFJlJQh+HqMvgKBKOyEqgknhNwYwmEv8isfV5nD
	hLfzWV0liEcRS1YJ6D+y6DvcHxn7oSNth3hACR5m8wl10uENeRuc/7qUDpLS2cXvorib6DnelHdtn
	tCjkYoV4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJuhO-0002F5-5f; Sun, 20 Sep 2020 08:27:54 +0000
Received: from smtp.h3c.com ([60.191.123.50] helo=h3cspam02-ex.h3c.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJuhF-0002DK-S3
 for linux-nvme@lists.infradead.org; Sun, 20 Sep 2020 08:27:48 +0000
Received: from DAG2EX07-IDC.srv.huawei-3com.com ([10.8.0.70])
 by h3cspam02-ex.h3c.com with ESMTPS id 08K8QiiG013053
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 20 Sep 2020 16:26:44 +0800 (GMT-8)
 (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 20 Sep 2020 16:26:47 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.1713.004; Sun, 20 Sep 2020 16:26:46 +0800
From: Tianxianting <tian.xianting@h3c.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH] [v2] nvme: use correct upper limit for tag in
 nvme_handle_cqe()
Thread-Topic: [PATCH] [v2] nvme: use correct upper limit for tag in
 nvme_handle_cqe()
Thread-Index: AQHWjamkvjMzTC+ou0aptn5bKR4hY6luQCAAgAEKLTCAAd/R8A==
Date: Sun, 20 Sep 2020 08:26:46 +0000
Message-ID: <4e8aec9ebe8a4b8792632e71cb4a0e65@h3c.com>
References: <20200918104420.30219-1-tian.xianting@h3c.com>
 <20200918192034.GA4030837@dhcp-10-100-145-180.wdl.wdc.com> 
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 08K8QiiG013053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200920_042746_883204_484EE4E3 
X-CRM114-Status: GOOD (  13.88  )
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

Hi,
I test and get the init flow of nvme admin queue and io queue in kernel 5.6,
Currently, the code use nvmeq->q_depth as the upper limit for tag in nvme_handle_cqe(), according to below init flow, we already have the race currently.

Admin queue init flow:
1, set nvmeq->q_depth 32 for admin queue;
2, register irq handler(nvme_irq) for admin queue 0;
3, set admin_tagset.queue_depth to 30 and alloc rqs;
4, nvme irq happen on admin queue;

IO queue init flow:
1, set nvmeq->q_depth 1024 for io queue 1~16;
2, register irq handler(nvme_irq) for io queue 1~16;
3, set tagset.queue_depth to 1023 and alloc rqs;
4, nvme irq happen on io queue;

So we have two issues need to fix:
1, register interrupt handler(nvme_irq) after tagset init(step 3 above) done to avoid a race;
2, use correct upper limit(queue_depth in tagset) for tag in nvme_handle_cqe(), which is the issue that will be solved in this patch I submitted.

Is it right? Thanks a lot.

-----Original Message-----
From: tianxianting (RD) 
Sent: Saturday, September 19, 2020 11:15 AM
To: 'Keith Busch' <kbusch@kernel.org>
Cc: axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Subject: RE: [PATCH] [v2] nvme: use correct upper limit for tag in nvme_handle_cqe()

Hi Keith,
Thanks a lot for your comments,
I will try to figure out a safe fix for this issue, then for you review:) 

-----Original Message-----
From: Keith Busch [mailto:kbusch@kernel.org] 
Sent: Saturday, September 19, 2020 3:21 AM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] nvme: use correct upper limit for tag in nvme_handle_cqe()

On Fri, Sep 18, 2020 at 06:44:20PM +0800, Xianting Tian wrote:
> @@ -940,7 +940,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	struct nvme_completion *cqe = &nvmeq->cqes[idx];
>  	struct request *req;
>  
> -	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
> +	if (unlikely(cqe->command_id >=
> +			nvmeq->qid ? nvmeq->dev->tagset.queue_depth :
> +			nvmeq->dev->admin_tagset.queue_depth)) {

Both of these values are set before blk_mq_alloc_tag_set(), so you still have a race. The interrupt handler probably just shouldn't be registered with the queue before the tagset is initialized since there can't be any work for the handler to do before that happens anyway.

The controller is definitely broken, though, and will lead to unavoidable corruption if it's really behaving this way.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
