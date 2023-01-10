Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC85C46467
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jan 2023 06:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1WmbrR32fzznpny+d7yXqtpAf7
	/uVOKvsJG78rN4k9dd3MarA7bTeivO0+wMBJRQ/5ZHSewpV5Co+aNTnTXPOQtTHodeKt4c6mTErn/
	+Svlr95LS/QepxM0x3Jw8IFBt/wjiqSpfyo8uBKEdW7zTG4EvKysBpM8bgI+euTQiqs/VLU5muRIT
	tscjvPz6p+4NJPmLkqFb2aCJ9sFHzbM7BGMaD3OnlwtYsREFPmbC7LOaQTRDL/dA1CnFv67KuEg43
	kQ76R2g4W7XfLvPNXwDyls58MJXoWmbRa35LN6KW508n+hdWUY2qN51Uz7+ve+iqWE3MXfhJuyJck
	8LXneTZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF8X8-005X8S-HK; Tue, 10 Jan 2023 06:54:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF8X6-005X7g-HG
	for linux-nvme@lists.infradead.org; Tue, 10 Jan 2023 06:54:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B36168BEB; Tue, 10 Jan 2023 07:54:49 +0100 (CET)
Date: Tue, 10 Jan 2023 07:54:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
	hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
	dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
	linux-nvme@lists.infradead.org, hch@lst.de,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 2/7] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Message-ID: <20230110065448.GB10289@lst.de>
References: <20230106083317.93938-1-p.raghav@samsung.com> <CGME20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f@eucas1p1.samsung.com> <20230106083317.93938-3-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106083317.93938-3-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_225452_721895_E3E19B1B 
X-CRM114-Status: UNSURE (   9.13  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

