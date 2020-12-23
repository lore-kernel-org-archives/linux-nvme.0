Return-Path: <SRS0=oc1E=F3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1FCC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 08:43:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4445220674
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 08:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4445220674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=euFIuSS59N8St085vSf/B3U2AY5Ks7Coex0nO8ZF4vU=; b=UEseGc3GZA0YMGBlV8gi+G7mE
	ZYf5qsddtPaJsoMGXQPZzbKqhc31S4IWr48hcCr05bDK3uS/5/swnR2sEvvomri3j6D2bRP9o4n7n
	cb1pTi5jEmGZcIoLrVBN0apbHfZPja8y/fv5e5kl4d4a/L6wbOYjq2v5pwg2TDDKnrmZI3zRD51uJ
	vckxwsxbqmDEs9m8qh/NQwdNPhIHQ78OC1hne/qsahK5cXHqM8jQRLi7avj/ZG9cpcpWXgH+uE7Rj
	rKiv72ASP3fyA36RdV/DbdfEpkjp/vveJs5L9IJkNykzo3GXrwV2d9LJ4MAaBB7n+wQCZ1JBmptiN
	htFxMVeqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krzk8-0007Je-KE; Wed, 23 Dec 2020 08:43:36 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krzk6-0007J9-Gs
 for linux-nvme@merlin.infradead.org; Wed, 23 Dec 2020 08:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=27fr01eTMWUlN3D6NqYYkycmLQZdGjLguMYnYrcjh0k=; b=jvsIF/r8BGIzbY62uHhaNRi5K/
 rfckmJFFbTcCUYZIOdJOawNI4/lvVSmoSua2QAVZEG3w1mEnkPvj653NwdoaXibbmNi/6zkpGZShi
 NYQYuJI6/Rp1uoYsPMPQMlBOvRphBOSu1nxYcZz2ym/dKAeHeBPROyZUuGcsErERwNN/0xyvCOnzY
 0spUgj0ZWRh/DN9AL6r0TnZ20dnQIqrFhO1QZN2KhlFs7TZz31Xk5+8JMBXh6+2yby6ozlg7FPXBD
 o/9Tbuvz1+/D4h0kchV8Id1VsZnWwSp8bqtYnKDURHcprJCysY7er74vnoVf2tnNQQ//OB2wEXV5Z
 XXw5junA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1krzk4-0007y6-GT; Wed, 23 Dec 2020 08:43:32 +0000
Date: Wed, 23 Dec 2020 08:43:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
Message-ID: <20201223084332.GA30502@infradead.org>
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Hao Wang <pkuwangh@gmail.com>, Linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Wouldn't testing with a not completely outdated kernel a better first
step?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
