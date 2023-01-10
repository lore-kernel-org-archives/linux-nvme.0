Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB07C54EBE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jan 2023 06:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E1hL21jD2ngWUbkRGOxc5HYD3asx2IeXNsWe2Firxz4=; b=pQWDv1NQP5d/UvRwNHmHVRlfXw
	rUC6j96D7AqB4YqbRB/tSCOHvqm6WEdV85ek2DZ9CK0LeVIDOLSMwjpMoKHfvnu+CSHfUCNRm1fNg
	ooMBj5cN3kWcXqCozT1EsbzLEHir126Ngku0PnXdxMoeXg+CEyO3SDhl8EgHwtn17UWhlEH/e8EV3
	cQynCUfQJycEnoQIiFCvhLPIRm+rRieiAQ5T0QZOjbDBzNSsNzgazEE7gRX5ZpCaABy4hZQLynQOp
	/eJ335jUg9OjfW9RHK5VfkP5PjpEIWwdPJNrkXf76d9VXxhbE1N8luu4ExPM9U3UQ70yAVUBBFqoT
	+C4fsing==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF8Yg-005XWK-2v; Tue, 10 Jan 2023 06:56:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF8Yc-005XVP-Sq
	for linux-nvme@lists.infradead.org; Tue, 10 Jan 2023 06:56:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E03868C4E; Tue, 10 Jan 2023 07:56:24 +0100 (CET)
Date: Tue, 10 Jan 2023 07:56:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
	hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
	dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
	linux-nvme@lists.infradead.org, hch@lst.de,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 5/7] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Message-ID: <20230110065623.GD10289@lst.de>
References: <20230106083317.93938-1-p.raghav@samsung.com> <CGME20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0@eucas1p2.samsung.com> <20230106083317.93938-6-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106083317.93938-6-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_225627_090260_89904031 
X-CRM114-Status: UNSURE (   8.93  )
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

Given that we don't even support the non pow of 2 zones in the block
layer I don't see why this is needed.  But either way it doesn't really
seem to fit into this series.

