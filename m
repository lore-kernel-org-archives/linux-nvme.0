Return-Path: <SRS0=1Q2H=NB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ED2C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 16:20:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0FBF60560
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 16:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0FBF60560
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2oaHiGV755Rq/y5fw6QiGAawbZlGCoAjVGUk/AL7Ra4=; b=rFtwk2gecBCUoq
	l9lEFjp77V1ACVIEsmlCwsRwwjAVkwJYUkY51+oiKjoWKz7DdGfejkT34A0WChBc4HIhxleNeRLpt
	EcDjWZE3WixOrucoZ4FLKzCD91hiRwKTrBD1BVEQTvOuGm1wejlc6VMu2kkb0pSDR5+aT5nPc1CLc
	8KFVFL+DFwBjRXWns0pz5QCZwf+yt7VyZilnQBS2uuobQoKIDaKLTKlopjYXQg6d1RRyAKN9v9hTn
	CyavtIsJxSsGhQuDBxWU4PHf3bUKOyU1g0UT12EH/lM3V0wM7j1EBeYF3CHi989Jwcw/SR8Y87XsA
	mjVUpQtEiKpCdoJ1RqKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDUUS-004R96-Hx; Tue, 10 Aug 2021 16:20:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDUUQ-004R8k-T8
 for linux-nvme@bombadil.infradead.org; Tue, 10 Aug 2021 16:20:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=942z5WfvgWFm6AIgbADMmcmc1woBLLci3y4dHNx4FDk=; b=szxNk0Hlfk9+yT1bBP4Od1wM6M
 lBbpHNB17Jir9aK5Tk4RnzB1cqQ1ZSX1c4aXtxZj4HS4Gy56wzIRn6zQz7MAJLs61zbHOQsGAnD5d
 JQVaUWz0Ir5y2BY40Bfb9JdY0f1PHti9PdZSn9r7EaMmCKgFAk+1yCD6bXNBMgL7jjcastVAgCyx8
 1kuGk2B3SyaiCkqoGYEhwromNYwP/B1D2e28oQUjVZ4Imv3MtDKswtQP5KxDR+3I4DswRedr2UW2A
 sMmBJkifnnmS3R/dgvmI+2s9CuF1TwNnMqxJZFgWEfZ3Qk4bVQdR5gCdjr+fckAsrHUP6ZNRZYhOM
 eVZj8Gxg==;
Received: from 089144200071.atnat0009.highway.a1.net ([89.144.200.71]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDUTO-00CKQF-M9; Tue, 10 Aug 2021 16:19:50 +0000
Date: Tue, 10 Aug 2021 18:19:25 +0200
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH] nvmet: pass back cntlid on successful completion
Message-ID: <YRKnDVmIqUVcuiSY@infradead.org>
References: <20210808062014.28151-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210808062014.28151-1-amit.engel@dell.com>
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

Thanks, applied with a slightly updated commit message.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
