Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E4606A329
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 05:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zT00/A8G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=E/O8FgOXfdBspSEpqFz048RRGpJCtIR8IcJMy9ZIl9E=; b=zT00/A8G3kvye3zQWI0BM2JTAw
	U5wZV4H1VenN7JSa/Z84ZJbssuvHk207RCk5PPnAkmMpwVPxEWJg3zlN1qWluh4ht/3RpaxAsFxoE
	a1D4A9QSLlO5dnAhZG8Zrg/b/EV/ik2OvjPOs5ONafCFi0sDz0vl00dbiKUfnuc9xIzX/dER0XKOm
	SHOrTnh5wOXyVCO8p+i05RvGE+Tjjn5EtZud1YdEVn5mWQXVEYjFPpfrPA/ulI2jh5+gUoWSzlNJ4
	TzymXHY6DqmxYXAoVjFoDQu7c8mANgFk18yk/5xLNyOksAkne4imQBVdF8/IF0hvkEzsgZT7opMHQ
	WwtoYcRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7EO-000000019Bm-0q4m;
	Tue, 03 Nov 2026 05:38:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7EL-000000019BA-1qPO
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 05:38:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 270F368AFE; Tue,  3 Nov 2026 06:38:42 +0100 (CET)
Date: Tue, 3 Nov 2026 06:38:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: hare@suse.de, hch@lst.de, kch@nvidia.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH v2] nvmet: use appropriate types for authentication
 payload lengths
Message-ID: <20261103053841.GA1526@lst.de>
References: <20261031075932.4345-1-sreekuttan2156239@gmail.com> <20261031081751.4583-1-sreekuttan2156239@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031081751.4583-1-sreekuttan2156239@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_213845_648941_A7EF9246 
X-CRM114-Status: UNSURE (   9.46  )
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

But please don't resend new versions in the same thread.

