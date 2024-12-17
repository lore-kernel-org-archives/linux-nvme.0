Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE29E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DTGdy72PWLurPoqxeJ8esmMng2fZpQkh5wlva0k4QRw=; b=kZFbORukHYwir6KKlZan/11xVM
	daamQomx7eFeF5759MHd9RiFEWoLn2DY/vj3PQkBM0KDsfjn7d4HurQts0oqvkdgL0nI4VIC/PqFq
	+WBs8KE+6vcT78h9dmGjm/xnijPmyw0hLRg6aisDT5dUouQrR2u/Ym8QDctJbMdIJRoChIRmQkV56
	N1T5lQFYobtb3+3ib6HkiI5Wb7tbX0fbIvWNFWiIraHbXO7d8PoTNHh8aGsXOTtiL4r2xqg6zoh8D
	IFmUs6XRM+PDjJWf3JLs0C9/Z9P88aTx2TViRxGeeDFVaad1Bap1Fds66UmYjUJJV6bm5rtrdEViR
	wz0FeqRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNSt0-0000000ChOf-2YCE;
	Tue, 17 Dec 2024 08:24:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNRVF-0000000CUd8-08NL
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 06:56:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E725668B05; Tue, 17 Dec 2024 07:56:14 +0100 (CET)
Date: Tue, 17 Dec 2024 07:56:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <20241217065614.GA19113@lst.de>
References: <202412122112.ca47bcec-lkp@intel.com> <20241213143224.GA16111@lst.de> <20241217045527.GA16091@lst.de> <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_225621_212399_22C7DF9D 
X-CRM114-Status: GOOD (  10.91  )
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

On Tue, Dec 17, 2024 at 02:55:23PM +0800, Oliver Sang wrote:
> from below information, it seems an 'ahci' to me. but since I have limited
> knowledge about storage driver, maybe I'm wrong. if you want more information,
> please let us know. thanks a lot!

Yes, this looks like ahci.  Thanks a lot!


