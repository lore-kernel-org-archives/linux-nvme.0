Return-Path: <SRS0=3CeD=3T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E9FC2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 17:47:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23DB20661
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 17:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ug83nk0k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSotuv0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23DB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z8QGVa/ROhLKLozYuglgEYCV3ijQNaVxUJsB75eVGWA=; b=Ug83nk0kpJqWft
	5m2d2dhf1tYjJPiN0soWc7TpDw3jm95ghAXhA2Tb7MnTUbNmsjK51Aq7M+abnOFFCOzutCkAzSdO5
	UdTTAQy9XmpdWkuKF8bmg2vuMsP3D2wezYfHxzFXtkO+EuIqIq3NNFmHxGwRjPdc5AMzQJ6Q2c4L1
	BQn6N+Gcq26ZF5qVkCQuEFo8tglUEAG9D2/D3Nyx7MstnIgSkEEonV35bB9yTFF1FeaRJ6LSXKImb
	YE4cgbimrnwglgA2xKFvlHUna5qdri4Q1i1Rw5eqsXYn7InhfDU0BG4wKIfVkkj6eJqbt4kabkd4R
	QshlOdAFZDxMebaWpM7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixDuq-00030h-Ga; Thu, 30 Jan 2020 17:47:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ixDum-0002xg-DL
 for linux-nvme@lists.infradead.org; Thu, 30 Jan 2020 17:47:42 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB90720661;
 Thu, 30 Jan 2020 17:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580406459;
 bh=gVzSyIk3d7JSoGlKVzcSpM7lHqE9HG2+wTGJ/pPCluc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZSotuv0WqzcPAKVl1/cFS8utYv/8jGwPwE/9ChbX1DvNCHNP5zLhgYIfhF1EFJyyx
 XBWmD9GBb5xbQwEHn0Kf3IwaIxnoWs513h6vsNBdvV41xkR+nhrlrhQ2Ay/PpshpFT
 fN09TdgYURwmLPoNKop1rsqCHODctpAVRFtMT4t4=
Date: Fri, 31 Jan 2020 02:47:32 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/1] nvme: clear io tags when freeing tagset
Message-ID: <20200130174732.GA7915@redsun51.ssa.fujisawa.hgst.com>
References: <20200123201947.4482-1-edmund.nadolski@intel.com>
 <20200123201947.4482-2-edmund.nadolski@intel.com>
 <20200130145335.GA8412@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200130145335.GA8412@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200130_094740_471204_1FACAF3B 
X-CRM114-Status: UNSURE (   9.82  )
X-CRM114-Notice: Please train this message.
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 30, 2020 at 06:53:35AM -0800, Christoph Hellwig wrote:
> +static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
> +{
> +	if (!nvmeq->qid)
> +		return nvmeq->dev->admin_tagset.tags[0];
> +	return nvmeq->dev->tagset.tags[nvmeq->qid - 1];
> +}

It's been this way for so long, I thought we cached the address of the
tags in the nvmeq using it to avoid this more complex lookip, so I told
Ed not do the above. But the original commit doing this was to remove
relying on a specific hctx to reach the tags, so it's nothing to do with
any observed performance change ... And this makes struct nvme_queue
smaller too, so all the better.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
