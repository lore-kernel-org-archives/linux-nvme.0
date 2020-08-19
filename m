Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B2C433E3
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 10:02:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61D7206B5
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 10:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IDREQrbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61D7206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XF+fM+JmbvKAusslOGjrrNqQ74AnFy3EnomOspz7xVw=; b=IDREQrbh/cEIZGK8yKN2XtQEr
	XfGnZOnDwdxVYUYjTPkmDTIrBANMNn51BxNtSyuZXkW+8mpXibZmZMWvvBHdQItPq9FGW2ndmydIR
	/R6mqyxRWhgfCBdYVDiDz4f6V7O749etkz6VXx2p3B0BB163k54PJ5phl8X3IkyIuvGFO3UuU7cCZ
	6LDGU/lRomJnihpG801hCJVwqt9G+g/MypfWf1sBLn+bDkOKvACpEDukU9oZNCi3cnzgiqQxtSAiw
	IDrh6f1bIJt/evDM6z7/nJjBCHRhiIut9zuC7JOkOTfHq5l5KG/qFs9F03JPlvzqNZCTnrS0PQghl
	5weSBcv4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8Kus-0003OC-Cd; Wed, 19 Aug 2020 10:01:58 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8Kup-0003NA-In
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 10:01:56 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C8D6A16F627936FD17A1;
 Wed, 19 Aug 2020 18:01:49 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 19 Aug 2020 18:01:47 +0800
Subject: Re: [PATCH 4/4] nvme: redirect commands on dying queue
To: Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>
References: <20200818071132.1136033-1-hch@lst.de>
 <20200818071132.1136033-5-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <4eeafb53-ad1f-a123-ad73-f996970a6f1e@huawei.com>
Date: Wed, 19 Aug 2020 18:01:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200818071132.1136033-5-hch@lst.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_060155_875560_226BD33F 
X-CRM114-Status: GOOD (  22.42  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Mike
 Snitzer <snitzer@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/18 15:11, Christoph Hellwig wrote:
> From: Chao Leng <lengchao@huawei.com>
> 
> If a command send through nvme-multipath failed on a dying queue, resend it
> on another path.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> [hch: rebased on top of the completion refactoring]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Mike Snitzer <snitzer@redhat.com>
> ---
>   drivers/nvme/host/core.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 36bb0fe9c7f6f8..a6785b86359fab 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -274,13 +274,14 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>   		return COMPLETE;
>   
>   	if (req->cmd_flags & REQ_NVME_MPATH) {
> -		if (nvme_is_path_error(nvme_req(req)->status))
> +		if (nvme_is_path_error(nvme_req(req)->status) ||
> +		    blk_queue_dying(req->q))
>   			return FAILOVER;
> +	} else {
> +		if (blk_queue_dying(req->q))
> +			return COMPLETE;
>   	}
>   
> -	if (blk_queue_dying(req->q))
> -		return COMPLETE;
> -
>   	return RETRY;
>   }

Suggestion:
Do not use blk_noretry_request. The local retry mechanism, which is
defined by nvme protocol, is conflicted with REQ_FAILFAST_TRANSPORT.
blk_noretry_request is not a good choice for nvme, even for SCSI,
this is not a good choice too, so SCSI does not use this MACRO.
We can seperate REQ_FAILFAST_TRANSPORT with other FAILFAST flag.
For REQ_FAILFAST_TRANSPORT, do local retry for non path error.
For other FAILFAST flag, complete request with error code immediately.
---
  drivers/nvme/host/core.c | 12 +++++++++++-
  1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a6785b86359f..cfd870780353 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -257,6 +257,16 @@ static void nvme_retry_req(struct request *req)
         blk_mq_delay_kick_requeue_list(req->q, delay);
  }

+static inline bool nvme_noretry_request(struct request *req)
+{
+       if (req->cmd_flags & (REQ_FAILFAST_DRIVER | REQ_FAILFAST_DEV))
+               return true;
+       if ((req->cmd_flags & REQ_FAILFAST_TRANSPORT) &&
+           nvme_is_path_error(nvme_req(req)->status))
+               return true;
+       return false;
+}
+
  enum nvme_disposition {
         COMPLETE,
         RETRY,
@@ -268,7 +278,7 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
         if (likely(nvme_req(req)->status == 0))
                 return COMPLETE;

-       if (blk_noretry_request(req) ||
+       if (nvme_noretry_request(req) ||
             (nvme_req(req)->status & NVME_SC_DNR) ||
             nvme_req(req)->retries >= nvme_max_retries)
                 return COMPLETE;
-- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
