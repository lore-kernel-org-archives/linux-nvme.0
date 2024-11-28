Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1F8D70DE3
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2024 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aTk2Z/DWr6/a5hHFx66sMYNQdWGPoAfLRkMb34K5kmU=; b=cO4nBJlKztRFPcSVZ/WpNnbRa1
	pnhG1y5Oxqm+K9jbbBTxO82/UxXWXdtQIKlljvdk/2KVm8RwO31RPkYQj6uSKCQRDghcNi2wmxnd2
	Ctcd9be27X4HSbcA9CG6yrei+C3jrBVm1GQeAy82NFtIvFK4AmZSgTEHr/AhRkRxp2y3qU0XqqXCh
	4aaMeiU3dTnk0vs9IzhLmkGmRpUzs8JgH12DzlnwdhWhmC9yqur4gaFsuTlINdHSXEGb1EW+Xv0JX
	Xjw4VxhR2Tlkr9pmGRRvVbzOSSrmRqviMpTqv1z7u0YcvIuv5/zDQLDt5vdhp++e5QynbUmQshC5b
	4M91ANkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGhYx-0000000G13g-2xjh;
	Thu, 28 Nov 2024 16:40:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGhYq-0000000G12p-3CSs
	for linux-nvme@lists.infradead.org;
	Thu, 28 Nov 2024 16:40:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A7A568D96; Thu, 28 Nov 2024 17:40:04 +0100 (CET)
Date: Thu, 28 Nov 2024 17:40:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241128164002.GA26959@lst.de>
References: <2b5a365a-215a-48de-acb1-b846a4f24680@acm.org> <20241111093154.zbsp42gfiv2enb5a@ArmHalley.local> <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org> <20241112135233.2iwgwe443rnuivyb@ubuntu> <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com> <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org> <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com> <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org> <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com> <Z0iKbPttERXaiexO@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0iKbPttERXaiexO@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_084012_945757_D56F82F0 
X-CRM114-Status: GOOD (  15.47  )
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

On Thu, Nov 28, 2024 at 08:21:16AM -0700, Keith Busch wrote:
> I think of copy a little differently. When you do a normal write
> command, the host provides the controller a vector of sources and
> lengths. A copy command is like a write command, but the sources are
> just logical block addresses instead of memory addresses.
> 
> Whatever solution happens, it would be a real shame if it doesn't allow
> vectored LBAs. The token based source bio doesn't seem to extend to
> that.

POPULATE TOKEN as defined by SCSI/SBC takes a list of LBA ranges as
well.

