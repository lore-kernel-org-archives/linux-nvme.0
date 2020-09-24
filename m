Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30793C4346E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 05:10:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FA62311A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 05:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1ukZ49C7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UAJv/JeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FA62311A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tVmJpHih2quVJrI90sfe/vidfieqA/mfCyWUEgzl2Ao=; b=1ukZ49C7rQ7I7OMhE6PGlR28J
	hOpzxcNdenLNinE4zeL6/7by/4iWdUBh/+/Xas6OXvSIOrldNmL4jVJLNKu0XwDfomKthMimQ5Qfq
	4M149MDi/gddgX7z3WbtBYyJabt8kDJs+F0DOGLmOl5XlH/xPZ7LBCEzDlBR2hdPCml0b0ryd9OTl
	Id7hGDqW77yKfD8TqaAeIUcRVFecYGApOll2mwINNwDD3c7TtcNnGNLGm1jmnOmQMpxkaCPaPDSva
	xDycf27jjqNzWUlBEyns5cnZpa/gmlup9VV23AX0zz1EuLWG6mjA6c3ffUV1fCeg7HedOlJYjT54r
	FpNc00MhQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLJW8-0003qI-He; Thu, 24 Sep 2020 05:10:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLJW6-0003qC-Sz
 for linux-nvme@merlin.infradead.org; Thu, 24 Sep 2020 05:10:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JCXyOa5uxUpAjzOJP2AX3oeKCJVkWYZ6cJtg6FEK9aA=; b=UAJv/JeOFirhJPGgMIDYfBwZH4
 f0DEtGJgjmJ+vZUHujraPzFc1RKlS82dptJjNe6HdjhVmIOTin5vTMufbWNA5PyMfD6jhUDy+vN8C
 Pl9zeCv2+GYGTJRIxZbZJozdBqUyu5wiw0pyS/1CRKp5bhK+kBlhyWq532kjUcH6Ge1ISgzoJPloY
 wioykRVUo15gxcZut7gFPHf6Lw/NNxcZIDOjS3LjSGK0daVMTb3kI8Hj5UbJzwrEMz+rKaaYsq27k
 4YCw18gy9VcHKm/5E7e36g26zxaC04x2xtgU2r8O7llQs+QRjS5DgM2OUOkEwzXaud8QZ4fFUwnMI
 8vlNq42Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kLJW5-0004Bv-G0; Thu, 24 Sep 2020 05:10:01 +0000
Date: Thu, 24 Sep 2020 06:10:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH] nvmet-fc: fix missing check for no hostport struct
Message-ID: <20200924051001.GA16058@infradead.org>
References: <20200922215412.126070-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200922215412.126070-1-james.smart@broadcom.com>
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

Thanks,

applied to nvme-5.10.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
