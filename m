Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37BAD1CDA1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 06:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4rT8jMa/m5c8vo6FHcVLlfqnyvfzSi9QxUdG8tGzbso=; b=PnAnWeNZijjAXdrMsoAdqbqH0J
	luPxqh4B/biu5qY1fip1yxaj19fdicPO4G7mEphe8t5FSwea5fUsZY6t+E+REi4pDLYgkDDvHc0Dg
	56g+qYLZ1ecFs6TdyxLBngNAMe6fASIYNxIJMYVnV457851DHayUT7UeJ63k5Szr+sCooscG6mAM4
	I8pda6YeQxSBgntzFZNy3YYdrgvht9cYTCaJz1/VTAonoPe4qsmHu2iM5dXoXmdkah5q7MU7dulKd
	XovBR2GLrjjdYgoBrLd8fiWse2YNDYRyKUJvyrhxhicThH/Zw3UZit1C6RF16tRcLksK6J6j/XMjt
	ORkdIrrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t382Z-00000009kdC-3pBw;
	Tue, 22 Oct 2024 06:06:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t382W-00000009kcc-34f2
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 06:06:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6F963227AAC; Tue, 22 Oct 2024 08:06:39 +0200 (CEST)
Date: Tue, 22 Oct 2024 08:06:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
Message-ID: <20241022060639.GA10510@lst.de>
References: <20241021110331.125962-1-kanie@linux.alibaba.com> <20241021110331.125962-3-kanie@linux.alibaba.com> <ZxbWxuzH3u6hAezr@kbusch-mbp> <b4bde72c-7123-4594-a064-a39aef7fa7ec@linux.alibaba.com> <ZxcIxhQMYt2fsPiY@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxcIxhQMYt2fsPiY@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_230644_934896_85DCA2E3 
X-CRM114-Status: GOOD (  17.58  )
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

On Mon, Oct 21, 2024 at 08:07:02PM -0600, Keith Busch wrote:
> I see, thank you for the clarification. I hadn't been paying close
> enough attention at that discussion.
> 
> So, minor problem here. This new feature is 6.13 material, but our
> upstream block branch has forked before that commit. IMO, I feel
> introducing that header movement after the merge window is poorly
> timed...
> 
> Anyway, I don't think I can get away with something this large in 6.12,
> so it's going to have to be in our second 6.13 nvme pull request after
> the next rebase. I've set myself a reminder to merge this when that
> happens.

This absolutely is not 6.12 material obviously.  But having the
block tree branched of before -rc2 seems a bit unusual and potentially
problematic anyway.  Jens, can you rebase or full a recent rc in?


