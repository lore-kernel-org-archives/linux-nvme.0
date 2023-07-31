Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660BBC001DC
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 05:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=VjPRBaSaw3Pm7HRcwSEDtcv5EB
	RR3dkFSoRqAunDTvYFfGOJh/w31/dslNJ30tCUuDOtLd59nAhpudXT8WHgMBepJ4jP5JOEMy3lUbc
	2jfZcOI0EZfDJ4qwbMrKCQUFGdxYBkIYKk3Yl8XcO4nR20wnBJ28pgGjqcPE8ZRIq8LbIAaI6JxEK
	usRJUwfLH/8YO3YhkP2metUQu5Xb0dF8pgeighJ3z36UFT2ziDc6wDYzgHKz3u+kop0dU4SNLo+ly
	2pKYqypD1nCHl1aDSVOcpfnQ+LovhsiM+tHzdc/U9sUabnY75IbUdYIVPlsqCQyvQ1sj4uFdMetwU
	2rAwexhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQLwC-00E5Rs-0y;
	Mon, 31 Jul 2023 05:59:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQLw9-00E5Hw-2Z
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 05:59:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 247A767373; Mon, 31 Jul 2023 07:59:19 +0200 (CEST)
Date: Mon, 31 Jul 2023 07:59:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Varun Prakash <varun@chelsio.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
	Rakshana Sridhar <rakshanas@chelsio.com>
Subject: Re: [PATCH] nvmet-tcp: pass iov_len instead of sg->length to
 bvec_set_page()
Message-ID: <20230731055918.GC30150@lst.de>
References: <20230727150550.5851-1-varun@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727150550.5851-1-varun@chelsio.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230730_225921_990452_1C0D7440 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

