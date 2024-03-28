Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEECC54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 06:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gt7etuwg5xw15QOsg+f5mw1SjStuIsAa5vGxSYG2+ck=; b=eEBJLCyF82ar6RXKMp4AdhD4JY
	NSfOYUfSytCCRstqYxuOlrXoXr3S3iEmQ3jzx0prd+st0+TiLiDGHTFDeyDKdXv1gX/BQ/JusxnM5
	Bz+F4DLHf9O+rypH7sVAxmYb+gOv4q1WhJ98dRZ1H3R9kYP+kbIDkanxDwY7cNFsckx2jBeT/6pOg
	FwdD9x9upl1rA3lIptFL5/Uj/IqOCcfGXCgggCXV3gFMjOl26WaFJGK0lLnAVQBgyyn4OF8bO431D
	ciIsCgWgV955iIYaHO26Yiv84s4HiUYnAncv9eCcAQn9u8dESU4rI8W66Ix5fYaewu/YJvyy8h8if
	0XUVI3DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjP4-0000000Cjx8-2gyj;
	Thu, 28 Mar 2024 06:38:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjP2-0000000Cjwd-2K9G
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 06:38:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50B2A68B05; Thu, 28 Mar 2024 07:38:16 +0100 (CET)
Date: Thu, 28 Mar 2024 07:38:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
Message-ID: <20240328063816.GA17642@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-10-dlemoal@kernel.org> <20240328043016.GA13701@lst.de> <714d0cbc-be4d-4aa9-b200-73c6caaa1d18@kernel.org> <20240328054652.GA16237@lst.de> <7d8f3ec4-c416-445f-92db-7d2b60726821@kernel.org> <20240328060357.GA16819@lst.de> <ca3fe7b0-7e27-4ac9-b669-5263c3cec550@kernel.org> <20240328062237.GA17225@lst.de> <0d54c569-f586-4b75-a8a3-509e3f3717e2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d54c569-f586-4b75-a8a3-509e3f3717e2@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_233820_756411_07AE8EAB 
X-CRM114-Status: GOOD (  14.06  )
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

On Thu, Mar 28, 2024 at 03:33:13PM +0900, Damien Le Moal wrote:
> Ha. OK. I did not see that one. But that means that the plug kfree() can then
> block the caller. Given that the last ref drop may happen from BIO completion
> context (when the last write to a zone making the zone full complete), I do not
> think we can use this function...

Ah, damn.  So yes, we probably still need the rcu head.  We can kill
the gendisk pointer, though.  Or just stick with the existing version
and don't bother with the micro-optimization, at which point the
mempool might actually be the simpler implementation?

