Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D24C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 08:18:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC0C60F94
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 08:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EC0C60F94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=09/K6P3rzapdli1GFrSrpz+2ip4Tszh2Mg9qjyGmf0s=; b=C+qHg+cKGLi3O6
	gHZhwzseU5GJ6Byjij+nUD6CWlW/1thho/vmQ+uKtqYCx4s6FQGCOOJ2DikLaR/K2GgfIAHm3cD6+
	KWYU/OVvf1D2fzU/uwFG1HcTqDMec/NTYWzDpvIyq6kxgCaXsYqRMTbxw7siEM7YOLOPo2NIWEWfc
	hJRo2afLO/EEG8cXCbuLjiJ37VNXcnr14d9xBvAZ+q4swucCwGRSilTubbhsmE/j7OCox6D0gfI0U
	iQp93Lxeqajjz5qrM9J+wbRx1MEEW4oeNtWS1jrBPVt2gtsu2JmeCT1d9uHF/TJW/ZLPoyomPWDgW
	uDHq/e+53EfGcC2VTTEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maZSO-00FXEP-6L; Wed, 13 Oct 2021 08:17:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maYD8-00FErr-08
 for linux-nvme@bombadil.infradead.org; Wed, 13 Oct 2021 06:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=6XBrGyfLCtOvf42dvPkBd38w5ZcZ/QL5CHQHSIDzL5w=; b=aXmVjKqdmVH4Guug9I2d4YepTQ
 ajHfevgjJqayh32OOaORhpGBwFN05XuL3bh4qCROeZoTOv2vVMFdZHuvZtCaQvRk5vBpSMC+FiXej
 959l+Ki1aMJKC7ywdzVh/4z3NQSrPSdkiALtzBaYaaTwxU1VKXPeW5WEKNIeYfYz4Z6DiP2ZlJF27
 zmagiupMSohLF8SXUvCUq8fQgb3JVW2myD3OKPAeeq3N4dTPit4fDWhonxI12vfUWcaxLd+RMIlSg
 nNLXZsDD3tSVjWdsAYJ8ywRKguIYl2g4ZcHu/WR6oLP/VAmbdVd+T5zs5YKV3OBj6q/nQUctW+D+d
 53lFXXKw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1maYCI-007CNT-O4; Wed, 13 Oct 2021 06:57:29 +0000
Date: Wed, 13 Oct 2021 07:57:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme: move the fast path nvme error and disposition
 helpers
Message-ID: <YWaDQiwoo/vjNXxZ@infradead.org>
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211012181742.672391-6-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Please Cc the nvme list for nvme changes.

> -static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
> -{
> -	if (likely(nvme_req(req)->status == 0))
> -		return COMPLETE;

I think the only part here that needs to be inline is this check.
The rest is all slow path error handling.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
