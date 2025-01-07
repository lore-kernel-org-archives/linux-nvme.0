Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B95E77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NXBzlsyXhru+85r8ZbescYZI6qXq2U6YF/g8I4MW+hY=; b=0QLZwamg7ZsLQJHdU+BldcLgID
	6MQ4ZlZC6gEDoVGXiXL0GHNQnrRzqKg3dUcjiqndFmOvTA+TvupXv7vj38sbramCUzOm7bkcrywzT
	Tw2B6llxouU3mXVbPO7xEYzfGjmE8ElynaIGNacLgjgjL0IhZ4X4A2eHEI/vnyxgRK5HhlrXpo9pB
	uOcBzouFaN6bkH/eCjn2HywyMIVcNKucNJV9Ql9mJz0f6UqH+6sZGZXJ//JpioZ1SNKseFxFuUf7l
	aRXguVgT/yJhXhoHYlwTvObNPf1VWDdrNzsz299jMQQ76XZ9bY0RBhFjIMm7aTy21NzSJHAqgsCWE
	kk6eWzsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV5Q3-000000040a8-0wHw;
	Tue, 07 Jan 2025 08:58:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV5Pz-000000040Zf-443W
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 08:58:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E40C968AFE; Tue,  7 Jan 2025 09:58:25 +0100 (CET)
Date: Tue, 7 Jan 2025 09:58:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	nbd@other.debian.org, linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 6/8] nvme: fix queue freeze vs limits lock order
Message-ID: <20250107085825.GA16827@lst.de>
References: <20250107063120.1011593-1-hch@lst.de> <20250107063120.1011593-7-hch@lst.de> <96c48ba0-3db5-4504-a456-e57440aa1b56@linux.ibm.com> <20250107082224.GB15960@lst.de> <263963d9-ac40-4f87-b38a-edb4202d294c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <263963d9-ac40-4f87-b38a-edb4202d294c@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_005832_153084_C9FEE632 
X-CRM114-Status: GOOD (  10.46  )
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

On Tue, Jan 07, 2025 at 02:15:05PM +0530, Nilay Shroff wrote:
> The nvme_set_ctrl_limits() sets certain queue limits which are 
> also used during IO processing. For instance, ->max_segment_size
> is used while submitting bio.

nvme_set_ctrl_limits only sets them in the on-stack queue_limits
structure, which is local to the calling thread.


