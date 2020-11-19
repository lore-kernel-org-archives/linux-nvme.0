Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0FAC2D0E4
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 08:00:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB62246BB
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 08:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b8+ddGL+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PzkXhuoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB62246BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lTXgRi7SHEw06lkNHBlHqp3VD2fwMBhmy3jWuYn7TPY=; b=b8+ddGL+OmeqPLrz8ZHTlGNqf
	XUMfWxsFmQUfhpnBcaWuPnkAbau7Y0YgRq8oTEi+sVoJH2ypuk9avRXB/GPc4Pwc/Nfy2wjNL+AMG
	DZlXdiMpC8biLH4qLvR73C0yoipHoyKwxSo8l75UjUVRep20WciFD/m7D0Dz58Yye2aXCJiQnApUx
	hFx4lLyW3U2FVBdRFkK5CvqQfGggyMhLYmFC5S2p7bt8k9EZZlSQjXC7JiKe6Howc/Zd4Xx+FOdl7
	fn/5PhHAo8POoYbDyVhFx3EqZ+lNdqwK1HndFCh5km8JRHPcWNxYFAy55W3gLTq6vZPCxYXsC22Ed
	UbjPbqsuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfers-0003WD-LG; Thu, 19 Nov 2020 08:00:36 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfern-0003Uy-NF
 for linux-nvme@merlin.infradead.org; Thu, 19 Nov 2020 08:00:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=XYDpXg9CTQvvO2zGH4cqKQUFyn+zcgg/9AwNB2fd4cw=; b=PzkXhuoXZc56qj3GPJwPg5PY6l
 3ShhrFuRJ2dJHkkjdAy4o7Cm8x1SNrj3ykN7+uV+JMKlVpmgOhHkf5wMN9p59V3f9XFRyMNMp5iSQ
 po8J7+sckHO01NuL8smc0Quy/qiELlYXH4IlBYRGcpyUiPWheVWiNcOddeb43EMpVzEc2tHtjBDP2
 BMnnWd8q2wp6n77le+Gk8ced9MZloPgrM0/IM8lqLfeNP/QB7ZfmUfbI7MrWc0K2ndCCygjkxbEiU
 VJPaD44/mUPXgT6Ot1ZS9wCoTKS3fCpEO0ji/16diFLcKmCw0gr2GghGPXzOBxBVQT0sUJic32Xr2
 F6of8aAQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kferm-0001aP-2u; Thu, 19 Nov 2020 08:00:30 +0000
Date: Thu, 19 Nov 2020 08:00:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Subject: Re: [PATCH] nvmet: remove unused ctrl->cqs
Message-ID: <20201119080030.GA6031@infradead.org>
References: <20201115121951.11302-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201115121951.11302-1-amit.engel@dell.com>
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
Cc: elad.grupi@dell.com, sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.11.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
