Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834F606A336
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GX/XH2dS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GX/XH2dSQHRUgryaSWV9cEZDWA
	3Aql7EMJRixz1Q8Kvm9N5gs8qO6Q1P8VFDw2Etsni3PSz6PAEj4JWM0+IQUCxg7fUbI8A/fBUaJ07
	ZvZjVC4DPu/TfXp+0y4MMp8M96LE+T9D//ETDosmDCYuBDwXHRFh2cNgD0UB0KWTu1nYxE4hztx/b
	3HegmzGJk8jcHcDtXPnTTgGAfzS0P/YYtzcyb4o20GN5oq/0DCokjgXtEVi23T64MD8xprbpU7d3g
	+3p8W+1KDq6zNtM5wJi+dqK4qZWxG3QNrs+hkqlyacPKK9SmMmztxnYPdpa2bmSouW3GtRyUq+U3u
	KgIn7r/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSbd-0000000FkGO-1BRg;
	Fri, 20 Nov 2026 17:41:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSbZ-0000000FkEn-2kYp
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:40:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 56A076732A; Fri, 20 Nov 2026 18:40:54 +0100 (CET)
Date: Fri, 20 Nov 2026 18:40:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvmet: Synchronize the TLS key debugfs read with
 admin queue teardown
Message-ID: <20261120174054.GB1363@lst.de>
References: <20261116075447.1713255-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116075447.1713255-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_094057_846541_0993FBC1 
X-CRM114-Status: UNSURE (   9.79  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

