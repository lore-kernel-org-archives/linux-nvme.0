Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D820C7EE25
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jun 2023 08:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GAAIRqqkx4vBaceVmFUxkRJ9Ec6cSuVyQKnbanRnmp8=; b=E1ft3KkwTcAEVrmE2I5givOV2a
	MwvVbKqeDVqNh1shn/9slNGhZn+fpwYX0BBDh6Xpim/ztcZqQi2sihhJZB3R/pHi7Itn6TkzZz5zl
	pLuNEN0kSjZyFvUkVVsajOTY36K6BGBflp8I/gjiJVTkfWWJTgFUYtjEPhPgIk0cjIGRPml8Etxmm
	JVJGUyTPci2zSx8RbWsVpV/1J2PoG0hrc1sV/ew44EcKtoJKjoYli1LA8sR1FOVHu4k2dr1s7+ch5
	GJR64nC8X+xctIirAd1FxPB12XinNct0dXdhN2BPvHcBa7+Q8Cs67ucUmeepFHsLXxSZABcf0dA5D
	aNWJnJUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7BDE-008Z3F-1r;
	Thu, 08 Jun 2023 08:41:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7BD9-008Z20-0K;
	Thu, 08 Jun 2023 08:41:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9341068BFE; Thu,  8 Jun 2023 10:41:29 +0200 (CEST)
Date: Thu, 8 Jun 2023 10:41:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 06/31] cdrom: remove the unused mode argument to
 cdrom_release
Message-ID: <20230608084129.GA14689@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-7-hch@lst.de> <ZH+6qd1W75G49P7p@equinox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH+6qd1W75G49P7p@equinox>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_014139_301288_6C52AA1F 
X-CRM114-Status: UNSURE (   9.60  )
X-CRM114-Notice: Please train this message.
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

On Wed, Jun 07, 2023 at 12:00:57AM +0100, Phillip Potter wrote:
> Looks good, thanks.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Hmm, these signoffs don't really make sense here.  Were they intended
as Reviewed-bys?


