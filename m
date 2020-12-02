Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1819FC64E7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 09:08:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47ACD221FB
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 09:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ACD221FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=leK/dL11sUQ0ItC3q2j9+Hpvyhz1fCxae+ceTVRWnnI=; b=ymRJg+Wb/MTCjODvkuV1Rix7b
	IioLVe7KdbPbqqsOXPn3bKXzOxC1qXrS+HlZrAZiJAiQiD+/s0CTkfwG8jw1R7mD9mN0GF1U8jmiX
	HVJEshln3aBxgvqMfXMs2HjjNIUCgn3YS1ocMdAH7jTORUTmHeZbwjxx455RsSImNPDQbNj8gcQPy
	B5lPnrrTD6odCRfSFJJV/EJ8SkZdvBNKEKfyIgTztNprh6BDO/g62qUf965EvEh+B82pHvQlAphvD
	DYjpusOWNktVuCbEs3AJ1HE5vEzflymH355oY2EeqPtw3FZyWd9zK+UmopcG0NIDUBbieVW+yQm6H
	Dhj0DYCUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkO82-0008MG-Hu; Wed, 02 Dec 2020 09:08:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkO7z-0008Lo-SQ
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 09:08:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 18D5367373; Wed,  2 Dec 2020 10:08:46 +0100 (CET)
Date: Wed, 2 Dec 2020 10:08:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V4 3/9] nvmet: trim down id-desclist to use req->ns
Message-ID: <20201202090845.GB2952@lst.de>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201202062227.9826-4-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_040848_055590_E5B743A3 
X-CRM114-Status: UNSURE (   6.61  )
X-CRM114-Notice: Please train this message.
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

This should probably go to the front of the queue.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
