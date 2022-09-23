Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B677ECAAD8
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UorYsw2Q0RA5v1p3DScoB0Hc2dP1ZUZpZTV/kkTX85E=; b=46bo3llYG/fZxMkutwtdlsrhcP
	SjJuwI2/dGy7IHD2E7PDfH059GRBtkLYcy+N7d5zjR37XM/tL7sX6Y67RRD9phe63SgEYtvkHixTT
	E9vRd/WGsJwM7m8Ff8VqUpac6YSpoT4baC9PbpDCs7cxotSUktkb1s1Q0LZPtPqzIEXZB/2dLoSTd
	/FNuWzdpK9keLg0L6cePi4ortwQpQnPVBXaFko0PdEXPPSadfzYkMdFN9T5/2y4FycPWQ1q/0vrjy
	TNAa5A+MLJEQqgKbBsB/l/B2f6Pxpn6sLFVlov8fqZAmpul4kvJP8DZWvuvS2e4tjbMiAaxapy0RQ
	+PH+4jNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkPj-004lwt-20; Fri, 23 Sep 2022 15:16:27 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkPg-004lw7-Tj; Fri, 23 Sep 2022 15:16:24 +0000
Date: Fri, 23 Sep 2022 08:16:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHSET 0/5] Enable alloc caching and batched freeing for
 passthrough
Message-ID: <Yy3NyACongSfayY+@infradead.org>
References: <20220922182805.96173-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922182805.96173-1-axboe@kernel.dk>
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

On Thu, Sep 22, 2022 at 12:28:00PM -0600, Jens Axboe wrote:
> This is good for a 10% improvement for passthrough performance. For
> a non-drive limited test case, passthrough IO is now more efficient
> than the regular bdev O_DIRECT path.

How so?  If it ends up faster we are doing something wrong in the
normal path as there should be no fundamental difference in the work
that is being done.

