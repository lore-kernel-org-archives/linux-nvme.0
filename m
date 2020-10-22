Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934D2C388F7
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 13:37:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9301222E9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 13:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eBV8Y+W2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RTkjg+B7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9301222E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dfGG15TSfoH4hmmKRcLWihZO8neJKQHikyutt3jxdeY=; b=eBV8Y+W2prD9d7PQ9swKgbTH0
	mrU5k2JnYtzZqWIHSc9Cc1DsI2oayQAWIw6fbhCmo9r+mMaiA6Ni7Hlq7dqA5kEYLsIeaEyTg0NOU
	P6VgHdN8n1HnaN3QDPdbSEb7Lmi2Wqb/iAf9aHi3kEtRKU2vDbOhBa9xmQ0tcDMK/knCYNyI5sz5o
	nCLGQsGAZov6P32e82JRvfH4E3LuafGUdix4DUap8xeLonYoJrMG2W8SGFKzxlf5CstQuBHlXw7iZ
	hbiiQ1gCyloKD1fr8vmildcrX/z42cmVX/MLTC+XMtzT+y8VpjLvQH+7vgump7q/zlMQp+cMGP97v
	vkL1qLSHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVamF-0001ka-45; Thu, 22 Oct 2020 13:37:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVamC-0001j7-Ko
 for linux-nvme@merlin.infradead.org; Thu, 22 Oct 2020 13:37:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Sq5FTZdZCuJGAIiKXu3zLR9CZVx0uxX1AdIquLrEsgI=; b=RTkjg+B78nX39WVY3x3ZD3w0r+
 8jHsoTpPX2GAdnRV9ichtD6DyTaJTk05kAMATHyYJge2c6x1Z8du5/FocbWfNwAPZJ55nGqcxUgCt
 +yfD0SdFz7ohe1kqPqO8DdLYbudYKCThYMiMkwFILImqHz2Dyx3pbh6oJhJVdAxUXnIf4Ivik/ec/
 eebJwo5T5ZsZk1R0FWzfF1Gm7htXkreN7itLt/DPPiwfASXHM+hDh0y/WwDpZeoRZ4qO3p9tfbqUj
 jCqpI6wbvJQII/MCY7Kw5U+j4UxNIsI38weXUbhNLJMlSLtOjdZXF3AkuGSxuz4U05+gnooPl+nML
 FF98lNmg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kVamB-0007xQ-AO; Thu, 22 Oct 2020 13:37:07 +0000
Date: Thu, 22 Oct 2020 14:37:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme-fc: fix error loop in create_hw_io_queues
Message-ID: <20201022133707.GA30500@infradead.org>
References: <20201016210604.48542-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201016210604.48542-1-james.smart@broadcom.com>
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

applied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
