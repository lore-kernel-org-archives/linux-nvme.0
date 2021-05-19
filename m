Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87198C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 07:01:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398F260FE9
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 07:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398F260FE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KuWi+es1P/b+pZo/z5ZFGxrcRX+6KRReLQazcuQ7ZC4=; b=pzKjt3AZQfIbq68zvrCtOLlMw
	QdZw9mpz9l0n5gbQcfdMmOeRmpeaaVSy9ZT1OWepNSTMttMvYl8i9rdycek+m5kUjpds/hxfnFKTS
	Fo6qSudxLDQD+QHfegqPalqs3ep+tZxm6CWRipJzuB9QFlZQM6DTQcAW9iceZpnj6ECevpi44U74Z
	zshhZhxiNl/4LyV27DBsRI9Uvpojs6sVwwl1oaPEBKJ3KksNG9y1xiUVNu+QLjs49Vt+fQuPuC4MH
	8n7GSrcgPD4APemyKsDop9exu9PW8UQ0v0DNXdH8zFrdiduJaQoelWjrEQugB/ShNlXthHoB1NYlY
	LCdQtezKw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljGCj-0035Q7-Tj; Wed, 19 May 2021 07:01:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljGCE-0035LU-EM
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 07:00:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AtLQOmT3RWv+aEdvfhmvoXrvtO8TBTQq5ZLyKjbSK3s=; b=MLbrAs2Km+eD55KhF+luMJ4p9D
 JCnSJ05TR8zakSZLQ2jombIQs/8DvluuSPpb/PVVtUeanXOhga7sMxCi0pPg/AWbJZUdfzYAlrRDy
 gpTmUOhJ1LopM7yjLGH51aSjvtraQwQnZ0MuM448ZxofODx/Ipw2BAz1X1Tp/Eg7mrayZrarADjxk
 r+XxkWZc+ImZE3dFeRBw6ZJmwrXpW4PP05YE2pVe5ZnWiT2YtcLDQWYyQGsEak0fqVQjpbeMW6xTC
 fk2NWJRFgCEcRV54SSzMO5Y0r0hsLXXunttPRkHXLEN81T9w9V7PJbb8kx4epqJgk0eLdrDTtm3o8
 NS6a5xqQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1ljGBE-00EhwI-Av; Wed, 19 May 2021 07:00:04 +0000
Date: Wed, 19 May 2021 07:59:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Cc: linux-nvme@lists.infradead.org, houpu.main@gmail.com
Subject: Re: [PATCH] nvmet: move ka_work initialization to nvmet_alloc_ctrl
Message-ID: <YKS3YGYMeJ94IJ0s@infradead.org>
References: <20210422123316.18362-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210422123316.18362-1-amit.engel@dell.com>
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

Thanks,

applied to nvme-5.14.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
