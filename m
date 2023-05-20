Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F231C77B7D
	for <linux-nvme@archiver.kernel.org>; Sat, 20 May 2023 04:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Olz8Q9qou3vPllKTQq/fIAK0oj6GwS/jm5LCTF2Um4I=; b=m9dfO7tIejM/wcRcJa1sNEOFbp
	XScpAZB0JUEQgm+2qp/7GxamiJoLt2C0rO6CJkRpP1BjXRTvkIMBau6zDLeGS7bVBXYksClUu5DGJ
	AWgbegwuBXdXiOSqodu5AukIDjUe3XC5gOGascKG6j3WEL8bY1i4froIEj0yVV4MIdjzS2zua7L75
	gYXiua0EV8PBxENXvn4wLYG0TW4SxsPKMPhdPHFJ3ObTKUSKdzi/4oXV68Tx9YyNHN69FYuKrpvc5
	dOjtBK9Eon15ou/bluFnF4y83NJ0tp30gv2FPPgp0dEPyKPt2Um9+Fi3pdZEEQe65V8JrC7fnP082
	a6ePUI8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0E94-000f1A-2g;
	Sat, 20 May 2023 04:24:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0E91-000ezn-2Q
	for linux-nvme@lists.infradead.org;
	Sat, 20 May 2023 04:24:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 220F468CFE; Sat, 20 May 2023 06:24:37 +0200 (CEST)
Date: Sat, 20 May 2023 06:24:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Irvin Cote <irvincoteg@gmail.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-core: use nvme_ns_head_multipath instead of
 ns->head->disk
Message-ID: <20230520042436.GC31780@lst.de>
References: <20230518221054.56378-1-irvincoteg@gmail.com> <20230518221054.56378-3-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518221054.56378-3-irvincoteg@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_212439_934554_2B989248 
X-CRM114-Status: GOOD (  11.76  )
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

On Thu, May 18, 2023 at 07:10:54PM -0300, Irvin Cote wrote:
> Change the way we check for a multipath nshead so as
> to consistently use the same check to assert the same condition.
> 
> Signed-off-by: Irvin Cote <irvincoteg@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

