Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E720C77B6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Apr 2023 05:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FObmSp5JXdw5HQ/AJuL4yuNez8ff68Ob2+aforFnhrM=; b=alu4o+aFg5zJndfxSN7+Q3PeL9
	3TpALwYC0CWdhqdT+vr9CBdu0u0qajPaSB9GyTUEnpsPlr2NSK2+wlZWFeYcfSkM8Yi9zBdYT4g3w
	No/bNOBt2GvGaI0xAP7dcngTMf7v0/s2sSmM/rLrvhD/AD9FazfAlUTU7UhrS4t/zB7hfW2rNk3xn
	G9aT0UgtNBYeN04HRxbUBx4vm+QgLNgapBZEETOQFYxwc0D6Olo+NfN6G7T1QqYhNf76nAxnQEhcS
	hgE1uxfQWzZ2wBamvgzGea7s1ItSC0w4np4NSnIIBAmGvkwSYQJ9fjtMinEwi/A17qmQtc9ZlSNHu
	O3B/O6qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnBkC-008Kln-25;
	Fri, 14 Apr 2023 05:13:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnBk9-008Kkx-1e
	for linux-nvme@lists.infradead.org;
	Fri, 14 Apr 2023 05:13:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E50068AA6; Fri, 14 Apr 2023 07:12:59 +0200 (CEST)
Date: Fri, 14 Apr 2023 07:12:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung
 PM173X
Message-ID: <20230414051259.GA11464@lst.de>
References: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com> <20230321132604.GA14120@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321132604.GA14120@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_221305_714234_327840B0 
X-CRM114-Status: GOOD (  12.40  )
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

On Tue, Mar 21, 2023 at 02:26:04PM +0100, Christoph Hellwig wrote:
> Can you send a patch with a new quirk that just disables the EUI64,
> but keeps the NGUID?

Did this go anywhere?

