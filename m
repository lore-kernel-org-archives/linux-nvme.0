Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B023AC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 19:04:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0406261073
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 19:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0406261073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IF3nj4f6GN0kxKTtTE6HR49ukBwhG/DF6EZrTTkBOgo=; b=kooVboE09eeb7DNPnysOYSKat
	K6U/UpB7+aR23tKaa/wQOUyaNyRZAk0eRBPXFQYmp2ktDTXM5BqEqDHJiUvhGBlM0SLRJqoDdu0Ye
	XgC0dSimlswj/ApqqKEgkJhUPKwK6fsKsukYQq2Maytl0Prz2zb+ALuu49xzUn5s30/5tHUtgo4St
	jlmaOzNlYBoGDbTQasnYJ4W1j+ps9oc1jb0jNsDzGVLqecGQ1RwtmQGaSPeHx4DDL7FtPAlLLhTEv
	3D1AJXsbVsA+gOVQgovGTEysg/4d3oMeX+gWOMOKf/A92zHlAQdiIw+nDkVyYEHyiQUlmQKRuTYeo
	UHBid5suA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1liiXV-00Fv4m-0d; Mon, 17 May 2021 19:04:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liiXR-00Fv4G-5I
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 19:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=gtWvH9v9UD2QFXmznmGLEnqDtiBreE8FfZ/9YamqUf8=; b=yRk9XX4udHz1J0NIkOmDhFvXqt
 HROUVFXUFFCRTpBz6wkvWoe6br5KqlIvjC6WCaj8na/mS0fkSNJU4Q9SxvDwiCFmiET2zIjSPMUb6
 RqCmQkWcEw9/bAKQxphPkn/2+QAufYh52aUIe+HxdGTWfSVja5Y0paZkHfxu3SyMT7puyKtVtb2MT
 1PycQl0TrulCoIvBZeZtV7gRgAGmTHNs4x+5YdQg865OhecBhNfNjOOYXVJHh1HmgTkU//3NDrBMY
 VlvwjLc5WVPCTmUfv5QB3c5uE1C/51PDiKLbcxnp9OQI3wj/kdbncE02+vq750QeUYNztbUfwA7Du
 R+/ILLYA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liiXO-00E4wA-DF
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 19:04:23 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7B6E61073;
 Mon, 17 May 2021 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621278262;
 bh=lHjmflU25Ns62yoJUkLy6dI7zshDF4zDi5ZZuJkfotA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u84W/b/KYM+l2p911nq1hsPmL/faEZ9iEfCfWuYe6dMuiv++waY8H8WhC2rGIEfs9
 WTlYHcgw6u6ikPxYO1Hl/FWJXaWb0rdgvvmw7U2Fi6rbv5Pq1FlTb2ohRdV86a8x9O
 nqGH8vgUbusSxaspL2LLFbKj0+Yv7dfAXlDM/ZFc8umJtsqKw7KtKvyv3qkW+RAdkv
 bVTLJJW+AV+xtLqgLUfszCexjFxXPaCemnyEeyJ/Cwe+K6sIeNqPDSmpbFwwTFuiu3
 DWb2Wfm/bgUr93pkg1r+36Ednbvtf5Sqz/IJChvZDWaDT0OBOl+GMArrMv0K+WZs9q
 kz1IgIx7OOwkg==
Date: Mon, 17 May 2021 12:04:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 3/3] nvme: code command_id with a genctr for
 use-after-free validation
Message-ID: <20210517190419.GE2709391@dhcp-10-100-145-180.wdc.com>
References: <20210517175955.602725-1-sagi@grimberg.me>
 <20210517175955.602725-4-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517175955.602725-4-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_120422_487645_0FBE881D 
X-CRM114-Status: GOOD (  13.54  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 17, 2021 at 10:59:55AM -0700, Sagi Grimberg wrote:
> +static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
> +		u16 command_id)
> +{
> +	u8 genctr = nvme_genctr_from_cid(command_id);
> +	u16 tag = nvme_tag_from_cid(command_id);
> +	struct request *rq;
> +
> +	rq = blk_mq_tag_to_rq(tags, tag);
> +	if (unlikely(!rq)) {
> +		pr_err("could not locate request for tag %#x\n",
> +			tag);
> +		return NULL;
> +	}
> +	if (unlikely(nvme_genctr_mask(nvme_req(rq)->genctr) != genctr)) {
> +		dev_err(nvme_req(rq)->ctrl->device,
> +			"request %#x genctr mismatch (got %#x expected %#x)\n",
> +			tag, genctr, nvme_req(rq)->genctr);
> +		return NULL;
> +	}

Should we also check for blk_mq_request_started(rq) here? It doesn't look
like the genctr is sufficient to detect a double completion of the same
command_id if the driver hasn't had a chance to advance the genctr for a
new request.

> +	return rq;
> +}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
