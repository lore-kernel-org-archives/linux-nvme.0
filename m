Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E0EC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 07:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tBh1WUlpsBzJNwdYcxd17yMzSXQpFwBHJOLbuC2XQb8=; b=4WHC8Hd8g6sPN5lzedBnHI4DqE
	9Yy3DF96Lthvqu2xoXOVE4w2tZQB/nY6N7LTFTxV1eMNT3RiK4YCNEJeit2cRGbFFkLf3v9SG7cP4
	Y0y4lZJZtyyjBlWnZNo+5YjyV46r+w/KUZM9eYtktE0f5tjACP8y44x+o8tZ/YJEi9FIHp3ZzggnG
	d+OljETjle/yPhfsrjRWwNrFCjxhOm/8uDaev+TrjDs5o8hBUbnoM0EAU8CdF6uY5iiHhogndZtD2
	0lIK/i8tChayZXnF0rcF6JZ6dt/QDQSLf8MiQwP7Z2qgRTTuTO34es/cwMPjBEpNV992dTS5GFzkF
	VoHNbzSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrE8E-0005Yo-Bd; Wed, 18 May 2022 07:30:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrE8C-0005WR-1A
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 07:30:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 430A768AFE; Wed, 18 May 2022 09:29:55 +0200 (CEST)
Date: Wed, 18 May 2022 09:29:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, gost.dev@samsung.com
Subject: Re: [PATCH 2/3] nvme: enable uring-passthrough for admin commands
Message-ID: <20220518072955.GA1867@lst.de>
References: <20220517053147.7925-1-joshi.k@samsung.com>
 <CGME20220517053712epcas5p20c6a2b123709d7df1a1df8c9b1c91125@epcas5p2.samsung.com>
 <20220517053147.7925-3-joshi.k@samsung.com> <20220517081520.GA14308@lst.de>
 <CA+1E3r+9CeNJAxGH8EzC+TSNgGt8GnLVCC9544_3v=pdgqmTbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3r+9CeNJAxGH8EzC+TSNgGt8GnLVCC9544_3v=pdgqmTbw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_003004_281204_40835848 
X-CRM114-Status: UNSURE (   9.66  )
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

Doing the controller based ioctls on a per-namespace node has been really
painful for the existing ioctl.  So I'd much prefer to avoid that, but
I'd be happy to hear more opinions.

