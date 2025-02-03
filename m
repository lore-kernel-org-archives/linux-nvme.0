Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5FEC02193
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 06:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dunjLnqUw3arxu468fa7I+MIUA+ivzNS6yOpKXU9LiI=; b=334U+CoUP3mgOmTch93KTlEp2Y
	advU4tfZhBEORFSAZYvZ/YKnQUcEDw0oy1azs6ZV74duQBJWho/I8+J5OepR5Y+EI8dJA7Rg47u/T
	5/ZfrrfbO3pfolWbUz7naN2U/30h4Vqw/IkA8dvHwelDIBvt2KaXXZLY/wl3EI0cT7krj79Ufkama
	AQCyxTubg4bjzoLcv0PdsHBRile0Tu4SsnhHNk1LON4/oBNeTJ1nasjxqhOQ0RK/y5S+FjLlBuXgT
	37L4iooZnG1UzNfiTOLo2m9u/T4k/6CiPSCyKtDuiPdPeTun//DeqdEqSZi7nd+9RRa9RZG8vbOlJ
	3d7BFUBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1teqL0-0000000EfdK-1EuP;
	Mon, 03 Feb 2025 06:53:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1teqKx-0000000Efct-0pm7
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 06:53:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 303E467373; Mon,  3 Feb 2025 07:53:32 +0100 (CET)
Date: Mon, 3 Feb 2025 07:53:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v11 07/10] block: introduce
 BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
Message-ID: <20250203065331.GA16999@lst.de>
References: <20241128112240.8867-1-anuj20.g@samsung.com> <CGME20241128113112epcas5p186ef86baaa3054effb7244c54ee2f991@epcas5p1.samsung.com> <20241128112240.8867-8-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128112240.8867-8-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250202_225339_387175_09CE3167 
X-CRM114-Status: GOOD (  12.97  )
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

Hi Anuj,

I just stumbled over this patch when forward porting my XFS PI support
code over the weekend, which failed badly because it didn't set the
new BIP_CHECK_GUARD and BIP_CHECK_REFTAG flags.  Now for the XFS side
that was just me being to lazy to forward port, but when I started
looking over bio_integrity_add_page users as part of doing this I think
I found a regression caused by this patch.

The scsi and nvme targets never sets these new flags when passing on PI,
so that will probably stop working.  So we'll need to set them and for
nvmet we could also improve the code to actually pass through the
individual flags.  Note that this is just by observation, I didn't find
time to actually set up the SCSI and NVMe target code with PI support.
Maybe we also need blktests test cases to exercise the code and avoid
regressions in the future?


