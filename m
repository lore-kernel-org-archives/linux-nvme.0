Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51909C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 08:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=O5OpoqLgNtSegqxzHMFeuq+Fs1
	LMVd4TK3d5quXS6yWfdLZnlGWUcD6xGzebf0hW8Rs/agoCyaDhHXWKVVOqxjUXH5Z2A8rlePUiLE0
	K91jiRXcSbniwVtHvOxTwq32f4KS/VjqUcUhiDJk1wt+hvzbpa0PIwK88nzjnJaZjDOaeTgtnctHd
	jIilccjqYGR3s4774cX/f8r6bnRhHhC7u87nlxyhzPbn5noa8DeGJDUZmwCSpqW0osWUaTizuhnjO
	X42tWK3A5DjTUtu9e1AEWq8DI+pOQm19/Xe4F6oJmaFs/33ciSemsi8yzDELwf0Y6ruIKdM5PJKsL
	pCRNyYVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqsNA-00COI1-1J; Tue, 17 May 2022 08:16:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqsN7-00COHJ-AW
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 08:16:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 54B5567373; Tue, 17 May 2022 10:15:58 +0200 (CEST)
Date: Tue, 17 May 2022 10:15:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: Re: [PATCH 1/3] nvme: helper for uring-passthrough checks
Message-ID: <20220517081558.GB14308@lst.de>
References: <20220517053147.7925-1-joshi.k@samsung.com>
 <CGME20220517053711epcas5p40f48777253119633d99c8b2b905793ff@epcas5p4.samsung.com>
 <20220517053147.7925-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517053147.7925-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_011601_534447_E4BE5FF4 
X-CRM114-Status: UNSURE (   8.33  )
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

