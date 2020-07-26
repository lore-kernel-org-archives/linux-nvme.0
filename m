Return-Path: <SRS0=KTc9=BF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094C8C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 15:43:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE79620714
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 15:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BYH3RbhW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejP/p/9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE79620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Z55rfbei2OXroudscpjc+CglX4rjtuFNZQ3J0/NjVCc=; b=BYH3RbhWq8+ig+Gm2M0Wgc8/T
	jpkJ5stM33h026f9B8OLxFCJHREqH8QmO/oFoYYWvXiVMg8RP5rSG7iHRtpVVDrq15V8J8OezuY5E
	TOOTxHBbNFia1coy6tUJvZyu4ndBJrDjhyiJlIxW0hjVbCRhs3pMZBPN87mRbyny+uXnwJMF0MCWp
	SHAbrrG/mILYRovqDduJtCirfQ0OqrGRU6V/DEAtvaotYsp1vTEFazYKVnKOC9Klffv6KB0XgoA2u
	iV03I6rlKrgZ1kcTZuPDZ4ViyY//UzzS7gHcGAFHb1cfgWX3yn9BxrQ+J/tcUTCH4Yv5KfSuY0ghp
	ApokBCB0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzioW-0000wp-VB; Sun, 26 Jul 2020 15:43:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzioV-0000wY-BM
 for linux-nvme@merlin.infradead.org; Sun, 26 Jul 2020 15:43:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=uNf8+Pe9XQPoJRDBSP2XX1PdaUGfc6duI8P7/6w7L7E=; b=ejP/p/9TRjUwN6U5Nw06R/IUkd
 J3iJTwHWB98kF+cjpBQzAxfk3MtkbnOt5lyqpx2J6VgLK8EP0NZSaAVd6u3AvzY20eYOm/OPD7GXl
 zo3e6fl4dBfhd/A0Nz8x9qAWGrnBROglOYeUY9dDatooK0mFPKm1y6fmft46rbR3pD4RkKcEyBtFP
 QKzzk3w4d3dAgiH1Glm/q9hnoYG8FW3nl0lSAuicxDJq6S47Kqwk4IcUK1vygbk+gnYhO7p7IZ7EC
 66awOoIN94M2+rOjrxPZgx9gIlEZujNEoAYxmF0yc7yL5lx0tblJxsO+fLyxXK/9fXdnpGjGFZy2y
 YzTlSopw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jzioU-000845-DH; Sun, 26 Jul 2020 15:43:46 +0000
Date: Sun, 26 Jul 2020 16:43:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvmet-fc: check successful reference in
 nvmet_fc_find_target_assoc
Message-ID: <20200726154346.GC30848@infradead.org>
References: <20200724164000.49831-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200724164000.49831-1-jsmart2021@gmail.com>
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 24, 2020 at 09:40:00AM -0700, James Smart wrote:
> When searching for an association based on an association id, when there
> is a match, the code takes a reference. However, it is not validating
> that the reference taking was successful.
> 
> Check the status of the reference. If unsuccessful, the device is being
> deleted and should be ignored.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>

Applied to nvme-5.9, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
