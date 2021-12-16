Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CACC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 09:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Thh0nXZnceqNDdds5eXbcz6jycQJGEnJOLIzCBHNA4=; b=3gkDpf4+img5v9Tt5HD/d+sTC+
	gaf8wPof16i7IL6YdLC/TBW2ZV/zsCj7/XEN1iRxwDJD85wapTCx4y9JbEqV7J4xhfMJ5mi7e0Os6
	vIOram0BilKoOURlu8cBbY6m1KO2YqZu5YAqnjY56S0aCca2TtIi/WURfzMAJGY3Mb/iE75RA159O
	0pw6/Dkzjs18Mx/ukNRDSSaQlyz3OLxDZ5SqjxaMhvq/UyGUWUsntQpUr7sRNWEBKWLqTYDi5xGVu
	pfsK9UMDzuQP/X04igGq+Mse+ykisNXGhwRbRPaCTaadO6oHxh5fHoV66jvKVaPgX+2L1cnpk4F4T
	Ljlgsu9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxmru-004N1K-5s; Thu, 16 Dec 2021 09:16:06 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mxme6-004G2Y-HM; Thu, 16 Dec 2021 09:01:50 +0000
Date: Thu, 16 Dec 2021 01:01:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/4] nvme: split command copy into a helper
Message-ID: <YbsAfoawFEV2R0pM@infradead.org>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215162421.14896-3-axboe@kernel.dk>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Just like the two times before: NAK.  Please remove nvme_submit_cmd and
open code it in the two callers.

