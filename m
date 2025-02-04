Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505CEC0218F
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 05:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tvkjcPsBUbZbtmQpp5BxhmkD/M1HReyKh6qCQH/3t6w=; b=37HEqdFEYB5Lot0Uoix82tCri8
	fOcu9Q1htlMXThtdcmLjnyYZJ9nel1oBAWyKuPguXrrV4XPNThiltv73i6Upo/BMkuqIXW6esSEQh
	YE7CMdetBR0hIOTffdVjOmzSXe66w0ED0b1kSws/sFcgKNumfAF5LkUhYhQ7uF1ECXbjQ/6qSHT4b
	EHWnbX5VSF9waW75dgXbim+SfwXY2x2t13NwUE+Ru1kdy8gNxUzYJO4qRWAUFKHflzGgYAIhNyJCD
	m8uUaV5akeSP2RGPAKeE09OjuWwPMqnay+OM3YiytSXQUChQzClxJJcny/cujvoO7vc71psZ3xjeB
	uyYpTlCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBEO-0000000HGI6-21k1;
	Tue, 04 Feb 2025 05:12:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBEL-0000000HGHl-2hpy
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 05:12:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6583668AFE; Tue,  4 Feb 2025 06:12:08 +0100 (CET)
Date: Tue, 4 Feb 2025 06:12:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250204051208.GG28103@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <yq134h0p1m5.fsf@ca-mkp.ca.oracle.com> <20250131074424.GA16182@lst.de> <yq17c66kfxs.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq17c66kfxs.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_211213_823668_29BE305A 
X-CRM114-Status: GOOD (  16.32  )
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

On Mon, Feb 03, 2025 at 02:31:13PM -0500, Martin K. Petersen wrote:
> > I never could come up with a good use of the app_tag for file systems,
> > so not wasting space for that is actually a good thing.
> 
> I wish we could just do 4 bytes of CRC32C + 4 bytes of ref tag. I think
> that would be a reasonable compromise between space and utility.

Agreed.

> But we
> can't do that because of the app tag escape. We're essentially wasting 2
> bytes per block to store a single bit flag.

Well, what do we actually need the app tag escape for except for
historical precedence?  In NVMe the app tag escape is an option for
deallocated blocks, but it's only one of the options, there other beeing
a synthetic guard/ref tag with the expected value.

> In general I think 4096+16 is a reasonable format going forward. With
> either CRC32C or CRC64 plus full LBA as ref tag.

That would also work fine.  NVMe supports 4byte crc32c + 2 byte app tag +
12 byte guard tag / storage tag and 8-byte crc64 + 2 byte app tag + 6
byte guard / storage tag, although Linux only supports the latter so far.

