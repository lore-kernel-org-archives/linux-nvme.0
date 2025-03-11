Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA61C28B2F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 08:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qm9OfE8uvzJcTX+25bKHtJ+IzR9fN2PYAiZteHJiwx8=; b=4TL97+70v74ja6nQxmSWx0t/HS
	vik83kTTLUAVfXVs2Ot279Ru9CwH1cq+TW7m44VGCVo4j5Z2Hea34EC84aA8EITwUgtmG0yxVHLzW
	hNTNoa0Jh2u6hEHsVYfohnmY6/oapmfobjseH404K+5XAM9vcrjavQYSoyA9NAfM6g83++PZddOLb
	bTIN1OT30a2erKyYNWomReHyRZ9u/WoQr0zVtJasF6JNCdmGDcfV5k57i60E6/OqUbAAQBTEJnPdb
	1kqkn1mkIlpR9we9NXUgXfdNsVoVdeTcnM5lp5sp+P0g3McJNN87GvScsXwXjsJavOZSrWfvgRJ4Z
	ddQjb4hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trual-00000004w79-3szP;
	Tue, 11 Mar 2025 08:03:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1truQy-00000004uxd-2wPp
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 07:53:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 24A3767373; Tue, 11 Mar 2025 08:53:47 +0100 (CET)
Date: Tue, 11 Mar 2025 08:53:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Jianlin Lv <iecedge@gmail.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, jianlv@ebay.com
Subject: Re: [PATCH] nvme-pci: Remove NVME_QUIRK_BOGUS_NID for device
 vendors
Message-ID: <20250311075346.GB14844@lst.de>
References: <20250308141102.34101-1-iecedge@gmail.com> <Z88aRU7Bq3SYtyyO@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z88aRU7Bq3SYtyyO@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_005352_878311_0BA02883 
X-CRM114-Status: GOOD (  11.40  )
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

On Mon, Mar 10, 2025 at 10:58:45AM -0600, Keith Busch wrote:
> Setting the quirk on demand lets the first scanned namespace export the
> "unique" identifiers as their own. Scanning isn't deterministic if you
> have more than one, so you wouldn't readily know which actual namespace
> a particular /dev/disk/by-id/ link points to.

Agreed.  The fact that we even allow the devices through is just to bow
down to the greast Linux dictator.  It's still a very bad idea for all
the same reasons as it was before.

