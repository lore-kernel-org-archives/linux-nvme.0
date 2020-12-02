Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B903BC64E8A
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 08:55:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13295221E9
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 08:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13295221E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g3VR4eDqKCBi7RMSMQnjhLQyMXE9/dTp77PsvReGP/s=; b=UxJYF+c50XbwbSU49MI7p6S4m
	i3vJfc2gY5d6pDNJO/+XWRPB4SQTRWicMMEfnOHKOrf7RrvDC6ILvdsZsQ2V/3K3GwRhYPD8vST0R
	NvnjeHpKsVeQ2fwdBT2yxwXd8F0T/C+woOfxIOvJDc9nT0ooNpZCepVqME1OQBJiWFHbNdmSBPA9G
	ymKjJhB6b0SDMZsFGWHmcag0MJd+t+7i3n987Mp7xQmGCZxiF1E1PaAcdZ7cndumL1phvWv0n2+B/
	ZwlV3cqMU+ECHGMnDvEZxyurLoIVEgnz9QFqvwQ7Rwn83Nbl2XJX0688tcEtz7XZj011UARLrY/S+
	hMGhDeSwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkNvG-0006Qc-Fc; Wed, 02 Dec 2020 08:55:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkNvF-0006QV-44
 for linux-nvme@merlin.infradead.org; Wed, 02 Dec 2020 08:55:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=uWpGyG4uI1IyljySwOiZDAbadE+N9TpiAEV5DiREgh4=; b=Tww4URfaJNptxmZfTX4rHfaXGn
 LrfagsHW9G4a9i6dXgpz5rhtk7tKS8ZJJ+gbyO2OJ2pjXJ1J0J6rOQpsaKTYaaIzMuAR4gmHvo9/y
 H86klH97PYdSvKD0yi0xoh6XoJ1ARSukv+yEJBKrCKo7r+AkJPD2K70MveJkrLV5uwBDbNC3KSwfy
 TOcajg7ljVJnSqSZEU+YjPaYjN/e5gCbMAFS9dllS+n0lUoIS5y09nMSuvo5WyqsAuE8pYzOqDT3K
 aI9kSgPolCiHy5Gdx/3evj+RK6Sv3XThsa64WhULAOdbYK5g2tzTJvztxPRFtGGEJgdUhs2jKaDbv
 e22mO7Tg==;
Received: from [2001:4bb8:184:6389:740f:6f27:77ba:2250] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkNvB-0007wg-EY; Wed, 02 Dec 2020 08:55:33 +0000
Date: Wed, 2 Dec 2020 09:55:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V4 1/9] block: allow bvec for zone append get pages
Message-ID: <20201202085531.GA2050258@infradead.org>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201202062227.9826-2-chaitanya.kulkarni@wdc.com>
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me, johannes.thumshirn@wdc.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 01, 2020 at 10:22:19PM -0800, Chaitanya Kulkarni wrote:
> Remove the bvec check in the bio_iov_iter_get_pages() for
> REQ_OP_ZONE_APPEND so that we can reuse the code and build iter from
> bvec.

We should do the same optimization for bvec pages that the normal path
does.  That being said using bio_iov_iter_get_pages in nvmet does not
	make any sense to me whatsover.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
