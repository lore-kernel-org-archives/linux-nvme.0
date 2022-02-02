Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33D6C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 07:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uQR4QyIfkQdaIGLrM9WsmYS4+wg30aubTF1pjLO1uEA=; b=4VEQE6YS10XlPfNQ1Ph2A+0I9U
	6INUSUR4At0FpwJ/9tdrwQoUUoXuTL7krtDheK0/Pml/OodyPjgoje3s6uU40q6d4Fe3Zpr4etrL8
	ECbJxvczk2Hd/KGpg53XMM51LBlDJdZOFHUZQ/6FhJB1BAyMBoqU1RCU3Ljebk2lW4ZznmvP5MW0j
	qeA5hVoyig63SO6gnmjGCwaUB/oMpjBuIKiiNzHQcqodq0UIuqBWvwMd6fmVNcTJ4uWSKDFFegh/g
	+KAyX14hHBpaobapsMuYCYNn0YN5w8VzAtriNzjzHbey/t9/IW3qRLNwCaCVLblu/FdTRp9nQwSun
	GaKDeehA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFALM-00ES7U-73; Wed, 02 Feb 2022 07:46:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFALH-00ES6E-Te
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 07:46:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D033C67373; Wed,  2 Feb 2022 08:46:08 +0100 (CET)
Date: Wed, 2 Feb 2022 08:46:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: add vectored-io support for user-passthru
Message-ID: <20220202074608.GA18318@lst.de>
References: <CGME20220131142354epcas5p3ff940846a88ae6fcfd8f9b3acb421913@epcas5p3.samsung.com>
 <20220131141847.4791-1-joshi.k@samsung.com> <20220201080202.GA29518@lst.de>
 <CA+1E3r+4K5Merus3RF_DOe3XmoDMpPS4duTst=e56Jam=bXZZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3r+4K5Merus3RF_DOe3XmoDMpPS4duTst=e56Jam=bXZZg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_234616_154484_9A8A96F8 
X-CRM114-Status: GOOD (  13.41  )
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

On Wed, Feb 02, 2022 at 12:22:53PM +0530, Kanchan Joshi wrote:
> Not many admin commands are buffer-heavy and likely to have lower
> invocation frequency too, so I did not think of adding support.
> If you foresee this to be useful for some (maybe log-page or
> fw-download), I can fold that in.

Just add this rationale to the commit message so that we document it for
future generations.

