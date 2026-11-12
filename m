Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD393606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZUCnaQW6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ZUCnaQW6U+gHX1TF1goBgl/55o
	ENJ8RLzdoWInZHqsjaTVpT5xvHTEMP+M6TmkkNN642Twiy9CnHBOibE6VusYRGTCzgG5iVyYTPaFY
	VUfHQAvR1Eob6y5f9ynmLLZgPyom6i/aa1e+yPKZbhH3dmOE8b5G7FpAITMaFrCbUupVUzM/2M/M2
	/S9pyq8OxGeeuI/7PFayoWpLR9Y2mq9KRBv0KNN/d4mgzy/QZwNNEZOE/fewaA56KVQ/hp3nfWcz3
	IjCsx5jJE2+pG8Gt2FB2ulybNfZqwtJt9QTZsDxH5DH/8Gnlnz4sAhaL9SJvbqMa52MaWM9FAKfsO
	W2/n0HCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRcBx-0000000B52O-1eH0;
	Thu, 12 Nov 2026 21:18:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRcBv-0000000B51W-0Dgp
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 21:18:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B9C1368D0E; Thu, 12 Nov 2026 22:18:39 +0100 (CET)
Date: Thu, 12 Nov 2026 22:18:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: hare@kernel.org, hare@suse.de, kbusch@kernel.org, kch@nvidia.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH v2] nvmet: reject invalid write-protect feature values
Message-ID: <20261112211839.GD11315@lst.de>
References: <20261109135536.2772-1-sreekuttan2156239@gmail.com> <20261109142428.2612-1-sreekuttan2156239@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109142428.2612-1-sreekuttan2156239@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_131843_235926_E9901372 
X-CRM114-Status: UNSURE (   8.83  )
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


