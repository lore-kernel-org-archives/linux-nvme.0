Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83448C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 01:57:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38780208DB
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 01:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZMUuF1xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38780208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dN21RsdTNN6t93nrmWqBQynexZjoz/C+HTnNP8pLIys=; b=ZMUuF1xk8caMbulaJLuct//wLi
	zi6HcjJpL+RgwlYoXaHb9pNIiNPIZX7mQEv+WownFC2cOWa/FwkVbmQP/IMss78uPQ2fJ8/eESqZg
	nLdU9pCCScdJgXFv3B/Po2p59UUxiQU/a+XQhdk2hBxpS9hVmkRrmvnlpZz+ZhUY+vxis9h1tQ70F
	7Jn9BeCuzuI8191/FPrO62MVsmQKcc1/Da8ABiUkGlUULHOipa6/ww0KcdBiqK4gkwnQIQdEJ/zP8
	9gJyj2n73IrOgnJwJbWNQTgRb3nXkdgNuQntXGfASdRyudUcj8KxlCajMukdBLOB/OyJsVOge8dxD
	77pXHoqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCvXu-0001fD-U0; Tue, 01 Sep 2020 01:57:14 +0000
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCvXo-0001dR-J3
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 01:57:10 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01358;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0U7ULv60_1598925419; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U7ULv60_1598925419) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 01 Sep 2020 09:56:59 +0800
Date: Tue, 1 Sep 2020 09:56:59 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 01/12] nvme-core: annotate nvme_alloc_request()
Message-ID: <20200901015659.GA4398@VM20190228-100.tbsite.net>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200831222707.35611-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_215708_897885_4659A038 
X-CRM114-Status: GOOD (  21.01  )
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
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Chaitanya,

On Mon, Aug 31, 2020 at 03:26:56PM -0700, Chaitanya Kulkarni wrote:
> The function nvme_alloc_request() is called from different context, The
> only place where it uses non NVME_QID_ANY value is for fabrics connect
> commands :-
> 
> nvme_submit_sync_cmd()		NVME_QID_ANY
> nvme_features()			NVME_QID_ANY
> nvme_sec_submit()		NVME_QID_ANY
> nvmf_reg_read32()		NVME_QID_ANY
> nvmf_reg_read64()		NVME_QID_ANY
> nvmf_reg_write32()		NVME_QID_ANY
> nvmf_connect_admin_queue()	NVME_QID_ANY
> nvmf_connect_io_queue() 	QID
> 	__nvme_submit_sync_cmd()
> 		nvme_alloc_request()
> 
> nvme_submit_user_cmd()		NVME_QID_ANY
> 	nvme_alloc_request()
> nvme_keep_alive()		NVME_QID_ANY
> 	nvme_alloc_request()
> nvme_timeout()			NVME_QID_ANY
> 	nvme_alloc_request()
> nvme_delete_queue()		NVME_QID_ANY
> 	nvme_alloc_request()
> nvmet_passthru_execute_cmd()	NVME_QID_ANY
> 	nvme_alloc_request()
> 
> With passthru nvme_alloc_request now falls into the I/O fast path.
> Annotate the case for block layer request allocation with likely and
> error condition with unlikely.
> 
> The only case this annotation will break for fabrics connect commands
> which are low frequency commands anyway.
> 
> This leads to following performance change in the passthru code :-
> 
> Bandwidth up (better) by 1.7 MB/s :-
> -----------------------------------------------------------------------
> * Average Bandwidth nvme-alloc-default: 272.10000 MB
> * Average Bandwidth nvme-alloc-likely:  273.80000 MB
> 
> Latency down (better) by ~5 usec :-
> -----------------------------------------------------------------------
> * Average Latency util nvme-alloc-default: 917.90300 (usec)
> * Average Latency util nvme-alloc-likely:  912.57100 (usec)
> 
> nvme-alloc-default.fio.10.log:read: IOPS=69.2k, BW=270MiB/s
> nvme-alloc-default.fio.1.log: read: IOPS=69.6k, BW=272MiB/s
> nvme-alloc-default.fio.2.log: read: IOPS=71.1k, BW=278MiB/s
> nvme-alloc-default.fio.3.log: read: IOPS=70.8k, BW=276MiB/s
> nvme-alloc-default.fio.4.log: read: IOPS=70.3k, BW=275MiB/s
> nvme-alloc-default.fio.5.log: read: IOPS=69.8k, BW=273MiB/s
> nvme-alloc-default.fio.6.log: read: IOPS=67.5k, BW=264MiB/s
> nvme-alloc-default.fio.7.log: read: IOPS=67.0k, BW=266MiB/s
> nvme-alloc-default.fio.8.log: read: IOPS=69.5k, BW=271MiB/s
> nvme-alloc-default.fio.9.log: read: IOPS=70.7k, BW=276MiB/s
> 
> nvme-alloc-likely.fio.10.log: read: IOPS=69.5k, BW=272MiB/s
> nvme-alloc-likely.fio.1.log:  read: IOPS=70.1k, BW=274MiB/s
> nvme-alloc-likely.fio.2.log:  read: IOPS=68.4k, BW=267MiB/s
> nvme-alloc-likely.fio.3.log:  read: IOPS=69.3k, BW=271MiB/s
> nvme-alloc-likely.fio.4.log:  read: IOPS=69.9k, BW=273MiB/s
> nvme-alloc-likely.fio.5.log:  read: IOPS=70.2k, BW=274MiB/s
> nvme-alloc-likely.fio.6.log:  read: IOPS=71.6k, BW=280MiB/s
> nvme-alloc-likely.fio.7.log:  read: IOPS=70.5k, BW=276MiB/s
> nvme-alloc-likely.fio.8.log:  read: IOPS=70.6k, BW=276MiB/s
> nvme-alloc-likely.fio.9.log:  read: IOPS=70.3k, BW=275MiB/s
> 
> nvme-alloc-default.fio.10.log:lat (usec): avg=924.12
> nvme-alloc-default.fio.1.log: lat (usec): avg=917.80
> nvme-alloc-default.fio.2.log: lat (usec): avg=898.58
> nvme-alloc-default.fio.3.log: lat (usec): avg=903.38
> nvme-alloc-default.fio.4.log: lat (usec): avg=908.74
> nvme-alloc-default.fio.5.log: lat (usec): avg=915.63
> nvme-alloc-default.fio.6.log: lat (usec): avg=946.41
> nvme-alloc-default.fio.7.log: lat (usec): avg=940.14
> nvme-alloc-default.fio.8.log: lat (usec): avg=920.30
> nvme-alloc-default.fio.9.log: lat (usec): avg=903.93
> 
> nvme-alloc-likely.fio.10.log: lat (usec): avg=919.55
> nvme-alloc-likely.fio.1.log:  lat (usec): avg=912.23
> nvme-alloc-likely.fio.2.log:  lat (usec): avg=934.59
> nvme-alloc-likely.fio.3.log:  lat (usec): avg=921.68
> nvme-alloc-likely.fio.4.log:  lat (usec): avg=914.25
> nvme-alloc-likely.fio.5.log:  lat (usec): avg=910.31
> nvme-alloc-likely.fio.6.log:  lat (usec): avg=892.22
> nvme-alloc-likely.fio.7.log:  lat (usec): avg=906.25
> nvme-alloc-likely.fio.8.log:  lat (usec): avg=905.41
> nvme-alloc-likely.fio.9.log:  lat (usec): avg=909.22
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5702a3843746..a62fdcbfd1cc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -508,7 +508,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
>  	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
>  	struct request *req;
>  
> -	if (qid == NVME_QID_ANY) {
> +	if (unlikely(qid == NVME_QID_ANY)) {

From your commit message, this should be likely(), right?

>  		req = blk_mq_alloc_request(q, op, flags);
>  	} else {
>  		req = blk_mq_alloc_request_hctx(q, op, flags,
> -- 
> 2.22.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
