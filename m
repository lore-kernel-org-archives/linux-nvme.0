Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA6CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hXFmK9ooi5FYSQ2IjEX0ybrtBakd5S5VbZ5c/uQdViQ=; b=0jpTyUIiQct6ncNEVqV++bA1iC
	4U5zIlpkbxxXs6nddLTWg4eqgGHRLtCoN4Dk7cVdoabbyLwRgA8r9euN7XJoqVATJa2BXYuGyoxQw
	hllWXYZXWf9nLHmHVa3JAEGzy6SXecwVWm864V3hyKlI/1fgpi7NQ0c/53PSHUH/8nBnFfQ8RGImZ
	VZXoqMhaieoqAdJLQ2POYwD6xo8MKjhK7jQC0Y6xuWpN4z5VX+LQa1wZKs/scEZuu3DThSfUnQUMk
	xK5cXH8YDwv2aQtjXG7p/a7xxY7FHKNTmlj/Gr7fBaY+nydZCl9KJoM7UQA0pC2C4eWeEDwk9VP0Q
	6siKdAuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2ya-008NbO-U8; Tue, 15 Mar 2022 08:56:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2yX-008Na2-AB
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:56:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 96D8468AA6; Tue, 15 Mar 2022 09:56:14 +0100 (CET)
Date: Tue, 15 Mar 2022 09:56:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 axboe@kernel.dk, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 09/17] io_uring: plug for async bypass
Message-ID: <20220315085614.GC4132@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152711epcas5p31de5d63f5de91fae94e61e5c857c0f13@epcas5p3.samsung.com>
 <20220308152105.309618-10-joshi.k@samsung.com>
 <20220310083303.GC26614@lst.de> <Yi9SVXAs8TlIcIkU@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi9SVXAs8TlIcIkU@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_015617_523598_FF85AF0D 
X-CRM114-Status: GOOD (  12.08  )
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

On Mon, Mar 14, 2022 at 10:33:57PM +0800, Ming Lei wrote:
> Plug support for passthrough rq is added in the following patch, so
> this one may be put after patch 'block: wire-up support for plugging'.

Yes.  And as already mentioned early that other patch really needs
a much better title and description.

