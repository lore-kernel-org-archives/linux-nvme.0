Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543FDC44501
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7HvOTnLSVrhSA0vc/vHEMh/02v+9+CSjHGHkKz38PLk=; b=FORyCQbH9Ufyl5ro58UH/cg2ru
	b3NV8A6bm6SkBqeZ5fvPKkTgRfZYVSONbY53p0Ulfrvi27OpHzaz5LK/d8COrWLToxjv9XWFkQav9
	eTceOhCbI3ZEPdZFrrgs2NYK+YsR8iybNVKYBj2YaAKpeqY6/B7rK3d2zfUOblUQGmEVTqFvxY/PK
	KbcfS57/5UPg6ByMRS9FgcMiKNGKf6UjgM4k0DiUtKJmnPCv6gA/OVpuurldllyXAdwUICNlCgurf
	Z5DPp8lJFU9faXetZAFzrAjXsu9cYL/JPgI7MTEHvaWDvIXGLcTnTBd2GfADD7AFiwolB/RPc+IQD
	Sf1XNJwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdZY-0000000CFJD-1hhP;
	Tue, 14 Jul 2026 13:53:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdZV-0000000CFIZ-0acS
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 13:53:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BFDE868BEB; Tue, 14 Jul 2026 15:53:11 +0200 (CEST)
Date: Tue, 14 Jul 2026 15:53:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] nvme/core: advertise
 BLK_EXPECTED_REF_TAG_CAPABLE
Message-ID: <20260714135310.GB714@lst.de>
References: <20260627061933.2187447-1-csander@purestorage.com> <20260627061933.2187447-3-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627061933.2187447-3-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_065317_334498_8465B140 
X-CRM114-Status: GOOD (  19.99  )
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

On Sat, Jun 27, 2026 at 12:19:33AM -0600, Caleb Sander Mateos wrote:
> NVMe Read, Write, and Write Zeroes commands include an (E)ILBRT field to
> specify the expected initial reference tag for the controller to check
> against the ref tags in the protection information buffer. However, the
> NVMe driver currently always sets (E)ILBRT to the lower bits of the LBA.
> The block integrity layer generates/verifies the PI ref tags according
> to the bio's ref tag seed, so it must "remap" the ref tags, adjusting
> for the difference between the ref tag seed and the absolute integrity
> interval number (= LBA).
> 
> If a request has an integrity payload, set (E)ILBRT to its ref tag seed
> so no ref tag remapping is required. Set BLK_EXPECTED_REF_TAG_CAPABLE in
> NVMe devices' enum blk_integrity_flags to skip the block integrity layer
> ref tag remapping.

I don't really understand how this is supposed to work.  For type 1 PI,
NVMe requires (E)ILBRT to match the lower bits of the start LBA:

  If the namespace is formatted for Type 1 protection, the value of the
  computed reference tag for the first logical block of the command is
  the value contained in the Initial Logical Block Reference Tag (ILBRT)
  or Expected Initial Logical Block Reference Tag (EILBRT) field in the
  command, and the computed reference tag is incremented for each
  subsequent logical block. The controller shall complete the command
  with a status of Invalid Protection Information if the ILBRT field or
  the EILBRT field does not match the value of the least significant bits
  of the SLBA field sized to the number of bits in the Logical Block
  Reference Tag"

For Type 2 this remapping could work, but doing it unconditionally
will make all data written using and earlier kernel in a partition
unreadable once this changes has been applied.

