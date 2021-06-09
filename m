Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36762C47082
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 00:04:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAED36128E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 00:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAED36128E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YMdROR7tEFAxxy7CTWrd7DxznIkvjjW+JW03NtDc4aI=; b=yqt65+mJaNNMij3DTYctv0kLfJ
	PWcZhqgygb2bSH+mv5Z+fXFzl8hP68O7AdWV0HDVJZk+yVIOb8frbZX0Md/P3Z51kTC5ZnHFUCUOQ
	BFfNPucFmtoRP501CXd7uRpDXNmS034urSs+KzstVWjsQUfNW8WC3koZo/fmI03syqHM4XTR3GEFE
	z76fGC6K7hbkCCnpjRQdVIF8fnF3G4MkJhAFEGeMRXhnOmwdzZCeOyzWHER0EiSXCPEk42C3+m4FA
	cON0cO+LhbaFm/iEz4RCkJggQLsppDAC55hocIQhxQRHm1nwWHWktnAvG0+diwTtiO65HrTMYLBJX
	+QcGUupA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqlhN-00ApmE-T7; Wed, 09 Jun 2021 00:03:57 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqlhL-00Aplu-6j
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 00:03:56 +0000
Received: by mail-wm1-f48.google.com with SMTP id d184so2945924wmd.0
 for <linux-nvme@lists.infradead.org>; Tue, 08 Jun 2021 17:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ofQstiq4gjhGloMR3B3vmsbu/J8852UlH72k0BVssTE=;
 b=eMQVfWMCZQd0VvgNjIM1Tw50lVg4eknZYEIAjjG82jnzbMYsQxwkCZ6qM9Pu5iKPSL
 BxiC4GHehB3GVNB7Wj40eHu0XOgL3QGEmgE902Ite5Wy/9Ti7sQGgfycw7z63mJHrsX2
 bOJV3oaSGvM+GGFoy48CN9tzrVS/X/qyJC50cvnkDlHXVGosaL0sbVaWIIzlkpVTlByu
 spG0VS7cOgrrWbR3MkQiEdQNFy5uFSvXxW9Yf7ZklqYBmZTYEhMk57I4bbnLn+jwU7F/
 TE74k4WgFSPooM5qLGT7i9CTn4PyeB17++fafu5eU6AFYBkmUTqjrLxAAEj+4u9FRwd1
 FkAA==
X-Gm-Message-State: AOAM533GwGnkJ2nW7vLOkS9Yg1yRLwKHeJP31FaGwUDfmcuTmRvPZ+Tp
 LTg3hhteItjfQjQLeZmYBZE=
X-Google-Smtp-Source: ABdhPJy19LVLXSAvAxv10BmsRUrsywHAUircXun/bu7R9T6hL38/i+a9docRUVLr+5jHnb+tHKvVyA==
X-Received: by 2002:a7b:c3d8:: with SMTP id t24mr7020548wmj.77.1623197032327; 
 Tue, 08 Jun 2021 17:03:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:12a9:2416:ca98:264f?
 ([2601:647:4802:9070:12a9:2416:ca98:264f])
 by smtp.gmail.com with ESMTPSA id j34sm14029888wms.7.2021.06.08.17.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 17:03:52 -0700 (PDT)
Subject: Re: BUG: scheduling while atomic when nvmet_rdma_queue_response fails
 in posting a request
To: Keith Busch <kbusch@kernel.org>
Cc: Michal Kalderon <mkalderon@marvell.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shai Malin <smalin@marvell.com>, Ariel Elior <aelior@marvell.com>
References: <CH0PR18MB4129247C2B9AE092E3C59740A1209@CH0PR18MB4129.namprd18.prod.outlook.com>
 <e059fc90-81e7-dbe8-86f4-87b4bdbd5bb0@grimberg.me>
 <20210608184134.GA339600@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4a031bc0-fba3-12d6-428f-a378aba1897e@grimberg.me>
Date: Tue, 8 Jun 2021 17:03:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608184134.GA339600@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_170355_286500_789F8FF8 
X-CRM114-Status: GOOD (  19.98  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 7d607f435e36..6d2eea322779 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/wait.h>
>>   #include <linux/inet.h>
>>   #include <asm/unaligned.h>
>> +#include <linux/async.h>
>>
>>   #include <rdma/ib_verbs.h>
>>   #include <rdma/rdma_cm.h>
>> @@ -712,6 +713,12 @@ static void nvmet_rdma_send_done(struct ib_cq *cq,
>> struct ib_wc *wc)
>>          }
>>   }
>>
>> +static void nvmet_rdma_async_release_rsp(void *data, async_cookie_t cookie)
>> +{
>> +       struct nvmet_rdma_rsp *rsp = data;
>> +       nvmet_rdma_release_rsp(rsp);
>> +}
>> +
>>   static void nvmet_rdma_queue_response(struct nvmet_req *req)
>>   {
>>          struct nvmet_rdma_rsp *rsp =
>> @@ -745,7 +752,12 @@ static void nvmet_rdma_queue_response(struct nvmet_req
>> *req)
>>
>>          if (unlikely(ib_post_send(cm_id->qp, first_wr, NULL))) {
>>                  pr_err("sending cmd response failed\n");
>> -               nvmet_rdma_release_rsp(rsp);
>> +               /*
>> +                * We might be in atomic context, hence release
>> +                * the rsp in async context in case we need to
>> +                * process the wr_wait_list.
>> +                */
>> +               async_schedule(nvmet_rdma_async_release_rsp, rsp);
>>          }
>>   }
> 
> Just FYI, async_schedule() has conditions where it may execute your
> callback synchronously. Your suggestion is probably fine for testing,
> but it sounds like you require something that can guarantee a non-atomic
> context for nvmet_rdma_release_rsp().

OK, it seems that the issue is that we are submitting I/O in atomic
context. This should be more appropriate...

--
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 7d607f435e36..16f2f5a84ae7 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -102,6 +102,7 @@ struct nvmet_rdma_queue {

         struct work_struct      release_work;
         struct list_head        rsp_wait_list;
+       struct work_struct      wr_wait_work;
         struct list_head        rsp_wr_wait_list;
         spinlock_t              rsp_wr_wait_lock;

@@ -517,8 +518,10 @@ static int nvmet_rdma_post_recv(struct 
nvmet_rdma_device *ndev,
         return ret;
  }

-static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
+static void nvmet_rdma_process_wr_wait_list(struct work_struct *w)
  {
+       struct nvmet_rdma_queue *queue =
+               container_of(w, struct nvmet_rdma_queue, wr_wait_work);
         spin_lock(&queue->rsp_wr_wait_lock);
         while (!list_empty(&queue->rsp_wr_wait_list)) {
                 struct nvmet_rdma_rsp *rsp;
@@ -677,7 +680,7 @@ static void nvmet_rdma_release_rsp(struct 
nvmet_rdma_rsp *rsp)
                 nvmet_req_free_sgls(&rsp->req);

         if (unlikely(!list_empty_careful(&queue->rsp_wr_wait_list)))
-               nvmet_rdma_process_wr_wait_list(queue);
+               schedule_work(&queue->wr_wait_work);

         nvmet_rdma_put_rsp(rsp);
  }
@@ -1446,6 +1449,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
          * inside a CM callback would trigger a deadlock. (great API 
design..)
          */
         INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
+       INIT_WORK(&queue->wr_wait_work, nvmet_rdma_process_wr_wait_list);
         queue->dev = ndev;
         queue->cm_id = cm_id;
         queue->port = port->nport;
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
