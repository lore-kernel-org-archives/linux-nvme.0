Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7115C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 00:54:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9256420A8B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 00:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iPQmUFxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9256420A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kfBpuGcaICw3EOaHCONVZK5rn0bjRJbdxHVQe6SYLu4=; b=iPQmUFxZAR4/cECG9Xl41yZfb
	qj6HXSdhMryuASrVZxw4mL4O1Oc0N6mp20IFj66+ce026bWCB1sNA8QKibWPyA2I8WggLGdZYwLd2
	RxJnZlV1xdKdGe9IPV2MrQR6qgkk2WiRk0J5wNXtyWZ8dw8rdRQoUbn0ob5JBsaXK+sU+wB8pU8dK
	U6ExuQ9VLdVIfSSFwlYUwi31y1hMWwf0wsMy/KYgeDocJv9k4QzOdyVGjTRHZHyDlUwXSgKR7ZEgL
	MHxDbFnHPTMm24lDzBNmgeFa449Jkv9avI6PPWxKOJlldGe5YhIzdqQEP2y+Op5daJ/JCw77YIv3A
	zDiNVfZvQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Dss-00015n-PZ; Tue, 28 Jul 2020 00:54:22 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Dsp-00015M-Ug
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 00:54:21 +0000
Received: by mail-wm1-f65.google.com with SMTP id k8so6144409wma.2
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 17:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u1gkGeFetF3rGlY8qaDx45rMkpu77Cqvm7xU95VZwvg=;
 b=qmHgNGeyldw98goto5Lcd7C+QbNgGNhvVq+7RtV97RLp1Y9P5DO5+SnXipHXiIPSt1
 9Za/IPHKRx3neB/MC5oE1ldOhF4/+tizU/yDHC3wGlbQ+w5tvBsvuzugsCgJ1+SzHC5y
 P3z1hRDHsEc5oM2Cpoy0J1RRggK1qwWH2qiR14m3rSz+h9kb9Xfuo6Gm5D3DHYaLnIl1
 G2rxr+Feg43WyKuxxbC8y1jIhhSk2/eD0NAVHwDmGtwQR4SLyWO4i36Xy8whLh0Z5Yej
 YzA6piME0ePqCL1Tart2UDx9wB8+UA8evwuljqFTEio1ArmzwAAtCpLn4EmMeQRiG3lC
 eIwA==
X-Gm-Message-State: AOAM530THgQ5CUujgwBP1ZerlUjtwvAHWIWAZWsO8xzJLlA/K04AGRWP
 AKlcwidgY3DnAZctI7mDk+U6cGm2
X-Google-Smtp-Source: ABdhPJyqlT5/XpeujbzEqr4rTTyCXKfrzmjXsJxZWao90G/LQ4HFBP9GBDeN4iiyY1+usdLm4YDADw==
X-Received: by 2002:a1c:9a07:: with SMTP id c7mr1563152wme.147.1595897657677; 
 Mon, 27 Jul 2020 17:54:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id s14sm14032320wrv.24.2020.07.27.17.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 17:54:17 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] nvme: use blk_mq_[un]quiesce_tagset
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-3-sagi@grimberg.me>
Message-ID: <56517f9c-2d4e-0fee-52d6-20ef9be54bc0@grimberg.me>
Date: Mon, 27 Jul 2020 17:54:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727231022.307602-3-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_205420_014349_C5141AA7 
X-CRM114-Status: GOOD (  22.63  )
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
Cc: linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
 Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 7/27/20 4:10 PM, Sagi Grimberg wrote:
> All controller namespaces share the same tagset, so we
> can use this interface which does the optimal operation
> for parallel quiesce based on the tagset type (e.g.
> blocking tagsets and non-blocking tagsets).
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 05aa568a60af..c41df20996d7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4557,23 +4557,13 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>   
>   void nvme_stop_queues(struct nvme_ctrl *ctrl)
>   {
> -	struct nvme_ns *ns;
> -
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		blk_mq_quiesce_queue(ns->queue);
> -	up_read(&ctrl->namespaces_rwsem);
> +	blk_mq_quiesce_tagset(ctrl->tagset);

Rrr.. this one is slightly annoying. We have the connect_q in
fabrics that we use to issue the connect command which is now
quiesced too...

If we will use this interface, we can unquiesce it right away,
but that seems kinda backwards...

--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af..70af0ff63e7f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4557,23 +4557,15 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);

  void nvme_stop_queues(struct nvme_ctrl *ctrl)
  {
-       struct nvme_ns *ns;
-
-       down_read(&ctrl->namespaces_rwsem);
-       list_for_each_entry(ns, &ctrl->namespaces, list)
-               blk_mq_quiesce_queue(ns->queue);
-       up_read(&ctrl->namespaces_rwsem);
+       blk_mq_quiesce_tagset(ctrl->tagset);
+       if (ctrl->connect_q)
+               blk_mq_unquiesce_queue(ctrl->connect_q);
  }
  EXPORT_SYMBOL_GPL(nvme_stop_queues);
--

Thoughts?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
