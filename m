Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B92C87FCB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eywHmgbuAklTuvcha3dlnZjI+g+cZEhlnvFSk1YRAM0=; b=CC3HoyOZCpybCIYAC2/P/V9wcZ
	8xRdPk6/SLQCztCuCRJ76kHikP0hQyRRJxbvCXJzERSg4xY+hLMcZVoKNdraSgC7DcD4eT3MdPH0E
	34fk+8g6OYENXZlNAb5ZtyJUutBhK1xN6r91O0rMXGmbFWqaGvAsGT9S0VCbluC/dw/jkPHzaGyhG
	7iNcnz4NKu9fSyzTrV/nhKBdMbNsWnGZGr+0lOQ3F4rABCbc45Wp7+zcl2HcxzYRMuCiR+0mHLEgC
	43czLbMiluiT4PQYJQMRq3PLDgd/X/plgZXhqXxe4afnt/EUJMDsenIg5VRghy6M2JUhEha6Z7LBK
	KU6XOwVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfYi-0000000FV7s-0kHU;
	Wed, 06 Aug 2025 14:56:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfWW-0000000FUlJ-0Xgc
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 14:53:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9FCEF68B05; Wed,  6 Aug 2025 16:53:34 +0200 (CEST)
Date: Wed, 6 Aug 2025 16:53:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250806145333.GA20102@lst.de>
References: <20250805195608.2379107-1-kbusch@meta.com> <aJKLGy9UkVjJTIIQ@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJKLGy9UkVjJTIIQ@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_075348_316015_AAF0B770 
X-CRM114-Status: GOOD (  12.71  )
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

On Tue, Aug 05, 2025 at 04:52:11PM -0600, Keith Busch wrote:
> On Tue, Aug 05, 2025 at 12:56:07PM -0700, Keith Busch wrote:
> > +	bv = next->bio->bi_io_vec[0];
> > +	bvprv = req->biotail->bi_io_vec[req->biotail->bi_vcnt - 1];
> 
> Hm, commit 7bcd79ac50d9d8 suggests I missed something obvious about not
> being allowed to use 'bi_vcnt - 1' for the tail bvec of the previous
> bio. I guess it's some stacking thing.

It is bio cloning and splitting.  bi_io_vec is the original payload added
to a bio, and directly accessing it is only allowed for the submitter,
i.e. usually the file system.  The I/O stack always need to go through
the bio_iter to deal with split/cloned/truncated/partially completed and
resubmitted bios.

