Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470D3C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ybvcRos16BZUDWjEGqsH6QmVKNBFn7FE1NWuQowi7d4=; b=AoXhyN33TsRWYUgHCbPcxFC109
	uG0Zbnrdufuz2n4Z/o443l1z7eiAXgA5HlK/SyGnDLykPuqQC4602YuEJ71dkIgVP/G9MWQTiwQga
	zX476BpABUWUexGZSKgiSWXvuQwhidm7zQBmCJQSQFTNIHcx4NBM9vF4z63b5QZ6XDt+GM2KiA888
	j7ouzM/jpy6lMtypPPWtj2gD/PWCe11TkEp4dnnykklvX4AQi11Osr/fmhFcOL1CHhLih40LH+d02
	5V2J6m0W5xSEpjC0knZjgCwj0Lu6eKNTMiEdivpsWIDzMt8jc0h6o2PkrDJ0MBg0FTWCg5i/OsxRd
	urxcO4pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pec0L-00CWDu-2q;
	Tue, 21 Mar 2023 13:26:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pec0G-00CWBW-2O
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 13:26:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 238F368B05; Tue, 21 Mar 2023 14:26:05 +0100 (CET)
Date: Tue, 21 Mar 2023 14:26:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung
 PM173X
Message-ID: <20230321132604.GA14120@lst.de>
References: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_062616_928116_0D5824DF 
X-CRM114-Status: GOOD (  10.24  )
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

Can you send a patch with a new quirk that just disables the EUI64,
but keeps the NGUID?

