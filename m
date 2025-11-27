Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B83BCFD2F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JB6Vn8jaGZJZFbHXqiLHtPjpjF68p2nfQjOHbcKK9KQ=; b=4+J4SamGc0Xulk/BYqEtvhsr3K
	35dqWS9BJlvHgYYgAUJBCRwpH3h9EUflfBf8gl7XedQN+w4/E/LMgkDvx2ErbW/uNPqIUVug90FT2
	+sB3kDg7oSTMRnK2HjPoAfy3WYj2LZaCdlwl8CYkgJJOB8AwdWApFMMtBEc6ELb4UZms3bv13bLAW
	9lHfUzVj4QXbEfObak+C/VsF7DU2tvPqpiR40yK870jEfiuAZs2Sfpw5c+Oa3Qnpugir2xqrDoSi2
	9M6wh8WrMFQH1UGuYQcH0Xtuhd1Ot7FGOFiEsnlWyXv0urn7Zf1kNUoEncDJD7ocGJAyNiLynQ3Rs
	BYfEUexA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdGn-0000000GntS-37yE;
	Thu, 27 Nov 2025 14:46:53 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdGl-0000000Gnt0-2Jdy;
	Thu, 27 Nov 2025 14:46:51 +0000
Date: Thu, 27 Nov 2025 06:46:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Stephen Zhang <starzhangzsd@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO
 Chain Handling
Message-ID: <aShkWxt9Yfa7YiSe@infradead.org>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSBA4xc9WgxkVIUh@infradead.org>
 <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
 <aSP5svsQfFe8x8Fb@infradead.org>
 <CANubcdVgeov2fhcgDLwOmqW1BNDmD392havRRQ7Jz5P26+8HrQ@mail.gmail.com>
 <aSf6T6z6f2YqQRPH@infradead.org>
 <3a29b0d8-f13d-4566-8643-18580a859af7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a29b0d8-f13d-4566-8643-18580a859af7@linux.alibaba.com>
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

On Thu, Nov 27, 2025 at 03:40:20PM +0800, Gao Xiang wrote:
> For erofs, let me fix this directly to use bio_endio() instead
> and go through the erofs (although it doesn't matter in practice
> since no chain i/os for erofs and bio interfaces are unique and
> friendly to operate bvecs for both block or non-block I/Os
> compared to awkward bvec interfaces) and I will Cc you, Ming
> and Stephen then.

Thanks.  I'll ping Coly for bcache.


