Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675D8C43464
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 19:20:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0351120848
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 19:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0h6BjabZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rndya9Po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0351120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7Efhu8vb5oXDo3TdSN2A6cAOf68nBUzY/lljmf1IMHM=; b=0h6BjabZSEMoZSrcOw+f9dH1M
	rPQL9SMNKq9jRphqtPcGECuN3Ug7sGtTMSgipkobWj1aOY9Q+Gi/ostgYGX3K/89IXAwTteVHT9ra
	2I/qPt2ijUh6Wn62ceIrOaPTADd/NAbkRs5eeosvE9X65/FnsnH4FqQ7dl8jv36Fm/laWqHMx9J1G
	AESDLQKw4EIqsMgDky+euPKbY8UGFLIWpinDFb4U03TpRTePIMaBhv0XsFYehN1tafz5K6m8q/mZB
	QFDZkw+bJS24BWm4nim/3x51iSotp/wIHmr6tUUdW+jqittxGA7Mrw/0wbtAXpclQ/9UUKcy1PXGr
	vv6qdfU5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJLw0-00029o-UA; Fri, 18 Sep 2020 19:20:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJLvy-00029N-9u
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 19:20:39 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CEEB120848;
 Fri, 18 Sep 2020 19:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600456837;
 bh=Ojjtf3XxHVf8O7TWPo1OaH20IQUd/Rub717GJHX/1Ag=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rndya9PoIkPmLOdSjEDwVErbNQhO1Zhg3JzC0oan4cqT20VceloTqr22iTh8cNJaF
 3X5iVX8aJ9l2+1WkAuh7o7jAkMlrmDL6C/ttRv9Klw6u9BLt2dYF0ttqtMs/sN1VCa
 3wLNQAMVdH692FpMKFDPJTDKaZHu4+sVIPFtUWnE=
Date: Fri, 18 Sep 2020 12:20:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Xianting Tian <tian.xianting@h3c.com>
Subject: Re: [PATCH] [v2] nvme: use correct upper limit for tag in
 nvme_handle_cqe()
Message-ID: <20200918192034.GA4030837@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200918104420.30219-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918104420.30219-1-tian.xianting@h3c.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200918_152038_507538_6C857135 
X-CRM114-Status: GOOD (  13.23  )
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
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 18, 2020 at 06:44:20PM +0800, Xianting Tian wrote:
> @@ -940,7 +940,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	struct nvme_completion *cqe = &nvmeq->cqes[idx];
>  	struct request *req;
>  
> -	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
> +	if (unlikely(cqe->command_id >=
> +			nvmeq->qid ? nvmeq->dev->tagset.queue_depth :
> +			nvmeq->dev->admin_tagset.queue_depth)) {

Both of these values are set before blk_mq_alloc_tag_set(), so you still
have a race. The interrupt handler probably just shouldn't be registered
with the queue before the tagset is initialized since there can't be any
work for the handler to do before that happens anyway.

The controller is definitely broken, though, and will lead to
unavoidable corruption if it's really behaving this way.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
