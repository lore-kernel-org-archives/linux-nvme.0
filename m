Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D12C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bTVdI825Tkl/OlYsGpiZED35R2B24kkizDdJnyf/b34=; b=Ww4q8S894gCVyFzrkfWRu1oEW5
	G6Zxer0irsir6+lZHJm2pF2QZNVLMoxYzWvymJy0Dann9pBXKpN0irnx7xTOTX8XtagdDYfgD3Rvd
	pjrx15By+6xK3pffRz6syG88SeRGscZ5en2rkt7dKhZaHcXhlQLu87EUFvXsHWWca9tqQVgavrhWW
	KwesaCVcUTF/Ke84mns6o4jiuZ4UugCPClA0ZRJLkII1sp4VXGLl1GYOI1pJJivFe+Ss+iPz2XtWD
	zx+v+WGEI/ZbwMp4tDVrlH8OItqntUlMuzEG/8TavW4qoEGfmYLRVDjIO+yWx/p8h85hGtt/2vUCJ
	D2oduiHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ75M-00HEt4-0R;
	Wed, 17 Jan 2024 14:40:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ75I-00HElu-0v
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 14:40:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 36CD268CFE; Wed, 17 Jan 2024 15:39:52 +0100 (CET)
Date: Wed, 17 Jan 2024 15:39:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: mengfanhui <mengfanhui@kylinos.cn>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: fix bogus request queue reference put
Message-ID: <20240117143952.GA27918@lst.de>
References: <20240117065043.79192-1-mengfanhui@kylinos.cn> <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_064004_610499_31FB8B85 
X-CRM114-Status: GOOD (  13.49  )
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

On Wed, Jan 17, 2024 at 04:04:12PM +0200, Sagi Grimberg wrote:
> How did you see this? disk->queue is allocated in blk_alloc_disk called
> in nvme_mpath_alloc_disk... I don't understand how you saw the same
> dereference that was addressed by this commit.

This looks like a backport of an old patch of yours to a geriatric
kernel to me..

