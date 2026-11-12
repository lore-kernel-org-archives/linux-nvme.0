Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41003606A321
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RxopiSi/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=RxopiSi/MUsOv/T58k3JwAchWc
	rML6NCxvqbG1enNfA6DqGJFsMl4c3n/ApkN8S0ielgVTMTsoRrjG50cKJbRzTzT/C0cjlV5exhPHk
	IfkoNR3S3pD44L/avk0R3nwpnS6pnworQkHlRfVadCfblNbBej9RVsl4tIVX7Z42J+Rx4ThK+hwVc
	NEp4pw3Z9WoHAnu5BNfuDGS1EcP9oPwGnJIKxRf2J/Z1n+jjAMAtg/ciWEhwS3sy05uWHk12vBDU3
	ZP/v/MSYEGFWT6EaGWcBw/AjtLWrL+JKQ3HUZzZgCKsbcerv3jpyM7Skcqrysh95OBEKvWLRKlBL0
	U0vHbWrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRcB6-0000000B4nh-3qUX;
	Thu, 12 Nov 2026 21:17:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRcB4-0000000B4mF-29eF
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 21:17:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 322BE68D0E; Thu, 12 Nov 2026 22:17:47 +0100 (CET)
Date: Thu, 12 Nov 2026 22:17:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, hare@suse.de,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-auth: use the parsed offset for the DH-CHAP
 key
Message-ID: <20261112211746.GB11315@lst.de>
References: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn> <20261109225919740-DfVem3ttLxIAe7wl3Puh@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109225919740-DfVem3ttLxIAe7wl3Puh@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_131750_699557_21C4D649 
X-CRM114-Status: UNSURE (   9.88  )
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


