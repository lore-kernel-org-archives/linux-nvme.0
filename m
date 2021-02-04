Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9FFC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 15:27:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E3164DF5
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 15:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E3164DF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5+WNkkXEUJwsgOlBb7+iWn4DoETJjG8BjCnGtthk65w=; b=lthNJozhNPugSV3c8nRONlSyX
	qbrQDaYqLG0oPwouFk2w62uklYeOP3QKjfGI3kXNSEQgJ4vijnyo+GDfj+4A34tNB/1cFxAD1s1EP
	uC52ObKAJQ3GMS2djrqKaYSH38dGP+nUdu3VdmGoJb5onKDbaLn+avEHJh7YxDUfMPKC07KlZ5Wd5
	mzc85z31O2/p2dXKL0icOYGprXFyC/cFsSTVl3tlZA75hYRBwFAMtDjh0sM8wDdxDalIRoDc+T7Q9
	qZbCM6cRl+QeZ4PPnoCxKgYr3Mygfap3YBLY5Q44Zx/KCpxyvHf5pHI7JYNwNLtBKatVi6nirEdmg
	9k6/Khlmg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7gXE-0002gS-PQ; Thu, 04 Feb 2021 15:27:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7gXD-0002gD-2O
 for linux-nvme@merlin.infradead.org; Thu, 04 Feb 2021 15:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dQIvt99fwhCBvXUQTuD6MxHn1FJmYyV8DY+psBZxvaU=; b=DfyTJgJfNDc/+uSFJDdVycdNGM
 DE9Wvah8fyzmCsLtlQLqWaEUUcUNmrAqI1rxZqZfv6+SBT0WO9ibF/u5U9sZtBxuwrtxUnlnWnRxh
 t4VhuHo8oKquMHWe96s33Rl8X9o5jxc1SQuJgA95wnl/jKjBNB8ARHcLCLSqT0SrRCgwHsjEMqO1u
 X9fMkCf5A8n9T9fHOLxTUpU0xTOF70GbtU1Ez0ZVcgGPihAY+CGDB680YBGTMQ/nk7p5abxJ46PU2
 U6xXZc8xQ55HT83ME+zdg6GY6cgCPJoX33JHoHl5p1LbvsF8/2s67GYa1zugrTy+qpO08UkOZdW5H
 KGREr+AA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1l7gXA-0012t1-N1; Thu, 04 Feb 2021 15:27:04 +0000
Date: Thu, 4 Feb 2021 15:27:04 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 5.11
Message-ID: <20210204152704.GA249252@infradead.org>
References: <YBwNukLwQfsXQL9U@infradead.org>
 <e407087c-3760-b725-4b02-692eee28041b@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e407087c-3760-b725-4b02-692eee28041b@kernel.dk>
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
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 04, 2021 at 08:25:05AM -0700, Jens Axboe wrote:
> On 2/4/21 8:07 AM, Christoph Hellwig wrote:
> > git://git.infradead.org/nvme.git nvme-5.11
> 
> You forgot the signed tag, but I pulled it.

Sorry.  The signed tag would also have been available as
"nvme-5.11-2021-02-04", but I fat-fingered the actual pull request.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
