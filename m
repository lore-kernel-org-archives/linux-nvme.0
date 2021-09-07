Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B6FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 16:48:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28FC361090
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 16:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 28FC361090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VkN9HzqbTX500hZSRdPbDWCQ/FrzYGtzi2x2mmGFvIg=; b=lW0OefTZnwoR4a
	IyXbej/ujBWhdVZ4HnYrn7RINN92LoNdRguRzMR5BgM534FqFknO/eTBnMGya8Ace6n/Kzz9IXHsC
	Ahg2rcHU3G1VulsEpW4p+GrZiksa+JVkxQyVT8qa5pEDoh855DsJNKMwdiO2WWJVBYLs7nrXavKTy
	ceXeT/a6zeKdlB/0QlCMFRjhh8bvAqYp8NyBrkQ5D7mo1DNhe6JEXvQIQAZTgb4jlsOuX6G5olHlP
	m3xMcB5+59rbI/UD822n1rhp143KOgdePuciQZ6K61gvX5Pr5yDBM6AZ5FZ9OjS1n5FwavT7oQFEV
	gbBlToUKLDkCnzO1H7yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNeGm-004GCW-UQ; Tue, 07 Sep 2021 16:48:24 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNeGj-004G9R-F4
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 16:48:22 +0000
Received: by mail-wr1-x434.google.com with SMTP id u9so15402038wrg.8
 for <linux-nvme@lists.infradead.org>; Tue, 07 Sep 2021 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LEtLeeGoFT8WbYTgRN3HPOn8m+iO600FeLjofpTTVKc=;
 b=kFT+bZHs4/bwXFPsPozvGaiFNmOrEdGI2lwaizqHt0g4Tc7o+nFSxLVT2xn9csBjSg
 742ZBjU2sTYGnkO6G0ljNyVsV6HkzmR+BDlpZNvd59EfLo8sg0mSH+Ub9LGBlAOxvnrH
 SBm+yqcd7cZL17QAnpr0ISvX4AN1hJUHzzt2aQRioSLCzFZvC7xue7Dy6HOfIIlil5wk
 so0FE9HkowHkw2QTNNNENEzrJ7DRCMWbET1gGq+iNAQJfbnYwRjb0djbapWz65kOHi78
 svEz+mMHh6AQaPXyrSlPkxY9Vq4ITsWg905bf8ItHn9erSQuTqJYq9fRzerr+GprSRAf
 LfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LEtLeeGoFT8WbYTgRN3HPOn8m+iO600FeLjofpTTVKc=;
 b=tkoWkD2kz0iPuRPEXUvzypcdnfOQfXBb92exA6EcdqLslcGDyUQFp7qLhRfDFWNEia
 lH+wvAxIIOCmC4zjJ6cybEAvJsMBb3ZtcZNkdV8ufLWkY7IxSQNJktyeWk4lsVtKVBSL
 v6UCnzQK4+BGlrcfV6ImF8Ljj8uR9cBW+Bf+4rfZnjlewVQTK/7gNPuNFdaWuqYzv81R
 iX6w3lE3v6clAr7OGmr0bJdSIjyxja7vGHX0VoyvTkFhMS8XhtclE/nM+xlduWH5u+57
 55cH2feU2yRdsFxWo6scnxLfe/s+wZ4V2EP1OVOAeu2qMiP5Sq3+sOQenWntGs7BEmxk
 AzwA==
X-Gm-Message-State: AOAM531Uw7Tjry9jBZwhypYw0SBewffv4uxJS4Ryvm0gtoBPM8BtPEAl
 KgwpLGETN6C7olQNgDBngXtW58PQV1fNIm30S48=
X-Google-Smtp-Source: ABdhPJx5l+2h9vRLIxgDpts+tXpc6KsZin2C4O26GsUgSORJMvpJyhdwVoRA3G6HU0hoJPjCWLZax6gg9IApUdatgiA=
X-Received: by 2002:adf:90cc:: with SMTP id i70mr19815231wri.408.1631033299617; 
 Tue, 07 Sep 2021 09:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210805125539.66958-1-joshi.k@samsung.com>
 <CGME20210805125937epcas5p15667b460e28d87bd40400f69005aafe3@epcas5p1.samsung.com>
 <20210805125539.66958-7-joshi.k@samsung.com> <20210907075055.GE29874@lst.de>
In-Reply-To: <20210907075055.GE29874@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 7 Sep 2021 22:17:53 +0530
Message-ID: <CA+1E3rJsrBjpS8mNTg3jk2VWDCZ54OsbB4LC8zZaVeaN0dr2dA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] nvme: enable passthrough with fixed-buffer
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com, 
 Javier Gonzalez <javier.gonz@samsung.com>, hare@suse.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_094821_593398_CB112626 
X-CRM114-Status: GOOD (  12.07  )
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

On Tue, Sep 7, 2021 at 1:21 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > +/*
> > + * Unlike blk_rq_map_user () this is only for fixed-buffer async passthrough.
> > + * And hopefully faster as well.
> > + */
>
> This belongs into io_uring.c.  And that hopeful comment needs to be
> validated and removed.

I'll do away with that comment. But sorry, what part do you think
should rather move to io_uring. Is that for the whole helper
"nvme_rq_map_user_fixed"?


-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
