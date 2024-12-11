Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F120E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 07:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e1osGU6dohdbtQy7kFBVIRbn/qIG5QaiQZJne9dI/IE=; b=rqEd746yAuf5Z52+YgC7ifa2El
	WcNbzrQS/ImBGiH15szWWfstT9MB5oBJknUqpOdiPx3JTj7B+GQlJ4e0qyleWksjo6RFkFPjpEFMv
	EZXdxLwhO8o8j+msHecmfbnMYYggzFehD48fW6LpJUSw84tz0cfyMTh88eqsuWOux1LiiXyVkg3qT
	k8wibnRgRRJvgR24NfIk0y0vBQC866UcplNq6UOV+vN2/GcDd0mhZeZnGmbbuofq+q6YRHX/bLsFA
	SBXG/DBZCzpaQwI78RGH9pyA5Ex9vIwEgjVkAfg6gO1H1zRaBY3diEkZenadaed6E51Sg+I51VfMU
	n2zI81Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLGv6-0000000E1U6-0EGR;
	Wed, 11 Dec 2024 07:14:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLGuz-0000000E1Tg-4BFI
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 07:13:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1410E68D12; Wed, 11 Dec 2024 08:13:51 +0100 (CET)
Date: Wed, 11 Dec 2024 08:13:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv13 00/11] block write streams with nvme fdp
Message-ID: <20241211071350.GA14002@lst.de>
References: <20241210194722.1905732-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210194722.1905732-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_231358_177797_35F68345 
X-CRM114-Status: GOOD (  10.65  )
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

On Tue, Dec 10, 2024 at 11:47:11AM -0800, Keith Busch wrote:
> Changes from v12:

The changes looks good to me.  I'll ty to send out an API for querying
the paramters in the next so that we don't merge the granularity as dead
code, but I'll need a bit more time to also write proper tests and
stuff.  For that it probably makes sense to expose these streams using
null_blk so that we can actually have a block test.  If someone feels
like speeding things up I'd also be happy for someone else to take
that work.


