Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE91C677C4
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dWcHYpA31JbmA2nac8ihY9TAm4SVn7mlu2jy9ZxK5Bc=; b=onXewYu9Uhy6SkJEs/olr0IgNE
	Ot9Xf9rBEcEZUVRScVtlDonM9qdjENXw08dpl6InBBVnlrBXlLH0iqbxJjiQCKQ1xQA5HzenNbopE
	IV+Rev+XUi5TBFBeoG6qVoOeBkJ2pvlplvfoEr45A3IguxJOvVyCWHW+IysV7gPxnvDwBOoRizc2O
	5xBhCKmIuHMinRR7cHVwd7F70lGbEpTUxzBPtvXsdOR222ldJnzVbRiGeOtUiEouP2UqD6Uz13Fo5
	7jxXPAgUpuwT9PtWtjX4UgvRGDlzlivUUKX1IJPu13CcyDCfhzpFT8b45LtEJnLLqgcQgPZ/eip9O
	A6GNI1tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP4dh-00000007v5J-35OD;
	Tue, 10 Jun 2025 19:28:05 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP1GV-00000007Nom-1abE
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 15:51:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1DD0EA51427;
	Tue, 10 Jun 2025 15:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8356FC4CEED;
	Tue, 10 Jun 2025 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749570713;
	bh=JQ0QQNCQ2xeKuiosGsHSQtXrqmR8dk9QsZKLN5vpNjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnXTAOgWAfWMUGwgZ3hA0GiMZPvvwyg5Yzo8ysOh4d1ryyUmmTQojadcm5j0XbQHI
	 j4giiNPDfYZzGG3Rqj1I9Zo9U/MOz4EHPZnU+Zh0qfcoMKjCt9CfSWHzthE3lVH3RR
	 Q6HILFxkd8kCsSY37cQbAUQyu/lhvtPt77qhDS91zV4F7A6oqkxJR+68JeQ53lLdgD
	 sriMYBEaegPzhK3cK3KeFodsBEDwm2qE99gsL92Ox76m6zaLD03VQk7LDeWTawzsM5
	 EeojJZx0S9Ew6h/3EKCc3m492CPqt0x4t7QhvpgmipZa8+YzudcBtbsuEw3hV4fw+9
	 MgR9WyePNeE8Q==
Date: Tue, 10 Jun 2025 09:51:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCHv2] block tests: nvme metadata passthrough
Message-ID: <aEhUlw8H2ZD98SpY@kbusch-mbp>
References: <20250609154122.2119007-1-kbusch@meta.com>
 <pgyqdqi76m7skiyirtjb3d7wtbb5223sk64eoqtafg7r763biw@7f4pdqtoptiv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pgyqdqi76m7skiyirtjb3d7wtbb5223sk64eoqtafg7r763biw@7f4pdqtoptiv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_085155_486016_3ED221CC 
X-CRM114-Status: GOOD (  16.37  )
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

On Tue, Jun 10, 2025 at 07:31:10AM +0000, Shinichiro Kawasaki wrote:
> Thanks for this v2. With the fix above, I was able to confirme that the test
> case passes with v6.16-rc1 kernel. When I reverted the kernel commit below,
> it failed. It looks working good as the fix confirmation.
> 
>  43a67dd812c5 ("block: flip iter directions in blk_rq_integrity_map_user()")

We should probably put a "Link:" tag in the commit message for this:

https://lore.kernel.org/linux-block/20250603184752.1185676-1-csander@purestorage.com/
 
> To run the test case, I tried QEMU nvme emulation devices with some different
> options. I found that the namespace should have format with metadata, and
> extended LBA should be disabled. IOW, QEMU -drive option should have value
> "pi=1,pil=1,ms=8" for the namespace.

That's fine, though you don't need to set protection information
capabilities for this. The test will still run if you enable it, but
it's probably better if you just let it be opaque metadata. You can also
test with ms=16 or ms=64 as both are supported by qemu's nvme device.

> I suggest to describe the device requirements in the test case comment. Also, I
> suggest to check the requirements for the test case, and skip if the
> requirements are not fulfilled. FYI, I prototyped such change as the patch
> below. Please let me know what your think. If you are okay with it, I will
> repost your patch together with my patch for common/rc and tests/nvme/rc as the
> v3 series.

Your changes look good. Thank you for the suggestions!

