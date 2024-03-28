Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A83C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 04:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=97n0l9Cye3dcMu//qmNro8xE7Ur6T9BhpinOtQjNjaw=; b=ieq0afLduYqueYSFQ87j6/epna
	Bf2ua9UGl6AT0mnv5oTHU76GQ2PS30nCydneDuKzcHpz2V/wWfowIplSTT3hUbRX0DPCh0HhGsn3R
	683FBuswKuhHUlVWgFPYsdJ3AVtXLt47haohCjx3TpSTcVDeHJF3O0/bD/43e/54ezW0zoKHZzyIU
	qW2hus3JbR4NzajRXgW9gxzzKEP96tHvIChJVe7MYyRKbX4OS07bVB30D5e80999GKx+vB/Y/1jpc
	dnNrEfwNLfecJ/zMYm9IOt8kBE5z1A/y4+/ZoOduoy+ZsP0fEhKaymURFWkg5VXiKhxYUez+JSxDR
	V80C1c9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rph8s-0000000CMQi-3Vlp;
	Thu, 28 Mar 2024 04:13:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rph8q-0000000CMQ4-1iI8
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 04:13:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3218868B05; Thu, 28 Mar 2024 05:13:23 +0100 (CET)
Date: Thu, 28 Mar 2024 05:13:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 03/30] block: Remove req_bio_endio()
Message-ID: <20240328041323.GB13510@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-4-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328004409.594888-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_211328_616238_AD44B54A 
X-CRM114-Status: GOOD (  13.53  )
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

On Thu, Mar 28, 2024 at 09:43:42AM +0900, Damien Le Moal wrote:
> Moving req_bio_endio() code into its only caller, blk_update_request(),
> allows reducing accesses to and tests of bio and request fields. Also,
> given that partial completions of zone append operations is not
> possible and that zone append operations cannot be merged, the update
> of the BIO sector using the request sector for these operations can be
> moved directly before the call to bio_endio().

Note that we should actually be able to support merging zone appends.

And this patch actually moves the assignment to the right place to be
able to deal with it, we'll just need to track the start offset to the
start of the request so that we can assign the right bi_sector.

Reviewed-by: Christoph Hellwig <hch@lst.de>

