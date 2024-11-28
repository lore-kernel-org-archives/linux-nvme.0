Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D534D6D255
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2024 03:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YP45EUk7tL9INNC4paefv19mGVC5isgpfyWc9fv757I=; b=sSu64G37lYF94SpkMTWn3WVDu8
	QQSg9svkQEjEwpadXoNLrJ67zyeA77Onj7hhVJ4JqT9N78KHTVppClT3ZMyIyBEC/nOSImr0tdk8n
	LD5MxMi+TAeH1p04Qzve8SHJi1DRmWw8hOmcBHt/AqG5qmqjo0mfPJGSZgqAKLKo9Fz5xWBQgkUNZ
	uF8QRpr/NKOBVXOXfEQik/XL5KciZ4QQWEM8ltBzgL8SCfxohV3krMPLzylbvSYzO5EP0IQWKzh91
	23tsMn8C0mUYlW//+jie9B6eNCpu44pXtuqyGkwVEy0CdERsOQucTIyrw9KnNpzDoBDBYburLItpe
	uPKHEk7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGV8b-0000000Ec9K-4AAu;
	Thu, 28 Nov 2024 03:24:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGV8Z-0000000Ec7F-2xoq
	for linux-nvme@lists.infradead.org;
	Thu, 28 Nov 2024 03:24:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8037868D05; Thu, 28 Nov 2024 04:24:04 +0100 (CET)
Date: Thu, 28 Nov 2024 04:24:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241128032404.GA12440@lst.de>
References: <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local> <2b5a365a-215a-48de-acb1-b846a4f24680@acm.org> <20241111093154.zbsp42gfiv2enb5a@ArmHalley.local> <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org> <20241112135233.2iwgwe443rnuivyb@ubuntu> <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com> <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org> <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com> <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org> <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_192415_890077_4B2E0AD6 
X-CRM114-Status: GOOD (  13.39  )
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

On Wed, Nov 27, 2024 at 03:14:09PM -0500, Martin K. Petersen wrote:
> How do you copy a block range without offload? You perform a READ to
> read the data into memory. And once the READ completes, you do a WRITE
> of the data to the new location.

Yes.  I.e. this is code that makes this pattern very clearm and for
which I'd love to be able to use copy offload when available:

http://git.infradead.org/?p=users/hch/xfs.git;a=blob;f=fs/xfs/xfs_zone_gc.c;h=ed8aa08b3c18d50afe79326e697d83e09542a9b6;hb=refs/heads/xfs-zoned#l820


