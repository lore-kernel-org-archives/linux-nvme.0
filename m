Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD43C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R+8Q/tih0bnxC28PuLB/QYFZY72kdtXWw1fUBQKK40A=; b=caJsjRoXpsJeBn/aIAbtvYSYy3
	U+uTd/eFcUHGA7tLZF+FvMsThN0fMMdg5qrwDDlRfjmZ8QoRcOeEH8KLNdQ6+yONbqanxEmOmMiYu
	hrfpRjRScEOuYLoxzXIRI++/vga/Rt8xiFS8IDBNhY56i0q/n/nA0DdsSiCCX++96oS7BPO5Kc0n1
	GNtgP2FtJ8GNKBleDAJe5AaTCwuPpambt/2JOqVokc6wTjONQb0mTGm1tpBsN1u0/WOB1aZGNG+Zx
	yO/iKbtt/VY6tOECBOUmQ4+c4MyucP6wjGR+WeryAUrqa8Bu2Kb2w5eO14doGiHqz6RsolvKbdrUA
	o5UvT3aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmzIT-003tqq-CC; Fri, 06 May 2022 14:51:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmzIQ-003toP-Nm
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 14:51:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3A06468AFE; Fri,  6 May 2022 16:50:58 +0200 (CEST)
Date: Fri, 6 May 2022 16:50:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org,
 shr@fb.com, joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 4/5] nvme: wire-up uring-cmd support for io-passthru
 on char-device.
Message-ID: <20220506145058.GA24077@lst.de>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061150epcas5p2b60880c541a4b2f144c348834c7cbf0b@epcas5p2.samsung.com>
 <20220505060616.803816-5-joshi.k@samsung.com>
 <f24d9e5e-34af-9035-ffbc-0a770db0cb20@kernel.dk>
 <20220505134256.GA13109@lst.de>
 <f45c89db-0fed-2c88-e314-71dbda74b4a7@kernel.dk>
 <8ae2c507-ffcc-b693-336d-2d9f907edb76@kernel.dk>
 <20220506082844.GA30405@lst.de>
 <6b0811df-e2a4-22fc-7615-44e5615ce6a4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b0811df-e2a4-22fc-7615-44e5615ce6a4@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_075106_950507_E0F7143B 
X-CRM114-Status: GOOD (  16.54  )
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

On Fri, May 06, 2022 at 07:37:55AM -0600, Jens Axboe wrote:
> Folded most of it, but I left your two meta data related patches as
> separate as I they really should be separate. However, they need a
> proper commit message and signed-off-by from you. It's these two:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.19/io_uring-passthrough&id=b855a4458068722235bdf69688448820c8ddae8e

This one should be folded into "nvme: refactor nvme_submit_user_cmd()",
which is the patch just before it that adds nvme_meta_from_bio.

> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.19/io_uring-passthrough&id=2be698bdd668daeb1aad2ecd516484a62e948547

Just add this:

"Add a small helper to act as the counterpart to nvme_add_user_metadata."

with my signoff:

Signed-off-by: Christoph Hellwig <hch@lst.de>

> I did not do your async_size changes, I think you're jetlagged eyes
> missed that this isn't a sizeof thing on a flexible array, it's just the
> offset of it. Hence for non-sqe128, the the async size is io_uring_sqe -
> offsetof where pdu starts, and so forth.

Hmm, this still seems a bit odd to me.  So without sqe128 you don't even
get the cmd data that would fit into the 64-bit SQE?

