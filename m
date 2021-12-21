Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00288C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mGCzuL6U14xbcUalrzYVZOEwtL2RNRYo1F5cedfAxzc=; b=J5gX2F1CaNIEq7eydWzYlc21B3
	qal4nScQtze4a/g8SDPTEK/+nPRv+0j1kMsf6oG0UCeHeXP/rG85NobJXq2eXtT6OrFtQ7rgQeZYk
	bci/SzOuRB+zdfpTPkUJOzKVqXmMdZtD/sZviOQZCzwNlAQAs0gbHAFBZ7MyLQa0vnre/ixsqCHGR
	mfeomGq56qyLYCXgd/T2wl3JXqVp9A4usxbkzz6l2G+ySx8jCXH6dhkLCaoJFb623Ca97mSXW/DSQ
	ILnOdF7xlAhp7G1WEkd9GBxgtAW67V45QBNUMi7zfKD/SRpGMa19xC7EJmPSInaaORme/8gL7CKrs
	5JQd7eaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzbAk-00636q-3b; Tue, 21 Dec 2021 09:11:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzbAf-00634O-KY
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 09:10:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4E61568AFE; Tue, 21 Dec 2021 10:10:54 +0100 (CET)
Date: Tue, 21 Dec 2021 10:10:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jackie Liu <liu.yun@linux.dev>
Cc: hch@lst.de, axboe@fb.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: memset scatterlist before sg_init_marker it
Message-ID: <20211221091054.GA8993@lst.de>
References: <20211220025439.3995260-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220025439.3995260-1-liu.yun@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_011057_854738_1D5210F9 
X-CRM114-Status: UNSURE (   7.94  )
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

Thanks,

applied to nvme-5.16 (with the fixes tag).

