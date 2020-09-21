Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44BAC43463
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 02:27:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155AE2078E
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 02:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XeEA67E6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155AE2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gFv18PXVRIooMq5bQZx0+i4fIDRBTX1XDwLHP5Uf/TE=; b=XeEA67E6tcB33CbxTDAJZ1gl8
	52Rigde5clh2ovUt3ucZ18efCM9Jm7QtdNkRXnuEC2iGPEKgdj9GU+LNPDiYOouoyzEhkcOqPIO3P
	cPDtF9j4q7WKKLC2C9e0oyFjV/POg1OM7dtsK/8zEhtfFw2bmrKqumW4O4TxEaS83ygPPeYSb27Rv
	LxI+rwJW5PeUl/7E/3PJiA0lfFjviE9/TOqdO5VBrUPxfbM/vBAAN2yOUB1QlWEjZltwWuoLRjZH2
	TZtIX+CTy9y6CesBjOyWIg5kZyv0JxYVXyzn4Sqx8TuZcu9mVla4VUVe7UBOnRqq0wEzyxLdyEZL8
	E5p8vHZNg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKBYE-0000Kw-Po; Mon, 21 Sep 2020 02:27:34 +0000
Received: from smtp.h3c.com ([60.191.123.56] helo=h3cspam01-ex.h3c.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKBYB-0000JG-NF
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 02:27:33 +0000
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([10.8.0.73])
 by h3cspam01-ex.h3c.com with ESMTPS id 08L2QjpK039265
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Sep 2020 10:26:45 +0800 (GMT-8)
 (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Sep 2020 10:26:46 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.1713.004; Mon, 21 Sep 2020 10:26:46 +0800
From: Tianxianting <tian.xianting@h3c.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH] [v2] nvme: use correct upper limit for tag in
 nvme_handle_cqe()
Thread-Topic: [PATCH] [v2] nvme: use correct upper limit for tag in
 nvme_handle_cqe()
Thread-Index: AQHWjamkvjMzTC+ou0aptn5bKR4hY6luQCAAgAEKLTCAAxV5EA==
Date: Mon, 21 Sep 2020 02:26:46 +0000
Message-ID: <1f0a3015fd6f40e792a15486f34491c7@h3c.com>
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
X-MAIL: h3cspam01-ex.h3c.com 08L2QjpK039265
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200920_222732_232066_B2C44595 
X-CRM114-Status: GOOD (  15.08  )
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

Hi Keith,
I found an extreme case, 
in function blk_mq_alloc_map_and_requests(), it will adjust tagset depth by 'set->queue_depth >>= 1' if there is no enough memory for rqs. 
If this happens, the real available number of tags(nr_tags) is much smaller than nvmeq->q_depth.
So the judgement "if (unlikely(cqe->command_id >= nvmeq->q_depth))" in nvme_handle_cqe() is really
meaningless.

I figured out a new patch, which replaces the meaningless judgement by checking whether the returned
req is null, if it is null, directly return.

Would you please spare several minutes to review below new patch? thanks
https://lkml.org/lkml/2020/9/20/400

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
