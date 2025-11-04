Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D91CCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=arSfxGGvyDJWIPxH0/L7w8rSBaW+ShK6/Qx4wR0jKzI=; b=iFiBhgjF4jAKc+lb3FgqH96Z0J
	8esBNQEc4Svxb1n2zrrla3N6zdK0MVnlh10p9HkXbJzsDcg4n21n0UHbOcmzOApA72plwprkxiPJN
	9BGhsdkQ7M+KadKcDMQA2qToAilQCSsDQG/CHBD+3k42BGEZ2VHV7Sw0Q1PtW9IedfSmhqtNigGwX
	IFYtqrDJVuoMwakKjp54seic/AOxZApGKA4PxC2Tbqnsy0SEOWnPA3uBClwLAndplTfq7NOYHT/ih
	F0fdl5Ejwwdfms+s3yj+mIxFeI0WehVON5H3o/FhjzpI+9JfnLeVmGpsboixJ8xvLVHQnNqL/gUIN
	QgDQBf6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGIEZ-0000000BzZR-1yp6;
	Tue, 04 Nov 2025 14:42:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGIEX-0000000BzZ4-0c10
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 14:42:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ECAAF227A87; Tue,  4 Nov 2025 15:41:58 +0100 (CET)
Date: Tue, 4 Nov 2025 15:41:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3 00/15] Introduce cached report zones
Message-ID: <20251104144158.GA27416@lst.de>
References: <20251104013147.913802-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104013147.913802-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_064205_327039_550B5A9F 
X-CRM114-Status: GOOD (  11.86  )
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

I just threw this into my xfstests setup, and it seems this version
is broken somehow.  Running on emulated ZNS devices with XFS I get
a lot of failures with warnings like this:

[   30.068652] XFS (nvme1n1): empty zone 1 has non-zero used counter (0x1).

[   49.316873] XFS (nvme0n1): empty zone 2 has non-zero used counter (0x10).

so it seems like it's not tracking WPs correctly, probably when using
zone append and unmount/remounting.

