Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B328CCD6E60
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KqGEmNyA5hT2LLfsgXtkSAUY2yGrhW9fUacz4P9Ho98=; b=SBgSgynOH3CigxTEwM7qyTrnay
	7bXXpQLjRqi5I440VVbVpDtUPeL9zl5VNu3L0vLJNZrZzBBzkhH+vbBQlrCQAyNehxa7MI+d7sPvi
	xzYhpkLZaWOBmMvVO0tV2sm/J0Xw2zfUpUHrDJGH0oTprk6yL94Lqc8J2uDEA3QIDbe+4XYyralc5
	E5SIUrrC2KgduLDg9I0dmv72XpumQXKjbQxCjA9MyfcEbwpwg4peQg8vzcVy+FUzQlGibB+Uz9jB5
	1mvmdCHqHnt6wAE+BOZhZrFdQwi+7YwVaRC0rkbQpfDVYOL3zZchcC0lMfN8fQxDAqKqFtrTwgji2
	K9KFk5bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wURG8-0000000DM4R-0SPF;
	Tue, 02 Jun 2026 15:42:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wURG7-0000000DM4L-1kib
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 15:42:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C8620601E9;
	Tue,  2 Jun 2026 15:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292C51F00898;
	Tue,  2 Jun 2026 15:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414946;
	bh=KqGEmNyA5hT2LLfsgXtkSAUY2yGrhW9fUacz4P9Ho98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nWFze1K8ww8P+C3c7ENGikKa3kP5LgZu+2tT2UAh6APf1KvvciyP55h/Xsynfkzh0
	 HdRCjql0Tu/UfagIvZ3yn6Iy/4qbjIPOTQuXZeT99/5DEf/B4kGsYZI3GQOCqsIm7Z
	 GzN0MG2bRKPqKQZfWQbDzvC5BWml1F+nXTVhx5fzXCyuARqAcqUCIEp2zBr5KHJEJ5
	 F6z1Cy23Q3Ya11o9ClQoK0PGQYbYyjvQ5G/3wSiM0ARrfrriykpJrQE0nwW/ekMGng
	 AV5uir1SA+sH5KDISxf+m6CRJe6x5hjHGG0gDqf4dtulNGbo2clZlS7Zo42q0Sordy
	 UWCx4b/26hGqg==
Date: Tue, 2 Jun 2026 16:42:19 +0100
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Chao Shi <coshi036@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v3] nvme: core: reject invalid LBA data size from
 Identify Namespace
Message-ID: <ah752_DIQdr_LHaB@kbusch-mbp>
References: <20260515185853.2761456-1-coshi036@gmail.com>
 <0938b6f8-8001-4fcf-95a4-327fa9077163@oracle.com>
 <ah7znSpPM-H-ACaV@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah7znSpPM-H-ACaV@kbusch-mbp>
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

On Tue, Jun 02, 2026 at 04:15:41PM +0100, Keith Busch wrote:
> On Tue, Jun 02, 2026 at 02:10:07PM +0100, John Garry wrote:
> > On 15/05/2026 19:58, Chao Shi wrote:
> > > +	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
> > > +	    check_shl_overflow(le64_to_cpu(id->nsze),> +			 id->lbaf[lbaf].ds -
> > SECTOR_SHIFT,
> > > +			       &capacity)) {
> > > +		dev_warn_once(ns->ctrl->device,
> > > +			"invalid LBA data size %u, skipping namespace\n",
> > > +			id->lbaf[lbaf].ds);
> > > +		ret = -ENODEV;
> > > +		goto out;
> > > +	}
> > 
> > JFYI, this is giving a C=1 warning:
> > 
> > drivers/nvme/host/core.c:2411:13: warning: unsigned value that used to  be signed checked against zero?
> > drivers/nvme/host/core.c:2411:13: signed value source
> > 
> > I can't seem to quieten it myself, though.
> > 
> > BTW, I would have thought that check_shl_overflow would catch
> > id->lbaf[lbaf].ds < SECTOR_SHIFT (so that we don't need the extra check).
> 
> I see it too. check_shl_overflow has checks that suggest it was
> expecting a signed type, as all the < 0 checks don't make sense for
> unsigned. The warning seems harmless, but I'd too like to see it
> suppressed.
> 
> I think it's odd that I'm not seeing a similar error for the similar
> usage in generic_check_addressable() from fs/libfs.c. They look the same
> to me with respect to the types passed in.

It appears that sparse is having trouble with the type provenance of a
__bitwise __le64 type. No idea why. As a test, I replaced the
le64_to_cpu() to a u64 type on stack initialized to a random ULL value
and the warning goes away. I say we can ignore the sparse warning, or we
can rewrite this to avoid the check_shl_overflow entirely.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cad9d97352615..6409a8218e3eb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2372,8 +2372,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	struct nvme_zone_info zi = {};
 	struct nvme_id_ns *id;
 	unsigned int memflags;
-	sector_t capacity;
-	unsigned lbaf;
+	unsigned lbaf, shift = 0;
+	u64 capacity, nsze;
 	int ret;
 
 	ret = nvme_identify_ns(ns->ctrl, info->nsid, &id);
@@ -2407,10 +2407,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 			goto out;
 	}
 
-	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
-	    check_shl_overflow(le64_to_cpu(id->nsze),
-			       id->lbaf[lbaf].ds - SECTOR_SHIFT,
-			       &capacity)) {
+	nsze = le64_to_cpu(id->nsze);
+	if (id->lbaf[lbaf].ds >= SECTOR_SHIFT)
+		shift = id->lbaf[lbaf].ds - SECTOR_SHIFT;
+
+	if (shift < SECTOR_SHIFT || shift >= 64 || nsze > U64_MAX >> shift) {
 		dev_warn_once(ns->ctrl->device,
 			"invalid LBA data size %u, skipping namespace\n",
 			id->lbaf[lbaf].ds);
--

