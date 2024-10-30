Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA698D74962
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 04:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wuAnQadFVWerGGx4RgVtc7Usk509+q+UcyxM7rCXau8=; b=HTp1owPgYQDvKTBxEFKp+yetLH
	b8QM7s+esVHI520RLCyiaL5dpIxs8GddnLyFJ/1VXqLwq76kP0oRKUDIw8G7QxIdGHToRjT07k5wO
	tsMYUtCr47C414MWXLz8hyKgg1hqqJk/DUPn+6niXmJO2dgbCztJ9Z8aaP3WYZlTfbpxCT8//EYo+
	Vm+QnlMw6P2e1pSjI0o55mSPk/xn82sI0z04YsKImMdf+oUZ2VHHFpQLiNtQWiD9D5RlSjN+blbT6
	XcFsYdGdDQN/NYkl7Pg934ctzHnTlgScWQLiqMjOE9mlDJe8FDQ72sw6I/BOckd5K16Ch6s4LAHG0
	ouKeDTnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t60cm-0000000Ghw3-1Ncy;
	Wed, 30 Oct 2024 04:48:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t60bm-0000000GheR-18xU
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 04:47:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD0F5227A8E; Wed, 30 Oct 2024 05:46:58 +0100 (CET)
Date: Wed, 30 Oct 2024 05:46:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
	joshi.k@samsung.com, javier.gonz@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv10 4/9] block: allow ability to limit partition write
 hints
Message-ID: <20241030044658.GA32344@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241029151922.459139-5-kbusch@meta.com> <a1ff3560-4072-4ecf-8501-e353b1c98bf0@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ff3560-4072-4ecf-8501-e353b1c98bf0@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_214702_478648_EB9FA3D8 
X-CRM114-Status: GOOD (  10.60  )
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

On Tue, Oct 29, 2024 at 10:25:11AM -0700, Bart Van Assche wrote:
>> +}
>
> bitmap_copy() is not atomic. Shouldn't the bitmap_copy() call be
> serialized against the code that tests bits in bdev->write_hint_mask?

It needs something.  I actually pointed that out last round, but forgot
about it again this time :)


