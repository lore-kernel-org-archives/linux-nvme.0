Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C877DC433E9
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 14:35:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574FA22D58
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 14:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574FA22D58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KSCM4KRQHrV+5Jg1nhwDyC8T+iTYjeoBabCtJ47/FOM=; b=bfvRc0WRo5ZbJviFp0oIeGFTXm
	3Wz2ALiJZ5qe0mksyZ2znNVvKr5Y518xjXNXdS47KJo8ba9hWa/I4ocX5TWWxJU5boG9ckkeUZhHs
	8SVQZOxWbr4D6D8vG/WywajoxNbBMgn7og/tkftlIbYec0DTwxicil6X4690ExjSci4NyexJpvYGY
	ccg8eC8rQNPPNMe/PmP93kuni1YRsACcCa04vJj3QXVJjAYKKyx6gvlgInE93Yr84a6jDsIFp5C8/
	HD5vSiiH1E9viG0vJt2Ve5TroFu5meTmypCQYGviUfN35/mQoDGkvGVZBJ8eCEZaJI86/p8JQh5Ol
	PvMFVCYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4PQo-0003pi-QB; Tue, 26 Jan 2021 14:34:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4PQn-0003pU-BQ
 for linux-nvme@merlin.infradead.org; Tue, 26 Jan 2021 14:34:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=CDsuXNtf148roxef2LTAJvqAu83Q2Loacfr+PFBx5qQ=; b=FaR44Cb7bsArbnhcXbbrOzXn9U
 G+rikagp4OzeWRReSxP+8EhOk97Lg483MX5j4pfl0sLcaZNVvPsBBr5Hw2zP1seA3Uf1/LGf+jMT1
 cukyn8X8t3uHhNAfEomKgPAN1gTffYW5q2ISokxbb6m1xf6y0qmnEt8MJFRZH2fAQqqL3lY9X4Mm4
 LaZwEpTJAPK6ZEJAzJ+pLyJWEXVxssnPcrOdHS6qEE6THa9itb/xnbWhgWsMOvxOMMJCpgT4k5jyP
 Lv561ACi05HLCnbERchd3R207k7P2XQuuexfp0rZCOE+39lxWBsMarPux4NJ2KsDc53Ii6RF2JWWO
 UC10gElg==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l4PP4-005kB7-Eq; Tue, 26 Jan 2021 14:34:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Subject: additional ->bi_bdev fixups
Date: Tue, 26 Jan 2021 15:33:05 +0100
Message-Id: <20210126143308.1960860-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
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
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

more fixes for the (so far theoretical) fallout from the ->bi_bdev
conversion.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
