Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C830C2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 13:56:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114A42071A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 13:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fOKfP2I2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PGGPPr35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114A42071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lTXgRi7SHEw06lkNHBlHqp3VD2fwMBhmy3jWuYn7TPY=; b=fOKfP2I2/kF5/v9ZFOgE3r30a
	adXe2T4/Vs5ARd1nWlDmVNezgzFGoJ2uytSE8/kGnKPLHoXgH+uI+CmDRakJ0ekOzf35ZH1DGnxnC
	/h41+c5vDgK4nuO8DwfOv/sKvnVZdk+fNYC71kCp/5/wU4kn4uo1HLmeq2EXXT4SlSJqHMYFBMbCJ
	XDzivlpwC9hhWMW2Kp5BlA+TBKzXGAjvscSmG4vOPUrCGP4VS+nyVdxzqc+rfS6DpZ2WYciOhrCf9
	pYnNc5ZWBpZgtNCGrLuG/otjmkcj095uBXeJtmMRLONMf1B6TUQx9MkYMcZOYuhv77gomL2gLq5qb
	A14d76B2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb2Dj-0000jZ-7q; Fri, 06 Nov 2020 13:56:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb2Dh-0000j0-SF
 for linux-nvme@merlin.infradead.org; Fri, 06 Nov 2020 13:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=XYDpXg9CTQvvO2zGH4cqKQUFyn+zcgg/9AwNB2fd4cw=; b=PGGPPr35OTNszZTVO+D8cOfu5f
 bCyv5JbbDgm9FqP4VN3Os1ZqVt9A+OyQK0DpB8qm2hulflUK9SjABzBxZ96LUmnxjdNE6Pmsrbxvs
 Aq6eQqSaXvtq2APGV41QcCMvEE2GkWK34D4uZY2R3J6HVW+3kTbvTv9tQ753jNzeeh1d9uV2DCd7p
 SV7dNtFY7V2OBTByHWD2/cWa5BZBlwRo7rs5CyzjiY4luw9Ol8NZRVAR+PsLKETSaKl2pjN/Db44J
 rWKenfkrCjgp/vb6Yiq0/GIiHMmHW0TqP0zQq9vhT+0PWfX9jH9//3FPgY2fbyxz6mjDzzEDrZQJc
 P8ZdA6JQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kb2De-0004eY-Mp; Fri, 06 Nov 2020 13:55:58 +0000
Date: Fri, 6 Nov 2020 13:55:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme-fcloop: add sysfs attribute to inject command drop
Message-ID: <20201106135558.GA17814@infradead.org>
References: <20201016212838.49298-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201016212838.49298-1-james.smart@broadcom.com>
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

applied to nvme-5.11.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
