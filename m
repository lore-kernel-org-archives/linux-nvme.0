Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498B5C7EE2E
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jun 2023 09:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bQ4hxpwi6OE6UTVICd0IkPx6VL5XPse1f31cPM2BFIE=; b=wq1nKo5kaVCbF2IAja15sIcZQ0
	TqodC+GPQXcu5gT5CnzacZz5O6LlXv09S4Z4mkh33vE8+H7EaZ9qBMOcLhbZcj4HG1q4R+NqxZ8tI
	v2gkQIN3kG856zbhKsUeSaI1b3qgUx2m0muQPLg40g0G7Rfy9rF32r+nThtGgk2289+BxqpAcB96M
	Jv/BgvhAP2RRl98+vSNpscZI0EEikoXOcEIQyrftHST65vkbfEtxeFKut70pRLDS8rIr7DuAKG/7P
	EYUKHc53WHnu8Z2zvUVTEvMSE4qe4x0oh3NDFGOyxpVG9dyqCmOBJLJ7+WAfaxyfnC3Cymb3qBUxA
	aj2V782A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7BZe-008dgQ-0n;
	Thu, 08 Jun 2023 09:04:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7BZa-008dfU-0T;
	Thu, 08 Jun 2023 09:04:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A178768AA6; Thu,  8 Jun 2023 11:04:44 +0200 (CEST)
Date: Thu, 8 Jun 2023 11:04:44 +0200
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
Message-ID: <20230608090444.GA15075@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-7-hch@lst.de> <ZH+6qd1W75G49P7p@equinox> <20230608084129.GA14689@lst.de> <ZIGVn9E9ME26V0Gn@equinox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIGVn9E9ME26V0Gn@equinox>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_020450_326678_AADD0A8F 
X-CRM114-Status: GOOD (  13.16  )
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

On Thu, Jun 08, 2023 at 09:47:27AM +0100, Phillip Potter wrote:
> Yes indeed - I was under the impression it was appropriate for a
> maintainer to signal their approval of a patch to maintained code using
> a Signed-off-by tag due to their involvement in the submission process?
> Apologies if I've got this wrong, happy to send Reviewed-bys by all
> means.

Signed-off-by is for the chain that the patches pass through.  You add
it when you apply or forward the patch.  Just give me a Reviewed-by
tag and say it shold apply to patches 1 to 6 and I'll add it.

