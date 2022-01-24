Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29203C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 13:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xEAq6ZbHJvSddIiFCmDz2W3G6/rPcwlgrTurgUxs2P0=; b=1ewir0aNWQnuwLo5sg6FTCcxoY
	ObYECLdlW/6KZMrykKVPvQ3D/jYtmSk2ZN5vQ1EQUmLu4WkOrnyclwi50E/+YMzyxZeqG/VVJmn9z
	uk63g3wdbXg1NAZvUN8OuPGLc1RBLZ2CU4J9Y2iflwaW3L/kb44LIGlYLDD/PtpA0Oe/k/PN7FRDk
	l1hZkvfBUvGq403SA4n2sydmhdXZc0iEiPfiUBv7i7yhLzlt6c9uQHXaje8ewlegLDGAVb8F/WMpK
	iLUzyYdlHDGs7JZvP/e092GTyuZPmBSiXqHxltSYCAcG3VRtL2iCTRe2LqxE/ACbsAfBGCVudriqk
	IO+WW/mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBzH0-003Squ-PA; Mon, 24 Jan 2022 13:20:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBzCt-003R1K-KW
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 13:16:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DE3F268BEB; Mon, 24 Jan 2022 14:16:24 +0100 (CET)
Date: Mon, 24 Jan 2022 14:16:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 10/13] block: add helper of disk_release_queue for
 release queue data for disk
Message-ID: <20220124131624.GI27269@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-11-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-11-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_051627_851724_1DEEB1DD 
X-CRM114-Status: GOOD (  12.19  )
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

On Sat, Jan 22, 2022 at 07:10:51PM +0800, Ming Lei wrote:
> Add one helper of disk_release_queue for releasing queue data for disk.

Please explain what "queue data for disk" is, and why this helper is
useful.  Right now it seems to just move a few things around without a
rationale or explanation of why it is safe.

